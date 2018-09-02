var fs  = require('fs')
var http = require('http')

var server = http.createServer(function(request,response){
    response.writeHead(200, { 'content-type': 'text/plain' })
    fs.createReadStream(String(process.argv[3])).pipe(response)
})

server.listen(Number(process.argv[2]))
