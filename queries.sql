/*Queries that provide answers to the questions from all projects.*/

SELECT * FROM animals WHERE name LIKE '%mon';
SELECT name FROM animals WHERE date_of_birth BETWEEN '2016-01-01' AND '2019-12-31';
SELECT name FROM animals WHERE neutered = true AND escape_attempts < 3;
SELECT date_of_birth FROM animals WHERE name IN ('Agumon', 'Pikachu');
SELECT name, escape_attempts FROM animals WHERE weight_kg > 10.5;
SELECT * FROM animals WHERE neutered = true;
SELECT * from animals WHERE name != 'Gabumon';
SELECT * FROM animals WHERE weight_kg >= 10.4 AND weight_kg <= 17.3;

/*update the animals table by setting the species column to unspecified.*/

BEGIN;
UPDATE animals SET species = 'unspecified' ;

SELECT * FROM animals ;
ROLLBACK;

SELECT * FROM animals ;

BEGIN;
UPDATE animals SET species = 'digimon' WHERE name LIKE '%mon';
UPDATE animals SET species = 'pokemon' WHERE species IS NULL;
SELECT * FROM animals ;
COMMIT;
SELECT * FROM animals ;

/*DELETE ALL RECORDS*/

BEGIN;
DELETE FROM animals;
SELECT * FROM animals ;
ROLLBACK;
SELECT * FROM animals ;

/*INSIDE A TRANSACTION DELETE ANIMALS BORN AFTER JAN 1,2022*/
BEGIN;
DELETE FROM animals WHERE date_of_birth > '2022-01-01';
SAVEPOINT ANBORNAFTERJAN12022;
SELECT * FROM animals ;

/*Update all animals' weight to be their weight multiplied by -1 THEN ROLLBACK TO SAVEPOINT*/
UPDATE animals SET weight_kg = weight_kg * -1 ;
ROLLBACK TO ANIMALBORNAFTERJAN12022;
SELECT * FROM animals ;

/*Update all animals' weights that are negative to be their weight multiplied by -1.*/
UPDATE animals SET weight_kg = weight_kg * -1 WHERE weight_kg < 0;
COMMIT;
SELECT * FROM animals ;

SELECT COUNT(*) AS animal_count FROM animals;
SELECT COUNT(*) AS have_not_escaped FROM animals WHERE escape_attempts = 0;
SELECT AVG(weight_kg) AS animals_average_weight FROM animals;
SELECT neutered, SUM(escape_attempts) AS total_escaped_attempts FROM animals GROUP BY neutered;
SELECT species, MIN(weight_kg) AS min_weight, MAX(weight_kg) AS max_weight FROM animals GROUP BY species;
SELECT species, AVG(escape_attempts) AS average_escape_attempts FROM animals WHERE date_of_birth BETWEEN '1990-01-01' AND '2000-12-31' GROUP BY species;

SELECT name FROM animals JOIN owners ON animals.owner_id = owners.id WHERE owners.full_name = 'Melody Pond';

SELECT animals.name FROM animals JOIN species ON animals.species_id = species.id WHERE species.name = 'Pokemon';

SELECT owners.full_name, COALESCE(array_agg(animals.name), '{}':: VARCHAR[]) AS animals_owned 
FROM owners 
LEFT JOIN animals ON owners.id = animals.owner_id
GROUP BY owners.full_name;

SELECT species.name AS species_name, COUNT(*) AS animal_count FROM animals JOIN species ON animals.species_id = species.id GROUP BY species.name;

SELECT animals.name FROM animals JOIN species ON animals.species_id = species.id JOIN owners ON animals.owner_id = owners.id WHERE owners.full_name = 'Jennifer Orwell' AND species.name = 'Digimon';

SELECT animals.name FROM animals JOIN owners ON animals.owner_id = owners.id WHERE owners.full_name = 'Dean Winchester' AND animals.escape_attempts = 0;

SELECT owners.full_name, COUNT(*) AS animal_count FROM owners JOIN animals ON owners.id = animals.owner_id GROUP BY owners.full_name ORDER BY animal_count DESC LIMIT 1;