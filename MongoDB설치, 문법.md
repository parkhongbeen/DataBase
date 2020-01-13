### MongoDB

> install mongodb

```
$ sudo apt update -y
$ sudo apt upgrade -y
$ sudo apt install -y mongodb
$ sudo systemctl status mongodb
$ sudo vi /etc/mongodb.conf
# bind_ip = 0.0.0.0
# auth = true
# 패스워드 설정
$ mongo
> use admin
> db.createUser({ user: "test", pwd: "testpw", roles: [ "root" ] })
> quit()
$ sudo systemctl restart mongodb
# aws 인스턴스 27017 포트 접속 허용

mongo명령어 입력시 mongo shell에 접속됩니다.
```

> **install robomongo**
>
> https://robomongo.org/ 페이지에서 경로에서 ROBO 3T 다운로드 후 설치 합니다.

> **Connection**
>
> MongoDB Connections에서 ip를 입력하여 서버의 mongoDB에 접속합니다.
>
> <img width="474" alt="스크린샷 2020-01-13 오후 8 10 32" src="https://user-images.githubusercontent.com/53684676/72251395-33ea7900-3641-11ea-8037-4a1c036f4920.png">



> mysql과 mongodb

| mysql | mongodb    |
| ----- | ---------- |
| table | collection |
| row   | document   |

```
Create Database
# Mongo라는 데이터베이스 생성
use Mongo
# 현재 사용중인 데이터베이스 확인
db
# 데이터베이스 리스트 확인
show dbs
```

````
# document 생성
user mongo
db.user.insert({"name": "hongbeen", "age": 28, "email": 123@naver.com })

# 현재 사용중인 데이터 삭제
db.dropdatabase()
````

```
Create Collection
# name: collection 이름
db.createCollection(name, [option])
# option
# autoIndex : true로 설정하면 _id 필드에 index가 자동으로 생성됩니다.
# size : 숫자 데이터를 사용하며 collection의 최대 사이즈를 byte 단위로 지정
# max : 숫자 데이터를 사용하며 최대 document 갯수를 설정

# user 컬렉션을 생성
db.createCollection("user")

# autoIndex와 max 옵션을 설정하여 info 컬렉션을 생성
db.createCollection("info1", { autoIndexId: true, capped: true, size: 500, max:5 })
db.createCollection("info2", { autoIndexId: true, capped: true, size: 50, max:5 })

# createCollection을 사용하지 않고 article 컬렉션을 생성
db.articles.insert( {"title":"data science", "contents":"mongodb" } )

# 컬렉션 list 확인
show.collections

# articles 컬렉션 삭제
db.articles.drop()
```

``````
# info컬렉션에 document 추가
db.<collection_name>.insert(<document>)

db.info1.insert({"subject": "python", "level":3})
db.info1.insert({"subject": "web", "level":1})
db.info1.insert({"subject": "sql1", "level":2})

# 한번에 여러개의 document 추가
# max:5 옵션 제한에 걸려 5개의 데이터가 info1에 들어간다.

db.info1.insert([
{"subject": "python", "level":3}
{"subject": "web", "level":1}
{"subject": "sql1", "level":2}
{"subject": "python", "level":3}
{"subject": "web", "level":1}
{"subject": "sql1", "level":2}
])

# document 삭제 // level
db.info.remove({level:2})

# document검색
db.collection.find(query, projection) // projection: 보여지는 컬럼을 지정
``````

```
# Find

format
db.collection.find(query, projection)
query: document조회 조건을 설정, 모든 document를 조회할때는 ({})
projection: document를 조회할 때 보여지는 필드를 정의
```

```
# query

# info 컬렉션에 있는 모든 document 조회
db.info.find()
db.getCollection('info').find({})

# subject가 python인 document 조회
db.info.find({"subject": "python"})
```

```
# 비교연산자

# level이 2 이하인 document를 조회
db.info.find({"level": {$lte: 2} })

# level이 3 이상인 document를 조회
db.info.find({"level": {$gte: 3} })

# subject가 java와 python을 포함하는 document 조회
db.info.find( {"subject": {$in: ["java", "python"]}} )
```

```
# 논리연산자

$or : 조건중 하나라도 true이면 true
$and : 모든 조건이 true이면 true
$not : 조건중 하나라도 false이면 true
$nor : 모든 조건이 false이면 true (or와 반대 개념)

# subject가 python이고 level이 3이상인 document 조회
db.info.find({ $and: [ { "subject": "python" }, {"level": {$gte: 3} } ] })

# subject가 python이아니고 level이 1이하가 아닌 document 조회
db.info.find({ $nor: [ { "subject":"python" }, { "level": {$lte: 1} } ] })

# level이 2보다 크지 않은 document 조회 (2 포함)
db.info.find({ "level": { $not: {$gt: 2} } })
```

```
# where

where 연산자를 사용하면 자바스크립트 표현식 사용이 가능합니다.
# level이 1인 document 조회
db.info.find( { $where: "this.level == 1"}
```

```
# basic

# subject와 comments만 출력되도록 find
# 설정을 true 값을 설정하던가 false 값을 설정합니다. ( _id는 따로 설정을 안하면 true )
db.info.find({},{"_id":false, "level":false})
db.info.find({},{"subject":true, "level":true})
db.info.find({},{"_id":false, "subject":true, "level":true})
```

```
# find

find method를 사용하면 find를 사용한 document의 결과를 가공하여 출력할수 있습니다.

# sort

document를 정렬시켜 줍니다.
'sort({key: value})' 와 같은 포멧으로 사용을 하며 key는 정렬할 필드명을 작성하고, value는
오름차순은 1, 내림차순을 -1을 넣어주면 됩니다.

# info 컬렉션의 document를 level 오름차순으로 정렬
db.info.find().sort({"level":1})

# info 컬렉션의 document를 level 내림차순으로 정렬
db.info.find().sort({"level":-1})

# level을 기준으로 내림차순으로 정렬한 후 subject를 기준으로 오름차순으로 정렬
db.info.find().sort({"level":-1, "subject":1})
```

```
# limit

# document의 결과를 level로 내림차순으로 정렬하고 3개까지만 출력
db.info.find().sort({"level":-1}).limit(3)
```

```
# skip

skip은 검색한 document의 시작부분을 설정할때 사용합니다.
# document를 3번째 부터 출력
db.info.find().skip(2)
```

```
# update

db.collection.update( query, update, { upsert: <bool>, multi: <bool> })

upsert : insert와 update의 합성어 (데이터가 있으면 update, 없으면 insert 한다는 의미)
multi : true로 설정되면 여려개의 document를 수정합니다. 기본값은 false

# 특정 document를 새로운 document로 수정하기
db.info.update(
{ "subject": "html" },
{ "subject": "sass", "level":2}
)

db.info.update(
{ "subject": "less" },
{ "subject": "less", "level": 2},
{ "upsert": true },
)
```

```
# $set, $unset
$set을 사용하면 특정 document의 필드를 수정할 수 있습니다.
$unset을 사용하면 특정 document의 필드를 삭제할 수 있습니다.

# level 2를 level 1로 수정 (여러개의 데이터 수정)
db.info.update(
{ level: 2 },
{ $set: { level: 1 } },
{ multi: true }
)

# subject가 sass인 document의 level필드 삭제
db.info.update(
{ subject: "sass" },
{ $unset: {level: 1} }
)
* level: 1의 1은 true를 의미합니다.

# level이 2이하인 데이터를 1로 수정하기
db.info.update(
{ level: {$lte: 2} },
{ $set: {level: 2} },
{ multi: 1},
)
```

```
# function
# 자바스크립트 문법으로 함수작성이 가능합니다.

# skip함수
var showSkip = function(start){
return db.info.find().skip(start)
}
showSkip(3)
```

