const mssql = require('mssql');
const mssql_config = require('../../mssqlConfigure/mssqlConnect').condfig;
const moment = require('moment');


// get employee information
async function get_employee_info(body)
{
    const connection = new mssql.ConnectionPool(mssql_config);
    await connection.connect();
    const trans = new mssql.Transaction(connection);
    try {
    await trans.begin();
    const request = new mssql.Request(trans);
    const pool = await request.input(
       'todate', mssql.VarChar(50), body.todate
    ).input('empid', mssql.Char(10),body.empid)
    .execute('employee.usp_get_employee');
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

// insert employee information
async function insert_employee_info(body)
{
    const connection = new mssql.ConnectionPool(mssql_config);
   
    await connection.connect();
    const trans = new mssql.Transaction(connection);
    try {
        await trans.begin();
        const request = new mssql.Request(trans);
        const pool = await request.
        input('employeeId', mssql.Char(10), String(body.employeeId)).
        input('employeeName', mssql.NVarChar(150), String(body.employeeName)).
        input('employedDate', mssql.Date, body.employedDate).
        input('birthDate', mssql.Date, body.birthDate).
        input('isActive', mssql.Bit, Boolean(body.isActive)).
        execute('employee.usp_insert_employee');
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

// update employee information
async function update_employee_info(body)
{
    const connection = new mssql.ConnectionPool(mssql_config);
    await connection.connect();
    const trans = new mssql.Transaction(connection);
    try {
        await trans.begin();
        const request = new mssql.Request(trans);
        const pool = await request.
        input('employeeId', mssql.Char(10), String(body.employeeId)).
        input('employeeName', mssql.NVarChar(150), String(body.employeeName)).
        input('employedDate', mssql.Date, body.employedDate).
        input('birthDate', mssql.Date, body.birthDate).
        input('isActive', mssql.Bit, Boolean(body.isActive)).
        execute('employee.usp_update_employee');
        await trans.commit();
        return pool.output;
    } catch (error) {
        await trans.rollback();
        throw error;
    } finally
    {
        await connection.close();
    }
}

// delete employee information

async function delete_employee_info(empid)
{
    const connection = new mssql.ConnectionPool(mssql_config);
    
    try {
        await connection.connect();
        const trans = new mssql.Transaction(connection);
        await trans.begin();
        const request = new mssql.Request(trans);
        const pool = await request.input(
            'employeeId', mssql.Char(10), empid
        ).execute('employee.usp_delete_employee');

        await trans.commit();

        return pool.output;  

    } catch (error) {
        await trans.rollback();
        throw error;
    } finally
    {
        await connection.close();
    }
}

module.exports = {
    get_employee_info: get_employee_info,
    insert_employee_info: insert_employee_info,
    update_employee_info: update_employee_info,
    delete_employee_info: delete_employee_info,
};