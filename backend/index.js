const express = require('express')
const cors = require('cors')
const cookieParser = require('cookie-parser')
require('dotenv').config()
const connectDB = require('./config/db')
const router = require('./routes')
console.log("url",process.env.FRONTEND_URL);
console.log("TOKEN_SECRET_KEY",process.env.TOKEN_SECRET_KEY);



const app = express()
app.use(cors({
    origin : process.env.FRONTEND_URL,
    credentials:true
}))
app.use(express.json())
app.use(cookieParser())

app.use("/api",router)

const PORT = 4000 || process.env.PORT


connectDB().then(()=>{
    app.listen(PORT,()=>{
        console.log("connnect to DB")
        console.log("Server is running "+PORT)
    })
})
