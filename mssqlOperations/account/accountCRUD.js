const mssql = require('mssql');
const mssql_config = require('../../mssqlConfigure/mssqlConnect').condfig;
const bcrypt = require('bcrypt');
const createToken = require('../../tokenOperations/createToken');
const renewToken = require('../../tokenOperations/renewToken');
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
        
        const request = new mssql.Request(trans);
       
        // create encrypt password
        const passwordEncrypt = bcrypt.hashSync(body.pwd, bcrypt.genSaltSync(10));
        const payloadForToken = {
            accountId: body.accountId,
            accountName: body.accountName,
            email: body.email
        };
        const atoken = createToken(payloadForToken,1),
              ftoken = createToken(payloadForToken,2);
        const table_tblaccount = new  mssql.Table();
        table_tblaccount.columns.add('accountId',mssql.Char(10));   
        table_tblaccount.columns.add('accountName',mssql.NVarChar(150));
        table_tblaccount.columns.add('email',mssql.VarChar(150));
        table_tblaccount.columns.add('pwd',mssql.VarChar(1000));
        table_tblaccount.columns.add('atoken',mssql.VarChar(1500));
        table_tblaccount.columns.add('ftoken',mssql.VarChar(1500));
        table_tblaccount.columns.add('note',mssql.NVarChar(250));
        
        table_tblaccount.rows.add(body.accountId, 
            body.accountName,
            body.email,
            passwordEncrypt,
            atoken,
            ftoken,
            body.note);
        console.log(table_tblaccount);
        const pool = await request.
        input('tblaccount', table_tblaccount).
        execute('employee.usp_insert_account');
        
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

// update account's information

async function update_account(body)
{
    const connection = new mssql.ConnectionPool(mssql_config);
    await connection.connect();
    const trans = new mssql.Transaction(connection);
    try {
        await trans.begin();
        const request = new mssql.Request(trans);
        const pool = await request.
        input('accountName', mssql.VarChar(150), body.accountName).
        input('email', mssql.VarChar(150), body.email).
        input('note', mssql.NVarChar(250), body.note).
        input('keyid', mssql.Int, body.keyid).
        execute('employee.usp_update_account');
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

// delete account

async function delete_account(keyid)
{
    const connection = new mssql.ConnectionPool(mssql_config);
    await connection.connect();
    const trans = new mssql.Transaction(connection);
    try {
        await trans.begin();
        const request = new mssql.Request(trans);
        const pool = await request.
        input('keyid', mssql.Int, keyid).
        execute('employee.usp_delete_account');
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

// update token

async function update_token_account(body)
{
    /*
    -- opt: 0 => atoken and ftoken
	-- opt: 1 => atoken
	-- opt: 2 => ftoken
    */
    if(!([0,1,2].includes(body.opt))) throw new Error('opt must be in (0,1,2)');
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