CREATE TABLE IF NOT EXISTS tbl_livro(
	id_livro SMALLINT PRIMARY KEY AUTO_INCREMENT,
	nome_livro VARCHAR(50) NOT NULL,
	isbn CHAR(30),
	id_autor SMALLINT NOT NULL,
	data_publicacao DATE NOT NULL,
	preco_livro DECIMAL NOT NULL
);

CREATE TABLE IF NOT EXISTS tbl_autor(
	id_autor SMALLINT PRIMARY KEY AUTO_INCREMENT,
	nome_autor VARCHAR(50),
	sobrenome_autor VARCHAR(60)
);

