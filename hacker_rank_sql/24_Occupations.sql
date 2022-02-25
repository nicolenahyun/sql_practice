-- Pivot the Occupation column in OCCUPATIONS so that each Name is sorted alphabetically and displayed underneath its corresponding Occupation. 
-- The output column headers should be Doctor, Professor, Singer, and Actor, respectively.

-- Note: Print NULL when there are no more names corresponding to an occupation.

-- 각 직업별 Index를 세기 위한 변수 설정
SET @D=0, @P=0, @S=0, @A=0;

-- 문자열의 알파벳순서에서 최솟값(MIN)은 A(a)로 시작하는 것을 추출해줌!
SELECT MIN(Doctor), MIN(Professor), MIN(Singer), MIN(Actor)
FROM (SELECT CASE WHEN Occupation = 'Doctor' THEN Name END AS Doctor,
             CASE WHEN Occupation = 'Professor' THEN Name END AS Professor,
             CASE WHEN Occupation = 'Singer' THEN Name END AS Singer,
             CASE WHEN Occupation = 'Actor' THEN Name END AS Actor,
             CASE
             WHEN Occupation = 'Doctor' THEN (@D:=@D+1)
             WHEN Occupation = 'Professor' THEN (@P:=@P+1)
             WHEN Occupation = 'Singer' THEN (@S:=@S+1)
             WHEN Occupation = 'Actor' THEN (@A:=@A+1)
             END AS RowNumber
       FROM Occupations
       ORDER BY Name) sub
GROUP BY RowNumber