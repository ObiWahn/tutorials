use enron

db.messages.aggregate([
{
    '$match' : {
        'headers.From' : 'andrew.fastow@enron.com'
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
    '$match' : {
        'to' : 'jeff.skilling@enron.com'
    }
},{
    '$group' : {
        '_id'   : 'Total Number:',
       'total' : { '$sum' : 1 }
    }
}
])
