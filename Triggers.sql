-- TRIGGER 1: Auto Log When A Task Is Marked As 'done'
DELIMITER //

CREATE TRIGGER trg_log_task_done
AFTER UPDATE ON Tasks
FOR EACH ROW
BEGIN
	IF NEW.status = 'done' AND OLD.status <> 'done' THEN
		INSERT INTO Progress_logs (task_id, time_spent)
        VALUES (NEW.task_id, 0);
	END IF;
END;
//

DELIMITER ;


-- TRIGGER 2: Only Allow A Delete On A Goal If It Was Created With In The Last 30 Days
DELIMITER //

CREATE TRIGGER trg_prevent_old_goal_delete
BEFORE DELETE ON Goals
FOR EACH ROW
BEGIN
	IF DATEDIFF(NOW(), OLD.created_at) > 30 THEN
		SIGNAL SQLSTATE '45000'
			SET MESSAGE_TEXT = 'Cannot delete goals older than 30 days';
	END IF;
END;
//

DELIMITER ;
USE goalstack


-- Trigger 3: It will Auto-create a default task when a new goal is inserted
DELIMITER //

CREATE TRIGGER trg_auto_default_task
After INSERT ON Goals
FOR EACH ROW
BEGIN
	INSERT INTO Tasks (goal_id, task_title, status, priority)
    VALUES (NEW.goal_id, 'Set a timeline', 'pending', 3);
END;
//

DELIMITER ;