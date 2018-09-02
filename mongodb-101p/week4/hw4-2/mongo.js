use homework4

db.products.drop()

db.products.insert({
    'brand':'fuddel',
    'price':40,
    'category' : 'hummel',
    'reviews' : [
        {
            'author' : 'supergrobi'
        }
    ]
})

db.products.insert({
    'brand':'huddel',
    'price':90,
    'category' : 'mors',
    'reviews' : [
        {
            'author' : 'obelaf'
        }
    ]
})


print('creating indexes')
db.products.ensureIndex({'price':-1})
db.products.ensureIndex({'category':1, 'brand':1})

print('query 1')
db.products.find({'brand':"GE"}).explain()
print('query 2')
db.products.find({'brand':"GE"}).sort({price:1}).explain()
print('query 3')
db.products.find({$and:[{price:{$gt:30}},{price:{$lt:50}}]}).sort({brand:1}).explain()
print('query 4')
db.products.find({brand:'GE'}).sort({category:1, brand:-1}).explain()
