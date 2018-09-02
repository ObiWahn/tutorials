var fs = require('fs')

var file_path = process.argv[2]
fs.readFile(file_path, 'utf-8', function (err,data){
    var lines = data.split('\n').length - 1
    console.log(lines)
    return lines
})
