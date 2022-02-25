-- The total score of a hacker is the sum of their maximum scores for all of the challenges. 
-- Write a query to print the hacker_id, name, and total score of the hackers ordered by the descending score. 
-- If more than one hacker achieved the same total score, then sort the result by ascending hacker_id. 
-- Exclude all hackers with a total score of  from your result.

-- Hackers: The hacker_id is the id of the hacker, and name is the name of the hacker. 
-- Submissions: The submission_id is the id of the submission, hacker_id is the id of the hacker who made the submission, challenge_id is the id of the challenge for which the submission belongs to, and score is the score of the submission. 

SELECT m.hacker_id, name, SUM(m.score) AS total_score
FROM (
    SELECT hacker_id, challenge_id, MAX(score) AS score
    FROM Submissions 
    GROUP BY hacker_id, challenge_id) AS m
JOIN Hackers AS h ON m.hacker_id = h.hacker_id
GROUP BY m.hacker_id, h.name
HAVING total_score > 0
ORDER BY total_score DESC, m.hacker_id;