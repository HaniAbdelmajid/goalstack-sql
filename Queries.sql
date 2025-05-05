
-- Showing Each Users Goals
SELECT u.name, u.email, g.goal_title
FROM Users u
INNER JOIN Goals g 
ON u.user_id = g.user_id;


-- Show the Tasks for each Goal
SELECT g.goal_title, t.task_title, t.status, t.priority
FROM Goals g
INNER JOIN Tasks t 
ON g.goal_id = t.goal_id;


-- Show the number of Tasks per Goal
SELECT g.goal_title, COUNT(*) AS task_count
FROM Goals g
INNER JOIN Tasks t 
ON g.goal_id = t.goal_id
Group by g.goal_id;


-- Total Time Spent Per Task
SELECT t.task_title, SUM(time_spent) AS total_time
FROM Tasks t
INNER JOIN Progress_logs p 
ON t.task_id = p.task_id
GROUP BY t.task_id
ORDER BY SUM(time_spent) DESC;


-- Total Time Spent For Each User
SELECT u.name, IFNULL(SUM(p.time_spent),0) AS total_minutes_logged
FROM Users u
INNER JOIN Goals g ON u.user_id = g.user_id
INNER JOIN Tasks t ON g.goal_id = t.goal_id
LEFT OUTER JOIN Progress_logs p ON t.task_id = p.task_id
GROUP BY u.user_id
ORDER BY Total_minutes_logged DESC;


-- Find The Goals that Are Equal To or Less than 50% Of Their Tasks Marked 'done'
SELECT g.goal_title, u.name AS user_name, 
COUNT(t.task_id) AS total_tasks, 
SUM(CASE WHEN t.status = 'done' THEN 1 ELSE 0 END) AS completed_tasks,
ROUND(SUM(CASE WHEN t.status = 'done' THEN 1 ELSE 0 END) * 100.0 / COUNT(t.task_id), 1) AS completion_percent
FROM Goals g
INNER JOIN Users u ON g.user_id = u.user_id
INNER JOIN Tasks t ON g.goal_id = t.goal_id
GROUP BY g.goal_id
HAVING ROUND(SUM(CASE WHEN t.status = 'done' THEN 1 ELSE 0 END) * 100.0 / COUNT(t.task_id), 1) <= 50;


