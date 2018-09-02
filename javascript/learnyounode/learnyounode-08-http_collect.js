var m_http= require('http')

var url = process.argv[2]
m_http.get(url, function(response){
    response.setEncoding('utf-8')
    var data_coll = ""
    response.on('data', function(data){
        data_coll += data
    })
    response.on('error', console.error)
    response.on('end',function(){
        console.log(data_coll.length)
        console.log(data_coll)
    })
})
