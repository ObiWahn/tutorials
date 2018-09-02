use enron

db.messages.aggregate([
{
    '$match' : {
        'headers.From' : { $in : ['susan.mara@enron.com',
                                  'soblander@carrfut.com',
                                  'evelyn.metoyer@enron.com'
        ] },
        'headers.To'   : { $in : ['jeff.dasovich@enron.com',
                                  'richard.shapiro@enron.com',
                                  'soblander@carrfut.com',
                                  'james.steffes@enron.com',
                                  'kate.symes@enron.com',
                                  'alan.comnes@enron.com'
        ] }
    }
},{
    '$project' : {
        '_id'  : 0,
        'from' : '$headers.From',
        'to'   : '$headers.To'
    }
},{
    '$unwind' : '$to'
},{
    '$group' : {
        '_id'   : { 'gfrom' : '$from' , 'gto' : '$to'},
       'total' : { '$sum' : 1 }
    }
},{
    '$sort' : { 'total' : 1 }
}
])
