use test
db.grades.aggregate([
    {$match:{
        state:{$in:['NY', 'CA']}
    }},
    {$project:{_id:0,city:1,state:1,pop:1}},
    {$group:{_id:{city:'$city',state:'$state'}, pop:{$sum:'$pop'}}},
    {$match:{
        pop:{$gt:25000},
    }},
    {$group:{_id:false,average:{$avg:'$pop'}}}
])

    //{$group:{_id:true,number:{$sum:1},totalpop:{$sum:'$pop'}}}
