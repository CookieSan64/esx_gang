INSERT INTO `addon_account` (name, label, shared) VALUES 
    ('society_miamiboy', 'miamiboy', 1)
;

INSERT INTO `datastore` (name, label, shared) VALUES 
    ('society_miamiboy', 'miamiboy', 1)
;

INSERT INTO `addon_inventory` (name, label, shared) VALUES 
    ('society_miamiboy', 'miamiboy', 1)
;

INSERT INTO `jobs` (`name`, `label`, `whitelisted`) VALUES
    ('miamiboy', 'miamiboy', 1)
;

INSERT INTO `job_grades` (`job_name`, `grade`, `name`, `label`, `salary`) VALUES
    ('miamiboy', 0, 'recrue', 'Recrue', 0),
    ('miamiboy', 1, 'membre', 'Membre', 0),
    ('miamiboy', 2, 'coboss', 'Sous Chef', 0),
    ('miamiboy', 3, 'boss', 'Chef', 0)
;
