var fs = require('fs')

var file_path = process.argv[2]
var file_content = fs.readFileSync(file_path, 'utf-8')
var lines = file_content.split('\n').length - 1
console.log(lines)
