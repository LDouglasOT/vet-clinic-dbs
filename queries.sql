/*Queries that provide answers to the questions from all projects.*/

SELECT * from animals WHERE name = 'Pikachu';

SELECT * from animals WHERE name LIKE '%mon';

SELECT name FROM animals WHERE date_of_birth BETWEEN '2016-01-01' AND '2019-12-31';

SELECT name FROM animals WHERE neutered = true AND escape_attempts < 3;

SELECT date_of_birth FROM animals WHERE name IN ('Agumon', 'Pikachu');

SELECT name, escape_attempts FROM animals WHERE weight_kg > 10.5;

SELECT * FROM animals WHERE neutered = true;

SELECT * FROM animals WHERE name <> 'Gabumon';

SELECT * FROM animals WHERE weight_kg >= 10.4 AND weight_kg <= 17.3;


-- Transactions begin
BEGIN;
UPDATE animals
SET species='unspecified';
SELECT * FROM animals
ROLLBACK;
SELECT * FROM animals

BEGIN;
UPDATE animals
SET species='digimon'
WHERE name LIKE '%mon%';

UPDATE animals
SET species='pokemon'
WHERE species='';
COMMIT;
SELECT * FROM animals;

BEGIN;
DELETE FROM animals;
SELECT * FROM animals;
ROLLBACK;
SELECT * FROM animals;

BEGIN
DELETE FROM animals
WHERE date_of_birth > '2022-01-01';

SAVEPOINT my_savepoint;
UPDATE animals
SET weight_kg = weight_kg * -1;
SELECT * FROM animals;
ROLLBACK TO my_savepoint
SELECT * FROM animals;

UPDATE animals
SET weight_kg = weight_kg * -1
WHERE weight_kg < 0;
SELECT * FROM animals;

SELECT COUNT(name) FROM animals;
SELECT COUNT(name) FROM animals
WHERE escape_attempts = 0;

SELECT AVG(weight_kg) FROM animals;

SELECT SUM(escape_attempts) FROM animals
WHERE neutered = True;

SELECT SUM(escape_attempts) FROM animals
WHERE neutered = False;

SELECT MAX(weight_kg) FROM animals
WHERE species = 'pokemon';

SELECT MIN(weight_kg) FROM animals
WHERE species = 'pokemon';

SELECT MAX(weight_kg) FROM animals
WHERE species = 'digimon';

SELECT MIN(weight_kg) FROM animals
WHERE species = 'digimon';

SELECT AVG(escape_attempts) FROM animals
WHERE date_of_birth BETWEEN '1990-01-01' AND '2000-12-31';

SELECT animals.name
FROM animals
JOIN owners ON animals.owners_id = owners.id
WHERE owners.full_name = 'Melody Pond';

SELECT animals.name
FROM animals
JOIN species ON animals.species_id = species.id
WHERE species.name = 'Pokemon';

SELECT owners.full_name, animals.name
FROM owners
LEFT JOIN animals ON owners.id = animals.owners_id;

SELECT species.name, COUNT(animals.id) AS animal_count
FROM species
LEFT JOIN animals ON species.id = animals.species_id
GROUP BY species.name;

SELECT animals.name
FROM animals
JOIN species ON animals.species_id = species.id
JOIN owners ON animals.owners_id = owners.id
WHERE species.name = 'Digimon' AND owners.full_name = 'Jennifer Orwell';

SELECT animals.name
FROM animals
JOIN owners ON animals.owners_id = owners.id
WHERE owners.full_name = 'Dean Winchester' AND
