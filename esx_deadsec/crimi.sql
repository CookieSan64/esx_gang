INSERT INTO `addon_account` (name, label, shared) VALUES 
    ('society_deadsec', 'deadsec', 1)
;

INSERT INTO `datastore` (name, label, shared) VALUES 
    ('society_deadsec', 'deadsec', 1)
;

INSERT INTO `addon_inventory` (name, label, shared) VALUES 
    ('society_deadsec', 'deadsec', 1)
;

INSERT INTO `jobs` (`name`, `label`, `whitelisted`) VALUES
    ('deadsec', 'deadsec', 1)
;

INSERT INTO `job_grades` (`job_name`, `grade`, `name`, `label`, `salary`) VALUES
    ('deadsec', 0, 'recrue', 'Recrue', 0),
    ('deadsec', 1, 'membre', 'Membre', 0),
    ('deadsec', 2, 'coboss', 'Sous Chef', 0),
    ('deadsec', 3, 'boss', 'Chef', 0)
;
