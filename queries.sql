/*Queries that provide answers to the questions from all projects.*/

/*day 1 queries*/

/*Find all animals whose name ends in "mon".*/
SELECT * from animals WHERE name like '%mon';
/*List the name of all animals born between 2016 and 2019.*/
SELECT name from animals WHERE date_of_birth BETWEEN '2016-1-1' AND '2019-1-1';
/*List the name of all animals that are neutered and have less than 3 escape attempts.*/
SELECT name from animals WHERE neutered=true AND escape_attempts < 3;
/*List the date of birth of all animals named either "Agumon" or "Pikachu".*/
SELECT date_of_birth FROM animals WHERE name LIKE 'Agumon' OR name LIKE 'Pikachu';
/*List name and escape attempts of animals that weigh more than 10.5kg*/
SELECT name, escape_attempts FROM animals WHERE weight_kg > 10.5;
/*Find all animals that are neutered.*/
SELECT * FROM animals WHERE neutered = true;
/*Find all animals not named Gabumon.*/
SELECT * FROM animals WHERE name NOT LIKE 'Gabumon';
/*Find all animals with a weight between 10.4kg and 17.3kg (including the animals with the weights that equals precisely 10.4kg or 17.3kg)*/
SELECT * FROM animals WHERE weight_kg >= 10.4 AND weight_kg <= 17.3;

/*day-2*/
/*transactions*/

/*transaction-1*/
begin;

update animals
set species = 'unspecified';

select * from animals;

rollback;

/*transaction-2*/
BEGIN;
UPDATE animals
SET species = 'digimon'
WHERE species LIKE '%mon';

UPDATE animals
SET species = 'pokemon'
WHERE species IS NULL;

SELECT * FROM animals;

COMMIT;

/*transaction-3*/
BEGIN;
DELETE FROM animals;
SELECT * FROM animals;
ROLLBACK;
SELECT * FROM animals;

/*transaction-4*/
BEGIN;
DELETE FROM animals;
SELECT * FROM animals;
ROLLBACK;
SELECT * FROM animals;

/*transaction-5*/
BEGIN;
DELETE FROM animals
WHERE date_of_birth > '2022-01-01';
SAVEPOINT del_animals_before_jan;
UPDATE animals
SET weight_kg = (weight_kg * -1);
ROLLBACK TO del_animals_before_jan;
UPDATE animals
SET weight_kg = (weight_kg * -1)
WHERE weight_kg < 0;
SELECT * FROM animals;
COMMIT;
SELECT * FROM animals;

/*Aggregates*/
SELECT COUNT(*) AS Total FROM animals;

SELECT COUNT(*) AS Never_escaped_count 
FROM animals
WHERE escape_attempts = 0;

SELECT AVG(weight_kg) AS Averege_weight
FROM animals;

SELECT neutered, SUM(escape_attempts) AS "Escapes_by_neutered" 
FROM animals 
GROUP BY neutered;

SELECT species, MAX(weight_kg) AS "Maximum Weight", MIN(weight_kg) AS "Minimum Weight" 
FROM animals 
GROUP BY species;

SELECT species, AVG(escape_attempts) AS "Average_Escape" 
FROM animals 
WHERE date_of_birth BETWEEN DATE '1990-01-01' AND DATE '2000-12-31' 
GROUP BY species; 

/*day-3*/
--joins
--joins
SELECT name 
FROM animals a
JOIN owners o ON a.owner_id = o.id 
WHERE o.full_name = 'Melody Pond';

SELECT * 
FROM animals a
JOIN species s ON s.id = a.species_id
WHERE s.name = 'Pokemon';

SELECT full_name AS "Owner", name AS "Animal"
FROM owners o
LEFT JOIN animals a ON o.id = a.owner_id;

SELECT COUNT(a.name) AS "# of Animals", s.name AS "Species" 
FROM animals a 
JOIN species s ON s.id = a.species_id 
GROUP BY s.name;

SELECT a.name AS "Digimons", o.full_name AS "Owner" 
FROM animals a JOIN species s ON a.species_id = s.id 
JOIN owners o ON a.owner_id = o.id 
WHERE s.name = 'Digimon' AND o.full_name = 'Jennifer Orwell';

SELECT o.full_name AS "Owner", a.name AS "Animal",
FROM animals a 
JOIN owners o ON o.id = a.owner_id 
WHERE o.full_name = 'Dean Winchester' AND a.escape_attempts = 0;

SELECT o.full_name AS 'Owner', COUNT(a.name) AS "Number of Animals" 
FROM animals a 
JOIN owners o ON a.owner_id = o.id 
GROUP BY o.full_name 
ORDER BY "Number of Animals" 
DESC LIMIT 1;

/*day-4*/
--queries

SELECT a.name AS "Animal", vi.visit_date AS "Date Last visited" 
FROM animals a 
JOIN visits vi ON vi.animals_id = a.id JOIN vets ve ON ve.id = vi.vets_id 
WHERE ve.name = 'William Tatcher' 
ORDER BY visit_date 
DESC LIMIT 1;

SELECT COUNT(DISTINCT(a.name)) AS "Count of Animals", ve.name AS "Vet Name" 
FROM animals a 
JOIN visits vi ON vi.animals_id = a.id JOIN vets ve ON ve.id = vi.vets_id 
WHERE ve.name = 'Stephanie Mendez' 
GROUP BY "Vet Name";

SELECT ve.name AS "Vet Name", s.name AS "Specialization" 
FROM vets ve 
LEFT JOIN specializations sp ON sp.vets_id = ve.id LEFT JOIN species s ON s.id = sp.species_id;

SELECT a.name AS "Visited Animals", vi.visit_date AS "Date visited" 
FROM animals a 
JOIN visits vi ON vi.animals_id = a.id JOIN vets ve ON ve.id = vi.vets_id 
WHERE ve.name = 'Stephanie Mendez' AND visit_date BETWEEN DATE '2020-04-01' AND '2020-08-30';

SELECT a.name AS "Animal", COUNT(vi.animals_id) AS "Count of visits" 
FROM animals a 
JOIN visits vi ON vi.animals_id = a.id 
GROUP BY a.name 
ORDER BY "Count of visits" DESC LIMIT 1;

SELECT a.name AS "Animal", ve.name AS "Vet Name", vi.visit_date AS "Date of Visit" 
FROM animals a 
JOIN visits vi ON vi.animals_id = a.id JOIN vets ve ON ve.id = vi.vets_id 
WHERE ve.name = 'Maisy Smith' ORDER BY visit_date LIMIT 1;

SELECT a.name AS "Animal", s.name AS "Species", date_of_birth, escape_attempts, neutered, weight_kg, ve.name AS "Vet Name", spc.name AS "Specialization", age AS "Vets' Age", date_of_graduation, vi.visit_date
FROM animals a 
JOIN visits vi ON vi.animals_id = a.id JOIN vets ve ON ve.id = vi.vets_id JOIN species s ON s.id = a.species_id JOIN specializations sp ON sp.vets_id = ve.id JOIN species spc ON spc.id = sp.species_id 
ORDER BY visit_date DESC LIMIT 1; 

SELECT COUNT(vi.animals_id) AS "Visits count by non specialist" 
FROM animals a JOIN visits vi ON vi.animals_id = a.id JOIN vets ve ON ve.id = vi.vets_id JOIN species s ON s.id = a.species_id JOIN specializations sp ON sp.vets_id = ve.id JOIN species spc ON spc.id = sp.species_id 
WHERE s.name <> spc.name;