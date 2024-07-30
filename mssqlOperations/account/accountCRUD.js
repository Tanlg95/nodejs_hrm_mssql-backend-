const mssql = require('mssql');
const mssql_config = require('../../mssqlConfigure/mssqlConnect').condfig;
const bcrypt = require('bcrypt');
const createToken = require('../../tokenOperations/createToken');
const renewToken = require('../../tokenOperations/renewToken');
const statusClass = require('../../support/status');
const valid = require('../../support/valid');
const status = new statusClass();
const moment = require('moment');



// create account

async function create_account(body)
{
    //console.log(mssql_config);
    // const connection = new mssql.ConnectionPool(mssql_config);
    const connection = new mssql.ConnectionPool(mssql_config);
   
    await connection.connect();
    const trans = new mssql.Transaction(connection);
    try {
        await trans.begin();
        // check array body
        if(!(body.body instanceof Array)) throw status.errorStatus(1);
        const account_input = body.body;
        const tblaccount = new mssql.Table();
        const request = new mssql.Request(trans);

        tblaccount.columns.add('accountId',mssql.Char(10));   
        tblaccount.columns.add('accountName',mssql.NVarChar(150));
        tblaccount.columns.add('email',mssql.VarChar(150));
        tblaccount.columns.add('pwd',mssql.VarChar(1000));
        tblaccount.columns.add('atoken',mssql.VarChar(1500));
        tblaccount.columns.add('ftoken',mssql.VarChar(1500));
        tblaccount.columns.add('note',mssql.NVarChar(250));
        
        for( let ele of account_input)
        {
        // create encrypt password
        const passwordEncrypt = bcrypt.hashSync(valid.validPassword(ele.pwd), bcrypt.genSaltSync(10));
        const payloadForToken = {
            accountId: ele.accountId,
            accountName: ele.accountName,
            email: ele.email
        };
        const atoken = createToken(payloadForToken,1),
              ftoken = createToken(payloadForToken,2);
            tblaccount.rows.add(
                    ele.accountId,
                    ele.accountName,
                    valid.validEmail(ele.email),
                    passwordEncrypt,
                    atoken,
                    ftoken,
                    ele.note
                )
        }

        //console.log(tblaccount);
        const pool = await request.
        input('tblaccount', tblaccount).
        execute('employee.usp_insert_account');
        
        await trans.commit();
        return {
            statusId: status.operationStatus(104) ,
            totalRowInserted: pool.rowsAffected[0]
        };
    } catch (error) {
        await trans.rollback();
        throw error;
    } finally
    {
        await connection.close();
    }
}

// update account's information

async function update_account(body)
{
    const connection = new mssql.ConnectionPool(mssql_config);
    await connection.connect();
    const trans = new mssql.Transaction(connection);
    try {
        await trans.begin();

        // check array body
        if(!(body.body instanceof Array)) throw status.errorStatus(1);
        const account_input = body.body;
        const tblaccount = new mssql.Table();

        tblaccount.columns.add('accountName', mssql.VarChar(150));
        tblaccount.columns.add('email', mssql.VarChar(150));
        tblaccount.columns.add('note', mssql.NVarChar(250));
        tblaccount.columns.add('keyid', mssql.Int);

        for(let ele of account_input)
        {
            // default accountId: 00000 => becuz tblaccount type require 5 columns
            // we dont use accountId => it doesn't matter
            tblaccount.rows.add(ele.accountName, valid.validEmail(ele.email), ele.note, ele.keyid);
        }

        const request = new mssql.Request(trans);
        const pool = await request.
        input('tblaccount', tblaccount).
        execute('employee.usp_update_account');
        await trans.commit();
        return {
            statusId: status.operationStatus(104), 
            totalRowModified: pool.rowsAffected[0]
        };
    } catch (error) {
        await trans.rollback();
        throw error;
    } finally
    {
        await connection.close();
    }
}

// delete account

async function delete_account(body)
{
    const connection = new mssql.ConnectionPool(mssql_config);
    await connection.connect();
    const trans = new mssql.Transaction(connection);
    try {
        await trans.begin();

        // check array body
        if(!(body.body instanceof Array)) throw status.errorStatus(1);
        const account_input = body.body;
        const tblaccount = new mssql.Table();

        tblaccount.columns.add('keyid', mssql.Int);

        for(let ele of account_input)
        {
            tblaccount.rows.add(ele.keyid);
        }
        const request = new mssql.Request(trans);
        const pool = await request.
        input('tblaccount', tblaccount).
        execute('employee.usp_delete_account');
        await trans.commit();
        return {
            statusId: status.operationStatus(104), 
            totalRowDeleted: pool.rowsAffected[0]
        };
    } catch (error) {
        await trans.rollback();
        throw error;
    } finally
    {
        await connection.close();
    }
}

// update token

async function update_token_account(body)
{
    /*
    -- opt: 0 => atoken and ftoken
	-- opt: 1 => atoken
	-- opt: 2 => ftoken
    */
    if(!([0,1,2].includes(body.opt))) throw status.errorStatus(7,[0,1,2]);
    const connection = new mssql.ConnectionPool(mssql_config);
    await connection.connect();
    const trans = new mssql.Transaction(connection);
    try {
        await trans.begin();
        const request = new mssql.Request(trans);
        //console.log(`atoken_old:${body.atoken_old}\nftoken: ${body.ftoken}`);
        const token = renewToken(body.atoken_old, body.ftoken);
        //console.log(`check token:` + token);
        const pool = await request.
        input('keyid', mssql.Int, body.keyid).
        input('atoken', mssql.VarChar(1500), token.atoken).
        input('ftoken', mssql.VarChar(1500), token.ftoken).
        input('opt', mssql.TinyInt, body.opt).
        execute('employee.usp_update_token');
        await trans.commit();
        return pool.recordset;
    } catch (error) {
        await trans.rollback();
        throw error;
    } finally
    {
        await connection.close();
    }
}

module.exports = {
    create_account: create_account,
    update_account: update_account,
    delete_account: delete_account,
    update_token_account: update_token_account,
};