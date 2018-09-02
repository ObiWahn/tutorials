process.stdin.pipe(
    require('request').post('http://localhost:8000')
).pipe(process.stdout)
