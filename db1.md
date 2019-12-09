# Data Base_Date_1

DB (Database): 데이터를 통합하여 관리하는 데이터의 집합

DBMS (Database Management System): 데이터 베이스를 관리하는 미들웨어 시스템,데이터 베이스

RDBMS (Relational Database Manafement System): Oracle, Mysql, Postgresql, Sqlite // 데이터의 테이블 사이에 키값으로 관계를 가지고 있는 데이터 베이스

NoSQL: Mongfodb, Hbase, Cassandra // 데이터 테이블 사이의 관계가 없이 데이터를 저장하는 데이터 베이스, 데이터사이의 과계가 없으므로 복잡성ㅇ ㅣ작고 많은 데이터의 저장이 가능



MySQL의 특징

- 오픈소스이며 다중 사용자와 다중 스레드 지원

- 다양한 운영체제에 다양한 프로그래밍 언어 지원

- 표준 SQL을 사용

- 작고 강력하며 가격이 저렴

  ![](/Users/hongbeen/Library/Application Support/typora-user-images/image-20191209202207843.png)

  

  

  

  ## Mysql설치 및 설정

```
AWS EC2 인스턴스에 Ubuntu OS에 MySQL 5.7.x 버전 설치
EC2 인스턴스 생성
- t2.micro
- Ubuntu 18.04 버전
- 보안그룹에서 3306 포트 추가
EC2인스턴스에 접속
# pem파일 400권한으로 변경
$ ssh -i ~/.ssh/rada.pem ubuntu@15.164.231.87

# apt-get 업데이트
$ sudo apt-get update -y
$ sudo apt-get upgrade -y

# MySQL Server 설치
$ sudo apt-get install mysql-server

# MySQL secure 설정
$ sudo mysql_secure_installation
Would you like to setup VALIDATE PASSWORD plugin? N
New password: wps
Re-enter new password: wps
Remove anonymous users? Y
Disallow root login remotely? N
Remove test database and access to it? Y
Reload privilege tables now? Y
```

```
# MySQL 패스워드 설정
$ sudo mysql
mysql> SELECT user,authentication_string,plugin,host FROM mysql.user;
mysql> ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password
BY 'wps';
mysql> FLUSH PRIVILEGES;
mysql> SELECT user,authentication_string,plugin,host FROM mysql.user;
mysql> exit
```

```
# 설정한 패스워드를 입력하여 접속
$ mysql -u root -p // -u는 user, -p는 password
```

```
# 외부접속 설정
$ sudo vi / etc/mysql/mysql.conf.d/mysqld.cnf
```

```
# bind-address를 127.0.0.1을 0.0.0.0 으로 변경
-------------------------------------------------------
bind-address = 0.0.0.0
-------------------------------------------------------
```

```
# 외부접속 패스워드 설정
mysql> grant all privileges on *.* to root@'%' identified by 'wps';
```

```
# 서버 시작 종료 상태확인
$ sudo systemctl start mysql.service
$ sudo systemctl stop mysql.service
$ sudo systemctl restart mysql.service
$ sudo systemctl status mysql.service
```

```
# 설정 후 서버 재시작으로 설정 내용 적용
$ sudo systemctl restart mysql.service
```

```
# password 변경: wps로 패스워드를 변경하는 
mysql> ALTER USER 'root@'localhost' IDENTIFIED BY 'wps';
```





## 샘플 데이터 추가

```
아래 링크에서  world와 sakila데이터 베이스 다운로드

https://dev.mysql.com/doc/index-other.html

# 서버로 sql파일을 전송
$ scp -i ~/.ssh/rada.pem ~/Desktop/sql/* ubuntu@15.164.231.87:~/

# 데이터 베이스 생성
$ mysql -u root -p
sql> create database world;
sql> create database sakila;
sql> create database employees;
sql> quit

# 데이터 베이스에 데이터 추가
$ mysql -u root -p world < world.sql
$ mysql -u root -p sakila < sakila-schema.sql
$ mysql -u root -p sakila < sakila-data.sql
$ mysql -u root -p employees < employees.sql
```



## Mysql Workbench 사용법

Mysql Management Tool
Workbench 다운로드 및 설치
https://dev.mysql.com/downloads/workbench/

**Workbench를 이용한 접속**

![image-20191209204048982](/Users/hongbeen/Library/Application Support/typora-user-images/image-20191209204048982.png)



Test Connection

![image-20191209204155985](/Users/hongbeen/Library/Application Support/typora-user-images/image-20191209204155985.png)



## 데이터 베이스 모델링

데이터 베이스 모델링은 데이터 베이스에서의 테이블 구조를 미리 계획해서 작성이다.RDBMS는 테이블간에 유기적으로 연결되어 있기 때문에 모델링을 잘하는 것이 중요하다.기본적으로 개념적 모델링,논리적 모델링,물리적 모델링 절차로 설계된다.

**개념적 모델링**: 업무분석해서 핵심 데이터의 집합을 정의하는 과정

![image-20191209204308288](/Users/hongbeen/Library/Application Support/typora-user-images/image-20191209204308288.png)

**논리적 모델링**: 개념적 모델링을 상세화하는 과정

![image-20191209204358386](/Users/hongbeen/Library/Application Support/typora-user-images/image-20191209204358386.png)

**물리적 모델링**: 논리적 모델링을 DBMS에 추가하기 위해 구체화되는 과정

![image-20191209204541070](/Users/hongbeen/Library/Application Support/typora-user-images/image-20191209204541070.png)

**관계선의 의미**

점선: 식별관계 / 부모가 있어야 자식이 생성됨

실선: 비식별관계 / 부모가 없어도 자식이 생성됨

![image-20191209204643551](/Users/hongbeen/Library/Application Support/typora-user-images/image-20191209204643551.png)

## SQL문의 종류: DML DDL DCL

**DML** (Data Manipulation Language)

데이터 조작어

데이터검색,삽입,수정,삭제등에 사용

SELECT, INSERT, UPDATE, DELETE

트랜젝션이 발생하는 SQL문



**DDL** (Data Definition Language)

데이터 정의어

데이터 베이스, 테이블, 뷰, 인덱스등의 데이터 베이스 개체를 생성, 삭제, 변경에 사용 / CREATE, DROP, ALTER, TRUNCATE



**DCL** (Data Control Language)

데이터 제어어

사용자의 권한을 부여하거나 빼앗을때 사용

GRUNT, REVORKE, DENY



```
SELECT FROM
데이터를 검색할때 사용되는 문법
SELECT <abc_1>, <abc_2>,...
FORM <table_name>

WHERE
특정 조건을 주어 데이터를 검색하는데 사용되는 문법
#비교연산
1억이 넘는 국가를 출력
SELECT *
FROM country
WHERE Population >= 100000000
# 논리연산: AND, OR
# 인구가 7000만에서 1억인 국가를 출력
SELECT *
FROM country
WHERE Population >= 70000000 AND Population <= 100000000
# 범위연산 : BETWEEN
# 인구가 7000만에서 1억인 국가를 출력
SELECT *
FROM country
WHERE Population BETWEEN 70000000 AND 100000000
# 아시아와 아프리카대륙의 국가데이터를 출력
SELECT *
FROM country
WHERE Continent = "Asia" OR Continent = "Africa"
# 특정 조건을 포함: IN, NOT IN
# 아시아와 아프리카 대륙의 국가 데이터를 출력
SELECT *
FROM country
WHERE Continent IN ("Asia", "Africa")
# 아시아와 아프리카대륙의 국가가 아닌 데이터를 출력
SELECT *
FROM country
WHERE Continent NOT IN ("Asia", "Africa")

ORDER BY
특정 컬럼의 값으로 데이터정렬에 사용되는 문법
# 오름차순 인구순으로 리스트를 출력
SELECT *
FROM country
ORDER BY population ASC
#내림차순 인구순으로 리스트를 출력
SELECT *
FROM country
ORDER BY population DESC


LIMIT
LIMIT은 조회하는 데이터의 수를 제한할 수 있습니다.
# 상위 5개 데이터를 출력
SELECT *
FROM country
ORDER BY population DESC
LIMIT 5
# 상위 6위~8위의 데이터를 출력
SELECT *
FROM country
ORDER BY population DESC
LIMIT 5, 3
```

