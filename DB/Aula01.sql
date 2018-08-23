create database if not exists db_locadora_noite;
use db_locadora_noite;

create table if not exists sexos(
	codigo int auto_increment primary key,
	nome varchar(255),
	sigla char(5)
);

drop table if exists sexos;


create table if not exists tb_sexos(
	sex_id tinyint(1) unsigned zerofill not null auto_increment,
	sex_nome varchar(20) not null,
	constraint primary key(sex_id)
);

alter table tb_sexos 
	add column sex_sigla char(1) not null;
    
alter table tb_sexos
	add constraint uk_sigla unique key(sex_sigla);
    
insert into tb_sexos(sex_sigla, sex_nome)
values ('M', 'MASCULINO'), ('F', 'FEMININO');

select * from tb_sexos;

create table if not exists tb_ufs(
	ufs_id tinyint(2) unsigned zerofill not null auto_increment,
    ufs_nome varchar(30) not null,
    ufs_sigla char(2) not null,
    constraint primary key(ufs_id),
    constraint uk_sigla unique key(ufs_sigla)
);

insert into tb_ufs (ufs_sigla, ufs_nome)
values ('RN', 'RIO GRANDE DO NORTE'),
('PB', 'PARAÍBA'),
('PE', 'PERNAMBUCO');

create table if not exists tb_tipos_midias(
	tdm_id tinyint(2) unsigned zerofill not null auto_increment,
    tdm_nome varchar(10) not null,
    constraint primary key(tdm_id)
);

insert into tb_tipos_midias(tdm_nome)
values ('VHS'), ('K7'), ('CD'), ('DVD'), ('BLUE RAY');

create table if not exists tb_cidades(
	cid_id smallint(4) unsigned zerofill not null auto_increment,
    cid_nome varchar(30) not null,
    cid_ufs_id tinyint(2) unsigned zerofill,
    constraint primary key(cid_id),
    constraint fk_ufs_cid foreign key(cid_ufs_id)
		references tb_ufs (ufs_id)
        on update cascade on delete cascade
);

insert into tb_cidades(cid_ufs_id, cid_nome)
value(1, 'NATAL'), (1, 'MOSSORÓ'), 
(2, 'JOÃO PESSOA'), (2, 'CAMPINA GRANDE'), 
(3, 'RECIFE');

create table if not exists tb_status(
	stt_id tinyint(1) unsigned zerofill not null auto_increment,
    stt_nome varchar(10) not null,
    constraint primary key(stt_id)
);


create table if not exists tb_copias(
	cop_id smallint(4) unsigned zerofill not null auto_increment,
    cop_stt_id tinyint(1) unsigned zerofill,
	cop_tdm_id tinyint(2) unsigned zerofill,
    constraint primary key(cop_id),
    constraint fk_tdm_cop foreign key(cop_tdm_id)
		references tb_tipos_midias (tdm_id)
        on update cascade on delete cascade,
	constraint fk_stt_cop foreign key(cop_stt_id)
		references tb_status (stt_id)
        on update cascade on delete cascade        
);


create table if not exists tb_copias_locacoes(
	cdl_loc_id int(9) unsigned zerofill not null,
    cdl_cop_id tinyint(1) unsigned zerofill,	
    constraint primary key(cdl_loc_id),
    constraint primary key(cdl_cop_id),
    constraint fk_tdm_cop foreign key(cop_tdm_id)
		references tb_tipos_midias (tdm_id)
        on update cascade on delete cascade,
	constraint fk_stt_cop foreign key(cop_stt_id)
		references tb_status (stt_id)
        on update cascade on delete cascade        
);
