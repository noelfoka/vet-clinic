/* Populate database with sample data. */

INSERT INTO animals(id, name, date_of_birth, escape_attempts, neutered, weight_kg)
VALUES (1, 'Agumon', '2020-02-03', 0, true, 10.23);

INSERT INTO animals(id, name, date_of_birth, escape_attempts, neutered, weight_kg)
VALUES (2, 'Gabumon', '2018-11-15', 2, true, 8);

INSERT INTO animals(id, name, date_of_birth, escape_attempts, neutered, weight_kg)
VALUES (3, 'Pikachu', '2021-01-07', 1, false, 15.04);

INSERT INTO animals(id, name, date_of_birth, escape_attempts, neutered, weight_kg)
VALUES (4, 'Devimon', '2017-05-12', 5, true, 11);

INSERT INTO animals (id, name, date_of_birth, escape_attempts, neutered, weight_kg) 
VALUES (5, 'Charmander', '2020-02-08', 0, FALSE, -11),
(6, 'Plantmon', '2021-11-15', 2, TRUE, -5.7),
(7, 'Squirtle', '1993-04-02', 3, FALSE, -12.13),
(8, 'Angemon', '2005-06-12', 1, TRUE, -45),
(9, 'Boarmon', '2005-06-07', 7, TRUE, 20.4),
(10, 'Blossom', '1998-10-13', 3, TRUE, 17),
(11, 'Ditto', '2022-05-14', 4, TRUE, 22) ;

INSERT INTO owners (full_name, age)
VALUES ('Sam Smith', 34),
('ennifer Orwell', 19),
('Bob', 45),
('Melody Pond', 77),
('Dean Winchester', 14),
('Jodie Whittaker', 38);

INSERT INTO species (name)
VALUES ('Pokemon'), ('Digimon');

UPDATE animals SET species_id = (
    CASE
        WHEN name LIKE '%mon' THEN (SELECT id FROM species WHERE name = 'Digimon')
        ELSE (SELECT id FROM species WHERE name = 'Pokemon')
    END
);

update animals set owner_id = case
when name = 'Agumon' then 1
when name in ('Gabumon', 'Pikachu') then 2
when name in ('Devimon', 'Plantmon') then 3
when name in ('Charmander', 'Squirtle', 'Blossom') then 4
when name in ('Angemon', 'Boarmon') then 5
end;

INSERT INTO vets(name, age, date_of_graduation) VALUES
('Vet William Tatcher', 45, '2000-04-23'),
('Vet Maisy Smith', 26, '2019-01-17'),
('Vet Stephanie Mendez', 64, '1981-05-04'),
('Vet Jack Harkness', 38, '2008-06-08');
