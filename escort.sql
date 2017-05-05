-- --------------------------------------------------------
-- Servidor:                     127.0.0.1
-- Versão do servidor:           5.6.27-log - MySQL Community Server (GPL)
-- OS do Servidor:               Win64
-- HeidiSQL Versão:              9.3.0.4984
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;

-- Copiando estrutura para tabela escort.anuncios_pessoas
DROP TABLE IF EXISTS `anuncios_pessoas`;
CREATE TABLE IF NOT EXISTS `anuncios_pessoas` (
  `apid` int(11) NOT NULL AUTO_INCREMENT,
  `pesid` int(11) NOT NULL,
  `ativo` int(1) NOT NULL DEFAULT '0',
  `aprovado` int(1) NOT NULL DEFAULT '0',
  `mensagem` text,
  `lido` int(1) DEFAULT '0',
  `titulo` varchar(60) NOT NULL,
  `url` varchar(160) NOT NULL,
  `descricao` text NOT NULL,
  `pessoasatendimento` varchar(50) NOT NULL,
  `locaisatendimento` varchar(50) NOT NULL,
  `localproprio` char(1) DEFAULT '0',
  `idiomas` varchar(50) NOT NULL,
  `moeda` varchar(4) NOT NULL,
  `cadastro` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `visitascount` int(11) DEFAULT '0',
  PRIMARY KEY (`apid`),
  KEY `FK12_Pessoas` (`pesid`),
  CONSTRAINT `FK12_Pessoas` FOREIGN KEY (`pesid`) REFERENCES `pessoas` (`pesid`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;

-- Copiando dados para a tabela escort.anuncios_pessoas: ~1 rows (aproximadamente)
/*!40000 ALTER TABLE `anuncios_pessoas` DISABLE KEYS */;
INSERT INTO `anuncios_pessoas` (`apid`, `pesid`, `ativo`, `aprovado`, `mensagem`, `lido`, `titulo`, `url`, `descricao`, `pessoasatendimento`, `locaisatendimento`, `localproprio`, `idiomas`, `moeda`, `cadastro`, `visitascount`) VALUES
	(8, 2, 1, 0, NULL, 0, 'Anuncio teste', 'anuncio-teste', 'teste descrição', 'Homens, Mulheres, Casais', '', '1', 'Português, Espanhol', 'R$', '2017-05-03 16:21:32', 1);
/*!40000 ALTER TABLE `anuncios_pessoas` ENABLE KEYS */;


-- Copiando estrutura para tabela escort.chats
DROP TABLE IF EXISTS `chats`;
CREATE TABLE IF NOT EXISTS `chats` (
  `chatid` int(11) NOT NULL AUTO_INCREMENT,
  `ppvid` int(11) NOT NULL,
  `lido` int(1) NOT NULL DEFAULT '0',
  `de` int(11) NOT NULL,
  `para` int(11) DEFAULT NULL,
  `mensagem` text NOT NULL,
  `dtenvio` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`chatid`),
  KEY `FK3_PPV` (`ppvid`),
  CONSTRAINT `FK3_PPV` FOREIGN KEY (`ppvid`) REFERENCES `ppv` (`ppvid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Copiando dados para a tabela escort.chats: ~0 rows (aproximadamente)
/*!40000 ALTER TABLE `chats` DISABLE KEYS */;
/*!40000 ALTER TABLE `chats` ENABLE KEYS */;


-- Copiando estrutura para tabela escort.destaque_pessoas
DROP TABLE IF EXISTS `destaque_pessoas`;
CREATE TABLE IF NOT EXISTS `destaque_pessoas` (
  `desid` int(11) NOT NULL AUTO_INCREMENT,
  `apid` int(11) NOT NULL,
  `destaque` int(1) NOT NULL DEFAULT '1',
  `inicio` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `final` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`desid`),
  KEY `FK10_Pessoas` (`apid`),
  CONSTRAINT `FK4_AnuncioPessoas` FOREIGN KEY (`apid`) REFERENCES `anuncios_pessoas` (`apid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Copiando dados para a tabela escort.destaque_pessoas: ~0 rows (aproximadamente)
/*!40000 ALTER TABLE `destaque_pessoas` DISABLE KEYS */;
/*!40000 ALTER TABLE `destaque_pessoas` ENABLE KEYS */;


-- Copiando estrutura para tabela escort.etnias
DROP TABLE IF EXISTS `etnias`;
CREATE TABLE IF NOT EXISTS `etnias` (
  `etid` int(3) NOT NULL AUTO_INCREMENT,
  `sexo` char(1) NOT NULL DEFAULT 'M',
  `etnia` varchar(50) NOT NULL,
  PRIMARY KEY (`etid`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8;

-- Copiando dados para a tabela escort.etnias: ~16 rows (aproximadamente)
/*!40000 ALTER TABLE `etnias` DISABLE KEYS */;
INSERT INTO `etnias` (`etid`, `sexo`, `etnia`) VALUES
	(1, 'M', 'Claro'),
	(2, 'F', 'Clara'),
	(3, 'M', 'Negro'),
	(4, 'F', 'Negra'),
	(5, 'M', 'Moreno'),
	(6, 'F', 'Morena'),
	(7, 'M', 'Mulato'),
	(8, 'F', 'Mulata'),
	(9, 'M', 'Loiro'),
	(10, 'F', 'Loira'),
	(11, 'M', 'Ruivo'),
	(12, 'F', 'Ruiva'),
	(13, 'M', 'Oriental'),
	(14, 'F', 'Oriental'),
	(15, 'M', 'Índio'),
	(16, 'F', 'Índia');
/*!40000 ALTER TABLE `etnias` ENABLE KEYS */;


-- Copiando estrutura para tabela escort.fotos_interacao
DROP TABLE IF EXISTS `fotos_interacao`;
CREATE TABLE IF NOT EXISTS `fotos_interacao` (
  `intid` int(11) NOT NULL AUTO_INCREMENT,
  `fotid` int(11) NOT NULL,
  `usuid` int(11) NOT NULL,
  `gostou` int(1) NOT NULL DEFAULT '0',
  `comentario` text,
  PRIMARY KEY (`intid`),
  KEY `FK2_Fotos` (`fotid`),
  KEY `FK2_Usuarios` (`usuid`),
  CONSTRAINT `FK2_Fotos` FOREIGN KEY (`fotid`) REFERENCES `pessoas_fotos` (`fotid`),
  CONSTRAINT `FK2_Usuarios` FOREIGN KEY (`usuid`) REFERENCES `usuarios` (`usuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Copiando dados para a tabela escort.fotos_interacao: ~0 rows (aproximadamente)
/*!40000 ALTER TABLE `fotos_interacao` DISABLE KEYS */;
/*!40000 ALTER TABLE `fotos_interacao` ENABLE KEYS */;


-- Copiando estrutura para tabela escort.locais_pessoas
DROP TABLE IF EXISTS `locais_pessoas`;
CREATE TABLE IF NOT EXISTS `locais_pessoas` (
  `locid` int(11) NOT NULL AUTO_INCREMENT,
  `apid` int(11) NOT NULL,
  `ativo` int(1) NOT NULL DEFAULT '0',
  `local` varchar(50) NOT NULL,
  `endereco` varchar(150) NOT NULL,
  `latitude` varchar(30) NOT NULL,
  `longitude` varchar(30) NOT NULL,
  PRIMARY KEY (`locid`),
  KEY `FK11__pessoas` (`apid`),
  CONSTRAINT `FK1_AnuncioPessoas` FOREIGN KEY (`apid`) REFERENCES `anuncios_pessoas` (`apid`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8;

-- Copiando dados para a tabela escort.locais_pessoas: ~2 rows (aproximadamente)
/*!40000 ALTER TABLE `locais_pessoas` DISABLE KEYS */;
INSERT INTO `locais_pessoas` (`locid`, `apid`, `ativo`, `local`, `endereco`, `latitude`, `longitude`) VALUES
	(12, 8, 1, 'Hotel Metrópole', 'Rua Barão de Jaceguai, 163 - Centro, Mogi das Cruzes', '-23.5220381', '-46.1963025'),
	(13, 8, 1, 'Motel Brás Cubas', 'Avenida Saraiva, 160 - Brás Cubas, Mogi das Cruzes', '-23.5400258', '-46.23197529999999');
/*!40000 ALTER TABLE `locais_pessoas` ENABLE KEYS */;


-- Copiando estrutura para tabela escort.modalidades
DROP TABLE IF EXISTS `modalidades`;
CREATE TABLE IF NOT EXISTS `modalidades` (
  `modid` int(11) NOT NULL AUTO_INCREMENT,
  `ativo` int(1) NOT NULL DEFAULT '1',
  `modalidade` varchar(50) NOT NULL,
  `descricao` text,
  `tipo` int(1) NOT NULL DEFAULT '1' COMMENT 'Tipo da Modalidade: 1 = Serviços Pessoais, 2 = Serviços PPV',
  PRIMARY KEY (`modid`)
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8;

-- Copiando dados para a tabela escort.modalidades: ~29 rows (aproximadamente)
/*!40000 ALTER TABLE `modalidades` DISABLE KEYS */;
INSERT INTO `modalidades` (`modid`, `ativo`, `modalidade`, `descricao`, `tipo`) VALUES
	(1, 1, 'Massagem Tântrica', 'Trata-se de um sistema completo de tratamento para expansão da sensibilidade e desenvolvimento do orgasmo, possibilitando uma cura no corpo, na mente e nas emoções.', 1),
	(2, 1, 'Massagem Nuru', 'Muito comum no Japão e nos Estados Unidos, a Massagem Nuru consiste numa técnica que envolve confiança e segurança entre massagista e cliente, onde seus corpos serão submetidos a toques diretos num colchão próprio, nele é utilizado um gel especial que espalhado em seu corpo de forma diferenciada.', 1),
	(3, 1, 'Acompanhante', NULL, 1),
	(4, 1, 'Sexo Oral', NULL, 1),
	(5, 1, 'Sexo Anal', NULL, 1),
	(6, 1, 'Sexo Vaginal', NULL, 1),
	(7, 1, 'Beijo na Boca', NULL, 1),
	(8, 1, 'Streaptease', NULL, 1),
	(9, 1, 'Fetiche', 'Desejo de teor sexual que se tem por alguma parte do corpo masculino como pés, boca, peitoral, braços fortes, barba, ou pela utilização de fantasias ou acessórios sexuais.', 1),
	(10, 1, 'Dominação', NULL, 1),
	(11, 1, 'Sexo Grupal', NULL, 1),
	(12, 1, 'Beijo Grego', 'Prática do sexo oral-anal.', 1),
	(13, 1, 'Masturbação', NULL, 1),
	(15, 1, 'Chuva Dourada', 'Modalidade sexual em que o homem urina na mulher ou a mulher urina no homem durante o sexo.', 1),
	(16, 1, 'Ativa', NULL, 1),
	(17, 1, 'Passiva', NULL, 1),
	(18, 1, 'Bondage', 'Fetiche geralmente relacionado com sadomasoquismo, onde a principal fonte de prazer consiste em amarrar e imobilizar seu parceiro ou pessoa envolvida. Pode ou não envolver a prática de sexo com penetração.', 1),
	(19, 1, 'Massagem Lingam', 'A Lingam massagem embora seja uma massagem peniana ela não é aplicada apenas no eixo do próprio pênis, a massagem deve ser executada também no períneo, bem como os testículos. Contrariamente à crença comum, a experiência nem sempre é algo que um homem quando iniciados estejam confortáveis, isso é comum, pois geralmente os homens são focados em performance, uma vez que uma massagem tantra lingam não é sobre o desempenho sexual masculino, mas sobre se entregar ao prazer aplicado externamente.', 1),
	(20, 1, 'Massagem Tailandesa', 'Terapia curativa tailandesa que utiliza a massagem como forma de equilíbrio corporal, onde o terapeuta usa seus pés, joelhos, polegares, palmas e cotovelos, além de pressão, compressão e alongamento, no corpo do paciente.', 1),
	(21, 1, 'Massagem Prostática', 'Prática sexual que consiste na introdução de um ou mais dedos, ou algum outro estimulador, no orifício anal durante o ato sexual. Esta prática é tida como um tabu para alguns homens. No entanto, pode ser bastante estimulante, devido à proximidade da próstata e às inúmeras terminações nervosas. A próstata é considerada por muitos como o correspondente do ponto G masculino.', 1),
	(22, 1, 'Massagem Relaxante', NULL, 1),
	(23, 1, 'Bukkake ', 'Modalidade de sexo grupal que consiste em uma pessoa “recebendo” a ejaculação de diversos homens.', 1),
	(24, 1, 'Coprofagia', 'Fetiche pela ingestão de fezes. Já a coprofilia é o fetiche pela manipulação de fezes, próprias ou do parceiro', 1),
	(25, 1, 'Banho romano', 'Ato de vomitar para provocar excitação.', 1),
	(26, 1, 'Fisting', 'Prazer com a inserção da mão ou antebraço na vagina ou ânus', 1),
	(27, 1, 'Podolatria', 'Desejo sexual que se concentra nos pés do parceiro. O podólatra tem para', 1),
	(28, 1, 'Chuva de Prata', 'Ato que acontece na relação sexual de ejacular na face do parceiro após o sexo oral, durante o orgasmo.', 1),
	(29, 1, 'Submissão', NULL, 1),
	(30, 1, 'Ficha Rosa', NULL, 1);
/*!40000 ALTER TABLE `modalidades` ENABLE KEYS */;


-- Copiando estrutura para tabela escort.modalidades_pessoas
DROP TABLE IF EXISTS `modalidades_pessoas`;
CREATE TABLE IF NOT EXISTS `modalidades_pessoas` (
  `mpid` int(11) NOT NULL AUTO_INCREMENT,
  `modid` int(11) NOT NULL,
  `apid` int(11) NOT NULL,
  `ativo` int(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`mpid`),
  KEY `FK1_Modalidades` (`modid`),
  KEY `FK2_Pessoas` (`apid`),
  CONSTRAINT `FK1_Modalidades` FOREIGN KEY (`modid`) REFERENCES `modalidades` (`modid`),
  CONSTRAINT `FK2_Anuncios` FOREIGN KEY (`apid`) REFERENCES `anuncios_pessoas` (`apid`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;

-- Copiando dados para a tabela escort.modalidades_pessoas: ~5 rows (aproximadamente)
/*!40000 ALTER TABLE `modalidades_pessoas` DISABLE KEYS */;
INSERT INTO `modalidades_pessoas` (`mpid`, `modid`, `apid`, `ativo`) VALUES
	(6, 26, 8, 1),
	(7, 21, 8, 1),
	(8, 5, 8, 1),
	(9, 4, 8, 1),
	(10, 6, 8, 1);
/*!40000 ALTER TABLE `modalidades_pessoas` ENABLE KEYS */;


-- Copiando estrutura para tabela escort.newsletter
DROP TABLE IF EXISTS `newsletter`;
CREATE TABLE IF NOT EXISTS `newsletter` (
  `nlid` int(11) NOT NULL AUTO_INCREMENT,
  `cadastro` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `nome` varchar(50) NOT NULL,
  `email` varchar(50) NOT NULL,
  `mensagem` text NOT NULL,
  PRIMARY KEY (`nlid`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

-- Copiando dados para a tabela escort.newsletter: ~5 rows (aproximadamente)
/*!40000 ALTER TABLE `newsletter` DISABLE KEYS */;
INSERT INTO `newsletter` (`nlid`, `cadastro`, `nome`, `email`, `mensagem`) VALUES
	(1, '2017-05-05 09:13:19', 'André Martos', 'andremartos@gmail.com', 'Teste de Mensságem!!!!'),
	(2, '2017-05-05 09:14:49', 'Daniel Augusto', 'danieltriboni@gmail.com', 'Teste\\r\\nde\\r\\nMensagem\\r\\ncom quebra de linha!!!!'),
	(3, '2017-05-05 09:15:38', 'Daniel Augusto', 'danieltriboni@gmail.com', 'teste\\r\\nde\\r\\nmesmgem'),
	(4, '2017-05-05 09:20:24', 'Daniel Augusto', 'danieltriboni@gmail.com', 'Teste \r\nda\r\nMensságemQ!!!'),
	(5, '2017-05-05 09:21:37', 'Daniel Augusto', 'danieltriboni@gmail.com', 'teste\r\nda\r\n,emsságem!!!');
/*!40000 ALTER TABLE `newsletter` ENABLE KEYS */;


-- Copiando estrutura para tabela escort.pessoas
DROP TABLE IF EXISTS `pessoas`;
CREATE TABLE IF NOT EXISTS `pessoas` (
  `pesid` int(11) NOT NULL AUTO_INCREMENT,
  `ativo` int(1) NOT NULL DEFAULT '1',
  `nome` varchar(50) NOT NULL,
  `apelido` varchar(50) NOT NULL,
  `url` varchar(50) NOT NULL,
  `sexo` char(1) NOT NULL DEFAULT 'F',
  `genero` varchar(10) NOT NULL DEFAULT 'venus',
  `etnia` varchar(15) NOT NULL,
  `olhos` varchar(15) NOT NULL,
  `cabelos` varchar(15) NOT NULL,
  `whatsapp` varchar(15) DEFAULT NULL,
  `tel1` varchar(15) NOT NULL,
  `tel2` varchar(15) NOT NULL,
  `twitter` varchar(50) DEFAULT NULL,
  `facebook` varchar(50) DEFAULT NULL,
  `googleplus` varchar(50) DEFAULT NULL,
  `nascimento` datetime NOT NULL,
  `naturalidade` varchar(50) NOT NULL,
  `rg` char(12) NOT NULL,
  `cpf` char(14) NOT NULL,
  `peso` varchar(3) NOT NULL,
  `altura` varchar(4) NOT NULL,
  `busto` varchar(3) DEFAULT NULL,
  `cintura` varchar(3) DEFAULT NULL,
  `quadril` varchar(3) DEFAULT NULL,
  `pcm` varchar(2) DEFAULT NULL,
  `cadastro` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `aprovado` int(1) NOT NULL DEFAULT '0',
  `mensagem` text,
  `lido` int(1) DEFAULT '0',
  `email` varchar(50) NOT NULL,
  `senha` varchar(100) NOT NULL,
  `documento` varchar(30) NOT NULL,
  `comprovacao` varchar(30) NOT NULL,
  `ppv` int(1) NOT NULL DEFAULT '0',
  `ppv_online` int(1) NOT NULL DEFAULT '0',
  `logon` int(1) NOT NULL DEFAULT '0',
  `dtultimoacesso` timestamp NULL DEFAULT NULL,
  `visitascount` int(9) DEFAULT '0',
  PRIMARY KEY (`pesid`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

-- Copiando dados para a tabela escort.pessoas: ~2 rows (aproximadamente)
/*!40000 ALTER TABLE `pessoas` DISABLE KEYS */;
INSERT INTO `pessoas` (`pesid`, `ativo`, `nome`, `apelido`, `url`, `sexo`, `genero`, `etnia`, `olhos`, `cabelos`, `whatsapp`, `tel1`, `tel2`, `twitter`, `facebook`, `googleplus`, `nascimento`, `naturalidade`, `rg`, `cpf`, `peso`, `altura`, `busto`, `cintura`, `quadril`, `pcm`, `cadastro`, `aprovado`, `mensagem`, `lido`, `email`, `senha`, `documento`, `comprovacao`, `ppv`, `ppv_online`, `logon`, `dtultimoacesso`, `visitascount`) VALUES
	(2, 1, 'Samanta Maynardi Oliveira', 'Sammy Maynardi', 'sammy-maynardi', 'F', 'venus', 'Branca', 'Castanhos', 'Castanhos', '(11) 94848-4856', '', '', '', '', '', '1981-01-14 00:00:00', 'Caxangá - PE, Brasil', '123654789', '338.286.978-01', '55', '1,60', '60', '50', '90', '', '2017-04-14 15:18:29', 1, NULL, 1, 'c18635315671048116126@sandbox.pagseguro.com.br', '202cb962ac59075b964b07152d234b70', 'doc-rz4vj9tn3xwc.jpg', 'doc-x9hcp8i5snyl.jpg', 0, 0, 1, '2017-05-05 15:10:01', 0),
	(4, 1, 'Daniel Triboni', 'Daniel', 'daniel', 'M', 'mars', 'Branca', 'Verdes', 'Castanhos', '(11) 98196-6796', '', '', '', '', '', '1981-01-14 00:00:00', 'Mogi das Cruzes - SP, Brasil', '123456789', '288.711.918-46', '78', '1,75', '', '', '', '', '2017-05-03 09:08:11', 0, NULL, 0, 'danieltriboni@gmail.com', '202cb962ac59075b964b07152d234b70', 'doc-mvxsgdfplwyr.jpg', 'doc-gusdey127p9j.jpg', 0, 0, 0, '2017-05-04 13:22:11', 0);
/*!40000 ALTER TABLE `pessoas` ENABLE KEYS */;


-- Copiando estrutura para tabela escort.pessoas_cache
DROP TABLE IF EXISTS `pessoas_cache`;
CREATE TABLE IF NOT EXISTS `pessoas_cache` (
  `cacheid` int(11) NOT NULL AUTO_INCREMENT,
  `apid` int(11) NOT NULL DEFAULT '0',
  `c30` varchar(5) DEFAULT NULL,
  `c1` varchar(5) DEFAULT NULL,
  `c2` varchar(5) DEFAULT NULL,
  `c4` varchar(5) DEFAULT NULL,
  `c8` varchar(5) DEFAULT NULL,
  `c12` varchar(5) DEFAULT NULL,
  `viagem` varchar(5) DEFAULT NULL,
  `custoprata` int(3) DEFAULT NULL,
  `custoouro` int(3) DEFAULT NULL,
  `custodiamante` int(3) DEFAULT NULL,
  PRIMARY KEY (`cacheid`),
  KEY `FK4_ModalidadesPessoas` (`apid`),
  CONSTRAINT `FK1_AnunciosPessoas` FOREIGN KEY (`apid`) REFERENCES `anuncios_pessoas` (`apid`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;

-- Copiando dados para a tabela escort.pessoas_cache: ~0 rows (aproximadamente)
/*!40000 ALTER TABLE `pessoas_cache` DISABLE KEYS */;
INSERT INTO `pessoas_cache` (`cacheid`, `apid`, `c30`, `c1`, `c2`, `c4`, `c8`, `c12`, `viagem`, `custoprata`, `custoouro`, `custodiamante`) VALUES
	(6, 8, '', '300', '500', '', '', '1.200', '', NULL, NULL, NULL);
/*!40000 ALTER TABLE `pessoas_cache` ENABLE KEYS */;


-- Copiando estrutura para tabela escort.pessoas_fotos
DROP TABLE IF EXISTS `pessoas_fotos`;
CREATE TABLE IF NOT EXISTS `pessoas_fotos` (
  `fotid` int(11) NOT NULL AUTO_INCREMENT,
  `apid` int(11) NOT NULL,
  `ativo` int(1) NOT NULL DEFAULT '1',
  `imagemurl` varchar(100) NOT NULL,
  `hash` varchar(12) NOT NULL,
  `tipo` int(1) NOT NULL COMMENT 'Tipo: 1 = thumb, 2 = large',
  `local` int(1) NOT NULL DEFAULT '1' COMMENT 'Local da Foto: 1 = Galeria Foto Pessoas, 2 = Galeria Pessoal, 3 = Foto Capa',
  `principal` char(1) NOT NULL DEFAULT 'S',
  `titulo` varchar(30) DEFAULT NULL,
  `descricao` text,
  PRIMARY KEY (`fotid`),
  KEY `FK5_Pessoas` (`apid`),
  CONSTRAINT `FK1_Anuncios` FOREIGN KEY (`apid`) REFERENCES `anuncios_pessoas` (`apid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Copiando dados para a tabela escort.pessoas_fotos: ~0 rows (aproximadamente)
/*!40000 ALTER TABLE `pessoas_fotos` DISABLE KEYS */;
/*!40000 ALTER TABLE `pessoas_fotos` ENABLE KEYS */;


-- Copiando estrutura para tabela escort.planos
DROP TABLE IF EXISTS `planos`;
CREATE TABLE IF NOT EXISTS `planos` (
  `plaid` int(11) NOT NULL AUTO_INCREMENT,
  `ativo` int(1) NOT NULL DEFAULT '1',
  `plano` varchar(50) NOT NULL,
  `tipo` int(1) NOT NULL DEFAULT '1' COMMENT 'Tipo do Plano: 1 = Pessoas, 2 = Usuarios',
  `valor` decimal(10,2) NOT NULL,
  `descricao` text NOT NULL,
  `anuncios` int(4) NOT NULL,
  `fotos` int(6) NOT NULL,
  `videos` int(6) DEFAULT NULL,
  PRIMARY KEY (`plaid`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

-- Copiando dados para a tabela escort.planos: ~3 rows (aproximadamente)
/*!40000 ALTER TABLE `planos` DISABLE KEYS */;
INSERT INTO `planos` (`plaid`, `ativo`, `plano`, `tipo`, `valor`, `descricao`, `anuncios`, `fotos`, `videos`) VALUES
	(1, 1, 'Basic', 1, 0.00, '<h5><i class="fa fa-id-card-o"></i> <em>Apenas 1 an&uacute;ncio</em></h5>\r\n<h5><i class="fa fa-file-photo-o"></i> <em>At&eacute; 12 Fotos</em></h5>\r\n<h5><i class="fa fa-file-video-o"></i> <em>At&eacute; 3 V&iacute;deos</em></h5>		                                          <h5><i class="fa fa-heart"></i> <em>Resultados nos mecanismos de busca</em></h5>\r\n<h5><i class="fa fa-heart-o"></i> <em>Destaque no Livreto e Poster na Home</em></h5>', 1, 12, 3),
	(2, 1, 'Premium', 1, 199.90, '<h5><i class="fa fa-id-card-o"></i> <em>At&eacute; 5 an&uacute;ncios</em></h5>\r\n<h5><i class="fa fa-file-photo-o"></i> <em>Fotos Ilimitadas</em></h5>\r\n<h5><i class="fa fa-file-video-o"></i> <em>V&iacute;deos Ilimitados</em></h5>		                                          <h5><i class="fa fa-heart"></i> <em>Resultados nos mecanismos de busca</em></h5>\r\n<h5><i class="fa fa-heart-o"></i> <em>Destaque no Livreto e Poster na Home</em></h5>', 5, 999, 999),
	(3, 1, 'Advanced', 1, 399.90, '<h5><i class="fa fa-id-card-o"></i> <em>An&uacute;ncios Ilimitados</em></h5>\r\n<h5><i class="fa fa-file-photo-o"></i> <em>Fotos Ilimitadas</em></h5>\r\n<h5><i class="fa fa-file-video-o"></i> <em>V&iacute;deos Ilimitados</em></h5>		                                          <h5><i class="fa fa-heart"></i> <em>Resultados nos mecanismos de busca</em></h5>\r\n<h5><i class="fa fa-heart-o"></i> <em>Destaque no Livreto e Poster na Home</em></h5>', 999, 999, 999);
/*!40000 ALTER TABLE `planos` ENABLE KEYS */;


-- Copiando estrutura para tabela escort.planos_pagamentos
DROP TABLE IF EXISTS `planos_pagamentos`;
CREATE TABLE IF NOT EXISTS `planos_pagamentos` (
  `pgid` int(11) NOT NULL AUTO_INCREMENT,
  `ppid` int(11) NOT NULL,
  `psid` varchar(100) DEFAULT NULL,
  `vloriginal` decimal(10,2) NOT NULL,
  `vencimento` datetime NOT NULL,
  `pagamento` datetime DEFAULT NULL,
  `vlcorrigido` decimal(10,2) DEFAULT NULL,
  `pago` int(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`pgid`),
  KEY `FK1_Planos` (`ppid`),
  CONSTRAINT `FK1_PlanosPessoas` FOREIGN KEY (`ppid`) REFERENCES `planos_pessoas` (`ppid`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

-- Copiando dados para a tabela escort.planos_pagamentos: ~3 rows (aproximadamente)
/*!40000 ALTER TABLE `planos_pagamentos` DISABLE KEYS */;
INSERT INTO `planos_pagamentos` (`pgid`, `ppid`, `psid`, `vloriginal`, `vencimento`, `pagamento`, `vlcorrigido`, `pago`) VALUES
	(2, 4, NULL, 0.00, '2017-05-04 09:38:45', NULL, NULL, 0),
	(10, 12, '', 0.00, '2017-05-08 10:46:52', NULL, NULL, 0),
	(11, 13, 'A10F074A-8BD6-4050-A2E8-36B6E248E282', 399.90, '2017-06-03 13:26:50', NULL, NULL, 0);
/*!40000 ALTER TABLE `planos_pagamentos` ENABLE KEYS */;


-- Copiando estrutura para tabela escort.planos_pessoas
DROP TABLE IF EXISTS `planos_pessoas`;
CREATE TABLE IF NOT EXISTS `planos_pessoas` (
  `ppid` int(11) NOT NULL AUTO_INCREMENT,
  `plaid` int(11) NOT NULL,
  `pesid` int(11) NOT NULL,
  `cadastro` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`ppid`),
  KEY `FK1_Planos` (`plaid`),
  KEY `FK3_Pessoas` (`pesid`),
  CONSTRAINT `FK1_Planos` FOREIGN KEY (`plaid`) REFERENCES `planos` (`plaid`),
  CONSTRAINT `FK3_Pessoas` FOREIGN KEY (`pesid`) REFERENCES `pessoas` (`pesid`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8;

-- Copiando dados para a tabela escort.planos_pessoas: ~3 rows (aproximadamente)
/*!40000 ALTER TABLE `planos_pessoas` DISABLE KEYS */;
INSERT INTO `planos_pessoas` (`ppid`, `plaid`, `pesid`, `cadastro`) VALUES
	(4, 2, 4, '2017-05-03 09:31:35'),
	(12, 1, 2, '2017-05-04 10:46:52'),
	(13, 3, 2, '2017-05-04 13:26:50');
/*!40000 ALTER TABLE `planos_pessoas` ENABLE KEYS */;


-- Copiando estrutura para tabela escort.planos_usuarios
DROP TABLE IF EXISTS `planos_usuarios`;
CREATE TABLE IF NOT EXISTS `planos_usuarios` (
  `ppid` int(11) NOT NULL AUTO_INCREMENT,
  `plaid` int(11) NOT NULL,
  `usuid` int(11) NOT NULL,
  `vloriginal` decimal(10,2) NOT NULL,
  `vencimento` datetime NOT NULL,
  `pagamento` datetime NOT NULL,
  `vlcorrigido` decimal(10,2) NOT NULL,
  `pago` int(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`ppid`),
  KEY `FK1_Planos` (`plaid`),
  KEY `FK3_Pessoas` (`usuid`),
  CONSTRAINT `FK1_Usuarios` FOREIGN KEY (`usuid`) REFERENCES `usuarios` (`usuid`),
  CONSTRAINT `FK2_Planos` FOREIGN KEY (`plaid`) REFERENCES `planos` (`plaid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

-- Copiando dados para a tabela escort.planos_usuarios: ~0 rows (aproximadamente)
/*!40000 ALTER TABLE `planos_usuarios` DISABLE KEYS */;
/*!40000 ALTER TABLE `planos_usuarios` ENABLE KEYS */;


-- Copiando estrutura para tabela escort.ppv
DROP TABLE IF EXISTS `ppv`;
CREATE TABLE IF NOT EXISTS `ppv` (
  `ppvid` int(11) NOT NULL AUTO_INCREMENT,
  `pesid` int(11) NOT NULL,
  `hash` varchar(50) NOT NULL,
  `inicio` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `fim` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`ppvid`),
  KEY `FK6_Pessoas` (`pesid`),
  CONSTRAINT `FK6_Pessoas` FOREIGN KEY (`pesid`) REFERENCES `pessoas` (`pesid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Copiando dados para a tabela escort.ppv: ~0 rows (aproximadamente)
/*!40000 ALTER TABLE `ppv` DISABLE KEYS */;
/*!40000 ALTER TABLE `ppv` ENABLE KEYS */;


-- Copiando estrutura para tabela escort.ppv_interacao
DROP TABLE IF EXISTS `ppv_interacao`;
CREATE TABLE IF NOT EXISTS `ppv_interacao` (
  `intid` int(11) NOT NULL AUTO_INCREMENT,
  `ppvid` int(11) NOT NULL,
  `usuid` int(11) NOT NULL,
  `mpid` int(11) NOT NULL,
  `custoprata` int(3) DEFAULT NULL,
  `custoouro` int(3) DEFAULT NULL,
  `custodiamante` int(3) DEFAULT NULL,
  PRIMARY KEY (`intid`),
  KEY `FK1_PPV` (`ppvid`),
  KEY `FK3_Usuarios` (`usuid`),
  KEY `FK4_ModalidadesPessoas` (`mpid`),
  CONSTRAINT `FK1_PPV` FOREIGN KEY (`ppvid`) REFERENCES `ppv` (`ppvid`),
  CONSTRAINT `FK3_Usuarios` FOREIGN KEY (`usuid`) REFERENCES `usuarios` (`usuid`),
  CONSTRAINT `FK5_ModalidadesPessoas` FOREIGN KEY (`mpid`) REFERENCES `modalidades_pessoas` (`mpid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Copiando dados para a tabela escort.ppv_interacao: ~0 rows (aproximadamente)
/*!40000 ALTER TABLE `ppv_interacao` DISABLE KEYS */;
/*!40000 ALTER TABLE `ppv_interacao` ENABLE KEYS */;


-- Copiando estrutura para tabela escort.usuarios
DROP TABLE IF EXISTS `usuarios`;
CREATE TABLE IF NOT EXISTS `usuarios` (
  `usuid` int(11) NOT NULL AUTO_INCREMENT,
  `ativo` int(1) NOT NULL DEFAULT '1',
  `nome` varchar(50) NOT NULL,
  `apelido` varchar(50) NOT NULL,
  `sexo` char(1) NOT NULL DEFAULT 'M',
  `avatar` varchar(50) DEFAULT NULL,
  `nascimento` datetime NOT NULL,
  `cadastro` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `email` varchar(50) NOT NULL,
  `senha` varchar(100) NOT NULL,
  `logon` int(1) NOT NULL DEFAULT '0',
  `onlinechat` int(1) NOT NULL DEFAULT '0',
  `dtultimoacesso` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`usuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Copiando dados para a tabela escort.usuarios: ~0 rows (aproximadamente)
/*!40000 ALTER TABLE `usuarios` DISABLE KEYS */;
/*!40000 ALTER TABLE `usuarios` ENABLE KEYS */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
