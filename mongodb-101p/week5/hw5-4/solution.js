use test
db.zips.aggregate([
    {$project:{
        _id:0,
        pop:1,
        first: {$substr : ["$city",0,1]}
    }},
    {$match:{
        first:{$in:['0','1','2','3','4','5','6','7','8','9']}
    }},
    {$group:{
        _id:'all in zip codes',
        total:{'$sum':'$pop'}
    }}
])
