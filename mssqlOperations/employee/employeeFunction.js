const mssql = require('mssql');
const mssql_config = require('../../mssqlConfigure/mssqlConnect').condfig;

// get the number of total employee

async function get_total_employee(todate)
{

    const connection = new mssql.ConnectionPool(mssql_config);
    await connection.connect();
    const trans = new mssql.Transaction(connection);
    try {
        await trans.begin();
        const request = new mssql.Request(trans);
        const pool = await request.
        input('todate', mssql.Char(10), todate).
        query('SELECT COUNT(employeeId) total_employee FROM employee.tblemployee WHERE employedDate < DATEADD(DAY,1,@todate)');
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
    get_total_employee: get_total_employee
}