INSERT INTO `addon_account` (name, label, shared) VALUES 
    ('society_vagos', 'vagos', 1)
;

INSERT INTO `datastore` (name, label, shared) VALUES 
    ('society_vagos', 'vagos', 1)
;

INSERT INTO `addon_inventory` (name, label, shared) VALUES 
    ('society_vagos', 'vagos', 1)
;

INSERT INTO `jobs` (`name`, `label`, `whitelisted`) VALUES
    ('vagos', 'vagos', 1)
;

INSERT INTO `job_grades` (`job_name`, `grade`, `name`, `label`, `salary`) VALUES
    ('vagos', 0, 'recrue', 'Recrue', 0),
    ('vagos', 1, 'membre', 'Membre', 0),
    ('vagos', 2, 'coboss', 'Sous Chef', 0),
    ('vagos', 3, 'boss', 'Chef', 0)
;
