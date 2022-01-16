-- Add a column to the todo table
ALTER TABLE todo
ADD done BOOLEAN DEFAULT false;