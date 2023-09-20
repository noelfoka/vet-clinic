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