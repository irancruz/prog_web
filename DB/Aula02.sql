use db_locadora_noite;

create table if not exists tb_bairros(
	bai_id int(9) unsigned zerofill not null auto_increment,
    bai_nome varchar(50) not null,
    bai_cid_id smallint(4) unsigned zerofill,
    constraint primary key (bai_id),
    constraint fk_cid_bai foreign key (bai_cid_id)
    references tb_cidades (cid_id)
    on update cascade on delete cascade
);

insert into tb_bairros (bai_cid_id, bai_nome)
values ('1', 'TIROL'), ('1', 'LAGOA AZUL'),
('2', 'ALTO DE SÃO MANOEL'), 
('3', 'MANÍRA'), ('3', 'BESSA'),
('4', 'CENTRO'), ('5', 'BOA VIAGEM');


create table if not exists tb_ceps(
	cep_id char(8) not null,
    cep_logradouro varchar(60) ,
    cep_bai_id int(9) unsigned zerofill,
    constraint primary key (cep_id),
    constraint fk_bai_cep foreign key (cep_bai_id)
    references tb_bairros (bai_id)
    on update cascade on delete cascade
);


insert into tb_ceps(cep_id, cep_bai_id, cep_logradouro) 
values ('59030350', 1, 'AVENIDA ALIXANDRINO DE ALENCAR'),
('59138500', 2, 'RUA PATATIVA DO ASSARÉ'),
('59650000', NULL, NULL),
('59067500', 1, 'RUA DOS ALGAROBAS'),
('58038518', 4, 'RUA ALINE FERREIRA RUFFO'),
('51030900', 7, 'AVENIDA BOA VIAGEM');


CREATE TABLE IF NOT EXISTS tb_clientes (
    cli_id INT(9) UNSIGNED ZEROFILL NOT NULL AUTO_INCREMENT,
    cli_nome VARCHAR(80) NOT NULL,
    cli_cpf CHAR(11) NOT NULL,
    cli_rg CHAR(9),
    cli_data_nascimento DATE NOT NULL,
    cli_sex_id TINYINT(1) UNSIGNED ZEROFILL NOT NULL,
    cli_cep_id CHAR(8) NOT NULL,
    cli_lograouro VARCHAR(60),
    cli_numero VARCHAR(10),
    cli_complemento VARCHAR(20),
    CONSTRAINT PRIMARY KEY (cli_id),
    CONSTRAINT uk_cpf UNIQUE KEY (cli_cpf),
    CONSTRAINT fk_sex_cli FOREIGN KEY (cli_sex_id)
        REFERENCES tb_sexos (sex_id)
        ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT fk_cep_cli FOREIGN KEY (cli_cep_id)
        REFERENCES tb_ceps (cep_id)
        ON UPDATE CASCADE ON DELETE CASCADE
);

insert into tb_clientes (cli_nome, cli_cpf, cli_rg, cli_data_nascimento, cli_cep_id, cli_sex_id)
values ('JHONATANN LUCAS', '09132187408', NULL, '1997-01-28', '59030350', 1),
('IRANILSON CRUZ', 		   '12034565466', NULL, '1987-06-12', '59067500', 1),
('AMANDA CRUZ', 		   '56897646874', NULL, '2005-02-12', '58038518', 2);


CREATE TABLE IF NOT EXISTS tb_fones_clientes (
    fdc_cli_id INT(9) UNSIGNED ZEROFILL NOT NULL,
    fdc_fone VARCHAR(12) NOT NULL,
    CONSTRAINT PRIMARY KEY (fdc_cli_id , fdc_fone),
    CONSTRAINT fk_cli_fdc FOREIGN KEY (fdc_cli_id)
        REFERENCES tb_clientes (cli_id)
        ON UPDATE CASCADE ON DELETE CASCADE
);


insert into tb_fones_clientes (fdc_cli_id, fdc_fone) 
values (1, '843232245'), (1, '8498721836'),
(2, '84999678541'), (3, '46541546');


CREATE TABLE IF NOT EXISTS tb_emails_clientes (
    edc_cli_id INT(9) UNSIGNED ZEROFILL NOT NULL,
    edc_email VARCHAR(100),
    CONSTRAINT PRIMARY KEY (edc_cli_id , edc_email),
    CONSTRAINT fk_cli_edc FOREIGN KEY (edc_cli_id)
        REFERENCES tb_clientes (cli_id)
        ON UPDATE CASCADE ON DELETE CASCADE
);

*******

CREATE TABLE IF NOT EXISTS tb_graus_parentescos (
    gdp_tinyinti_id INT(9) UNSIGNED ZEROFILL NOT NULL AUTO_INCREMENT,
    edc_email VARCHAR(100),
    CONSTRAINT PRIMARY KEY (edc_cli_id , edc_email),
    CONSTRAINT fk_cli_edc FOREIGN KEY (edc_cli_id)
        REFERENCES tb_clientes (cli_id)
        ON UPDATE CASCADE ON DELETE CASCADE
);


create table if not exists tb_dependentes(
	dep_id int(9) UNSIGNED ZEROFILL NOT NULL AUTO_INCREMENT,
    dep_nome varchar(80) not null,
    dep_data_dascimento date not null,
    dep_cli_id int(9) unsigned zerofill not null,
    dep_sex_id tinyint(1) unsigned zerofill not null,
    dep_gdp_id tinyint(2) unsigned zerofill not null,
    constraint primary key (dep_id),
    constraint fk_cli_dep foreign key (dep_cli_id)
		references tb_clientes (cli_id)
        on update cascade on delete cascade,	
    constraint fk_gdp_dep foreign key (dep_gdp_id)
		references tb_graus_parentescos (gdp_id)
        on update cascade on delete cascade,
	constraint fk_sex_dep foreign key (dep_sex_id)
		references tb_sexos (sex_id)
        on update cascade on delete cascade        
);


