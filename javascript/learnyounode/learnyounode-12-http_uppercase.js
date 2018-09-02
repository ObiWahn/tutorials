var fs  = require('fs')
var http = require('http')

var server = http.createServer(function(request,response){
    if (request.method != 'POST'){
        return response.end('send me a POST\n')
    }

    var map = require('through2-map')
    response.writeHead(200, { 'content-type': 'text/plain' })

    request.pipe(map(function (chunk) {
        return chunk.toString().toUpperCase()
    })).pipe(response)
})

server.listen(Number(process.argv[2]))
