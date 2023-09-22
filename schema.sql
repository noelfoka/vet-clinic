/* Database schema to keep the structure of entire database. */

CREATE TABLE animals (
	id INTEGER PRIMARY KEY NOT NULL,
	name varchar,
	date_of_birth date,
	escape_attempts INTEGER,
	neutered boolean,
	weight_kg decimal
);

ALTER TABLE animals ADD species varchar(255);

CREATE TABLE owners (
	id serial PRIMARY KEY,
	full_name VARCHAR(255),
	age INTEGER
);

CREATE TABLE species (
	id serial PRIMARY KEY,
	name VARCHAR(155)
);

ALTER TABLE animals
DROP species,
ADD COLUMN species_id INTEGER,
ADD COLUMN owner_id INTEGER;

ALTER TABLE animals
 ADD CONSTRAINT fk_species FOREIGN KEY (species_id) REFERENCES species(id),
 ADD CONSTRAINT fk_owner FOREIGN KEY (owner_id) REFERENCES owners(id);

CREATE TABLE vets (
	id SERIAL PRIMARY KEY,
	name VARCHAR(150),
	age INTEGER,
	date_of_graduation DATE
);

CREATE TABLE specializations (
	species_id INTEGER,
	vet_id INTEGER,
	PRIMARY KEY (species_id, vet_id),
	CONSTRAINT fk_species
		FOREIGN KEY (species_id)
			REFERENCES species(id),
	CONSTRAINT fk_vets
		FOREIGN KEY (vet_id)
			REFERENCES vets(id)
);
