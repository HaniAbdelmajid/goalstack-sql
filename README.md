# goalstack-sql

A MySQL-based system to manage user goals, tasks, and activity logs using advanced SQL features.

## # Overview
GoalStack is a structured SQL project that tracks users, their goals, the tasks under those goals, and the time they log toward each task. It demonstrates strong database design, complex queries, and automation using triggers and stored procedures.

## # Features
- Normalized relational schema (Users, Goals, Tasks, Progress_logs)
- Advanced SQL queries (JOINs, aggregates, CASE, GROUP BY)
- Triggers for automation (e.g., auto-log completion, block deletions)
- Stored procedures for reusable logic (e.g., log_time, delete_goal)
- Clean ERD diagram for schema visualization

## # Files
- schema.sql – Create tables and define relationships
- insert_data.sql – Sample dataset for testing
- queries.sql – Sample analysis and reporting queries
- procedures.sql – Custom business logic procedures
- triggers.sql – Database event triggers
- erd.png – Entity Relationship Diagram
- README.md – Project documentation

## # How to Use
- Download MySQl, set up a connection, then do the following:
1. Run `schema.sql` to create all tables
2. Run `insert_data.sql` to populate the database
3. Explore `queries.sql` for reporting logic
4. Review or execute `procedures.sql` and `triggers.sql` to automate behaviors
