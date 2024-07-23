require('dotenv').config();

const condfig = {
    user: process.env.MSSQL_USER,
    password: process.env.MSSQL_PASSWORD,
    database: process.env.MSSQL_DATABASE,
    server: process.env.MSSQL_SERVERNAME,
    options:{
        trustedConnection: (process.env.MSSQL_SERVERTRUSTEDCONNECTION === 1)? true : false,
        enableArithAbort: (process.env.MSSQL_ARITHABORT === 1)? true : false,
        //trustServerCertificate: true,
        instanceName: process.env.MSSQL_INSTANCENAME,
        encrypt: (process.env.MSSQL_ENCRYPT === 1)? true: false,
        port: Number(process.env.MSSQL_PORT)
    }
}

module.exports = {condfig: condfig};