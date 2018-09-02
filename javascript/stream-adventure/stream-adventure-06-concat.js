process.stdin.pipe(require('concat-stream')(function(data){
    var out = data.toString()
                  .split('').reverse().join('')
    console.log(out)
}))
