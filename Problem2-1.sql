-- Alexey Milovanov
-- Comp-269 Final Exam
-- 12.17.18
-- Instructor: Dr. Yin Bao

-- Problem 2
    
use university;

INSERT INTO student

VALUES
(1,'Giannis', 'Antetokoumoo', 'CS', 100),
(2,'Mike', 'Conlev', 'CS', 80),
(3,'DeMar', 'DeRozan', 'ART', 90),
(4,'Kyrie', 'Irvina', 'ART', 88);

INSERT INTO faculty
VALUES
(10,'Werito', 'STEM', 'Instructor'),
(20,'Ratidi', 'STEM', 'Professor'),
(30,'DeMar', 'ENG', 'Professor'),
(40,'Kyrie', 'ENG', 'Instructor');

INSERT INTO class

VALUES
(12, 20, 'MW', 100),
(23, 30, 'MTh', 110),
(34, 10, 'MTh', 115),
(45, 40, 'MW', 100);

INSERT INTO enroll
VALUES
(1, 23, 80),
(2, 34, 90),
(3, 45, 100),
(4, 45, 89);
