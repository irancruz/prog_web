create database db_locadora_noite;

create sequence sequence_id_sexo;

create table tb_sexos(
	sex_id smallint not null default nextval('sequence_id_sexo'),
	sex_nome varchar(10) not null,
	sex_sigla char(1) not null,
	constraint pk_sexo primary key(sex_id),
	constraint uk_sigla unique(sex_sigla)
);


insert into tb_sexos (sex_sigla, sex_nome) values ('M', 'MASCULINO'), ('F', 'FEMININO');

select * from tb_sexos;

create sequence sequence_id_cliente;

create table tb_cliente(
	cli_id bigint not null default nextval('sequence_id_cliente'),
	cli_nome varchar(80) not null,
	cli_cpf char(11) not null,
	cli_data_nascimento date not null,	
	cli_sex_id smallint,
	constraint pk_liente primary key(cli_id),
	constraint uk_cpf unique(cli_cpf),
	constraint fk_sex_cli foreign key(cli_sex_id)
	references tb_sexos(sex_id)
	on update cascade on delete cascade
);

insert into tb_cliente (cli_nome, cli_cpf, cli_data_nascimento, cli_sex_id) 
values ('IRANILSON S CRUZ', '81343930472', '1976-08-19', 1),
('MILEN CRUZ', '465465588', '2014-08-23', 2);

select * from tb_cliente;

create table tb_fones_clientes(
	fdc_cli_id bigint not null,
	fdc_fone varchar(12) not null,
	constraint pk_fone_cliente primary key (fdc_cli_id, fdc_fone),
	constraint pk_cli_fdc foreign key(fdc_cli_id)
		references tb_cliente(cli_id)
		on update cascade on delete cascade
);

insert into tb_fones_clientes (fdc_cli_id, fdc_fone)
values (1, '84321646546'), (1, '232135555'), (2, '8432135544');


select * from tb_fones_clientes