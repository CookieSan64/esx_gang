INSERT INTO `addon_account` (name, label, shared) VALUES 
    ('society_ballas', 'Ballas', 1)
;

INSERT INTO `datastore` (name, label, shared) VALUES 
    ('society_ballas', 'Ballas', 1)
;

INSERT INTO `addon_inventory` (name, label, shared) VALUES 
    ('society_ballas', 'Ballas', 1)
;

INSERT INTO `jobs` (`name`, `label`, `whitelisted`) VALUES
    ('ballas', 'Ballas', 1)
;

INSERT INTO `job_grades` (`job_name`, `grade`, `name`, `label`, `salary`) VALUES
    ('ballas', 0, 'recrue', 'Recrue', 0),
    ('ballas', 1, 'membre', 'Membre', 0),
    ('ballas', 2, 'coboss', 'Sous Chef', 0),
    ('ballas', 3, 'boss', 'Chef', 0)
;
