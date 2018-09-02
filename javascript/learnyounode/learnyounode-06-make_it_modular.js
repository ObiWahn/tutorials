var m_learn6  = require('./learnyouanode-6-make_it_modular-module.js')

var path = process.argv[2]
var ext  = process.argv[3]

m_learn6(path, ext, function(err, list){
    if (err){
        console.error("there was an error", err)
    }
})
