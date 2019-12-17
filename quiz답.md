### quiz

```

# 함수사용법 : 90% 이상 사용되는 언어 출력

select count(disinct(language)) as count
from countrylanguage
where percentage >= 99
order by language						// 14
```

```
1. country 테이블에서 중복을 제거한 Continent를 조회하세요.

slect distinct(continent)
from country
```

```
2. Sakila 데이터베이스에서 국가가 인도고객의 수를 출력하세요.

use sakila
select country, count(country) as count
from customer_list
where country = "India"
```

```
3. 한국도시중에 인구가 100만이 넘는 도시를 조회하여 인구순으로 내림차순하세요.

select name, population
from city
where countrycode = "KOR" and population > 1000000
```

```
4. city 테이블에서 population이 800만 ~ 1000만 사이인 도시데이터를 인구수순으로 내림차순하세요.
```

```
5. country 테이블에서 1940 ~ 1950년도 사이에 독립한 국가들을 조회하고 독립한 년도 순으로 오름차순하세요. 
```

```
6. contrylanguage 테이블에서 스페인어, 한국어, 영어를 95%이상 사용하는 국가 코드를 Percentage로 내림차순하여 아래와 같이 조회하세요.
```

## day_2

select *

from country

```
# group by : count, max, min, avg, var_samp, stddev
# city 테이블에서 국가별 도시의 갯수를 출력

select countrycode, count(countrydcode)
from city
group by countrycode
```

````
# 대륙별 인구수와 GNP 최대값을 조회
select continent, max(population), max(GNP)
from country
where GNP > 0 // GNP가 0이상인것들만
group by continent
````

```
use sakila

select customer_id, staff_id, sum(amount)
from payment
group by customer_id, staff_id
with rollup  //
```

