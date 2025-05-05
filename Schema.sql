DROP TABLE Users;  -- Drop Tables if needed
DROP TABLE Goals;
DROP TABLE Tasks;
DROP TABLE Progress_logs;


-- A User
CREATE TABLE Users (
	user_id INT AUTO_INCREMENT, -- Unique user_id ( increments by 1 each time a user is added to the DB )
    name VARCHAR(255),
    email VARCHAR(255),
    CONSTRAINT PK_Users PRIMARY KEY (user_id)
);


-- A Goal created by the user to be completed
CREATE TABLE Goals  ( 
	goal_id INT AUTO_INCREMENT,  -- Unique goal_id ( increments by 1 each time a user is added to the DB )
    user_id INT,
    goal_title VARCHAR(255),
    created_at DATETIME DEFAULT NOW(),  -- If user has not given a date the default date will be the current time the Goal was created
    
    CONSTRAINT PK_Goals PRIMARY KEY (goal_id),
    CONSTRAINT FK_Goals FOREIGN KEY (user_id) REFERENCES Users(user_id)
);


-- Each Goal needs to have a task or many tasks
CREATE TABLE Tasks (
	task_id INT AUTO_INCREMENT,  -- Unique task_id ( increments by 1 each time a user is added to the DB )
    goal_id INT,
    task_title VARCHAR(255),
    status ENUM('pending', 'in progress', 'done') DEFAULT 'pending',  -- If not specified by the user the default value will be pending ( not completed yet )
    priority INT DEFAULT 3 CHECK (priority BETWEEN 1 AND 5),  -- If user does not give a specific priority number 1-5, its given 3 ( medium ) by default
    
    CONSTRAINT PK_Tasks PRIMARY KEY (task_id),
    CONSTRAINT FK_Tasks FOREIGN KEY (goal_id) REFERENCES Goals(goal_id)
    
);


-- Tracks the time user spent on a task
CREATE TABLE Progress_logs (
	log_id INT AUTO_INCREMENT,
    task_id INT,
    time_spent INT,
    date_logged DATETIME DEFAULT NOW(),
    
    CONSTRAINT PK_Progress_logs PRIMARY KEY (log_id),
    CONSTRAINT FK_Progress_logs FOREIGN KEY (task_id) REFERENCES Tasks(task_id)
);