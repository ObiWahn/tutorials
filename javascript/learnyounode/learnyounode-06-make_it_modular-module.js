var m_fs   = require('fs')
var m_path = require('path')

function ext_filter(ext, path){
    if (m_path.extname(path) === '.' + ext)
        { return true }
    return false
}

module.exports = function(path, ext, cb){
    m_fs.readdir(path, function(err, list){
        if (err) { return cb(err) }
        rv = list.filter(ext_filter.bind(undefined, ext))
        rv.forEach(function(x){console.log(x)})
        cb(null, rv)
    })
}
