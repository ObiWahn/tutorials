var m_http= require('http')

var url = process.argv[2]
m_http.get(url, function(response){
    response.setEncoding('utf-8')
    response.on('data', console.log)
    response.on('error', console.error)
})
