-- Procedure 1: Logs time for a certain task and updates the tasks status to 'in progress' if it was 'pending'
DELIMITER //

CREATE PROCEDURE log_time (
	IN task_id_input INT,
    IN minutes_input INT
)

BEGIN
	-- Inserting the log
    IF minutes_input <= 0 THEN
		SIGNAL SQLSTATE '45000'
			SET MESSAGE_TEXT = 'Time logged must be greater than 0 minutes';
	END IF;
    
    INSERT INTO Progress_logs(task_id, time_spent)
    VALUES(task_id_input, minutes_input);
    
    -- If the status is 'pending', update to 'in progress'
    UPDATE Tasks
    SET status = 'in progress'
    WHERE task_id = task_id_input AND status = 'pending';
END;
//

DELIMITER ;


-- Procedure 2: Deletes a goal, all its respective tasks and its progress logs
DELIMITER //

CREATE PROCEDURE delete_goal (
	IN goal_id_input INT
)
BEGIN
	-- Delete the progress logs for tasks under this goal
    DELETE FROM Progress_logs
    WHERE task_id IN (
		SELECT task_id FROM Tasks WHERE goal_id = goal_id_input
    );
    
    -- Delete the tasks under this goal
    DELETE FROM Tasks
    WHERE goal_id = goal_id_input;
    
    -- Delete the goal itself
    DELETE FROM Goals
    WHERE goal_id = goal_id_input;
END;
//

DELIMITER ;


-- Procedure 3: It will return the total goals, total tasks, completed tasks, and % complete
DELIMITER //

CREATE PROCEDURE user_progress_summary (
	IN user_id_input INT
)
BEGIN
	SELECT
		u.name AS user_name,
        COUNT(DISTINCT g.goal_id) AS total_goals,
        COUNT(t.task_id) AS total_tasks,
        SUM(CASE WHEN t.status = 'done' THEN 1 ELSE 0 END) AS completed_tasks,
        ROUND(SUM(CASE WHEN t.status = 'done' THEN 1 ELSE 0 END) * 100.0 / COUNT(t.task_id), 1) AS completion_percent
	FROM Users u
    JOIN Goals g ON u.user_id = g.user_id
    JOIN Tasks t ON g.goal_id = t.goal_id
    WHERE u.user_id = user_id_input
    GROUP BY u.user_id;
END;
//

DELIMITER ;
        