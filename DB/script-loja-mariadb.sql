CREATE TABLE tb_marcas (
  mar_id SMALLINT(4) UNSIGNED ZEROFILL NOT NULL AUTO_INCREMENT,
  mar_nome VARCHAR(20) NOT NULL,
  PRIMARY KEY(mar_id)
);

CREATE TABLE tb_departamentos (
  dep_id TINYINT(3) UNSIGNED ZEROFILL NOT NULL AUTO_INCREMENT,
  dep_nome VARCHAR(20) NOT NULL,
  dep_sigla CHAR(5) NOT NULL,
  dep_desconto DECIMAL(3,2) NOT NULL,
  PRIMARY KEY(dep_id)
);

CREATE TABLE tb_formas_pagamentos (
  fdp_id TINYINT(2) UNSIGNED ZEROFILL NOT NULL AUTO_INCREMENT,
  fdp_nome VARCHAR(20) NOT NULL,
  PRIMARY KEY(fdp_id)
);

CREATE TABLE tb_sexos (
  sex_id TINYINT(1) UNSIGNED ZEROFILL NOT NULL AUTO_INCREMENT,
  sex_nome VARCHAR(12) NOT NULL,
  sex_sigla CHAR(1) NOT NULL,
  PRIMARY KEY(sex_id),
  UNIQUE INDEX uk_sigla(sex_sigla)
);

CREATE TABLE tb_ufs (
  uf_id TINYINT(2) UNSIGNED ZEROFILL NOT NULL AUTO_INCREMENT,
  uf_nome VARCHAR(30) NOT NULL,
  uf_sigla CHAR(2) NOT NULL,
  PRIMARY KEY(uf_id),
  UNIQUE INDEX uk_sigla(uf_sigla)
);

CREATE TABLE tb_cidades (
  cid_id SMALLINT(4) UNSIGNED ZEROFILL NOT NULL AUTO_INCREMENT,
  cid_nome VARCHAR(50) NOT NULL,
  cid_uf_id TINYINT(2) UNSIGNED ZEROFILL NULL,
  PRIMARY KEY(cid_id),
  INDEX fk_uf_cid(cid_uf_id),
  FOREIGN KEY(cid_uf_id)
    REFERENCES tb_ufs(uf_id)
      ON DELETE CASCADE
      ON UPDATE CASCADE
);

CREATE TABLE tb_produtos (
  pro_id INT(9) UNSIGNED ZEROFILL NOT NULL AUTO_INCREMENT,
  pro_nome VARCHAR(20) NOT NULL,
  pro_descricao VARCHAR(100) NULL,
  pro_preco DECIMAL(6,2) NOT NULL,
  pro_quantidade_estoque SMALLINT(5) UNSIGNED ZEROFILL NOT NULL,
  pro_quantidade_minima TINYINT(3) UNSIGNED ZEROFILL NOT NULL,
  pro_mar_id SMALLINT(4) UNSIGNED ZEROFILL NOT NULL,
  pro_dep_id TINYINT(3) UNSIGNED ZEROFILL NOT NULL,
  PRIMARY KEY(pro_id),
  INDEX fk_dep_pro(pro_dep_id),
  INDEX fk_mar_pro(pro_mar_id),
  FOREIGN KEY(pro_dep_id)
    REFERENCES tb_departamentos(dep_id)
      ON DELETE CASCADE
      ON UPDATE CASCADE,
  FOREIGN KEY(pro_mar_id)
    REFERENCES tb_marcas(mar_id)
      ON DELETE CASCADE
      ON UPDATE CASCADE
);

CREATE TABLE tb_bairros (
  bai_id INT(9) UNSIGNED ZEROFILL NOT NULL AUTO_INCREMENT,
  bai_nome VARCHAR(50) NOT NULL,
  bai_cid_id SMALLINT(4) UNSIGNED ZEROFILL NOT NULL,
  PRIMARY KEY(bai_id),
  INDEX fk_cid_bai(bai_cid_id),
  FOREIGN KEY(bai_cid_id)
    REFERENCES tb_cidades(cid_id)
      ON DELETE CASCADE
      ON UPDATE CASCADE
);

CREATE TABLE tb_ceps (
  cep_id CHAR(8) NOT NULL,
  cep_logradouro VARCHAR(80) NULL,
  cep_bai_id INT(9) UNSIGNED ZEROFILL NULL,
  PRIMARY KEY(cep_id),
  INDEX fk_bai_cep(cep_bai_id),
  FOREIGN KEY(cep_bai_id)
    REFERENCES tb_bairros(bai_id)
      ON DELETE CASCADE
      ON UPDATE CASCADE
);

CREATE TABLE tb_clientes (
  cli_id INT(9) UNSIGNED ZEROFILL NOT NULL AUTO_INCREMENT,
  cli_nome VARCHAR(80) NOT NULL,
  cli_cep_id CHAR(8) NOT NULL,
  cli_numero VARCHAR(10) NULL,
  cli_complemento VARCHAR(20) NULL,
  PRIMARY KEY(cli_id),
  INDEX fk_cep_cli(cli_cep_id),
  FOREIGN KEY(cli_cep_id)
    REFERENCES tb_ceps(cep_id)
      ON DELETE CASCADE
      ON UPDATE CASCADE
);

CREATE TABLE tb_emails_clientes (
  edc_cli_id INT(9) UNSIGNED ZEROFILL NOT NULL,
  edc_email VARCHAR(100) NOT NULL,
  PRIMARY KEY(edc_cli_id, edc_email),
  INDEX fk_cli_edc(edc_cli_id),
  FOREIGN KEY(edc_cli_id)
    REFERENCES tb_clientes(cli_id)
      ON DELETE CASCADE
      ON UPDATE CASCADE
);

CREATE TABLE tb_funcionarios (
  fun_matricula SMALLINT(4) UNSIGNED ZEROFILL NOT NULL AUTO_INCREMENT,
  fun_nome VARCHAR(80) NOT NULL,
  fun_cpf CHAR(11) NOT NULL,
  fun_rg CHAR(9) NULL,
  fun_data_admissao DATE NOT NULL,
  fun_data_demissao DATE NULL,
  fun_sex_id TINYINT(1) UNSIGNED ZEROFILL NOT NULL,
  fun_sup_matricula SMALLINT(4) UNSIGNED ZEROFILL NULL,
  fun_cep_id CHAR(8) NOT NULL,
  fun_numero VARCHAR(10) NULL,
  fun_complemento VARCHAR(20) NULL,
  PRIMARY KEY(fun_matricula),
  INDEX fk_sup_fun(fun_sup_matricula),
  INDEX fk_sex_fun(fun_sex_id),
  INDEX fk_cep_fun(fun_cep_id),
  UNIQUE INDEX uk_cpf(fun_cpf),
  FOREIGN KEY(fun_sup_matricula)
    REFERENCES tb_funcionarios(fun_matricula)
      ON DELETE SET NULL
      ON UPDATE SET NULL,
  FOREIGN KEY(fun_sex_id)
    REFERENCES tb_sexos(sex_id)
      ON DELETE CASCADE
      ON UPDATE CASCADE,
  FOREIGN KEY(fun_cep_id)
    REFERENCES tb_ceps(cep_id)
      ON DELETE CASCADE
      ON UPDATE CASCADE
);

CREATE TABLE tb_pessoas_fisicas (
  cpf_cli_id INT(9) UNSIGNED ZEROFILL NOT NULL,
  cpf_cpf CHAR(11) NOT NULL,
  cpf_rg CHAR(9) NULL,
  cpf_sex_id TINYINT(1) UNSIGNED ZEROFILL NOT NULL,
  PRIMARY KEY(cpf_cli_id),
  INDEX fk_cli_cpf(cpf_cli_id),
  INDEX fk_sex_cpf(cpf_sex_id),
  UNIQUE INDEX uk_cpf(cpf_cpf),
  FOREIGN KEY(cpf_cli_id)
    REFERENCES tb_clientes(cli_id)
      ON DELETE CASCADE
      ON UPDATE CASCADE,
  FOREIGN KEY(cpf_sex_id)
    REFERENCES tb_sexos(sex_id)
      ON DELETE CASCADE
      ON UPDATE CASCADE
);

CREATE TABLE tb_vendas (
  ven_id INT(9) UNSIGNED ZEROFILL NOT NULL AUTO_INCREMENT,
  ven_nota_fiscal INT(9) UNSIGNED ZEROFILL NOT NULL,
  ven_fun_matricula SMALLINT(4) UNSIGNED ZEROFILL NOT NULL,
  ven_cli_id INT(9) UNSIGNED ZEROFILL NOT NULL,
  ven_fdp_id TINYINT(2) UNSIGNED ZEROFILL NOT NULL,
  ven_data_venda DATE NOT NULL,
  ven_total_venda DECIMAL(6,2) NOT NULL,
  PRIMARY KEY(ven_id),
  INDEX fk_cli_ven(ven_cli_id),
  INDEX fk_fun_ven(ven_fun_matricula),
  INDEX fk_fdp_ven(ven_fdp_id),
  FOREIGN KEY(ven_cli_id)
    REFERENCES tb_clientes(cli_id)
      ON DELETE CASCADE
      ON UPDATE CASCADE,
  FOREIGN KEY(ven_fun_matricula)
    REFERENCES tb_funcionarios(fun_matricula)
      ON DELETE CASCADE
      ON UPDATE CASCADE,
  FOREIGN KEY(ven_fdp_id)
    REFERENCES tb_formas_pagamentos(fdp_id)
      ON DELETE CASCADE
      ON UPDATE CASCADE
);

CREATE TABLE tb_fones_funcionarios (
  fdf_fun_matricula SMALLINT(4) UNSIGNED ZEROFILL NOT NULL,
  fdf_fone VARCHAR(12) NOT NULL,
  PRIMARY KEY(fdf_fun_matricula, fdf_fone),
  INDEX fk_fun_fdf(fdf_fun_matricula),
  FOREIGN KEY(fdf_fun_matricula)
    REFERENCES tb_funcionarios(fun_matricula)
      ON DELETE CASCADE
      ON UPDATE CASCADE
);

CREATE TABLE tb_pessoas_juridicas (
  cpj_cli_id INT(9) UNSIGNED ZEROFILL NOT NULL,
  cpj_razao_social VARCHAR(80) NOT NULL,
  cpj_cnpj CHAR(14) NOT NULL,
  cpj_inscricao_estadual CHAR(9) NOT NULL,
  cpj_inscricao_municipal CHAR(9) NOT NULL,
  cpj_website VARCHAR(80) NULL,
  PRIMARY KEY(cpj_cli_id),
  INDEX fk_cli_cpj(cpj_cli_id),
  UNIQUE INDEX uk_cnpj(cpj_cnpj),
  FOREIGN KEY(cpj_cli_id)
    REFERENCES tb_clientes(cli_id)
      ON DELETE CASCADE
      ON UPDATE CASCADE
);

CREATE TABLE tb_fornecedores (
  for_id SMALLINT(4) UNSIGNED NOT NULL AUTO_INCREMENT,
  for_nome_fantasia VARCHAR(80) NOT NULL,
  for_razao_social VARCHAR(80) NOT NULL,
  for_cnpj CHAR(14) NOT NULL,
  for_inscricao_estadual CHAR(9) NOT NULL,
  for_inscricao_municipal CHAR(9) NOT NULL,
  for_website VARCHAR(80) NULL,
  for_cep_id CHAR(8) NOT NULL,
  for_numero VARCHAR(10) NULL,
  for_complemento VARCHAR(20) NULL,
  PRIMARY KEY(for_id),
  UNIQUE INDEX uk_cnpj(for_cnpj),
  INDEX fk_cep_for(for_cep_id),
  FOREIGN KEY(for_cep_id)
    REFERENCES tb_ceps(cep_id)
      ON DELETE CASCADE
      ON UPDATE CASCADE
);

CREATE TABLE tb_fones_clientes (
  fdc_fone VARCHAR(12) NOT NULL,
  fdc_cli_id INT(9) UNSIGNED ZEROFILL NOT NULL,
  PRIMARY KEY(fdc_fone, fdc_cli_id),
  INDEX fk_cli_fdc(fdc_cli_id),
  FOREIGN KEY(fdc_cli_id)
    REFERENCES tb_clientes(cli_id)
      ON DELETE CASCADE
      ON UPDATE CASCADE
);

CREATE TABLE tb_emails_funcionarios (
  edf_fun_matricula SMALLINT(4) UNSIGNED ZEROFILL NOT NULL,
  edf_email VARCHAR(100) NOT NULL,
  PRIMARY KEY(edf_fun_matricula, edf_email),
  INDEX fk_fun_edf(edf_fun_matricula),
  FOREIGN KEY(edf_fun_matricula)
    REFERENCES tb_funcionarios(fun_matricula)
      ON DELETE CASCADE
      ON UPDATE CASCADE
);

CREATE TABLE tb_emails_fornecedores (
  edf_for_id SMALLINT(4) UNSIGNED NOT NULL,
  edf_email VARCHAR(100) NOT NULL,
  PRIMARY KEY(edf_for_id, edf_email),
  INDEX fk_for_edf(edf_for_id),
  FOREIGN KEY(edf_for_id)
    REFERENCES tb_fornecedores(for_id)
      ON DELETE CASCADE
      ON UPDATE CASCADE
);

CREATE TABLE tb_compras (
  com_id INT(9) UNSIGNED ZEROFILL NOT NULL AUTO_INCREMENT,
  com_nota_fiscal INT(9) UNSIGNED ZEROFILL NOT NULL,
  com_for_id SMALLINT(4) UNSIGNED NOT NULL,
  com_data_compra DATE NOT NULL,
  com_total_compra DECIMAL(6,2) NOT NULL,
  PRIMARY KEY(com_id),
  INDEX fk_for_com(com_for_id),
  FOREIGN KEY(com_for_id)
    REFERENCES tb_fornecedores(for_id)
      ON DELETE CASCADE
      ON UPDATE CASCADE
);

CREATE TABLE tb_itens_compras (
  idc_com_id INT(9) UNSIGNED ZEROFILL NOT NULL,
  idc_pro_id INT(9) UNSIGNED ZEROFILL NOT NULL,
  PRIMARY KEY(idc_com_id, idc_pro_id),
  INDEX fk_com_idc(idc_com_id),
  INDEX fk_pro_idc(idc_pro_id),
  FOREIGN KEY(idc_com_id)
    REFERENCES tb_compras(com_id)
      ON DELETE CASCADE
      ON UPDATE CASCADE,
  FOREIGN KEY(idc_pro_id)
    REFERENCES tb_produtos(pro_id)
      ON DELETE CASCADE
      ON UPDATE CASCADE
);

CREATE TABLE tb_itens_vendas (
  idv_ven_id INT(9) UNSIGNED ZEROFILL NOT NULL,
  idv_pro_id INT(9) UNSIGNED ZEROFILL NOT NULL,
  PRIMARY KEY(idv_ven_id, idv_pro_id),
  INDEX fk_ven_idv(idv_ven_id),
  INDEX fk_pro_idv(idv_pro_id),
  FOREIGN KEY(idv_ven_id)
    REFERENCES tb_vendas(ven_id)
      ON DELETE CASCADE
      ON UPDATE CASCADE,
  FOREIGN KEY(idv_pro_id)
    REFERENCES tb_produtos(pro_id)
      ON DELETE CASCADE
      ON UPDATE CASCADE
);

CREATE TABLE tb_fones_fornecedores (
  fdf_for_id SMALLINT(4) UNSIGNED NOT NULL,
  fdf_fone VARCHAR(12) NOT NULL,
  PRIMARY KEY(fdf_for_id, fdf_fone),
  INDEX fk_for_fdf(fdf_for_id),
  FOREIGN KEY(fdf_for_id)
    REFERENCES tb_fornecedores(for_id)
      ON DELETE CASCADE
      ON UPDATE CASCADE
);


