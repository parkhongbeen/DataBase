# view
# 가상 테이블 = 실제 데이터틑 저장하지는 않습니다.
# 복잡한ㅋ 쿼리문을 간단하게 만들어주는 효과가 있습니다.
# 수정이 불가능하며 인덱스 설정이 불가능합니다.

CREATE VIEW code_name AS

select code, name
from country

select *
from city
join country
on city.countrycode = code_name.code

# Index
# 테이블에서 데이터 검색을 빠르게 해줄 수 있는 기능


