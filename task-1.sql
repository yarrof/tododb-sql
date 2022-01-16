-- Create two tables, one to store the users and one for the todos
CREATE TABLE "user"(
    id INT PRIMARY KEY,
    "name" VARCHAR(50)
);
CREATE TABLE todo(
    id INT PRIMARY KEY,
    task VARCHAR(100),
	user_id INT,
    FOREIGN KEY(user_id) REFERENCES "user"(id)
);