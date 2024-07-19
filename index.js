require('dotenv').config();
const express = require('express');
const app = express();
const router = require('./router/router');
const bodyparser = require('body-parser');
const welcome = {
    status: "connected successfully!",
    author: "tanlg95"
};

app.use(bodyparser.urlencoded({extended: true}));
app.use(bodyparser.json());
app.use('/api',router);
router.use((req,res,next)=>{
    console.log('middleware!');
    next();
});



const port = process.env.SERVER_PORT || 3333;
app.listen(port,() => console.log(`server is running at port ${port}`));