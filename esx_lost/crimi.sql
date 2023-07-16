INSERT INTO `addon_account` (name, label, shared) VALUES 
    ('society_lost', 'lost', 1)
;

INSERT INTO `datastore` (name, label, shared) VALUES 
    ('society_lost', 'lost', 1)
;

INSERT INTO `addon_inventory` (name, label, shared) VALUES 
    ('society_lost', 'lost', 1)
;

INSERT INTO `jobs` (`name`, `label`, `whitelisted`) VALUES
    ('lost', 'lost', 1)
;

INSERT INTO `job_grades` (`job_name`, `grade`, `name`, `label`, `salary`) VALUES
    ('lost', 0, 'recrue', 'Recrue', 0),
    ('lost', 1, 'membre', 'Membre', 0),
    ('lost', 2, 'coboss', 'Sous Chef', 0),
    ('lost', 3, 'boss', 'Chef', 0)
;
