INSERT INTO `addon_account` (name, label, shared) VALUES 
    ('society_carjacker', 'Carjacker', 1)
;

INSERT INTO `datastore` (name, label, shared) VALUES 
    ('society_carjacker', 'Carjacker', 1)
;

INSERT INTO `addon_inventory` (name, label, shared) VALUES 
    ('society_carjacker', 'Carjacker', 1)
;

INSERT INTO `jobs` (`name`, `label`, `whitelisted`) VALUES
    ('carjacker', 'Carjacker', 1)
;

INSERT INTO `job_grades` (`job_name`, `grade`, `name`, `label`, `salary`) VALUES
    ('carjacker', 0, 'recrue', 'Recrue', 0),
    ('carjacker', 1, 'membre', 'Membre', 0),
    ('carjacker', 2, 'coboss', 'Sous Chef', 0),
    ('carjacker', 3, 'boss', 'Chef', 0)
;
