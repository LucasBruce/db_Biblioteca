CREATE DATABASE IF NOT EXISTS db_Biblioteca;
SELECT DATABASE();
USE db_Biblioteca;

CREATE TABLE IF NOT EXISTS tbl_livro(
	id_livro SMALLINT PRIMARY KEY AUTO_INCREMENT,
	nome_livro VARCHAR(50) NOT NULL,
	isbn CHAR(30),
	data_publicacao DATE NOT NULL,
	preco_livro FLOAT NOT NULL,
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

/*script de inserção de dados nas tabelas do banco (carga e consultas de dados para teste)*/

INSERT INTO tbl_autor(nome_autor, sobrenome_autor)
 VALUES
 ('Deniel', 'Barret'),
 ('Gerald', 'Carter'),
 ('Mark', 'Sobell'),
 ('William', 'Stanek'),
 ('Richard', 'Blum');

INSERT INTO tbl_editora(nome_editora)
 VALUES
 ('Prentice Hall'),
 ('O Reilly'),
 ('Microsoft Press'),
 ('Wiley');

INSERT INTO tbl_livro(nome_livro, isbn, data_publicacao, preco_livro,
id_autor, id_editora)
 VALUES
 ('Linux Command Line and Shell Scripting', '1438569669', '20091221', 68.35, 5, 4),
 ('SSH, the Secure Shell', '127658789', '20091221', 58.30, 1, 2),
 ('Using Samba', '123856789', '20001221', 61.45, 2, 2),
 ('Fedora and Red Hat Linux', 123346789, '20101101', 62.24, 3, 1),
 ('Windows Server 2012 Inside Out', 123356789, '20040517', 66.80, 4, 3),
 ('Microsoft Exchange Server 2010', 123366789, '20001221', 45.30, 4, 3);

select * from tbl_livro
where id_livro > 2 and id_autor < 3;

select * from tbl_livro
where id_livro > 2 or id_autor < 3;

select * from tbl_livro
where id_livro > 2 and not id_autor < 3;

-- funções de agregação

select count(*) as TotalAutores from tbl_autor;

select count(distinct id_autor) as id_autor from tbl_autor;

select max(preco_livro) as MaiorPreço from tbl_livro;

select min(preco_livro) as Menorpreço from tbl_livro;

select AVG(preco_livro) as MediaPreço from tbl_livro;

select sum(preco_livro) as SomaPreços from tbl_livro;

-- renomeando tabelas

create table if not exists clientes(
  id_cliente SMALLINT PRIMARY KEY auto_increment,
  nome_cliente CHAR(20)
); 

insert into clientes(id_cliente, nome_cliente)
  values
  (20, 'carluxo'),
  (23, 'bananinha'),
  (30, 'gadiza');

delete from tbl_cliente where id_cliente = '30';

rename table clientes to tbl_cliente;

select * from tbl_cliente;

-- atualizar ou alterar registro

update tbl_cliente
set nome_cliente = 'bananão'
where id_cliente = '30';
 
 select * from tbl_livro;

update tbl_livro
set nome_livro = 'SSH, o shell seguro'
where id_livro = '2';

-- seleção de intervalos

select * from tbl_livro
where data_publicacao between '20040517' and '20110517';

select nome_livro as Livros, preco_livro as Preços from tbl_livro
where preco_livro between 40.00 and 60.00;

-- LIKE e NOT LIKE padrão de caracter em filtro de consulta

select nome_livro from tbl_livro
where nome_livro like 'f%';

select nome_livro from tbl_livro
where nome_livro not like 's%';

select nome_livro from tbl_livro
where nome_livro like '_i%';