var m_http= require('http')

function get_data(index, urls, result){
    m_http.get(urls[index], function(response){
        response.setEncoding('utf-8')
        var data_coll = ""
        response.on('data', function(data){
            data_coll += data
        })
        response.on('error', console.error)
        response.on('end',function(){
            console.log(data_coll)
            result[index]=data_coll
            if (index < urls.length-1){
                get_data(index + 1, urls, result)
            }
        })
    })
}

var g_result = []
var g_urls = process.argv.slice(2).map(String)
get_data(0, g_urls, g_result)
g_result.forEach(function(x){console.log(x.output)})
