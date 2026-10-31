create database bd_ccflex;
use bd_ccflex;

CREATE table IF NOT EXISTS tb_alunos (
	cd_rm int primary key not null,
    nm_aluno varchar(60) not null,
    nr_idade int not null
);

CREATE table tb_curso (
	cd_curso varchar (10) primary key not null,
    sgl_cuso char (2) not null,
    nm_aluno varchar (60) not null,
    tp_curso int not null
    );
    
drop table tb_alunos;

CREATE table IF NOT EXISTS tb_alunos (
	cd_rm int primary key not null,
    nm_aluno varchar(60) not null,
    nr_idade int not null,
    fk_cd_curso varchar(10) not null,
    constraint fk_curso foreign key (fk_cd_curso) references tb_curso(cd_curso)
);

insert into tb_curso (cd_curso, sgl_cuso, nm_aluno, tp_curso) values
("CC-FLEX", "CC", "Ciência da Computação", 8),
("CC-P", "CC", "Ciência da Computação", 8),
("ADS-FLEX", "AD", "Análise e Desenvolvimento de Sistemas", 6),
("BIOT", "BT", "Biotecnologia", 8);

insert into tb_alunos (cd_rm, nm_aluno, nr_idade, fk_cd_curso) values
("21396176", "José Silva", 23, "CC-FLEX"),
("98462781", "João Carlos", 22, "CC-P"),
("74981427", "Jennifer Moura", 21, "ADS-FLEX"),
("73324577", "Julia Silva", 20, "CC-FLEX"),
("81623891", "Jhonatan Cardoso", 19, "ADS-FLEX");