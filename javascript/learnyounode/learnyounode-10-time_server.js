var net = require('net')
var strftime = require('strftime')


var server = net.createServer(function (socket) {
    var reply = strftime("%Y-%m-%d %H:%M\n", new Date())
    socket.write(reply)
    socket.end()
})

server.listen(process.argv[2])
