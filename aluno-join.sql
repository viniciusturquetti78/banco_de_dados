create database aula12;

use aula12;

create table aluno(

ra int primary key auto_increment,
nome varchar(45),
bairro varchar(45)
);

create table disciplina(
id int primary key auto_increment,
nome varchar(45)
);


insert into aluno values
(null,'Gustavo','Vila Alpina'),
(null,'Nilton','Vila Alpina'),
(null,'Miguel','Vila Alpina'),
(null,'Guilherme','São Lucas'),
(null,'Italo','Vila Ema');

insert into disciplina values
(null,'Algoritimos'),
(null,'BD'),
(null,'Arq Comp'),
(null,'Socio Emoc'),
(null,'TI'),
(null,'PI');


create table curso(

fk_aluno int,
foreign key (fk_aluno) references Aluno(ra),
fk_disciplina int,
foreign key (fk_disciplina) references disciplina(id),

perLetivo int,
primary key (fk_aluno, fk_disciplina, perLetivo),

media decimal(4,2),
qdtFaltas int
);

insert into curso values
(2,4,20191,7,2);

select * from aluno;
select * from disciplina;
select * from curso;
create table cursso(
	idCurso int primary key,
    nomeCurso varchar(10),
    coordenador varchar(40)
);

insert into cursso value
(1000,'ADS','gerson'),
(1001,'CCO','marise'),
(1002,'BD','alex');

alter table aluno add fkcurso int, add foreign key(fkcurso) references cursso(idCurso);
update aluno set fkcurso=1000 where ra <= 1;
update aluno set fkcurso=1001 where ra = 2;
update aluno set fkcurso=1002 where ra = 3;
select * from aluno;

insert into aluno values
(null,'luis fernando','guarapiranga', null);

select * from aluno, cursso where idCurso = fkcurso;
-- join 
select * from aluno al join curso cc on cc.idcurso;
-- quando se faz um join, usando join
select * from aluno as al join cursso as cc on cc.idCurso = al.fkcurso;
-- quando se faz um join, isso equivale a um innerjoin
select * from aluno inner join curso on idCurso=fkcurso;

select * from aluno left join cursso on  idCurso = fkcurso;
-- exibe os alunos e os cursos correspondentes, e 
-- os cursos não correspondentes associados a nenhum aluno 
select * from aluno right join cursso on idCurso = fkcurso;

-- idem ao comando anterior, usando JOIN
select * from aluno join alunodisciplina on fk_aluno = ra join disciplina on fk_disciplina = id;


select * from aluno join alunodisciplina on fk_disciplina = id where nomealuno = 'nilton';
-- join  
start transaction;
delete from cursso where idCurso = 1003;
select * from curso;
rollback;

select * from aluno al, join disciplina ad on ad.fk_aluno = al.ra join disciplina di on ad.fk_disciplina = di.id where nomedisc = 'algoritmo';
-- ================================================================================================== --
-- Exibir os dados dos alunos e das disciplinas correspondentes.
select al.nome as 'Nome', dis.nome as 'Disciplina', cs.qdtFaltas as 'Faltas' from aluno as al, disciplina as dis, curso as cs where cs.fk_aluno = al.ra and cs.fk_disciplina = dis.id;


-- Exibir os dados de um aluno e os dados das disciplinas desse aluno.
select al.nome as 'Nome', dis.nome as 'Disciplina', cs.qdtFaltas as 'Faltas' from aluno as al, 
disciplina as dis, curso as cs where cs.fk_aluno = al.ra and cs.fk_disciplina = dis.id and dis.id = 1;

-- Exibir a soma das médias e a soma das quantidades de faltas.
select sum(media), sum(qdtFaltas) from curso ;

-- Exibir a média das médias e a média das quantidades de faltas.
select round(avg(media),2), sum(qdtFaltas) from curso ;

-- Exibir a maior e a menor média.
select max(media), min(media) from curso;

-- Exibir a maior e a menor quantidade de faltas.
select max(qdtFaltas) as 'Maximo de faltas', min(qdtFaltas) as 'Minimo de faltas' from curso;

-- Exibir a maior e a menor média agrupado por disciplina.
select di.nome as Disciplina, max(cs.media) as 'Media maxima', min(cs.media) as 'Media minima' from curso as cs, 
disciplina as di where di.id = cs.fk_disciplina group by di.nome ;

-- Exibir a maior e a menor média agrupado por aluno
select al.nome as 'Nome Aluno', max(cs.media) as 'Media maxima', min(cs.media) as 'Media minima' from curso as cs, 
disciplina as di, aluno as al where al.ra = cs.fk_disciplina group by al.nome ;

-- Exibir apenas as médias da tabela AlunoDisciplina.
select media from curso;

-- Exibir as médias distintas da tabela AlunoDisciplina.
select distinct(media) as 'Medias distintas' from curso where media;

-- Exibir a quantidade de médias da tabela AlunoDisciplina.
select count(media) as 'Numero de medias' from curso;

-- Exibir a quantidade de médias distintas da tabela AlunoDisciplina.
select count(distinct(media))
as 'Quantidade de médias distintas' from curso;
