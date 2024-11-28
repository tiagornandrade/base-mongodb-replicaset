# from pymongo import MongoClient


# client = MongoClient(
#     "mongodb://mongo1:27017,mongo2:27018,mongo3:27019/?replicaSet=rs0"
# )
# db = client["test"]

# print(db.list_collection_names())

from pymongo import MongoClient

client = MongoClient(
    "mongodb://base-mongodb-replicaset-mongo1-1:27017,base-mongodb-replicaset-mongo2-1:27018,base-mongodb-replicaset-mongo3-1:27019/test?replicaSet=myReplicaSet",
    serverSelectionTimeoutMS=50000
)

db = client["test"]
collection = db["instance"]

documents = collection.find()

print("Documentos na coleção:")
for doc in documents:
    print(doc)
