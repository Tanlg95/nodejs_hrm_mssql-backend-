const mssql = require('mssql');
const mssql_config = require('../../mssqlConfigure/mssqlConnect').condfig;
const statusClass = require('../../support/status');
const status = new statusClass();
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
         // check array body
        if(!(body.body instanceof Array)) throw status.errorStatus(1);
        const employee_input = body.body;
        const tblemployee = new mssql.Table();
        tblemployee.columns.add('employeeId', mssql.Char(10));
        tblemployee.columns.add('employeeName', mssql.NVarChar(150));
        tblemployee.columns.add('employedDate', mssql.Date);
        tblemployee.columns.add('birthDate', mssql.Date);
        tblemployee.columns.add('isActive', mssql.Bit);

        for(let ele of employee_input)
        {
            tblemployee.rows.add(
                String(ele.employeeId), 
                String(ele.employeeName),
                new Date(ele.employedDate).toISOString().split('T')[0],
                new Date(ele.birthDate).toISOString().split('T')[0],
                Boolean(ele.isActive)
            );
        }
        const request = new mssql.Request(trans);
        const pool = await request.
        input('tblemployee', tblemployee).
        execute('employee.usp_insert_employee');
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

// update employee information
async function update_employee_info(body)
{
    const connection = new mssql.ConnectionPool(mssql_config);
    await connection.connect();
    const trans = new mssql.Transaction(connection);
    try {
        await trans.begin();

        // check array body
        if(!(body.body instanceof Array)) throw status.errorStatus(1);
        const employee_input = body.body;
        const tblemployee = new mssql.Table();

        tblemployee.columns.add('employeeName', mssql.NVarChar(150));
        tblemployee.columns.add('employedDate', mssql.Date);
        tblemployee.columns.add('birthDate', mssql.Date);
        tblemployee.columns.add('isActive', mssql.Bit);
        tblemployee.columns.add('keyid', mssql.Int);

        for(let ele of employee_input)
        {
            tblemployee.rows.add(
                String(ele.employeeName),
                new Date(ele.employedDate).toISOString().split('T')[0],
                new Date(ele.birthDate).toISOString().split('T')[0],
                Boolean(ele.isActive),
                Number(ele.keyid)
            );
        }

        const request = new mssql.Request(trans);
        const pool = await request.
        input('tblemployee', tblemployee).
        execute('employee.usp_update_employee');
        await trans.commit();
        return {
            statusId: status.operationStatus(104) ,
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

// delete employee information

async function delete_employee_info(body)
{
    const connection = new mssql.ConnectionPool(mssql_config);
    await connection.connect();
    const trans = new mssql.Transaction(connection);
    try {
        await trans.begin();

        // check array body
        if(!(body.body instanceof Array)) throw status.errorStatus(1);
        const employee_input = body.body;
        const tblemployee = new mssql.Table();

        tblemployee.columns.add('keyid', mssql.Int);

        for(let ele of employee_input)
        {
            tblemployee.rows.add(String(ele.keyid));
        }

        const request = new mssql.Request(trans);
        const pool = await request.input(
           'tblemployee', tblemployee
        ).execute('employee.usp_delete_employee');

        await trans.commit();

        return {
            statusId: status.operationStatus(104) ,
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

module.exports = {
    get_employee_info: get_employee_info,
    insert_employee_info: insert_employee_info,
    update_employee_info: update_employee_info,
    delete_employee_info: delete_employee_info,
};