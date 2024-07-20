const mssql = require('mssql');
const mssql_config = require('../../mssqlConfigure/mssqlConnect').condfig;
const bcrypt = require('bcrypt');
const createToken = require('../../tokenOperations/createToken');
const moment = require('moment');


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
        table_tblaccount.columns.add('pwd',mssql.NVarChar(2000));
        table_tblaccount.columns.add('atoken',mssql.NVarChar(2000));
        table_tblaccount.columns.add('ftoken',mssql.NVarChar(2000));
        table_tblaccount.columns.add('note',mssql.NVarChar(150));
       
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
    } finally
    {
        await connection.close();
    }
}

module.exports = {
    create_account: create_account
};