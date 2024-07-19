const mssql = require('mssql');
const mssql_config = require('../../mssqlConfigure/mssqlConnect').condfig;


// get current position of employee

async function get_max_position(body)
{
    const connection = new mssql.ConnectionPool(mssql_config);
    await connection.connect();
    const trans = new mssql.Transaction(connection);
    try {
        await trans.begin();
        const request = new mssql.Request(trans);
        const pool =  await request.
        input('todate', mssql.Date, body.todate).
        input('employeeId', mssql.Char(10), body.employeeId).
        query(`
                SELECT
                    p.employeeId, p.datechange, p.posId, (SELECT posName FROM employee.tblref_position ref WHERE ref.posId = p.posId) posName , p.note
                FROM employee.tblemppos p
                INNER JOIN(
                    SELECT  employeeId, MAX(datechange) max_date
                    FROM employee.tblemppos
                    WHERE datechange < DATEADD(DAY,1,@todate) 
                        AND employeeId LIKE IIF(@employeeId IS NULL, '%', CONCAT('%',@employeeId,'%'))
                    GROUP BY employeeId
                )sub ON p.employeeId = sub.employeeId

            `);
        await trans.commit();
        return pool.recordset
    } catch (error) {
        await trans.rollback();
        throw error;
    } finally
    {
        connection.close();
    }
}

module.exports = {
    get_max_position: get_max_position
}