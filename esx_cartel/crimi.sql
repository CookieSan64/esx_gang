INSERT INTO `addon_account` (name, label, shared) VALUES 
    ('society_cartel', 'cartel', 1)
;

INSERT INTO `datastore` (name, label, shared) VALUES 
    ('society_cartel', 'cartel', 1)
;

INSERT INTO `addon_inventory` (name, label, shared) VALUES 
    ('society_cartel', 'cartel', 1)
;

INSERT INTO `jobs` (`name`, `label`, `whitelisted`) VALUES
    ('cartel', 'cartel', 1)
;

INSERT INTO `job_grades` (`job_name`, `grade`, `name`, `label`, `salary`) VALUES
    ('cartel', 0, 'recrue', 'Recrue', 0),
    ('cartel', 1, 'membre', 'Membre', 0),
    ('cartel', 2, 'coboss', 'Sous Chef', 0),
    ('cartel', 3, 'boss', 'Chef', 0)
;
