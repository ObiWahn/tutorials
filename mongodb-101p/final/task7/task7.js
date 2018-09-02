use obi
//db.albums.findOne()

print("before deletion")
db.images.find({ "tags" : "kittens" }).count()

print("aggregation")
var rv = db.albums.aggregate([
{
    "$project" : { "images" : 1 }
},{
    "$unwind" : "$images"
},{
    "$group" : {
        "_id" : "List of Images",
        "image_list" : { "$addToSet" : "$images" }
    }
}
])

var image_list = rv.result[0].image_list

print("aggregation2")
//for (image in image_list){
//    print("searching for image: " + image)
//    res = db.images.findOne({ "_id" : image })
//    print(res)
//}

image_list.forEach(function(val,idx){
    res = db.images.update({ "_id" : val }, { "$set" : { "inAlbum" : true} })
})
db.images.remove({"inAlbum" : null },false)

print("after deletion")
db.images.find({}).count()
db.images.find({ "tags" : "kittens" }).count()
