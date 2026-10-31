Create database bd_pessoas_e_propriedades;
Use bd_pessoas_e_propriedades;

Create table tb_pessoa_fisica (
cd_cpf varchar(11) primary key,
nm_pessoa_fisica varchar(60),
nr_idade int);

Create table tb_empresa (
cd_cnpj varchar (15) primary key,
nm_fantasia_empresa varchar (60),
vl_capital_social float,
id_cpf varchar (11),
Constraint fk_id_cpf foreign key (id_cpf) references tb_pessoa_fisica(cd_cpf) on delete cascade);

Create table tb_automovel (
cd_placa varchar (7) primary key,
nm_marca varchar (30),
nm_modelo varchar (30),
nr_ano_fabricacao int,
vl_tabela_fipe float,
id_cpf varchar (11),
Constraint fk_cod_cpf foreign key (id_cpf) references tb_pessoa_fisica(cd_cpf) on delete cascade
);

insert into tb_pessoa_fisica (cd_cpf, nm_pessoa_fisica, nr_idade) values 
('56478903890', 'João Silva', 50),
('67896532451', 'Rafaela Arruda', 39),
('78635428919', 'Marcos Borges', 30);

INSERT INTO tb_empresa (cd_cnpj, nm_fantasia_empresa, vl_capital_social, id_cpf) values
('898028760703456', 'Cacau Show', 100000.00, '56478903890'),
('427526330847867', 'McDonalds', 350000.00, '67896532451'),
('753914480772234', 'BK', 100000.00, '78635428919'),
('502461810602345', 'Comeri Automóveis', 100000.00, '56478903890'),
('365618280976578', 'Habbibs', 350000.00, '67896532451'),
('883943600683421', 'Chiquinho Sorvete', 100000.00, '78635428919');

INSERT INTO tb_automovel(cd_placa, nm_marca, nm_modelo, nr_ano_fabricacao, vl_tabela_fipe, id_cpf) values
('GIA2173', 'Chevrolet', 'CAMARO', 2012, 300000.00, '56478903890'),
('JWK6O88', 'KIA', 'PICANTO', 2011, 350000.00, '67896532451'),
('CAI9281', 'FORD', 'FUSION', 2010, 100000.00, '67896532451'),
('HUC1J39', 'FORD', 'FOCUS', 2006, 20000.00, '56478903890'),
('FUH1345', 'RENAULT', 'CLIO', 2003, 350000.00, '78635428919');

SELECT tb_automovel.cd_placa, tb_automovel.nm_marca, tb_automovel.nm_modelo,
tb_empresa.cd_cnpj, tb_empresa.nm_fantasia_empresa from tb_automovel INNER JOIN tb_empresa ON tb_automovel.id_cpf;

SELECT 	tb_pessoa_fisica.nm_pessoa_fisica as 'PROPRIETÁRIO', tb_automovel.cd_placa as 'PLACA', tb_automovel.nm_marca as 'MONTADORA', tb_automovel.nm_modelo as 'MODELO' from tb_pessoa_fisica
INNER JOIN tb_automovel ON tb_pessoa_fisica.cd_cpf = tb_automovel.id_cpf;

SELECT tb_pessoa_fisica.nm_pessoa_fisica as 'Proprietário', tb_empresa.cd_cnpj  as 'CNPJ',nm_fantasia_empresa as 'EMPRESA' 
from tb_pessoa_fisica INNER JOIN tb_empresa on tb_pessoa_fisica.cd_cpf = tb_empresa.id_cpf;

SELECT tb_pessoa_fisica.nm_pessoa_fisica as 'PROPRIETARIO', avg(tb_empresa.vl_capital_social) as 'CAPITAL MÉDIO'
from tb_pessoa_fisica JOIN tb_empresa ON tb_pessoa_fisica.cd_cpf= tb_empresa.id_cpf
group by tb_pessoa_fisica.cd_cpf, tb_pessoa_fisica.nm_pessoa_fisica;

SELECT pf.nm_pessoa_fisica AS 'PROPRIETÁRIO', a.cd_placa AS 'PLACA', a.nm_marca AS 'MONTADORA', a.nm_modelo AS 'MODELO', a.vl_tabela_fipe AS 'VALOR FIPE'
FROM tb_pessoa_fisica pf INNER JOIN tb_automovel a ON pf.cd_cpf = a.id_cpf
WHERE a.vl_tabela_fipe = (
    SELECT MAX(a2.vl_tabela_fipe)
    FROM tb_automovel a2
    WHERE a2.id_cpf = pf.cd_cpf);
    
SELECT pf.nm_pessoa_fisica AS 'PROPRIETÁRIO',    e.cd_cnpj AS 'CNPJ', e.nm_fantasia_empresa AS 'EMPRESA', e.vl_capital_social AS 'CAPITAL SOCIAL'
FROM tb_pessoa_fisica pf INNER JOIN tb_empresa e ON pf.cd_cpf = e.id_cpf
WHERE e.vl_capital_social = (
    SELECT MIN(e2.vl_capital_social)
    FROM tb_empresa e2
    WHERE e2.id_cpf = pf.cd_cpf
);

SELECT
    pf.nm_pessoa_fisica AS 'PROPRIETÁRIO',
    AVG(valores.valor) AS 'VALOR MÉDIO'
FROM tb_pessoa_fisica pf

INNER JOIN (
    
    -- Valores dos automóveis
    SELECT
        id_cpf,
        vl_tabela_fipe AS valor
    FROM tb_automovel

    UNION ALL

    -- Valores das empresas
    SELECT
        id_cpf,
        vl_capital_social AS valor
    FROM tb_empresa

) AS valores
    ON pf.cd_cpf = valores.id_cpf

GROUP BY
    pf.cd_cpf,
    pf.nm_pessoa_fisica;

-- 4 - PESQUISA:
--     NOME DO PROPRIETÁRIO
--     EMPRESA OU MODELO DO AUTOMÓVEL
--     VALOR DO CAPITAL SOCIAL OU TABELA FIPE
-- =========================================================

SELECT
    pf.nm_pessoa_fisica AS 'PROPRIETÁRIO',
    e.nm_fantasia_empresa AS 'EMPRESA',
    e.vl_capital_social AS 'CAPITAL SOCIAL',
    a.nm_modelo AS 'MODELO DO AUTOMÓVEL',
    a.vl_tabela_fipe AS 'VALOR FIPE'
FROM tb_pessoa_fisica pf
LEFT JOIN tb_empresa e
    ON pf.cd_cpf = e.id_cpf
LEFT JOIN tb_automovel a
    ON pf.cd_cpf = a.id_cpf
WHERE
    pf.nm_pessoa_fisica LIKE '%João%'
    OR e.nm_fantasia_empresa LIKE '%João%'
    OR a.nm_modelo LIKE '%João%';