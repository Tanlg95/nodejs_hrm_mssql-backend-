const mssql = require('mssql');
const mssql_config = require('../../mssqlConfigure/mssqlConnect').condfig;
const statusClass = require('../../support/status');
const status = new statusClass();

// get employee's department

async function get_department_employee(body)
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
        query('SELECT * FROM employee.ufn_get_department(@todate,@empid)');
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
    get_department_employee: get_department_employee,
}