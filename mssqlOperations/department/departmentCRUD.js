const mssql = require('mssql');
const mssql_config = require('../../mssqlConfigure/mssqlConnect').condfig;
const statusClass = require('../../support/status');
const status = new statusClass();


// create employee's department

async function insert_department_employee(body)
{
    // console.log(body.body);
    const connection = new mssql.ConnectionPool(mssql_config);
    await connection.connect();
    const trans = new mssql.Transaction(connection);
    try {
        await trans.begin();
        // check array body
        if(!(body.body instanceof Array)) throw status.errorStatus(1);
        const employee_input = body.body;

        const request = new mssql.Request(trans);
        const tbl_tblempdep = new mssql.Table();
        tbl_tblempdep.columns.add('employeeId', mssql.Char(10));
        tbl_tblempdep.columns.add('datechange', mssql.Date);
        tbl_tblempdep.columns.add('depId', mssql.Char(10));
        tbl_tblempdep.columns.add('note', mssql.NVarChar(150));

        
        for(let ele of employee_input)
        {
            tbl_tblempdep.rows.add(ele.employeeId, ele.datechange, ele.depId, ele.note);
        }
        //console.log(tbl_tblempdep);
        const pool = await request.input('tblempdep', tbl_tblempdep)
        .execute('employee.usp_insert_department');
        await trans.commit();
        return {
            statusId: status.operationStatus(104) ,
            totalRowInserted: pool.rowsAffected[0]
        }; 
    } catch (error) {
        trans.rollback();
        throw error;

    } finally
    {
        await connection.close();
    }
}

// update employee's department

async function update_department_employee(body)
{
    const connection = new mssql.ConnectionPool(mssql_config);
    await connection.connect();
    const trans = new mssql.Transaction(connection);
    try {
        await trans.begin();
        // check array body
        if(!(body.body instanceof Array)) throw status.errorStatus(1);
        const employee_input = body.body;
        const tblEmpdep = new mssql.Table();

        tblEmpdep.columns.add('datechange', mssql.Date);
        tblEmpdep.columns.add('depId', mssql.Char(10));
        tblEmpdep.columns.add('note', mssql.NVarChar(150));
        tblEmpdep.columns.add('keyid', mssql.Int);

        for(let ele of employee_input)
        {
            tblEmpdep.rows.add(new Date(ele.datechange).toISOString().split('T')[0], ele.depId, ele.note, ele.keyid);
        }
        
        const request = new mssql.Request(trans);
        const pool = await request.
        input('tblempdep', tblEmpdep).
        execute('employee.usp_update_department');
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

// delete employee's department 

async function delete_department_employee(body)
{
    const connection = new mssql.ConnectionPool(mssql_config);
    await connection.connect();
    const trans = new mssql.Transaction(connection);
    try {
        await trans.begin();
        // check array body
        if(!(body.body instanceof Array)) throw status.errorStatus(1);
        const employee_input = body.body;
        const tblDelete = new mssql.Table();
        tblDelete.columns.add('keyid', mssql.Int);

        for(let ele of employee_input)
        {
            tblDelete.rows.add(ele.keyid);
        }

        const request = new mssql.Request(trans);
        const pool = await request.
        input('tblempdep', tblDelete).
        execute('employee.usp_delete_department');
        await trans.commit();
        return {
            statusId: status.operationStatus(104) ,
            totalRowDeleted: pool.rowsAffected[0]
        }; 
    } catch (error) {
        await trans.rollback();
    } finally
    {
        await connection.close();
    }
}


module.exports = {
    insert_department_employee: insert_department_employee,
    update_department_employee: update_department_employee,
    delete_department_employee: delete_department_employee,
}