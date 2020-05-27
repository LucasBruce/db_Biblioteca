CREATE DATABASE IF NOT EXISTS db_Biblioteca;
SELECT DATABASE();
USE db_Biblioteca;

CREATE TABLE IF NOT EXISTS tbl_livro(
	id_livro SMALLINT PRIMARY KEY AUTO_INCREMENT,
	nome_livro VARCHAR(50) NOT NULL,
	isbn CHAR(30),
	data_publicacao DATE NOT NULL,
	preco_livro DECIMAL NOT NULL,
    id_autor SMALLINT NOT NULL,
    id_editora SMALLINT NOT NULL,
    CONSTRAINT fk_id_autor_tbl_livro FOREIGN KEY(id_autor)
     REFERENCES tbl_autor(id_autor),
	CONSTRAINT fk_id_editora_tbl_livro FOREIGN KEY(id_editora)
     REFERENCES tbl_editora(id_editora)
);

CREATE TABLE IF NOT EXISTS tbl_autor(
	id_autor SMALLINT PRIMARY KEY AUTO_INCREMENT,
	nome_autor VARCHAR(50) NOT NULL,
	sobrenome_autor VARCHAR(60) NOT NULL
);

CREATE TABLE IF NOT EXISTS tbl_editora(
	id_editora SMALLINT PRIMARY KEY AUTO_INCREMENT,
	nome_editora VARCHAR(50) NOT NULL
);
