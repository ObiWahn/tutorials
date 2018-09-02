use blog
db.posts.aggregate([
    {$project:{ '_id':0, comments:1}},
    {$unwind:'$comments'},
    {$project:{author:'$comments.author'}},
    {$group:{"_id":{author:"$author"},posts:{$sum:1}}},
    {$sort:{posts:-1}},
    {$limit:1}
])

