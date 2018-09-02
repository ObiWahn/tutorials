var server = require('http').createServer(function(request, response){
    var url = require('url').parse(request.url, true)
    var date = new Date(url.query.iso)
    var rv = {}

    if (url.pathname === "/api/unixtime"){
       rv['unixtime'] = date.getTime()
    }
    else if (url.pathname === "/api/parsetime"){
       rv['hour']   = date.getHours()
       rv['minute'] = date.getMinutes()
       rv['second'] = date.getSeconds()
    }

    if (Object.keys(rv).length != 0) {
        response.writeHead(200, { 'content-type': 'application/json' })
        response.end(require('JSON').stringify(rv))
    }
    else{
        response.writeHead(404)
        response.end('Error 404')
    }
})

server.listen(Number(process.argv[2]))
