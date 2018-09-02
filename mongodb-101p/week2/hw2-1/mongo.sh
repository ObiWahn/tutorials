#!/bin/bash

mongo <<HERE
use students
db.grades.count()
db.grades.aggregate(
    {
        '\$group':{
            '_id':'\$student_id',
            'average':{\$avg:'\$score'}
        }
    },{
        '\$sort':{'average':-1}
    },{
        '\$limit':1
    })

db.grades.find(
    {
        'type' : 'exam',
        'score' : {\$gte: 65 }
    }).sort({
        'score': 1
    })
HERE
