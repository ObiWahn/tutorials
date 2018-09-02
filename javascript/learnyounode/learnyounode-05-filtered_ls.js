var m_fs   = require('fs')
var m_path = require('path')

var path = process.argv[2]
var ext  = process.argv[3]

function ext_filter(ext, path){
    if (m_path.extname(path) === '.' + ext)
        { return true }
    return false
}

m_fs.readdir(path, function(err, list){
    if (err) { throw err }
    list.filter(ext_filter.bind(undefined, ext))
        .forEach(function(x){console.log(x)})
})
