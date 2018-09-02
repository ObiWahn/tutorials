use test
db.grades.aggregate([
    {$unwind:'$scores'},
    {$match:{
        'scores.type':{$ne:'quiz'}
    }},
    {$group:{
        _id:{c_id:'$class_id',s_id:'$student_id'},
        average:{$avg:'$scores.score'}
    }},
    {$group:{
        _id:'$_id.c_id',
        average:{$avg:'$average'}
    }},
    {$sort:{average:-1}},
    {$limit:1}
])

