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
insert into tbl_autor(nome_autor, sobrenome_autor)
 values
 ('joao', 'pedro');
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

-- REGEXP - Expressões Regulares em consultas

select nome_livro from tbl_livro
where nome_livro regexp '^[FS]';

select nome_livro from tbl_livro
where nome_livro regexp '^[^FS]';

select nome_livro from tbl_livro
where nome_livro regexp '[ng]$';

select nome_livro from tbl_livro
where nome_livro regexp '^[FS]|Mi';

-- como inserir valor padrão em uma coluna

alter table tbl_autor modify column sobrenome_autor 
varchar(60) default 'da silva';

select * from tbl_autor;

insert into tbl_autor(id_autor, nome_autor)
  values
  (6, 'joão');
  
insert into tbl_autor(id_autor, nome_autor, sobrenome_autor)
  values
  (7, 'Rita', 'de souza');

ALTER TABLE tbl_autor MODIFY COLUMN sobrenome_autor VARCHAR(60);

insert into tbl_autor(id_autor, nome_autor)
  values
  (8, 'jaiminho');
  
-- backup e restauração do banco comandos no terminal

-- backup (mysqldump -u root -p db_Biblioteca > /home/bananinha/db_Biblioteca.sql)

/*restauração lembrando que é preciso criar um banco e restaurar o arquivo de 
backup nele (sudo mysql -u root -p db_banco < /home/lucas/db.Biblioteca.sql) */


-- GROUP BY - Agrupamento de Registros

select * from tbl_venda
where produto = 'mouse';

-- Consulta usando agragação para somar o total de vendas de mouse

select sum(quantidade) as TotalMouse from tbl_venda
where produto = 'mouse';

-- Consulta totalizando as vendas de todos os produtos por cidade

select cidade, sum(quantidade) as TotalProdutos from tbl_venda
group by cidade;

-- Consulta usando agregação total de registros de vendas por cidade
select * from tbl_venda;
select cidade, count(*) as Registros from tbl_venda
group by cidade;

-- MySQL - HAVING - Filtrando os resultados do Agrupamento - 27

/*Consulta retornando total de vendas das cidades com menos de 2500 produtos vendidos*/
select cidade, sum(quantidade) as total from tbl_venda
group by cidade
having total < 2500;

/*Consulta retornando total de vendas do produto 'Teclado' das cidades com menos de 1500 
teclados vendidos*/
select cidade, sum(quantidade) as totalTeclados from tbl_venda
where produto = 'Teclado'
group by cidade
having totalTeclados < 1500;

-- MySQL - VIEWS - Criando Tabelas Virtuais (Visões) - 28

create view vw_livrosAutores as select nome_livro as livro, nome_autor as autor
from tbl_livro l
inner join tbl_autor a
on a.id_autor = l.id_autor;

-- alter view
alter view vw_livrosAutores as select tbl_livro.nome_livro as livro,
tbl_autor.nome_autor as autor, tbl_livro.preco_livro as valor
from tbl_livro 
inner join tbl_autor 
on tbl_autor.id_autor = tbl_livro.id_autor;

select * from vw_livrosAutores
order by valor;

/*exclusão da view*/
drop view vw_livrosAutores;
 
select livro, autor from vw_livrosAutores;

/*MySQL - INNER JOIN - Consultar dados em duas ou mais Tabelas - 29
inner join e a interseção do um conjunto os só retornaram por meio do
inner join se caso as tabelas envolvidas tiverem os dados se caso uma das
tabelas não tiver registro não será retornado nem um dado*/

select * from tbl_livro
inner join tbl_autor
on tbl_autor.id_autor = tbl_livro.id_autor;

select tbl_livro.nome_livro, tbl_livro.isbn, 
tbl_autor.nome_autor from tbl_livro
inner join tbl_autor
on tbl_autor.id_autor = tbl_livro.id_autor;

select l.nome_livro as livro, e.nome_editora
as editora from tbl_livro l
inner join tbl_editora e
on e.id_editora = l.id_editora
where e.nome_editora like 'M%';

select l.nome_livro as Livros, e.nome_editora as Editoras,
a.nome_autor as Autores from tbl_livro l
inner join tbl_editora e
on e.id_editora = l.id_editora
inner join tbl_autor a
on a.id_autor = l.id_autor;

/*MySQL - LEFT e RIGHT JOIN - Consultar dados em duas ou mais Tabelas - 30
lembrando que a tabela principal será a tabela a esquerda ou direita left and right
e não as segundarias*/

select * from tbl_autor
left join tbl_livro
on tbl_autor.id_autor = tbl_livro.id_autor;

select * from tbl_autor
left join tbl_livro
on tbl_autor.id_autor = tbl_livro.id_autor
where tbl_livro.id_autor is null;

select * from tbl_livro l
right join tbl_editora e
on l.id_editora = e.id_editora;

select * from tbl_editora e
right join tbl_livro l
on l.id_livro = e.id_livro;

select * from tbl_editora e
left join tbl_livro l
on e.id_editora = l.id_editora
where l.id_editora is null;
