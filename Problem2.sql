-- Alexey Milovanov
-- Comp-269 Final Exam
-- 12.17.18
-- Instructor: Dr. Yin Bao

-- Problem 2
    
use university;

INSERT INTO student
(firstName, lastName, major, credits)
VALUES
('Giannis', 'Antetokoumoo', 'CS', 100),
('Mike', 'Conlev', 'CS', 80),
('DeMar', 'DeRozan', 'ART', 90),
('Kyrie', 'Irvina', 'ART', 88);

INSERT INTO faculty
(lastName, department, rank)
VALUES
('Werito', 'STEM', 'Instructor'),
('Ratidi', 'STEM', 'Professor'),
('DeMar', 'ENG', 'Professor'),
('Kyrie', 'ENG', 'Instructor');

INSERT INTO class
(classSchedule, room)
VALUES
('MW', 100),
('MTh', 110),
('MTh', 115),
('MW', 100);

INSERT INTO enroll
(grade)
VALUES
(80),
(90),
(100),
(89);
