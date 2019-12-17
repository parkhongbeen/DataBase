```
인코드 - 코드로 되어있는 알파벳을 숫자로 바꿔주는것

디코드 - 인코딩의 반대 개념,즉 부호를 복호(원래의 정보로 되돌리다)하는 작업
```

### SQL문의 종류 - DML, DDL, DCL

#### DML(데이터 조작어): 데이터베이스의 테이블에 들어 있는 데이터에 변형을 가하는 종류

- INSERT : 데이터입력
- UPDATE : 데이터수정
- DELETE : 데이터삭제

#### DDL(데이터 정의어): 테이블과 같은 데이터 구조를 정의하는데 사용되는 명령어들로 데이터 구조와 관련된 명령어들을 말한다

- CREATE : 데이터베이스, 테이블 생성
- ALTER : 데이터베이스, 테이블 변경
- DROP : 데이터베이스, 테이블 삭제
- RENAME : 데이터베이스. 객체이름변경
- TRUNCATE : 테이블을 초기화상태로

#### DCL(데이터 제어어): 데이터베이스에 접근하고 객체들을 사용하도록 권한을 주고 회수하는 명령어들을 말함

- GRANT : 권한부여
- REVOKE : 권한취소

#### TCL(트랜잭션 제어어): 논리적인 작업의 단위를 묶어서 DML에 의해 조작된 결과를 작업단별로 제어하는 명령어를 말함

- COMMIT : 트랜잭션 종료처리 저장
- ROLLBACK : 트랜잭션 취소
- SAVEPOINT : 임시저장

#### Date & Time

DATE: 날짜를 저장하는 데이터 타입,기본 포멧은 "년-월-일"

DATETIME: 날짜와 시간을 저장하는 데이터 타입,기본 포멧은 "년-월-일 시:분:초"

TIMESTAME: 날짜와 시간을 저장하는 데이터 타입, DATETIME과 다른점은 날짜를 입력하지 않으면 현재 날짜와 시간을 자동으로 저장할 수 있는 특징이 있음

TIME: 시간을 저장하는 데이터 타입, 기본 포멧은 "시:분:초"

YEAR: 연도를 저장할 수 있는 데이터 타입 / YEAR(2) 는 2자리의 연도를 저장할 수 있으며,YEAR(4)는 4자리의 연도를 저장할 수 있음

#### Constraint: 제약조건

NOT NULL: NULL값을 저장할 수 없음

UNIQUE: 같은 값을 저장할 수 없음

PRIMARY KEY: NOT NULL과 UNIQUE의 제약을 동시에 만족해야함,컬럼에 비어 있는 값과 동일한 값을 저장할 수 없음

FOREIGN KEY: 다른 테이블과 연겨되는 값이 저장

DEFAULT: 데이터를 저장할때 해당 컬럼에 별도의 저장값이 없으면 DEFAULT로 설정된 값이 저장됨

AUTO_INCREMENT: 주로 테이블의 PRIMARY KEY데이터를 저장할때 자동으로 숫자를 1씩 증가시켜주는 기능으로 사용함

#### CEIL, ROUND, TRUNCATE는 소수점 올림, 반올림, 버림 함수이다

CEIL: 실수 데이터를 올림 할 때 사용

ex) SELECT CEIL(12.345)  # 12.345를 올림하여 정수로 나타냄

ROUND: 실수데이터를 반올림 할 때 사용

ex) SELECT ROUND(12.345, 2) # 12.345를 소수 둘째자리까지 나타내고 소수 셋째자리에서 반올림

TRUNCATE: 실수 데이터를 버림 할 때 사용

ex) SELETE TRUNCATE(12.345, 2) # 12.345를 소수 둘째자리까지 나타내고 소수 셋째자리에서 버림



DATE_FORMAT: 날짜 데이터에 대한 포멧을 바꿔줌

ex) SELECT DATE_FORMAT(payment_date, "%Y-%m")AS monthly, SUM(amount) AS amount FROM payment

GROUP BY monthly



#### SQL에서도 다른 언어에서처럼 조건문 사용이 가능함.(IF, CASE)

##### IF(조건, 참, 거짓)

ex) 도시 인구가 100만이 넘으면 ""big city"그렇지 않으면 "small city"를 출력하는 city_scale 컬럼을 추가

SELECT name, population, IF(population > 1000000, "big city", "small city")AS city_scale FROM city

###### IFNULL(참, 거짓)

ex) 독립년도가 없는 데이터는 0으로 출력

SELECT IndepYear, IFNULL(IndepYear, 0) as IndepYear

FROM country

##### CASE

CASE

​			WHEN (조건1) THEN (출력1)

​			WHEN (조건2) THEN (출력2)

END AS (컬럼명)

ex) 나라별로 인구가 10억 이상, 1억 이상, 1억 이하인 컬럼을 추가하여 출력

SELECT name, population,

​			CASE

​						WHEN population > 1000000000 THEN "upper 1 bilion"

​						WHEN population > 100000000 THEN "upper 100 milion"

​						ELSE " below 100 milion

#### JOIN: 여러개의 테이블에서 데이터를 모아서 보여줄 때 사용됨

- INNER JOIN : 두 테이블 사이에 공통된 값이 없는 row는 출력하지 않는다.

- LEFT JOIN : 왼쪽 테이블을 기준으로 왼쪽 테이블의 모든 데이터가 출력되고 매핑되는 키값이 없으면 NULL로 출력된다.

- RIGHT JOIN : 오른쪽 테이블을 기준으로 왼쪽 테이블의 모든 데이터가출력되고 매핑되는 키값이 없으면 NULL로 출력된다.

  ![image-20191217114200708](/Users/hongbeen/Library/Application Support/typora-user-images/image-20191217114200708.png)

#### UNION

SELETE문의 결과데이터를 하나로 합쳐서 출력. 컬럼의 갯수와 타입,순서가 같아야 함. 자동으로 distinct를 하여 중복을 제거해줌, 중복제거를 안하고 컬럼 데이터를 합치고 싶으면 UNION ALL을 사용



#### Sub Query

query문 안에 있는 query를 의미함. SELECT절 FROM절, WHERE등에 사용이 가능함

#### VIEW

가상 테이블로 특 정수로 데이터만 보고자 할 때 사용합니다.실제 데이터를 저장하고 있지는 않습니다.한마디로 특정 컬럼의 데이터를 보여주는 역할만 맣ㅂ니다.뷰를 사용함으로 퀴리를 더 단순하게 만들 수 있습니다.한번 생성된 뷰는 수정이 불가능하며 인덱스설정이 불가능합니다.