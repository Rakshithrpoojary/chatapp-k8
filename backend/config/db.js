const fs = require("fs");
const mongouri =fs.readFileSync("/mnt/secrets/MONGODB_URII","utf8").trim();
const mongoose = require("mongoose")
console.log("MONGOURI",mongouri)


async function connectDB(){
    try{
        await mongoose.connect(mongouri)
    }catch(err){
        console.log(err)
    }
}

module.exports = connectDB