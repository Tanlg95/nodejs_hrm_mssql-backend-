const express = require('express');
const router = express.Router();
const employee = require('../mssqlOperations/employee/employeeCRUD');
const employeeFunction = require('../mssqlOperations/employee/employeeFunction');
const position = require('../mssqlOperations/position/positionCRUD');
const positionFunction = require('../mssqlOperations/position/positionFunction');
const account = require('../mssqlOperations/account/accountCRUD');


//------------------------------ employee ----------------------------------//

router.get('/employee',(req,res,next) =>{
    const body = req.body;
    employee.get_employee_info(body).then(
        respone => res.json(respone)
    ).catch(
        err => next(err)
    );
});

router.post('/employee/insert',(req,res,next) =>{
    const body = req.body;
    employee.insert_employee_info(body).then(
        respone => res.json(respone)
    ).catch(
        err => next(err)
    );
});

router.post('/employee/udpate',(req,res,next) =>{
    const body = req.body;
    employee.update_employee_info(body).then(
        respone => res.json(respone)
    ).catch(
        err => next(err)
    );
});

router.post('/employee/delete/:empid',(req,res,next) =>{
    const empid = req.params.empid;
    employee.delete_employee_info(empid).then(
        respone => res.json(respone)
    ).catch(
        err => next(err)
    );
})

router.get('/employee/get_total_emp',(req,res,next) =>{
    const todate = req.body.todate;
    employeeFunction.get_total_employee(todate).then(
        respone => res.json(respone)
    ).catch(
        err => next(err)
    );
})
//------------------------------ position ----------------------------------//

router.get('/position',(req,res,next) =>{
    const body = req.body;
    position.get_position_employee(body).then(
        respone => res.json(respone)
    ).catch(
        err => next(err)
    );
})

router.post('/position/insert',(req,res,next) =>{
    const body = req;
    position.insert_position_employee(body).then(
        respone => res.json(respone)
    ).catch(
        err => next(err)
    );
})

router.post('/position/update',(req,res,next) =>{
    const body = req.body;
    position.update_position_employee(body).then(
        respone => res.json(respone)
    ).catch(
        err => next(err)
    );
})

router.post('/position/delete/:keyid',(req,res,next) =>{
    const keyid = req.params.keyid;
    position.delete_position_employee(keyid).then(
        respone => res.json(respone)
    ).catch(
        err => next(err)
    );
})

router.get('/position/get_max_pos',(req,res,next) =>{
    const body = req.body;
    positionFunction.get_max_position(body).then(
        respone => res.json(respone)
    ).catch(
        err => next(err)
    );
})


//------------------------------ account ----------------------------------//


router.post('/account/create',(req,res,next) =>{
    const body = req.body;
    account.create_account(body).then(
        respone => res.json(respone)
    ).catch(
        err => next(err)
    );
})

module.exports = router;