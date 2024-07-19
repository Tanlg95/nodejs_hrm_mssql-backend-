const mssql = require('mssql');
const mssql_config = require('../../mssqlConfigure/mssqlConnect').condfig;

// get employee's position

async function get_position_employee(body)
{
    const connection = new mssql.ConnectionPool(mssql_config);
    await connection.connect();
    const trans = new mssql.Transaction(connection);
    try {
        await trans.begin();
        const request = new mssql.Request(trans);
        const pool = await request.
        input('todate', mssql.Date, body.todate).
        input('empid', mssql.Char(10), body.empid).
        query('SELECT * FROM employee.ufn_get_position(@todate,@empid)');
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

// create employee's position

async function insert_position_employee(body)
{
    // console.log(body.body);
    const connection = new mssql.ConnectionPool(mssql_config);
    await connection.connect();
    const trans = new mssql.Transaction(connection);
    try {
        await trans.begin();
        const request = new mssql.Request(trans);
        const tbl_tblemppos = new mssql.Table();
        tbl_tblemppos.columns.add('employeeId', mssql.Char(10));
        tbl_tblemppos.columns.add('datechange', mssql.Date);
        tbl_tblemppos.columns.add('posId', mssql.Char(10));
        tbl_tblemppos.columns.add('note', mssql.NVarChar(150));

        // check array body
        if(!(body.body instanceof Array)) throw new Error('body input must be an array!!')
        const employee_input = body.body;
        for(let ele of employee_input)
        {
            tbl_tblemppos.rows.add(ele.employeeId, ele.datechange, ele.posId, ele.note);
        }
        console.log(tbl_tblemppos);
        const pool = await request.input('tblemppos', tbl_tblemppos)
        .execute('employee.usp_insert_position');
        await trans.commit();
        return pool.output;
    } catch (error) {
        trans.rollback();
        throw error;

    } finally
    {
        await connection.close();
    }
}

// update employee's position

async function update_position_employee(body)
{
    const connection = new mssql.ConnectionPool(mssql_config);
    await connection.connect();
    const trans = new mssql.Transaction(connection);
    try {
        await trans.begin();
        const request = new mssql.Request(trans);
        const pool = await request.
        input('employeeId', mssql.Char(10), body.employeeId).
        input('datechange', mssql.Date, body.datechange).
        input('posId', mssql.Char(10), body.posId).
        input('note', mssql.NVarChar(150), body.note).
        input('keyid', mssql.Int,  body.keyid).
        execute('employee.usp_update_position');
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

// delete employee's position 

async function delete_position_employee(keyid)
{
    const connection = new mssql.ConnectionPool(mssql_config);
    await connection.connect();
    const trans = new mssql.Transaction(connection);
    try {
        await trans.begin();
        const request = new mssql.Request(trans);
        const pool = await request.
        input('keyid', mssql.Char(10), keyid).
        execute('employee.usp_delete_position');
        await trans.commit();
        return pool.output;
    } catch (error) {
        await trans.rollback();
    } finally
    {
        await connection.close();
    }
}


module.exports = {
    get_position_employee: get_position_employee,
    insert_position_employee: insert_position_employee,
    update_position_employee: update_position_employee,
    delete_position_employee: delete_position_employee
}