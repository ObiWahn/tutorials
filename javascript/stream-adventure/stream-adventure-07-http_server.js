//  trough must be defined inside the callback passed to createServer()
//  see http://stackoverflow.com/questions/24938293/nodeschool-streams-adventure-http-server
//  so the code below did not work and had to be moved inside
//
//var tr = require('through')(function(buf){
//        this.queue(buf.toString().toUpperCase())
//    },
//    function(end){
//        this.queue(null)
//    }
//);

require('http').createServer(function(request, response){
    if(request.method == 'POST'){
        request.pipe(
            require('through')(function(buf){
                this.queue(buf.toString().toUpperCase())
            })
        ).pipe(response)
    } else {
        response.end('ERROR: please send POST\n')
    }
}).listen(process.argv[2])
