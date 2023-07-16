INSERT INTO `addon_account` (name, label, shared) VALUES 
    ('society_gang', 'gang', 1)
;

INSERT INTO `datastore` (name, label, shared) VALUES 
    ('society_gang', 'gang', 1)
;

INSERT INTO `addon_inventory` (name, label, shared) VALUES 
    ('society_gang', 'gang', 1)
;

INSERT INTO `jobs` (`name`, `label`, `whitelisted`) VALUES
    ('gang', 'gang', 1)
;

INSERT INTO `job_grades` (`job_name`, `grade`, `name`, `label`, `salary`) VALUES
    ('gang', 0, 'recrue', 'Recrue', 0),
    ('gang', 1, 'membre', 'Membre', 0),
    ('gang', 2, 'coboss', 'Sous Chef', 0),
    ('gang', 3, 'boss', 'Chef', 0)
;
