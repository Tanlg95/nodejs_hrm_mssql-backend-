const mssql = require('mssql');
const mssql_config = require('../../mssqlConfigure/mssqlConnect').condfig;
const bcrypt = require('bcrypt');

// login account

async function login(body)
{
    const connection = new mssql.ConnectionPool(mssql_config);
    await connection.connect();
    const trans = new mssql.Transaction(connection);
    try {
        await trans.begin();
        const request = new mssql.Request(trans);
        // get the password for compare
        const get_password = await request.
        input('accountId', mssql.Char(10), body.accountId).
        query('SELECT pwd, atoken FROM employee.tblaccount WHERE accountId = @accountId');
        const encrypt_password = get_password.recordset[0].pwd;
        // compare passwords
        const check_match_password = bcrypt.compareSync(body.pwd, encrypt_password);
        
        if(!check_match_password) throw new Error('incorrect password !!!');
        await trans.commit();
        // return employee's information
        return {
            statusId: 1,
            statusName: "logged in successfully!!!",
            atoken: get_password.recordset[0].atoken
        };
    } catch (error) {
        await trans.rollback();
        throw error;
    } finally
    {
        await connection.close();
    }
};


// change password

async function changePassword(body)
{
    const connection = new mssql.ConnectionPool(mssql_config);
    await connection.connect();
    const trans = new mssql.Transaction(connection);
    try {
        await trans.begin();
        const request = new mssql.Request(trans);
        // get the password for compare
        const get_password = await request.
        input('keyidf', mssql.Int, body.keyid).
        query('SELECT pwd, atoken FROM employee.tblaccount WHERE keyid = @keyidf');
        const encrypt_password =  get_password.recordset[0].pwd;
        console.log(`check password: ${encrypt_password}`);
        // compare passwords
        const check_match_password = bcrypt.compareSync(body.old_password, encrypt_password);
        if(!check_match_password) throw new Error('incorrect password!!!');
        // create a new password
        const new_encrypt_password = bcrypt.hashSync(body.new_password,  bcrypt.genSaltSync(10));    
        // update password
        const request2 = new mssql.Request(trans);
        const pool = await request2.
        input('keyid', mssql.Int, body.keyid).
        input('new_password', mssql.VarChar(1000), new_encrypt_password).
        execute('employee.usp_change_account_password');
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
    login: login,
    changePassword: changePassword
};