INSERT INTO `addon_account` (name, label, shared) VALUES 
    ('society_ghost', 'ghost', 1)
;

INSERT INTO `datastore` (name, label, shared) VALUES 
    ('society_ghost', 'ghost', 1)
;

INSERT INTO `addon_inventory` (name, label, shared) VALUES 
    ('society_ghost', 'ghost', 1)
;

INSERT INTO `jobs` (`name`, `label`, `whitelisted`) VALUES
    ('ghost', 'ghost', 1)
;

INSERT INTO `job_grades` (`job_name`, `grade`, `name`, `label`, `salary`) VALUES
    ('ghost', 0, 'recrue', 'Recrue', 0),
    ('ghost', 1, 'membre', 'Membre', 0),
    ('ghost', 2, 'coboss', 'Sous Chef', 0),
    ('ghost', 3, 'boss', 'Chef', 0)
;
