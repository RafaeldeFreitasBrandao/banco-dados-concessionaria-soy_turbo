CREATE DATABASE soy_turbo;
USE soy_turbo;

-- ========== TABELA GERENTE ============== --

create table gerentes
(
id_gerente	INT AUTO_INCREMENT NOT NULL,
nome 		VARCHAR(100) NOT NULL,
CPF 		CHAR(11) NOT NULL,
telefone 	VARCHAR(50) NOT NULL,
endereco 	VARCHAR(150) NOT NULL,
email 		VARCHAR(150) NOT NULL,
salario     DECIMAL(10,2) NOT NULL,

UNIQUE (CPF),
UNIQUE (email),
UNIQUE (telefone),

PRIMARY KEY (id_gerente)
);

-- ========== TABELA FORNECEDOR ============== --

create table fornecedores
(
id_fornecedor INT AUTO_INCREMENT NOT NULL,
nome_empresa  VARCHAR(200) NOT NULL,
CNPJ 		  CHAR(14) NOT NULL,
email 		  VARCHAR(150) NOT NULL,
endereco 	  VARCHAR(150) NOT NULL,
telefone 	  VARCHAR(50) NOT NULL,

id_gerente 	  INT NOT NULL,

UNIQUE (CNPJ),
UNIQUE (email),
UNIQUE (telefone),

PRIMARY KEY (id_fornecedor),
FOREIGN KEY (id_gerente) REFERENCES gerentes(id_gerente)

);

-- ============= TABELA FRETADORES ============== --

create table fretadores
(
id_fretador 	INT AUTO_INCREMENT NOT NULL,
nome 			VARCHAR(100) NOT NULL,
CPF 			CHAR(11) NOT NULL,
email 			VARCHAR(150) NOT NULL,
telefone 		VARCHAR(50) NOT NULL,
endereco 		VARCHAR (150) NOT NULL,
salario 		DECIMAL(10,2) NOT NULL,

id_gerente 		INT NOT NULL,

UNIQUE (CPF),
UNIQUE (email),
UNIQUE (telefone),

PRIMARY KEY (id_fretador),
FOREIGN KEY (id_gerente) REFERENCES gerentes(id_gerente)
);

-- =========== TABELA VENDEDORES =============== --

create table vendedores
(
id_vendedor 	INT AUTO_INCREMENT NOT NULL,
nome 			VARCHAR(100) NOT NULL,
CPF 			CHAR(11) NOT NULL, 
email 			VARCHAR(150) NOT NULL, 
telefone 		VARCHAR(50) NOT NULL,
endereco 		VARCHAR(150) NOT NULL,
salario 		DECIMAL(10,2) NOT NULL,
id_gerente 		INT NOT NULL,

UNIQUE (CPF),
UNIQUE (email),
UNIQUE (telefone),

PRIMARY KEY (id_vendedor),
FOREIGN KEY (id_gerente) REFERENCES gerentes(id_gerente)

);

-- ========== TABELA COMPRADORES =========== --

create table compradores
(
id_comprador 	INT AUTO_INCREMENT NOT NULL,
nome 			VARCHAR(100) NOT NULL,
CPF 			CHAR(11) NOT NULL,
email 			VARCHAR(150) NOT NULL, 
telefone 		VARCHAR(50) NOT NULL,
endereco 		VARCHAR(150) NOT NULL,

UNIQUE (CPF),
UNIQUE (email),
UNIQUE (telefone),

PRIMARY KEY (id_comprador)

);

-- =============== TABELA MODELOS ================= --

create table modelos
(
codigo_modelo	INT AUTO_INCREMENT NOT NULL,
modelo 			VARCHAR(100) NOT NULL,

id_fornecedor 	INT NOT NULL,

PRIMARY KEY (codigo_modelo),
FOREIGN KEY (id_fornecedor) REFERENCES fornecedores(id_fornecedor)

);

-- =============== TABELA AUTOMÓVEIS VENDIDOS ===== --

create table automoveis_vendidos 
(
codigo_auto 	INT AUTO_INCREMENT NOT NULL,
cor 			VARCHAR(100) NOT NULL,
ano 			YEAR NOT NULL, 
quilometragem 	INT NOT NULL,
preco_venda 	DECIMAL (10,2) NOT NULL, 

codigo_modelo	INT NOT NULL, 

PRIMARY KEY (codigo_auto),
FOREIGN KEY (codigo_modelo) REFERENCES modelos(codigo_modelo)
);

-- =============== TABELA CONTRATOS =============== --

create table contratos
(
codigo_contrato INT AUTO_INCREMENT NOT NULL,
criado_em		TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,

id_vendedor 	INT NOT NULL,
codigo_auto 	INT NOT NULL,
id_comprador 	INT NOT NULL,

forma_pagamento ENUM('À VISTA', 'PARCELADO') NOT NULL DEFAULT 'PARCELADO',
opcao_entrega   ENUM('RETIRADA', 'ENTREGA') NOT NULL DEFAULT 'RETIRADA',
status_garantia ENUM('SIM', 'NÃO') NOT NULL DEFAULT 'NÃO',
status_seguro 	ENUM('SIM', 'NÃO') NOT NULL DEFAULT 'NÃO',

PRIMARY KEY (codigo_contrato),
FOREIGN KEY (id_vendedor) REFERENCES vendedores(id_vendedor),
FOREIGN KEY (codigo_auto) REFERENCES automoveis_vendidos(codigo_auto),
FOREIGN KEY (id_comprador) REFERENCES compradores(id_comprador)

);

-- =============== TABELA ENTREGAS ===================== --

create table entrega
(
codigo_entrega  INT AUTO_INCREMENT NOT NULL,
data_entrega    DATE NOT NULL,
horario 	    TIME NOT NULL,

id_fretador     INT NOT NULL,
codigo_contrato INT NOT NULL,

PRIMARY KEY (codigo_entrega),
FOREIGN KEY (id_fretador) REFERENCES fretadores(id_fretador),
FOREIGN KEY (codigo_contrato) REFERENCES contratos(codigo_contrato)

);

-- ============ INSERÇÃO DE REGISTROS ================== --

-- ============ TABELA GERENTES (10 gerentes) ======================= --

INSERT INTO gerentes (nome, CPF, telefone, endereco, email, salario) VALUES

('Arthur Silva', '11132978538', '+55 41 978417432', 'Rua das Flores, 12 - Rebouças, Curitiba - PR', 'arthur.silva12@gmail.com', 18800.00),
('Belinda Freitas', '11132978540', '+55 41 937417434', 'Travessa Oliva, 23 - Centro, Curitiba - PR', 'belinda.freitas23@gmail.com', 17500.00),
('Carlotta Cristovão', '11132978545', '+55 41 917417439', 'Rua Ipiranga, 9 - Batel, Curitiba - PR', 'carlotta.cristovao9@gmail.com', 18300.00),
('Daniel Alves', '11132978548', '+55 41 974417442', 'Vila Nova, 34 - São João, Curitiba - PR', 'daniel.alves34@gmail.com', 17800.00),
('Elisa Carmen', '11132978549', '+55 41 927417443', 'Praça Rui Barbosa, 2 - Santa Felicidade, Curitiba - PR', 'elisa.carmen2@gmail.com', 19400.00),
('Fernanda Felipe', '11132978550', '+55 41 997417444', 'Rua das Palmeiras, 77 - Pilarzinho, Curitiba - PR', 'fernanda.felipe77@gmail.com', 17650.00),
('Gabriel Cadeira', '11132978552', '+55 41 977417446', 'Rua dos Andradas, 301 - Juvevê, Curitiba - PR', 'gabriel.cadeira301@gmail.com', 17100.00),
('Hulk Neto', '11132978554', '+55 41 974517448', 'Travessa do Sol, 5 - Bigorrilho, Curitiba - PR', 'hulk.neto5@gmail.com', 21000.00),
('Neymar Junior', '11132978555', '+55 41 917817449', 'Rua Maracanã, 100 - Monçungue, Curitiba - PR', 'neymar.junior100@gmail.com', 23000.00),
('Zico Alcides', '11132978556', '+55 41 927437450', 'Avenida dos Campeões, 9 - Tarumã, Curitiba - PR', 'zico.alcides9@gmail.com', 16950.00);

-- ============ TABELA FORNECEDOR (15 fornecedores) =============== --

INSERT INTO fornecedores (nome_empresa, CNPJ, email, endereco, telefone, id_gerente) VALUES
('AutoPeças Silva Ltda', '12345678000191', 'contato@autopecassilva.com.br', 'Rua XV de Novembro, 123 - Centro, Curitiba - PR', '+55 41 991000001', 1),
('AutoMotores Ltda', '23456789000182', 'vendas@automotores.com.br', 'Avenida Sete de Setembro, 742 - Rebouças, Curitiba - PR', '+55 41 991000002', 5),
('Rápido Carros S/A', '34567890000173', 'comercial@rapidocarros.com.br', 'Rua Professor Marques, 456 - Batel, Curitiba - PR', '+55 41 991000003', 3),
('Prime Auto Comércio', '45678901000164', 'suporte@primeauto.com.br', 'Alameda Princesa Izabel, 89 - Bigorrilho, Curitiba - PR', '+55 41 991000004', 4),
('Central Veículos LTDA', '56789012000155', 'contato@centralveiculos.com.br', 'Rua 24 de Maio, 210 - Centro Cívico, Curitiba - PR', '+55 41 991000005', 10),
('Turbo Motors Distribuição', '67890123000146', 'distrib@turbomotors.com.br', 'Rodovia BR-277, Km 75 - Distrito Industrial, Curitiba - PR', '+55 41 991000006', 6),
('AutoTech Distribuidora', '78901234000137', 'tecnologia@autotech.com.br', 'Rua Chile, 1120 - Centro, Curitiba - PR', '+55 41 991000007', 2),
('CarCenter Comércio', '89012345000128', 'contato@carcenter.com.br', 'Avenida Iguaçu, 3000 - Água Verde, Curitiba - PR', '+55 41 991000008', 8),
('NovaRoda Comércio Ltda', '90123456000119', 'vendas@novaroda.com.br', 'Travessa Santo Antônio, 52 - Juvevê, Curitiba - PR', '+55 41 991000009', 5),
('Rodas & Cia Importação', '11234567000190', 'import@rodasecia.com.br', 'Rua Monsenhor Ivo Zanlorenzi, 987 - Portão, Curitiba - PR', '+55 41 991000010', 1),
('MotorPrime Ltda', '22345678000181', 'comercial@motorprime.com.br', 'Avenida Marechal Floriano Peixoto, 1570 - Centro, Curitiba - PR', '+55 41 991000011', 9),
('Garage Plus Distribuição', '33456789000172', 'contato@garageplus.com.br', 'Rua Coronel Menna Barreto, 221 - Batel, Curitiba - PR', '+55 41 991000012', 7),
('Elite Automotiva S/A', '44567890000163', 'elite@eliteautomotiva.com.br', 'Rua Francisco Dallalibera, 1400 - Santa Felicidade, Curitiba - PR', '+55 41 991000013', 10),
('AutoMaster Distribuição', '55678901000154', 'suporte@automaster.com.br', 'Rua José Hauer, 410 - Boqueirão, Curitiba - PR', '+55 41 991000014', 3),
('Velocitta Imports Ltda', '66789012000145', 'contato@velocittaimports.com.br', 'Rua Machado de Assis, 75 - Alto da XV, Curitiba - PR', '+55 41 991000015', 5);

-- ===================== TABELA FRETADOR (20 fretadores) ===================== --

INSERT INTO fretadores (nome, CPF, email, telefone, endereco, salario, id_gerente) VALUES

('Marcos Andrade', '12345678901', 'marcos.andrade@fretelog.com', '+55 41 992200001', 'Rua XV de Novembro, 300 - Centro, Curitiba - PR', 5200.00, 9),
('Claudio Pereira', '23456789012', 'claudio.pereira@fretelog.com', '+55 41 992200002', 'Avenida Sete de Setembro, 845 - Rebouças, Curitiba - PR', 5400.00, 2),
('Anderson Silva', '34567890123', 'anderson.silva@fretelog.com', '+55 41 992200003', 'Rua Marechal Deodoro, 150 - Centro, Curitiba - PR', 4800.00, 3),
('Rafael Nogueira', '45678901234', 'rafael.nogueira@fretelog.com', '+55 41 992200004', 'Rua Chile, 900 - Água Verde, Curitiba - PR', 5000.00, 4),
('Juliano Mendes', '56789012345', 'juliano.mendes@fretelog.com', '+55 41 992200005', 'Rua Alferes Poli, 1220 - Centro, Curitiba - PR', 4700.00, 5),
('Pedro Costa', '67890123456', 'pedro.costa@fretelog.com', '+55 41 992200006', 'Avenida Iguaçu, 1950 - Água Verde, Curitiba - PR', 5900.00, 1),
('Fabio Lima', '78901234567', 'fabio.lima@fretelog.com', '+55 41 992200007', 'Rua João Negrão, 850 - Rebouças, Curitiba - PR', 6100.00, 7),
('Rogerio Campos', '89012345678', 'rogerio.campos@fretelog.com', '+55 41 992200008', 'Rua Nunes Machado, 675 - Centro, Curitiba - PR', 6300.00, 8),
('Leonardo Torres', '90123456789', 'leonardo.torres@fretelog.com', '+55 41 992200009', 'Av. Visconde de Guarapuava, 980 - Batel, Curitiba - PR', 5500.00, 6),
('Bruno Carvalho', '11223344556', 'bruno.carvalho@fretelog.com', '+55 41 992200010', 'Rua Conselheiro Laurindo, 200 - Centro, Curitiba - PR', 5800.00, 10),
('Carlos Eduardo', '22334455667', 'carlos.eduardo@fretelog.com', '+55 41 992200011', 'Rua das Flores, 45 - Centro, Curitiba - PR', 4900.00, 2),
('Fernando Rocha', '33445566778', 'fernando.rocha@fretelog.com', '+55 41 992200012', 'Av. República Argentina, 1550 - Portão, Curitiba - PR', 6200.00, 9),
('Gustavo Matos', '44556677889', 'gustavo.matos@fretelog.com', '+55 41 992200013', 'Rua Monsenhor Celso, 310 - Centro, Curitiba - PR', 5600.00, 3),
('Henrique Duarte', '55667788990', 'henrique.duarte@fretelog.com', '+55 41 992200014', 'Rua Padre Anchieta, 800 - Bigorrilho, Curitiba - PR', 6400.00, 4),
('Eduardo Ramos', '66778899001', 'eduardo.ramos@fretelog.com', '+55 41 992200015', 'Rua Augusto Stresser, 410 - Juvevê, Curitiba - PR', 6000.00, 1),
('Marcelo Pinto', '77889900112', 'marcelo.pinto@fretelog.com', '+55 41 992200016', 'Rua Coronel Dulcídio, 221 - Batel, Curitiba - PR', 5300.00, 5),
('Sergio Oliveira', '88990011223', 'sergio.oliveira@fretelog.com', '+55 41 992200017', 'Estrada da Graciosa, 1400 - Santa Felicidade, Curitiba - PR', 5150.00, 7),
('Victor Hugo', '99001122334', 'victor.hugo@fretelog.com', '+55 41 992200018', 'Avenida Presidente Kennedy, 410 - Boqueirão, Curitiba - PR', 5750.00, 10),
('Mateus Ribeiro', '10111213141', 'mateus.ribeiro@fretelog.com', '+55 41 992200019', 'Rua Ubaldino do Amaral, 75 - Alto da XV, Curitiba - PR', 4650.00, 6),
('Thiago Fernandes', '12131415161', 'thiago.fernandes@fretelog.com', '+55 41 992200020', 'Rua Eduardo Sprada, 48 - Mercês, Curitiba - PR', 6050.00, 8);

-- ==================== TABELA VENDEDORES (20 vendedores) ====================== --

INSERT INTO vendedores (nome, CPF, email, telefone, endereco, salario, id_gerente) VALUES

('Lucas Almeida', '13579246810', 'lucas.almeida@vendemais.com', '+55 41 994100021', 'Rua Desembargador Motta, 1250 - Batel, Curitiba - PR', 4300.00, 1),
('Amanda Rodrigues', '24681357902', 'amanda.rodrigues@vendemais.com', '+55 41 994100022', 'Avenida Manoel Ribas, 2300 - Mercês, Curitiba - PR', 4450.00, 3),
('Ricardo Souza', '35792468103', 'ricardo.souza@vendemais.com', '+55 41 994100023', 'Rua Visconde do Rio Branco, 410 - Centro, Curitiba - PR', 4600.00, 2),
('Juliana Carvalho', '46813579204', 'juliana.carvalho@vendemais.com', '+55 41 994100024', 'Rua Augusto Stresser, 980 - Juvevê, Curitiba - PR', 4400.00, 4),
('Felipe Martins', '57924681305', 'felipe.martins@vendemais.com', '+55 41 994100025', 'Rua Marechal Hermes, 180 - Centro Cívico, Curitiba - PR', 4750.00, 8),
('Patrícia Duarte', '68035792406', 'patricia.duarte@vendemais.com', '+55 41 994100026', 'Rua Itupava, 1040 - Alto da XV, Curitiba - PR', 4150.00, 6),
('Tiago Ramos', '79146813507', 'tiago.ramos@vendemais.com', '+55 41 994100027', 'Rua Chile, 720 - Água Verde, Curitiba - PR', 4900.00, 7),
('Gabriela Torres', '80257924608', 'gabriela.torres@vendemais.com', '+55 41 994100028', 'Rua Brigadeiro Franco, 600 - Rebouças, Curitiba - PR', 4650.00, 5),
('Rodrigo Nascimento', '91368035709', 'rodrigo.nascimento@vendemais.com', '+55 41 994100029', 'Rua Pasteur, 100 - Batel, Curitiba - PR', 4500.00, 9),
('Camila Pires', '10279146810', 'camila.pires@vendemais.com', '+55 41 994100030', 'Rua Martim Afonso, 125 - Mercês, Curitiba - PR', 4700.00, 10),
('Bruno Ferreira', '11380257911', 'bruno.ferreira@vendemais.com', '+55 41 994100031', 'Rua Rockefeller, 200 - Jardim Botânico, Curitiba - PR', 4850.00, 10),
('Natália Mendes', '12491368012', 'natalia.mendes@vendemais.com', '+55 41 994100032', 'Rua Emiliano Perneta, 430 - Centro, Curitiba - PR', 4550.00, 8),
('Rafael Cardoso', '13502479113', 'rafael.cardoso@vendemais.com', '+55 41 994100033', 'Rua Vicente Machado, 870 - Batel, Curitiba - PR', 5000.00, 1),
('Larissa Oliveira', '14613580214', 'larissa.oliveira@vendemais.com', '+55 41 994100034', 'Rua Coronel Dulcídio, 315 - Batel, Curitiba - PR', 4400.00, 3),
('André Barbosa', '15724691315', 'andre.barbosa@vendemais.com', '+55 41 994100035', 'Rua Brigadeiro Franco, 1120 - Rebouças, Curitiba - PR', 4200.00, 5),
('Beatriz Costa', '16835702416', 'beatriz.costa@vendemais.com', '+55 41 994100036', 'Rua Cruz Machado, 80 - Centro, Curitiba - PR', 4350.00, 4),
('Diego Fernandes', '17946813517', 'diego.fernandes@vendemais.com', '+55 41 994100037', 'Rua Monsenhor Celso, 500 - Centro, Curitiba - PR', 4550.00, 7),
('Letícia Silva', '18057924618', 'leticia.silva@vendemais.com', '+55 41 994100038', 'Rua Bento Viana, 250 - Batel, Curitiba - PR', 4700.00, 6),
('Guilherme Lopes', '19168035719', 'guilherme.lopes@vendemais.com', '+55 41 994100039', 'Rua Buenos Aires, 120 - Centro, Curitiba - PR', 4950.00, 7),
('Fernanda Almeida', '20279146820', 'fernanda.almeida@vendemais.com', '+55 41 994100040', 'Rua Saldanha Marinho, 540 - Centro, Curitiba - PR', 4850.00, 9);

-- ================= TABELA COMPRADORES (40 COMPRADORES) ======================== --

INSERT INTO compradores (nome, CPF, email, telefone, endereco) VALUES

('João Henrique', '31122333445', 'joao.henrique@compramais.com', '+55 41 995000001', 'Rua Marechal Deodoro, 950 - Centro, Curitiba - PR'),
('Mariana Souza', '32233444556', 'mariana.souza@compramais.com', '+55 41 995000002', 'Avenida Água Verde, 1420 - Água Verde, Curitiba - PR'),
('Carlos Alberto', '33344555667', 'carlos.alberto@compramais.com', '+55 41 995000003', 'Rua João Negrão, 555 - Rebouças, Curitiba - PR'),
('Fernanda Lima', '34455666778', 'fernanda.lima@compramais.com', '+55 41 995000004', 'Rua Padre Anchieta, 1200 - Bigorrilho, Curitiba - PR'),
('Lucas Nogueira', '35566777889', 'lucas.nogueira@compramais.com', '+55 41 995000005', 'Rua Emiliano Perneta, 810 - Centro, Curitiba - PR'),
('Aline Martins', '36677888990', 'aline.martins@compramais.com', '+55 41 995000006', 'Rua Visconde de Nácar, 430 - Centro, Curitiba - PR'),
('Ricardo Pinto', '37788999001', 'ricardo.pinto@compramais.com', '+55 41 995000007', 'Rua Brigadeiro Franco, 1540 - Rebouças, Curitiba - PR'),
('Juliana Castro', '38899001112', 'juliana.castro@compramais.com', '+55 41 995000008', 'Rua Itupava, 720 - Alto da XV, Curitiba - PR'),
('Thiago Correia', '39900112223', 'thiago.correia@compramais.com', '+55 41 995000009', 'Rua Augusto Severo, 280 - Cristo Rei, Curitiba - PR'),
('Camila Ramos', '40011223334', 'camila.ramos@compramais.com', '+55 41 995000010', 'Rua Conselheiro Dantas, 100 - Prado Velho, Curitiba - PR'),
('Rafael Souza', '41122334445', 'rafael.souza@compramais.com', '+55 41 995000011', 'Rua General Carneiro, 620 - Centro, Curitiba - PR'),
('Patrícia Almeida', '42233445556', 'patricia.almeida@compramais.com', '+55 41 995000012', 'Rua Chile, 1150 - Água Verde, Curitiba - PR'),
('Bruno Oliveira', '43344556667', 'bruno.oliveira@compramais.com', '+55 41 995000013', 'Rua Desembargador Westphalen, 960 - Centro, Curitiba - PR'),
('Larissa Costa', '44455667778', 'larissa.costa@compramais.com', '+55 41 995000014', 'Rua Dom Pedro I, 150 - São Francisco, Curitiba - PR'),
('Eduardo Henrique', '45566778889', 'eduardo.henrique@compramais.com', '+55 41 995000015', 'Rua João Bettega, 1340 - Portão, Curitiba - PR'),
('Sabrina Moraes', '46677889990', 'sabrina.moraes@compramais.com', '+55 41 995000016', 'Avenida Getúlio Vargas, 900 - Rebouças, Curitiba - PR'),
('André Ferreira', '47788990011', 'andre.ferreira@compramais.com', '+55 41 995000017', 'Rua Bento Viana, 980 - Batel, Curitiba - PR'),
('Natália Rocha', '48899001122', 'natalia.rocha@compramais.com', '+55 41 995000018', 'Rua Marechal José Bernardino Bormann, 480 - Mercês, Curitiba - PR'),
('Marcelo Dias', '49900112233', 'marcelo.dias@compramais.com', '+55 41 995000019', 'Rua Coronel João Guilherme Guimarães, 240 - Hugo Lange, Curitiba - PR'),
('Gabriela Mendes', '50011223344', 'gabriela.mendes@compramais.com', '+55 41 995000020', 'Rua Visconde do Rio Branco, 990 - Centro, Curitiba - PR'),
('Rodrigo Pacheco', '51122334455', 'rodrigo.pacheco@compramais.com', '+55 41 995000021', 'Rua Nicarágua, 210 - Cabral, Curitiba - PR'),
('Tatiane Borges', '52233445566', 'tatiane.borges@compramais.com', '+55 41 995000022', 'Rua Chile, 640 - Água Verde, Curitiba - PR'),
('Vitor Carvalho', '53344556677', 'vitor.carvalho@compramais.com', '+55 41 995000023', 'Rua Nunes Machado, 1150 - Centro, Curitiba - PR'),
('Beatriz Santos', '54455667788', 'beatriz.santos@compramais.com', '+55 41 995000024', 'Rua da Paz, 430 - São Francisco, Curitiba - PR'),
('Daniel Figueiredo', '55566778899', 'daniel.figueiredo@compramais.com', '+55 41 995000025', 'Rua José Loureiro, 670 - Centro, Curitiba - PR'),
('Paula Rezende', '56677889900', 'paula.rezende@compramais.com', '+55 41 995000026', 'Rua Marechal Mallet, 380 - Juvevê, Curitiba - PR'),
('Henrique Matos', '57788990011', 'henrique.matos@compramais.com', '+55 41 995000027', 'Rua Coronel Amazonas Marcondes, 520 - Alto da Glória, Curitiba - PR'),
('Sofia Almeida', '58899001122', 'sofia.almeida@compramais.com', '+55 41 995000028', 'Rua Chile, 330 - Água Verde, Curitiba - PR'),
('Gustavo Azevedo', '59900112233', 'gustavo.azevedo@compramais.com', '+55 41 995000029', 'Rua Brigadeiro Franco, 880 - Rebouças, Curitiba - PR'),
('Luana Teixeira', '60011223344', 'luana.teixeira@compramais.com', '+55 41 995000030', 'Rua Tapajós, 190 - Cristo Rei, Curitiba - PR'),
('Isabela Freitas', '61122334455', 'isabela.freitas@compramais.com', '+55 41 995000031', 'Rua Martim Afonso, 410 - Mercês, Curitiba - PR'),
('Diego Santos', '62233445566', 'diego.santos@compramais.com', '+55 41 995000032', 'Rua Sete de Abril, 320 - Rebouças, Curitiba - PR'),
('Bianca Pires', '63344556677', 'bianca.pires@compramais.com', '+55 41 995000033', 'Rua da Glória, 270 - Alto da Glória, Curitiba - PR'),
('Leandro Carvalho', '64455667788', 'leandro.carvalho@compramais.com', '+55 41 995000034', 'Rua dos Pioneiros, 180 - Santa Felicidade, Curitiba - PR'),
('Michele Duarte', '65566778899', 'michele.duarte@compramais.com', '+55 41 995000035', 'Rua Benjamin Constant, 500 - Centro, Curitiba - PR'),
('Pedro Ramos', '66677889900', 'pedro.ramos@compramais.com', '+55 41 995000036', 'Rua Silva Jardim, 1250 - Rebouças, Curitiba - PR'),
('Vanessa Oliveira', '67788990011', 'vanessa.oliveira@compramais.com', '+55 41 995000037', 'Rua João Gualberto, 350 - Alto da Glória, Curitiba - PR'),
('Renan Batista', '68899001122', 'renan.batista@compramais.com', '+55 41 995000038', 'Rua Manoel Ribas, 1400 - Mercês, Curitiba - PR'),
('Juliana Figueira', '69900112233', 'juliana.figueira@compramais.com', '+55 41 995000039', 'Rua Desembargador Motta, 210 - Batel, Curitiba - PR'),
('Matheus Lopes', '70011223344', 'matheus.lopes@compramais.com', '+55 41 995000040', 'Rua Itupava, 890 - Alto da XV, Curitiba - PR');

-- ============= TABELA MODELOS (25 modelos) ==================== --

INSERT INTO modelos (modelo, id_fornecedor) VALUES
('Chevrolet Onix', 1),
('Volkswagen Gol', 5),
('Fiat Argo', 7),
('Hyundai HB20', 2),
('Honda Civic', 12),
('Toyota Corolla', 10),
('Chevrolet Tracker', 4),
('Renault Kwid', 9),
('Fiat Mobi', 15),
('Volkswagen Polo', 11),
('Honda Fit', 6),
('Toyota Yaris', 13),
('Jeep Compass', 1),
('Nissan Kicks', 9),
('Peugeot 208', 4),
('Ford Ka', 2),
('Honda HR-V', 7),
('Toyota Hilux', 10),
('Chevrolet Cruze', 5),
('Fiat Strada', 6),
('Jeep Renegade', 11),
('Volkswagen Virtus', 12),
('Honda City', 9),
('Nissan Versa', 13),
('Toyota RAV4', 15);

-- ============== TABELA AUTOMÓVEIS VENDIDOS (50 autmóveis vendidos) ================ --

INSERT INTO automoveis_vendidos(cor, ano, quilometragem, preco_venda, codigo_modelo) VALUES

('Branco', 2018, 64000, 66000.00, 8),
('Cinza', 2023, 7000, 111000.00, 3),
('Prata', 2019, 53000, 75000.00, 13),
('Preto', 2020, 42000, 83000.00, 16),
('Branco', 2018, 67000, 67000.00, 3),
('Vermelho', 2022, 20000, 96000.00, 5),
('Cinza', 2017, 83000, 58000.00, 14),
('Branco', 2021, 29000, 88000.00, 3),
('Azul', 2023, 8000, 112000.00, 7),
('Prata', 2020, 41000, 82000.00, 10),
('Preto', 2019, 56000, 72000.00, 3),
('Branco', 2021, 25000, 89000.00, 6),
('Cinza', 2023, 10000, 110000.00, 17),
('Prata', 2020, 43000, 82000.00, 3),
('Branco', 2021, 27000, 88000.00, 2),
('Preto', 2018, 68000, 66000.00, 11),
('Cinza', 2016, 91000, 56000.00, 3),
('Branco', 2024, 3000, 121000.00, 9),
('Vermelho', 2022, 17000, 98000.00, 15),
('Branco', 2019, 55000, 75000.00, 12),
('Prata', 2020, 41000, 82000.00, 18),
('Azul', 2022, 16000, 95000.00, 3),
('Cinza', 2017, 78000, 61000.00, 4),
('Branco', 2023, 6000, 113000.00, 3),
('Vermelho', 2019, 56000, 74000.00, 10),
('Preto', 2018, 69000, 66000.00, 5),
('Branco', 2023, 7000, 112000.00, 14),
('Cinza', 2021, 30000, 87000.00, 3),
('Branco', 2020, 40000, 81000.00, 7),
('Prata', 2022, 21000, 97000.00, 8),
('Vermelho', 2020, 38000, 83000.00, 3),
('Branco', 2017, 81000, 58000.00, 13),
('Cinza', 2023, 8000, 111000.00, 10),
('Branco', 2021, 31000, 88000.00, 17),
('Preto', 2019, 54000, 76000.00, 15),
('Prata', 2019, 52000, 74000.00, 3),
('Cinza', 2023, 7000, 114000.00, 11),
('Branco', 2021, 28000, 89000.00, 18),
('Branco', 2024, 2000, 125000.00, 3),
('Prata', 2018, 66000, 67000.00, 6),
('Branco', 2023, 9000, 110000.00, 12),
('Cinza', 2017, 83000, 59000.00, 10),
('Branco', 2022, 21000, 99000.00, 24),
('Cinza', 2020, 42000, 82000.00, 5),
('Azul', 2020, 37000, 85000.00, 13),
('Prata', 2021, 31000, 87000.00, 7),
('Branco', 2022, 20000, 96000.00, 16),
('Cinza', 2023, 7000, 112000.00, 4),
('Branco', 2021, 26000, 90000.00, 10),
('Cinza', 2020, 40000, 82000.00, 15);


-- ============= TABELA CONTRATOS (50 contratos) ================ --

INSERT INTO contratos (criado_em, id_vendedor, codigo_auto, id_comprador, forma_pagamento, opcao_entrega, status_garantia, status_seguro) VALUES

('2024-12-05 14:23:10', 1, 1, 1, 'À VISTA', 'ENTREGA', 'NÃO', 'SIM'),
('2024-12-10 09:15:42', 3, 2, 2, 'PARCELADO', 'RETIRADA', 'SIM', 'NÃO'),
('2024-12-20 16:42:55', 4, 3, 3, 'À VISTA', 'ENTREGA', 'NÃO', 'NÃO'),
('2025-01-03 11:05:33', 6, 4, 4, 'PARCELADO', 'RETIRADA', 'SIM', 'SIM'),
('2025-01-15 08:22:11', 7, 5, 5, 'PARCELADO', 'ENTREGA', 'NÃO', 'NÃO'),
('2025-02-01 19:45:27', 8, 6, 6, 'À VISTA', 'RETIRADA', 'SIM', 'SIM'),
('2025-02-14 13:30:44', 10, 7, 7, 'PARCELADO', 'ENTREGA', 'NÃO', 'NÃO'),
('2025-03-02 10:05:05', 11, 8, 8, 'À VISTA', 'RETIRADA', 'SIM', 'NÃO'),
('2025-03-12 21:12:20', 12, 9, 9, 'PARCELADO', 'ENTREGA', 'NÃO', 'SIM'),
('2025-03-25 07:55:33', 13, 10, 10, 'À VISTA', 'RETIRADA', 'SIM', 'NÃO'),
('2025-04-08 14:40:50', 14, 11, 11, 'PARCELADO', 'ENTREGA', 'NÃO', 'SIM'),
('2025-04-19 18:15:12', 15, 12, 12, 'À VISTA', 'RETIRADA', 'SIM', 'NÃO'),
('2025-05-01 09:50:01', 16, 13, 13, 'PARCELADO', 'ENTREGA', 'NÃO', 'SIM'),
('2025-05-15 11:20:45', 17, 14, 14, 'À VISTA', 'RETIRADA', 'SIM', 'NÃO'),
('2025-05-25 15:33:17', 18, 15, 15, 'PARCELADO', 'ENTREGA', 'NÃO', 'SIM'),
('2025-06-04 20:42:38', 19, 16, 16, 'À VISTA', 'RETIRADA', 'SIM', 'NÃO'),
('2025-06-18 08:15:09', 4, 17, 17, 'PARCELADO', 'ENTREGA', 'NÃO', 'NÃO'),
('2025-07-01 17:55:50', 6, 18, 18, 'À VISTA', 'RETIRADA', 'SIM', 'SIM'),
('2025-07-12 10:10:10', 7, 19, 19, 'PARCELADO', 'ENTREGA', 'NÃO', 'NÃO'),
('2025-07-20 13:33:22', 8, 20, 20, 'À VISTA', 'RETIRADA', 'SIM', 'NÃO'),
('2025-08-03 09:44:30', 10, 21, 21, 'PARCELADO', 'ENTREGA', 'NÃO', 'SIM'),
('2025-08-15 15:05:11', 11, 22, 22, 'À VISTA', 'RETIRADA', 'SIM', 'NÃO'),
('2025-08-28 11:20:45', 12, 23, 23, 'PARCELADO', 'ENTREGA', 'NÃO', 'SIM'),
('2025-09-05 08:30:50', 13, 24, 24, 'À VISTA', 'RETIRADA', 'SIM', 'NÃO'),
('2025-09-12 14:55:27', 14, 25, 25, 'PARCELADO', 'ENTREGA', 'NÃO', 'SIM'),
('2025-09-20 19:05:33', 15, 26, 26, 'À VISTA', 'RETIRADA', 'SIM', 'NÃO'),
('2025-09-25 16:42:12', 16, 27, 27, 'PARCELADO', 'ENTREGA', 'NÃO', 'SIM'),
('2025-10-01 07:22:45', 17, 28, 28, 'À VISTA', 'RETIRADA', 'SIM', 'NÃO'),
('2025-10-03 12:33:17', 1, 29, 29, 'PARCELADO', 'ENTREGA', 'NÃO', 'SIM'),
('2025-10-05 18:10:50', 2, 30, 30, 'À VISTA', 'RETIRADA', 'SIM', 'NÃO'),
('2025-10-06 14:05:25', 4, 31, 31, 'PARCELADO', 'ENTREGA', 'NÃO', 'SIM'),
('2025-10-07 11:22:38', 6, 32, 32, 'À VISTA', 'RETIRADA', 'SIM', 'NÃO'),
('2025-10-08 17:33:50', 7, 33, 33, 'PARCELADO', 'ENTREGA', 'NÃO', 'SIM'),
('2025-10-09 09:44:11', 8, 34, 34, 'À VISTA', 'RETIRADA', 'SIM', 'NÃO'),
('2025-10-10 13:55:27', 10, 35, 35, 'PARCELADO', 'ENTREGA', 'NÃO', 'SIM'),
('2025-10-11 15:20:05', 11, 36, 36, 'À VISTA', 'RETIRADA', 'SIM', 'NÃO'),
('2025-10-12 10:30:44', 12, 37, 37, 'PARCELADO', 'ENTREGA', 'NÃO', 'SIM'),
('2025-10-12 19:42:30', 13, 38, 38, 'À VISTA', 'RETIRADA', 'SIM', 'NÃO'),
('2025-10-12 21:15:12', 14, 39, 39, 'PARCELADO', 'ENTREGA', 'NÃO', 'SIM'),
('2025-10-12 08:50:22', 15, 40, 40, 'À VISTA', 'RETIRADA', 'SIM', 'NÃO'),
('2025-10-12 12:33:17', 16, 41, 2, 'PARCELADO', 'ENTREGA', 'NÃO', 'SIM'),
('2025-10-12 16:05:50', 17, 42, 1, 'À VISTA', 'RETIRADA', 'SIM', 'NÃO'),
('2025-10-12 18:22:11', 1, 43, 10, 'PARCELADO', 'ENTREGA', 'NÃO', 'SIM'),
('2025-10-12 20:15:33', 2, 44, 26, 'À VISTA', 'RETIRADA', 'SIM', 'NÃO'),
('2025-10-12 21:40:50', 4, 45, 38, 'PARCELADO', 'ENTREGA', 'NÃO', 'SIM'),
('2025-10-12 22:55:27', 6, 46, 11, 'À VISTA', 'RETIRADA', 'SIM', 'NÃO'),
('2025-10-12 23:30:12', 7, 47, 14, 'PARCELADO', 'ENTREGA', 'NÃO', 'SIM'),
('2025-10-12 23:50:05', 8, 48, 15, 'À VISTA', 'RETIRADA', 'SIM', 'NÃO'),
('2025-10-13 00:05:33', 10, 49, 20, 'PARCELADO', 'ENTREGA', 'NÃO', 'SIM'),
('2025-10-13 00:15:42', 11, 50, 5, 'À VISTA', 'RETIRADA', 'SIM', 'NÃO');


-- ============== TABELA ENTREGAS (25 entregas) ============= --

INSERT INTO entrega (data_entrega, horario, id_fretador, codigo_contrato) VALUES 
('2025-02-05', '14:23:10', 1, 1),
('2025-02-20', '16:42:55', 2, 3),
('2025-03-15', '08:22:11', 3, 5),
('2025-04-14', '13:30:44', 4, 7),
('2025-05-12', '21:12:20', 5, 9),
('2025-06-08', '14:40:50', 6, 11),
('2025-07-01', '09:50:01', 7, 13),
('2025-07-25', '15:33:17', 8, 15),
('2025-08-18', '08:15:09', 9, 17),
('2025-09-12', '10:10:10', 10, 19),
('2025-10-03', '09:44:30', 11, 21),
('2025-10-28', '11:20:45', 12, 23),
('2025-11-12', '14:55:27', 2, 25),
('2025-11-25', '16:42:12', 14, 27),
('2025-12-03', '12:33:17', 15, 29),
('2025-12-06', '14:05:25', 5, 31),
('2025-12-08', '17:33:50', 17, 33),
('2025-12-10', '13:55:27', 18, 35),
('2025-12-12', '10:30:44', 19, 37),
('2025-12-12', '21:15:12', 20, 39),
('2025-12-12', '12:33:17', 1, 41),
('2025-12-12', '18:22:11', 9, 43),
('2025-12-12', '21:40:50', 1, 45),
('2025-12-12', '23:30:12', 10, 47),
('2025-12-13', '00:05:33', 1, 49);
