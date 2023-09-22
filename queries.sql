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

select a.name, vi.date_of_visits 
from animals a 
join visits vi on a.id = vi.animal_id 
join vets ve on ve.id = vi.vet_id 
where ve.name ='Vet William Tatcher' 
order by(vi.date_of_visits) desc limit 1;

select count(distinct(a.name)) as total_seen
from animals a 
join visits vi on a.id = vi.animal_id 
join vets ve on vi.vet_id = ve.id 
where ve.name = 'Vet Stephanie Mendez'; 

select ve.name, s.name as specialties 
from vets ve 
left join specializations sp on ve.id = sp.vet_id 
left join species s on s.id = sp.species_id;

select a.name, vi.date_of_visits 
from animals a join visits vi on a.id = vi.animal_id 
join vets v on vi.vet_id = v.id 
where v.name = 'Vet Stephanie Mendez'
and vi.date_of_visits between '2020-04-01' and '2020-08-30';

select a.name as most_visited, count(vi.animal_id) 
from animals a join visits vi on a.id = vi.animal_id 
join vets v on v.id = vi.vet_id 
group by(vi.animal_id, a.name) 
order by count(vi.animal_id) desc limit 1;

select a.name, vi.date_of_visits as most_visited 
from animals a 
join visits vi on a.id = vi.animal_id 
join vets v on v.id = vi.vet_id 
where v.name = 'Vet Maisy Smith' 
order by(vi.date_of_visits) limit 1;

select a.name,v.name as vet_name, vi.date_of_visits 
from animals a join visits vi on a.id = vi.animal_id 
join vets v on v.id = vi.vet_id 
order by(vi.date_of_visits) desc limit 1;

select count(*) from visits 
join animals on animals.id = visits.animal_id 
join species on species.id = animals.species_id 
join vets on vets.id = visits.vet_id 
left join specializations sp on sp.vet_id = vets.id 
where sp.species_id != animals.species_id or sp.species_id is null;

select species.name, count(species.id) 
from species join animals on species.id = animals.species_id 
join visits on visits.animal_id = animals.id 
join vets on vets.id = visits.vet_id 
where vets.name = 'Vet Maisy Smith' 
group by(species.id) 
order by(species.id) desc limit 1;