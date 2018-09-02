var count=0
var tr = require('through')(function(buf){
    count+=1
    if (count % 2 === 0){
        this.queue(buf.toString().toUpperCase() + '\n')
    } else {
        this.queue(buf.toString().toLowerCase() + '\n')
    }
});

process.stdin.pipe(require('split')()).pipe(tr).pipe(process.stdout);
