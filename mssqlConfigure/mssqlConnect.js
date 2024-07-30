require('dotenv').config();

const condfig = {
    user: process.env.MSSQL_USER, // your account user
    password: process.env.MSSQL_PASSWORD, // your account password 
    database: process.env.MSSQL_DATABASE, // your database name, default: hrm
    server: process.env.MSSQL_SERVERNAME, // your server
    options:{
        trustedConnection: (process.env.MSSQL_SERVERTRUSTEDCONNECTION === 1)? true : false, // default: true
        enableArithAbort: (process.env.MSSQL_ARITHABORT === 1)? true : false, // default: true
        //trustServerCertificate: true,
        instanceName: process.env.MSSQL_INSTANCENAME,
        encrypt: (process.env.MSSQL_ENCRYPT === 1)? true: false, // default: true
        port: Number(process.env.MSSQL_PORT) // your port
    }
}

module.exports = {condfig: condfig};