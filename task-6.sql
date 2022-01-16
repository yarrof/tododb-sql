-- Delete tasks from the todo table that are done already
DELETE FROM todo
WHERE done=true;
