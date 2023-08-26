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
JOIN owners ON animals.owner_id = owners.id
WHERE owners.full_name = 'Melody Pond';

SELECT animals.name
FROM animals
JOIN species ON animals.species_id = species.id
WHERE species.name = 'Pokemon';

SELECT owners.full_name, animals.name
FROM owners
LEFT JOIN animals ON owners.id = animals.owner_id;

SELECT species.name, COUNT(animals.id) AS animal_count
FROM species
LEFT JOIN animals ON species.id = animals.species_id
GROUP BY species.name;

SELECT animals.name
FROM animals
JOIN species ON animals.species_id = species.id
JOIN owners ON animals.owner_id = owners.id
WHERE species.name = 'Digimon' AND owners.full_name = 'Jennifer Orwell';

SELECT animals.name
FROM animals
JOIN owners ON animals.owner_id = owners.id
WHERE owners.full_name = 'Dean Winchester' AND



SELECT animals.name AS last_animal_seen
FROM visits
JOIN vets ON visits.vet_id = vets.id
JOIN animals ON visits.animal_id = animals.id
WHERE vets.name = 'William Tatcher'
ORDER BY visits.visit_date DESC
LIMIT 1;


SELECT COUNT(DISTINCT animal_id) AS animal_count
FROM visits
JOIN vets ON visits.vet_id = vets.id
WHERE vets.name = 'Stephanie Mendez';


SELECT vets.name, COALESCE(species.name, 'None') AS specialty
FROM vets
LEFT JOIN specializations ON vets.id = specializations.vet_id
LEFT JOIN species ON specializations.species_id = species.id;

SELECT animals.name
FROM visits
JOIN vets ON visits.vet_id = vets.id
JOIN animals ON visits.animal_id = animals.id
WHERE vets.name = 'Stephanie Mendez'
  AND visits.visit_date BETWEEN '2020-04-01' AND '2020-08-30';

SELECT animals.name, COUNT(*) AS visit_count
FROM visits
JOIN animals ON visits.animal_id = animals.id
GROUP BY animals.name
ORDER BY visit_count DESC
LIMIT 1;

SELECT vets.name AS first_vet_visited
FROM visits
JOIN vets ON visits.vet_id = vets.id
JOIN animals ON visits.animal_id = animals.id
WHERE animals.name = 'Maisy Smith'
ORDER BY visits.visit_date ASC
LIMIT 1;

SELECT animals.name AS animal_name, vets.name AS vet_name, visits.visit_date
FROM visits
JOIN vets ON visits.vet_id = vets.id
JOIN animals ON visits.animal_id = animals.id
ORDER BY visits.visit_date DESC
LIMIT 1;

SELECT COUNT(*) AS visits_with_non_specialist
FROM visits
JOIN vets ON visits.vet_id = vets.id
JOIN animals ON visits.animal_id = animals.id
LEFT JOIN specializations ON vets.id = specializations.vet_id AND animals.id = specializations.species_id
WHERE specializations.vet_id IS NULL;

SELECT species.name AS suggested_specialty
FROM visits
JOIN animals ON visits.animal_id = animals.id
JOIN specializations ON animals.id = specializations.species_id
JOIN species ON specializations.species_id = species.id
WHERE animals.name = 'Maisy Smith'
GROUP BY species.name
ORDER BY COUNT(*) DESC
LIMIT 1;