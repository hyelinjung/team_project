/*M!999999\- enable the sandbox mode */ 
-- MariaDB dump 10.19  Distrib 10.6.20-MariaDB, for Win64 (AMD64)
--
-- Host: 127.0.0.1    Database: asklepios
-- ------------------------------------------------------
-- Server version	10.6.20-MariaDB

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Sequence structure for `board_sequence`
--

DROP SEQUENCE IF EXISTS `board_sequence`;
CREATE SEQUENCE `board_sequence` start with 302 minvalue 1 maxvalue 9223372036854775806 increment by 1 cache 1000 nocycle ENGINE=InnoDB;
DO SETVAL(`board_sequence`, 3302, 0);

--
-- Sequence structure for `like_sequence`
--

DROP SEQUENCE IF EXISTS `like_sequence`;
CREATE SEQUENCE `like_sequence` start with 1 minvalue 1 maxvalue 9223372036854775806 increment by 1 cache 1000 nocycle ENGINE=InnoDB;
DO SETVAL(`like_sequence`, 3001, 0);

--
-- Sequence structure for `registration_code_seq`
--

DROP SEQUENCE IF EXISTS `registration_code_seq`;
CREATE SEQUENCE `registration_code_seq` start with 11 minvalue 1 maxvalue 9223372036854775806 increment by 1 nocache nocycle ENGINE=InnoDB;
DO SETVAL(`registration_code_seq`, 54, 0);

--
-- Sequence structure for `reservation_code_seq`
--

DROP SEQUENCE IF EXISTS `reservation_code_seq`;
CREATE SEQUENCE `reservation_code_seq` start with 1 minvalue 1 maxvalue 9223372036854775806 increment by 1 nocache nocycle ENGINE=InnoDB;
DO SETVAL(`reservation_code_seq`, 244, 0);

--
-- Sequence structure for `review_sequence`
--

DROP SEQUENCE IF EXISTS `review_sequence`;
CREATE SEQUENCE `review_sequence` start with 238 minvalue 1 maxvalue 9223372036854775806 increment by 1 nocache nocycle ENGINE=InnoDB;
DO SETVAL(`review_sequence`, 242, 0);

--
-- Table structure for table `ai_answer`
--

DROP TABLE IF EXISTS `ai_answer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ai_answer` (
  `ai_answer_id` int(11) NOT NULL AUTO_INCREMENT,
  `content` varchar(1000) NOT NULL,
  `date` datetime DEFAULT current_timestamp(),
  `question_id` int(11) NOT NULL,
  `ai_sub` varchar(50) NOT NULL DEFAULT '실시간 고민 해결사',
  `ai_name` varchar(50) NOT NULL DEFAULT 'asklepios AI',
  `ai_read` char(1) DEFAULT '0',
  PRIMARY KEY (`ai_answer_id`),
  KEY `question_id` (`question_id`),
  CONSTRAINT `ai_answer_ibfk_1` FOREIGN KEY (`question_id`) REFERENCES `question` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ai_answer`
--

LOCK TABLES `ai_answer` WRITE;
/*!40000 ALTER TABLE `ai_answer` DISABLE KEYS */;
/*!40000 ALTER TABLE `ai_answer` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `answer`
--

DROP TABLE IF EXISTS `answer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `answer` (
  `answer_id` int(11) NOT NULL AUTO_INCREMENT,
  `question_id` int(11) NOT NULL,
  `content` varchar(100) NOT NULL,
  `date` datetime DEFAULT current_timestamp(),
  `user_doctor_id` varchar(12) NOT NULL,
  `hospital_name` varchar(30) NOT NULL,
  `user_doctor_medical` varchar(10) NOT NULL,
  `answer_read` char(1) DEFAULT '0',
  PRIMARY KEY (`answer_id`),
  KEY `question_id` (`question_id`),
  KEY `user_doctor_id` (`user_doctor_id`),
  CONSTRAINT `answer_ibfk_1` FOREIGN KEY (`question_id`) REFERENCES `question` (`id`) ON DELETE CASCADE,
  CONSTRAINT `answer_ibfk_2` FOREIGN KEY (`user_doctor_id`) REFERENCES `user_doctor` (`user_doctor_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `answer`
--

LOCK TABLES `answer` WRITE;
/*!40000 ALTER TABLE `answer` DISABLE KEYS */;
/*!40000 ALTER TABLE `answer` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `board`
--

DROP TABLE IF EXISTS `board`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `board` (
  `board_sequence` int(11) NOT NULL AUTO_INCREMENT,
  `board_user_id` varchar(12) DEFAULT NULL,
  `board_category` varchar(12) DEFAULT NULL,
  `board_title` varchar(100) DEFAULT NULL,
  `board_content` varchar(6000) DEFAULT NULL,
  `board_binary` varchar(200) DEFAULT NULL,
  `board_viewcount` int(10) DEFAULT NULL,
  `board_date` varchar(12) DEFAULT NULL,
  `board_goodcount` int(10) DEFAULT NULL,
  PRIMARY KEY (`board_sequence`),
  KEY `fk_board_user_id` (`board_user_id`),
  CONSTRAINT `fk_board_user_id` FOREIGN KEY (`board_user_id`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `board`
--

LOCK TABLES `board` WRITE;
/*!40000 ALTER TABLE `board` DISABLE KEYS */;
/*!40000 ALTER TABLE `board` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `boardlike`
--

DROP TABLE IF EXISTS `boardlike`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `boardlike` (
  `board_like_num` int(11) NOT NULL,
  `board_like_check` tinyint(1) DEFAULT NULL,
  `board_sequence` varchar(100) DEFAULT NULL,
  `board_user_id` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`board_like_num`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `boardlike`
--

LOCK TABLES `boardlike` WRITE;
/*!40000 ALTER TABLE `boardlike` DISABLE KEYS */;
INSERT INTO `boardlike` VALUES (1002,1,'292','test2'),(1003,1,'204','test2'),(1004,1,'206','test2'),(1005,1,'205','test2'),(1006,1,'301','test2'),(1019,1,'287','test2'),(1020,1,'287','test1'),(1022,1,'301','test3'),(1023,1,'214','test3'),(1025,1,'287','test3'),(1056,1,'299','taekyun'),(1057,1,'307','taekyun'),(1058,1,'302','taekyun'),(2003,1,'300','test'),(2004,1,'1303','taekyun'),(2005,1,'1304','taekyun'),(2009,1,'1304','test');
/*!40000 ALTER TABLE `boardlike` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `file`
--

DROP TABLE IF EXISTS `file`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `file` (
  `board_user_id` varchar(100) DEFAULT NULL,
  `board_binary` varchar(100) DEFAULT NULL,
  `original_name` varchar(100) DEFAULT NULL,
  `save_name` varchar(100) DEFAULT NULL,
  `size` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `file`
--

LOCK TABLES `file` WRITE;
/*!40000 ALTER TABLE `file` DISABLE KEYS */;
/*!40000 ALTER TABLE `file` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hospital`
--

DROP TABLE IF EXISTS `hospital`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `hospital` (
  `hospital_code` varchar(12) NOT NULL,
  `hospital_name` varchar(30) DEFAULT NULL,
  `hospital_addr` varchar(100) DEFAULT NULL,
  `hospital_tel` varchar(20) DEFAULT NULL,
  `hospital_date` varchar(20) DEFAULT NULL,
  `hospital_time` varchar(20) DEFAULT NULL,
  `hospital_notice` varchar(200) DEFAULT NULL,
  `hospital_intro` varchar(100) DEFAULT NULL,
  `hospital_accept` varchar(10) NOT NULL DEFAULT '대기',
  `hospital_certification` varchar(500) NOT NULL,
  PRIMARY KEY (`hospital_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hospital`
--

LOCK TABLES `hospital` WRITE;
/*!40000 ALTER TABLE `hospital` DISABLE KEYS */;
INSERT INTO `hospital` VALUES ('HOSP001','유레카내과의원','경기 수원시 영통구 효원로 400 탑프라자 4층 402~405호','031-123-4567','n','09:00-18:00','추석 연휴 휴진 안내','2023년 개원한 내과 전문 병원으로, 감기, 고혈압, 만성질환 등 다양한 질환을 진료합니다.','승인','5473f2a5-a5e4-45ab-8048-1793ccb277f3.pdf'),('HOSP002','김민희의원','경기 수원시 영통구 효원로 363 위브하늘채 B상가 310호','031-234-5678','y','09:00-18:30','공휴일 진료 안내','1986년 개원한 소아청소년과 전문 병원으로, 공휴일에도 진료를 제공합니다.','승인','5473f2a5-a5e4-45ab-8048-1793ccb277f3.pdf'),('HOSP003','김정오치과의원','경기 수원시 영통구 동수원로 520','031-345-6789','y','09:30-18:00','토요일 진료 안내','1992년 개원한 치과로, 토요일에도 진료를 제공합니다.','승인','5473f2a5-a5e4-45ab-8048-1793ccb277f3.pdf'),('HOSP004','매탄삼성내과의원','경기 수원시 영통구 인계로 264','031-456-7890','n','09:00-19:00','건강검진 안내','1999년 개원한 내과 전문 병원으로, 고혈압, 당뇨병 등 만성질환을 진료합니다.','승인','5473f2a5-a5e4-45ab-8048-1793ccb277f3.pdf'),('HOSP005','성모정형외과의원','경기 수원시 영통구 중부대로 240 2,4,5층','031-567-8901','n','07:30-17:30','진료 시간 변경 안내','1991년 개원한 정형외과로, 허리통증, 디스크, 관절염 등을 치료합니다.','승인','5473f2a5-a5e4-45ab-8048-1793ccb277f3.pdf'),('HOSP006','수원성심정신건강의학과의원','경기 수원시 영통구 동수원로 526 신라빌딩 2층','031-678-9012','y','09:30-18:00','화요일 휴진 안내','2005년 개원한 정신건강의학과 전문 병원으로, 소아 진료와 알코올 환자 진료를 제공합니다.','승인','5473f2a5-a5e4-45ab-8048-1793ccb277f3.pdf'),('HOSP007','삼성탑내과','경기 수원시 영통구 중부대로 240 3층','031-789-0123','n','07:00-18:00','공휴일 진료 안내','2011년 개원한 내과로, 고지혈증, 고혈압, 당뇨병 등을 진료하며 공휴일에도 진료를 제공합니다.','승인','5473f2a5-a5e4-45ab-8048-1793ccb277f3.pdf'),('HOSP008','서울나이스마취통증의학과의원','경기 수원시 영통구 효원로 393 밀레니엄플라자 207호','031-213-8585','y','09:00-18:00','신규 개원 안내','2023년 개원한 마취통증의학과로, VDT 증후군, 관절병증 등을 치료합니다.','승인','5473f2a5-a5e4-45ab-8048-1793ccb277f3.pdf'),('HOSP009','의료법인한성재단S서울병원','경기 수원시 영통구 중부대로246번길 14','031-901-2345','y','08:30-18:30','척추관절 전문 진료 안내','2008년 개원한 병원으로, 내과, 신경외과, 정형외과 등 다양한 진료과목을 제공합니다.','승인','5473f2a5-a5e4-45ab-8048-1793ccb277f3.pdf'),('HOSP010','맹해성이비인후과의원','경기 수원시 영통구 인계로 219 삼성1차아파트 상가 2층 207호','031-012-3456','y','09:00-18:00','토요일 진료 안내','이비인후과 전문 병원으로, 토요일에도 진료를 제공합니다.','승인','5473f2a5-a5e4-45ab-8048-1793ccb277f3.pdf'),('HOSP011','서울뿌리치과의원','경기 수원시 팔달구 중부대로 249 2층','031-248-7528','y','09:00-18:00','많은 치과들, 수많은 광고속에 환자의 마음을 공감해 줄 수 있는 치과를 찾기란 힘든 일입니다. 막상 어느 치과를 가야할 지 망설인다면 소개환자가 많은 치과로 가시는게 올바른 선택입니다.','오기 전 꼭 양치 해주세요 ~ ','승인','5473f2a5-a5e4-45ab-8048-1793ccb277f3.pdf'),('HOSP012','초이스병원','경기 수원시 영통구 중부대로 268 1층','031-216-8275','y','09:00-18:00','앞으로도 대한민국 비수술척추관절병원이라는 책임감과 자긍심을 잊지 않고 수준높은 의료서비스로 환자 한분 한분에게 만족과 믿음을 드리는 초이스병원이 되겠습니다. 감사합니다.','주차장은 우회전 후 뒷편에 있습니다.','승인','5473f2a5-a5e4-45ab-8048-1793ccb277f3.pdf'),('HOSP013','베스탑 비뇨기과의원 수원','경기 수원시 영통구 효원로 387 풍성프라자 402호','031-213-0035','n','09:00-17:30','#남성수술 #비뇨기과 #요로결석 #정관수술 #통증치료','주차장은 우회전 후 뒷편에 있습니다.','승인','5473f2a5-a5e4-45ab-8048-1793ccb277f3.pdf'),('HOSP015','가톨릭대학교 성빈센트병원','경기 수원시 팔달구 중부대로 93 ','1577-8588','y','09:00-18:00','성빈센트병원은 해마다 폐암, 위암, 대장암, 뇌졸중 등 여러 부문에서 최고등급인 1등급을 획득하고 있고, 1994년 국내 최초 복강경 비장절제술 성공,\r\n1996년 세계 최초 직장암에 대한 복강경 항문괄약근 보존술 성공 등 더 나은 의료서비스를 제공하고자 최선의 노력을 기울이고 있습니다.','주차장이 혼잡하니 대중교통을 이용해주시기 바랍니다.','승인','5473f2a5-a5e4-45ab-8048-1793ccb277f3.pdf'),('HOSP016','김찬병원','경기 수원시 팔달구 경수대로 450 3-13층','1577-8858','n','09:30-17:30','30년이 넘는 시간동안 각종 통증질환으로 저희 의료진을 찾아 주신 수많은 환자분께 진심으로 감사 인사 드립니다. ','휴게시간 월 ~ 토 13:00 ~ 14:00','승인','5473f2a5-a5e4-45ab-8048-1793ccb277f3.pdf'),('HOSP017','하늘마음한의원 수원점','경기 수원시 팔달구 경기 수원시 팔달구 권광로 ','031-237-8575','y','10:00-18:00','첫 단추를 어떻게 끼우느냐는 매우 중요합니다.\r\n애초에 잘못 끼우지 않으시도록, 한참 오래 전에 잘못 끼운 것도 바로 잡아줄 수 있는, 그런 좋은 기회의 만남이 되겠습니다','휴게시간 월,화,목,금 13:00 ~ 14:00','승인','5473f2a5-a5e4-45ab-8048-1793ccb277f3.pdf'),('HOSP018','백성병원','경기 수원시 팔달구 인계로 102 ','031-238-9121','y','09:00-18:00','병원은 언제나 청결하고 깨끗해야 합니다.\r\n바이러스 살균, 병원균 차단, 바닥, 내부, 의료기 청결, 일회용 주사기 사용\r\n본질에 충실한다는 것은 늘 당연하지만 어렵다고 생각합니다.\r\n흰 백, 성대할 성.\r\n기본에 늘 충실한 백성병원이 되겠습니다.','휴게시간 월 ~ 금 12:30 ~ 13:30','승인','5473f2a5-a5e4-45ab-8048-1793ccb277f3.pdf'),('HOSP019','서울88의원','경기 수원시 팔달구 중부대로 44 건우까사미타워 8층 ','1833-2088','y','09:30-17:30','서울88의원은 2024년 인터벤션 특화 의료기관으로 첫발을 내디뎠습니다.\r\n첨단 의료장비와 체계적인 의료시스템을 갖추고 임상경험이 풍부한 의료진들이 협진하여 최상의 의료서비스를 제공하기 위해 끊임없이 노력하고 있습니다.','3T MRI 정밀진단, 투석혈관, 하지정맥류, 전립선비대, 항암포트, 중심정맥관, 배액관','승인','5473f2a5-a5e4-45ab-8048-1793ccb277f3.pdf'),('HOSP021','강남여성병원','경기 수원시 팔달구 중부대로 96 ','031-222-7575','n','09:00-18:00','강남여성병원은 여성의 건강은 물론 마음까지 생각합니다. 저희 강남여성병원은 1984년 개원하여 39년간 전통과 신뢰를 바탕으로 현재까지 여성의 건강과 아름다움을 위해 끊임없이 노력하고 있습니다.\r\n항상 연구하고 발전하는 병원, 최고의 여성병원으로 성장할 것을 약속합니다.','수원 산부인과, 수원 하이푸, 자궁근종, 요실금 치료, TOT수술, 여성질환진료','승인','5473f2a5-a5e4-45ab-8048-1793ccb277f3.pdf'),('HOSP023','해성병원','경기 수원시 팔달구 경수대로 542 ','031-222-7511','n','09:00-18:00','안녕하십니까 해성병원 원장 서소영입니다.\r\n본 해성병원은 뇌혈관 질환 및 파킨슨병과같은 다양한 신경계 질환과 수술후 재활치료를 전문으로 하는 병원으로써\r\n전문적 재활치료와 내 외과 통합 시스템을 구축하며 환자의 빠른 회복과 일상생활로의 복귀를 위한 재활전문병원 입니다 .','#간호간병통합서비스 #골다공증 #대상포진 #면역치료 #언어치료 #오십견 #재활 #저혈압 #통증치료','승인','5473f2a5-a5e4-45ab-8048-1793ccb277f3.pdf'),('HOSP024','한독병원','경기 수원시 팔달구 경수대로 487 ','031-232-4511','n','09:00-18:00','','#디스크질환 #물리치료','승인','5473f2a5-a5e4-45ab-8048-1793ccb277f3.pdf'),('HOSP025','투유의원','경기 수원시 팔달구 인계로 130 더스퀘어빌딩 7층','1522-8837','n','10:00-18:00','투유는 2명의 의료진이 성형과 피부파트를 나누어서 진료합니다.\r\n피부성형에 대한 올바른 지식과 임상으로 해답을 제시합니다.\r\n바른 관점에서 만드는 성형수술과 피부시술이 투유에 있습니다.','#눈밑지방재배치 #레이저시술 #레이저토닝 #리프팅 #실리프팅 #여드름 #오타모반제거 #잡티제거 #지방이식 #필러','승인','5473f2a5-a5e4-45ab-8048-1793ccb277f3.pdf'),('HOSP026','화이트드림치과 수원점','경기 수원시 팔달구 효원로265번길 35 화이트드림빌딩 4-5층','031-609-2880','y','10:00-18:00','화이트드림치과는 수원시청역에서만 10년이상 매년 성장을 거듭하며 운영되는 있는 치과입니다. 200평 이상의 넓은 규모로 앞선 디지털 장비 시스템과 가공 시스템, 경험이 풍부한 전문 의료진의 대학병원식 협진진료를 적용하였습니다.','수원시청역 8번출구 도보 1분, 8인의 분야별 협진진료','승인','5473f2a5-a5e4-45ab-8048-1793ccb277f3.pdf'),('HOSP027','우리병원','경기 수원시 팔달구 경수대로 419 ','031-211-1700','n','09:00-18:00','우리병원은 지속적으로 성장발전하는 병원입니다.\r\n우리병원은 환자가 편안함을 느끼는 병원이며, 환자에게 신뢰받는 병원입니다.\r\n우리병원은 수준급의 의료서비스를 제공하는 병원이며, 직원 모두가 행복하고 자부심을 갖는 병원입니다. 척추디스크·관절병원 WOORI HOSPITAL','발렛파킹 있습니다.','승인','5473f2a5-a5e4-45ab-8048-1793ccb277f3.pdf'),('HOSP028','쉬즈메디병원','경기 수원시 팔달구 장다리로 288 ','031-231-7300','n','09:00-18:00','쉬즈메디병원은 다년간 쌓아 온 의료 경험을 기반으로 미래의 희망을 책임질 새 생명의 분만을 받는 숭고한 과업과 사회 발전에 이바지하는 병원을 지향합니다.\r\n생명에 대한 책임감을 가지고 내부적으로는 끊임없이 전문성을 강화하며, 고객에게는 진심을 다함으로써 보다 나은 고품질의 의료 서비스를 제공하는 병원으로 성장해 나갈 것을 약속드립니다.','휴게시간 월 ~ 금 13:00 ~ 14:00','승인','5473f2a5-a5e4-45ab-8048-1793ccb277f3.pdf'),('HOSP029','정답병원','경기 수원시 팔달구 경수대로 471 ','031-232-9725','n','09:00-18:00','꼭 필요한 수술인지 다시 확인하세요\r\n안 해도 되는 수술로 고통받는 분들을 보면 마음이 아픕니다.\r\n관절 / 척추 수술 꼭 필요한지 정답병원에서 다시 확인하세요.','#관절경수술 #관절염 #교통사고후유증 #도수치료 #디스크질환 #무릎관절치료 #물리치료 #통증치료 #회전근개손상','승인','5473f2a5-a5e4-45ab-8048-1793ccb277f3.pdf'),('HOSP031','동수원병원','경기 수원시 팔달구 중부대로 165 1~9층','1533-2114','y','09:00-17:00','의료법인 녹산의료재단은 1968년 변외과 의원을 모태로 하여,\r\n1975년 수원제일병원 을 거쳐 1981년 의료법인 녹산의료재단으로 설립 되었으며,\r\n최첨단 의료장비와 체계적인 의료시스템, 신뢰 할 수 있는 전문 의료진을 기반으로\r\n40여년을 지역주민과 함께 해 온 지역사회의 전통 있는 종합병원입니다.','#건강검진 #물리치료 #자궁내막증','승인','5473f2a5-a5e4-45ab-8048-1793ccb277f3.pdf'),('HOSP032','아주대학교병원','경기 수원시 영통구 월드컵로 164 ','1688-6114-1','n','09:00-17:00','1994년에 문을 연 아주대학교병원은 환자에게는 최선의 진료를 다하고\r\n지역 의료인에게는 최신 의학 정보를 제공하며 첨단 연구를 통해 국내 의학 발전을\r\n선도한다는 진료 철학을 바탕으로 한 해 한 해 발전을 거듭해 왔습니다.\r\n\r\n“우리는 항상 당신 곁에 있으며,\r\n당신의 아픔을 치유하기 위하여 끊임없이 헌신합니다\"','휴게시간 월 ~ 금 12:30 ~ 13:30','승인','5473f2a5-a5e4-45ab-8048-1793ccb277f3.pdf'),('HOSP033','서울올바른내과의원','경기 수원시 팔달구 중부대로 44 건우까사미타워 4층','031-236-0775','n','09:00-18:00','안녕하세요! 올바른 진료, 믿을 수 있는 병원 서울올바른내과의원입니다.','점심시간 없이 진료합니다.','승인','5473f2a5-a5e4-45ab-8048-1793ccb277f3.pdf'),('HOSP034','봉피부과의원','경기 수원시 영통구 중부대로 259 예스프라자 402호 (우)16503','031-211-8275','n','09:30-17:30','수원시민 118만명!\r\n그동안 오신분들 \"46만명\"\r\n2.5명당 1명이 \"봉피부과&성형외과\"를 방문해 주셨습니다.\r\n\r\n앞으로도 오시는 분들을 위해\r\n\r\n실력으로! 믿음으로! 진심으로! 결과로서!\r\n\r\n보답하겠습니다.','휴게시간 월 ~ 금 12:30 ~ 14:00','대기','5473f2a5-a5e4-45ab-8048-1793ccb277f3.pdf');
/*!40000 ALTER TABLE `hospital` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary table structure for view `hospital_doctor`
--

DROP TABLE IF EXISTS `hospital_doctor`;
/*!50001 DROP VIEW IF EXISTS `hospital_doctor`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `hospital_doctor` AS SELECT
 1 AS `hospital_code`,
  1 AS `hospital_name`,
  1 AS `hospital_addr`,
  1 AS `hospital_tel`,
  1 AS `hospital_date`,
  1 AS `hospital_time`,
  1 AS `hospital_notice`,
  1 AS `hospital_intro`,
  1 AS `user_doctor_code`,
  1 AS `user_doctor_id`,
  1 AS `user_doctor_hospital_code`,
  1 AS `user_doctor_medical`,
  1 AS `user_doctor_career`,
  1 AS `user_doctor_graduate`,
  1 AS `user_id`,
  1 AS `user_password`,
  1 AS `user_name`,
  1 AS `user_name_eng`,
  1 AS `user_register_number`,
  1 AS `user_tel`,
  1 AS `user_addr`,
  1 AS `user_email`,
  1 AS `user_authority`,
  1 AS `user_info_agreement`,
  1 AS `user_image` */;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `img_question`
--

DROP TABLE IF EXISTS `img_question`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `img_question` (
  `img_question_id` int(11) NOT NULL AUTO_INCREMENT,
  `fileName` varchar(50) NOT NULL,
  `question_id` int(11) NOT NULL,
  `origin` varchar(50) NOT NULL,
  PRIMARY KEY (`img_question_id`),
  KEY `question_id` (`question_id`),
  CONSTRAINT `img_question_ibfk_1` FOREIGN KEY (`question_id`) REFERENCES `question` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `img_question`
--

LOCK TABLES `img_question` WRITE;
/*!40000 ALTER TABLE `img_question` DISABLE KEYS */;
/*!40000 ALTER TABLE `img_question` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `medical_history`
--

DROP TABLE IF EXISTS `medical_history`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `medical_history` (
  `medical_history_code` varchar(12) NOT NULL,
  `medical_history_user_id` varchar(12) DEFAULT NULL,
  `medical_history_hospital_code` varchar(50) DEFAULT NULL,
  `medical_history_date` varchar(10) DEFAULT NULL,
  `medical_history_doctor_code` varchar(50) DEFAULT NULL,
  `medical_history_memo` varchar(100) DEFAULT NULL,
  `medical_history_data` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`medical_history_code`),
  KEY `fk_medical_history_user_id` (`medical_history_user_id`),
  KEY `fk_medical_history_hospital_code` (`medical_history_hospital_code`),
  KEY `fk_medical_history_doctor_code` (`medical_history_doctor_code`),
  CONSTRAINT `fk_medical_history_doctor_code` FOREIGN KEY (`medical_history_doctor_code`) REFERENCES `user_doctor` (`user_doctor_code`),
  CONSTRAINT `fk_medical_history_hospital_code` FOREIGN KEY (`medical_history_hospital_code`) REFERENCES `hospital` (`hospital_code`),
  CONSTRAINT `fk_medical_history_user_id` FOREIGN KEY (`medical_history_user_id`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `medical_history`
--

LOCK TABLES `medical_history` WRITE;
/*!40000 ALTER TABLE `medical_history` DISABLE KEYS */;
/*!40000 ALTER TABLE `medical_history` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `question`
--

DROP TABLE IF EXISTS `question`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `question` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(100) NOT NULL,
  `content` varchar(100) NOT NULL,
  `date` datetime DEFAULT current_timestamp(),
  `tag` varchar(50) DEFAULT NULL,
  `sub` varchar(10) DEFAULT NULL,
  `user_id` varchar(12) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `question_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `question`
--

LOCK TABLES `question` WRITE;
/*!40000 ALTER TABLE `question` DISABLE KEYS */;
/*!40000 ALTER TABLE `question` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `reservation`
--

DROP TABLE IF EXISTS `reservation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `reservation` (
  `reservation_code` varchar(12) NOT NULL,
  `reservation_hospital_code` varchar(10) DEFAULT NULL,
  `reservation_user_doctor_code` varchar(50) DEFAULT NULL,
  `reservation_user_id` varchar(12) DEFAULT NULL,
  `reservation_date` varchar(10) DEFAULT NULL,
  `reservation_time` varchar(10) DEFAULT NULL,
  `reservation_memo` varchar(200) DEFAULT NULL,
  `reservation_accept` varchar(10) DEFAULT '대기',
  PRIMARY KEY (`reservation_code`),
  UNIQUE KEY `unique_hospital_doctor_date_time` (`reservation_hospital_code`,`reservation_user_doctor_code`,`reservation_date`,`reservation_time`),
  KEY `fk_reservation_user_id` (`reservation_user_id`),
  KEY `fk_reservation_hospital_code` (`reservation_hospital_code`),
  KEY `fk_reservation_user_doctor_code` (`reservation_user_doctor_code`),
  CONSTRAINT `fk_reservation_hospital_code` FOREIGN KEY (`reservation_hospital_code`) REFERENCES `hospital` (`hospital_code`),
  CONSTRAINT `fk_reservation_user_doctor_code` FOREIGN KEY (`reservation_user_doctor_code`) REFERENCES `user_doctor` (`user_doctor_code`),
  CONSTRAINT `fk_reservation_user_id` FOREIGN KEY (`reservation_user_id`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reservation`
--

LOCK TABLES `reservation` WRITE;
/*!40000 ALTER TABLE `reservation` DISABLE KEYS */;
INSERT INTO `reservation` VALUES ('RES001','HOSP002','e039dcc3-491c-489f-8e90-7ac41addb550','dhgn206','2025-02-02','09:00','갑자기 피부에 붉은 발진이 생기고 가려움증이 심해요.','대기'),('RES002','HOSP003','9c5a6e81-4e6f-4d44-9978-7fef48a13e0c','dhgn206','2025-02-02','09:00','온몸이 가려워서 긁다 보니 피부가 상처가 나고 있어요.','대기'),('RES003','HOSP002','e039dcc3-491c-489f-8e90-7ac41addb550','dhgn206','2025-02-02','14:00','얼굴에 붉은 반점이 생기고 열감이 느껴져요.','대기'),('RES004','HOSP003','9c5a6e81-4e6f-4d44-9978-7fef48a13e0c','dhgn206','2025-02-02','11:00','손에 물집이 생기고 터지면서 액체가 흘러나와요.','대기'),('RES005','HOSP002','e039dcc3-491c-489f-8e90-7ac41addb550','dhgn206','2025-02-03','16:00','팔꿈치와 무릎 부위가 거칠고 각질이 많이 일어나요.','대기'),('RES006','HOSP002','e039dcc3-491c-489f-8e90-7ac41addb550','dhgn206','2025-02-02','16:30','피부에 여드름이 잘 안 사라지고 흉터가 오래가요.','대기'),('RES007','HOSP002','e039dcc3-491c-489f-8e90-7ac41addb550','dhgn206','2025-02-02','11:00','팔과 다리에 붉고 비늘 같은 반점이 생기고 가려워요.','대기'),('RES008','HOSP003','9c5a6e81-4e6f-4d44-9978-7fef48a13e0c','dhgn206','2025-02-03','11:30','상처가 감염되어서 고름이 생기고 아파요.\n','대기'),('RES009','HOSP003','9c5a6e81-4e6f-4d44-9978-7fef48a13e0c','dhgn206','2025-01-29','15:00','햇볕에 많이 노출된 부위가 검게 변해버렸어요.','대기'),('RES010','HOSP002','e039dcc3-491c-489f-8e90-7ac41addb550','dhgn206','2025-01-28','11:30','발바닥이 갈라져서 걷는 게 힘들어요.','승인'),('RES011','HOSP002','e039dcc3-491c-489f-8e90-7ac41addb550','dhgn206','2025-01-30','11:00','겨울철에 피부가 너무 건조해져서 갈라지고 아파요.','대기'),('RES012','HOSP003','9c5a6e81-4e6f-4d44-9978-7fef48a13e0c','dhgn206','2025-01-28','11:30','피부가 아프고 만지면 찌릿한 느낌이 들어요.','대기'),('RES013','HOSP009','7ba6e64d-a496-4639-825c-49460241bd11','dhgn206','2025-01-31','14:30','털이 나는 부위에 붉은 염증이 생기고 아파요.','대기'),('RES014','HOSP009','7ba6e64d-a496-4639-825c-49460241bd11','dhgn206','2025-01-26','11:30','피부에 작은 혹이 생겼는데 점점 커지고 있어요.','대기'),('RES015','HOSP009','7ba6e64d-a496-4639-825c-49460241bd11','dhgn206','2025-01-29','11:30','머리카락이 많이 빠져서 두피가 보일 정도예요.','대기'),('RES016','HOSP009','7ba6e64d-a496-4639-825c-49460241bd11','dhgn206','2025-01-27','14:00','피부에서 불쾌한 냄새가 나서 고민이에요.','대기'),('RES017','HOSP009','7ba6e64d-a496-4639-825c-49460241bd11','dhgn206','2025-01-29','14:00','피부의 일부가 다른 색으로 변해버렸어요.','대기'),('RES018','HOSP009','7ba6e64d-a496-4639-825c-49460241bd11','dhgn206','2025-01-26','14:00','상처가 나고 나서 피부가 붉어지고 부풀어 올랐어요.\n','대기'),('RES019','HOSP009','7ba6e64d-a496-4639-825c-49460241bd11','dhgn206','2025-01-26','11:00','피부가 붓고 열이 나서 불편해요.\n','대기'),('RES020','HOSP003','9c5a6e81-4e6f-4d44-9978-7fef48a13e0c','dhgn206','2025-02-05','11:00','피부가 가렵고 염증이 자주 생겨요.','대기'),('RES021','HOSP013','00ab3b7e-ae2e-42cf-bcba-81db0c1bb5a9','test','2025-01-26','14:00','빈뇨 하루에 화장실을 너무 자주 가서 불편해요.','대기'),('RES022','HOSP024','6720afef-cbe9-46bb-9fdf-9d67c0e4bc54','test','2025-01-26','14:30','배뇨통 소변을 볼 때마다 통증이 느껴져서 힘들어요.','대기'),('RES023','HOSP009','39859300-ef55-47cf-bb8b-84cd44d9e9d7','test','2025-01-26','14:00','혈뇨 소변에 피가 섞여 나와서 걱정이에요.','대기'),('RES024','HOSP033','f99010d5-cee5-4f45-ade6-59534add53bb','test','2025-01-26','11:00','음경의 발진 음경에 붉은 발진이 생겨서 가려워요.','대기'),('RES025','HOSP009','39859300-ef55-47cf-bb8b-84cd44d9e9d7','test','2025-02-02','16:00','고환 통증 고환에 통증이 느껴져서 걱정이에요.','대기'),('RES026','HOSP013','00ab3b7e-ae2e-42cf-bcba-81db0c1bb5a9','test','2025-01-26','09:00','소변의 양 감소 소변이 잘 나오지 않고 양이 적어서 불안해요.','대기'),('RES027','HOSP024','6720afef-cbe9-46bb-9fdf-9d67c0e4bc54','test','2025-01-27','11:00','신장 통증 허리 쪽에서 통증이 느껴져서 불안해요.','대기'),('RES028','HOSP009','39859300-ef55-47cf-bb8b-84cd44d9e9d7','test','2025-01-28','14:00','성욕 감소 최근에 성욕이 줄어들어서 고민이에요.','대기'),('RES029','HOSP013','00ab3b7e-ae2e-42cf-bcba-81db0c1bb5a9','test','2025-02-03','11:00','발기부전 성관계 중 발기가 잘 되지 않아서 고민이에요.','대기'),('RES030','HOSP033','f99010d5-cee5-4f45-ade6-59534add53bb','test','2025-01-26','11:30','소변의 잔여감 소변을 본 후에도 잔여감이 남아 불편해요.','대기'),('RES031','HOSP024','6720afef-cbe9-46bb-9fdf-9d67c0e4bc54','test','2025-01-29','14:00','소변의 힘 감소 소변을 볼 때 힘이 잘 들어가지 않아서 불편해요.','대기'),('RES032','HOSP013','00ab3b7e-ae2e-42cf-bcba-81db0c1bb5a9','test','2025-01-27','13:30','급박뇨 소변이 마려운 느낌이 갑자기 들어서 참기 힘들어요.','대기'),('RES033','HOSP009','39859300-ef55-47cf-bb8b-84cd44d9e9d7','test','2025-01-26','13:00','요도 분비물 소변을 볼 때 요도에서 분비물이 나와서 걱정이에요.','대기'),('RES034','HOSP033','f99010d5-cee5-4f45-ade6-59534add53bb','test','2025-01-30','13:30','전립선 통증 하복부에 통증이 느껴져서 불편해요.','대기'),('RES035','HOSP013','00ab3b7e-ae2e-42cf-bcba-81db0c1bb5a9','test','2025-01-26','13:00','성병 증상 성관계 후에 이상한 증상이 나타나서 불안해요.','대기'),('RES036','HOSP024','6720afef-cbe9-46bb-9fdf-9d67c0e4bc54','test','2025-01-26','13:00','소변의 색 소변이 평소와 다르게 탁하고 어두운 색이에요.','대기'),('RES037','HOSP009','39859300-ef55-47cf-bb8b-84cd44d9e9d7','test','2025-02-04','13:00','요실금 갑자기 소변이 새서 당황스러운 상황이 자주 생겨요.','대기'),('RES038','HOSP013','00ab3b7e-ae2e-42cf-bcba-81db0c1bb5a9','test','2025-01-29','09:00','소변의 냄새 소변에서 이상한 냄새가 나서 걱정이에요.','대기'),('RES039','HOSP033','f99010d5-cee5-4f45-ade6-59534add53bb','test','2025-01-28','09:00','성기 부종 성기가 붓고 아파서 걱정이에요.','대기'),('RES040','HOSP013','00ab3b7e-ae2e-42cf-bcba-81db0c1bb5a9','test','2025-01-24','09:00','성기 가려움증 성기 부위가 가려워서 불편해요.','대기'),('RES041','HOSP028','346687a5-6ed1-4657-a130-f21c9130c270','dhgn206','2025-01-28','09:00','월경 불순 생리 주기가 불규칙해서 걱정이에요.','대기'),('RES042','HOSP015','599ac6c4-3a99-41d9-87fb-1c57c6ffe72a','dhgn206','2025-01-26','09:00','생리통 생리 기간 동안 심한 통증이 있어요.','대기'),('RES043','HOSP028','346687a5-6ed1-4657-a130-f21c9130c270','dhgn206','2025-01-26','09:00','생리통 생리 기간 동안 심한 통증이 있어요.','대기'),('RES044','HOSP028','346687a5-6ed1-4657-a130-f21c9130c270','dhgn206','2025-01-26','11:00','질 분비물 변화 질에서 나오는 분비물이 평소와 달라졌어요.','대기'),('RES045','HOSP028','346687a5-6ed1-4657-a130-f21c9130c270','dhgn206','2025-01-27','09:00','가려움증 질 부위가 가려워서 불편해요.','대기'),('RES046','HOSP028','346687a5-6ed1-4657-a130-f21c9130c270','dhgn206','2025-01-29','09:00','성교통 성관계 중에 통증이 느껴져서 힘들어요.','대기'),('RES047','HOSP028','346687a5-6ed1-4657-a130-f21c9130c270','dhgn206','2025-01-26','09:30','임신 증상 임신 가능성이 있어서 증상이 걱정돼요.','대기'),('RES048','HOSP028','346687a5-6ed1-4657-a130-f21c9130c270','dhgn206','2025-01-30','09:00','유방 통증 유방에 통증이 느껴져서 불안해요.','대기'),('RES049','HOSP010','ee2e2f62-6609-4f90-8ce0-85042093558a','98jiyong','2025-02-04','10:00','콧물이 나오고 비염이 심해요','대기'),('RES050','HOSP017','f1fc0be2-bb8a-4521-82f6-45c195055d9b','98jiyong','2025-02-13','14:00','발목 인대가 늘어나고 오른팔 골절','대기'),('RES051','HOSP018','17c0d8bd-3d7e-4374-9385-86f29baf4058','98jiyong','2025-02-06','11:30','장염에 걸렸어요 화장실을 자주 가요','대기'),('RES052','HOSP017','a9d97d09-3a24-412d-87e5-eee702a3dc1b','98jiyong','2025-02-22','14:30','스트레스성 불안이 있고 우울증에 걸린것처럼 기분이 우울해요','대기'),('RES053','HOSP016','dc288d41-b757-4a7a-ae64-29a67e05f99e','98jiyong','2025-02-04','15:30','탈장이 있어요','대기'),('RES054','HOSP029','80f28d0b-fd56-4305-8153-a540464c632f','98jiyong','2025-02-07','11:30','눈이 건조하고 눈꼽이 자주껴요 눈이 충혈되고 다래끼가 생겼어요','대기'),('RES055','HOSP024','6720afef-cbe9-46bb-9fdf-9d67c0e4bc54','98jiyong','2025-02-04','11:30','요로결석 치료','대기'),('RES056','HOSP021','446b6fb6-9ec9-49ee-8f10-f5d3d1b8655b','98jiyong','2025-02-04','13:30','아이가 열이 안 떨어지고 기침을 계속해요 감기 증상','대기'),('RES057','HOSP006','bd66e593-6663-48e4-baea-872a29df3529','98jiyong','2025-02-14','09:00','스트레스가 너무 심해요\n','대기'),('RES058','HOSP032','2a118d12-3520-4198-96c5-e4219098cf36','dhgn206','2025-02-05','14:00','여드름 관리 하기 위해 화농성여드름 화농성 여드름','대기'),('RES059','HOSP033','f8bbf34d-e1f0-4795-b763-8fec870cf7f4','dhgn206','2025-02-15','11:00','며칠 째 설사를 계속 해요','대기'),('RES060','HOSP032','2a118d12-3520-4198-96c5-e4219098cf36','dhgn206','2025-02-14','11:00','여드름이 계속 생겨요\n여드름이 안 사라져요\n여드름 흉터 제거하고 싶어요','대기'),('RES061','HOSP033','f8bbf34d-e1f0-4795-b763-8fec870cf7f4','test','2024-01-04','14:00','코피가 자주 나고 땀을 많이 흘려요','승인'),('RES062','HOSP001','4fb63188-1578-4a0a-ae21-5a1234cb85cf','test','2024-05-15','11:00','목이 붓고 돌리기가 힘들어요 ','대기'),('RES065','HOSP008','0015b7e8-6d3a-40a9-8dca-fc5f4318a48c','test','2024-08-21','14:30','기침이 계속 나고 가래가 많이 나옵니다. 열도 조금 있는 것 같아요.','대기'),('RES066','HOSP012','452655ac-08db-4309-855a-b207591792eb','test','2024-11-11','16:00','복부가 아프고 소화가 잘 안 돼요. 특히 기름진 음식을 먹으면 더 심해집니다.','대기'),('RES067','HOSP013','3b1fbe25-7838-47aa-9eab-0f3843b4c0e8','test','2024-12-24','09:00','열이 나고 오한이 심해요. 몸이 떨리는 느낌이 듭니다.','대기'),('RES068','HOSP018','17c0d8bd-3d7e-4374-9385-86f29baf4058','test','2025-02-05','11:30','무릎과 팔꿈치가 아프고 부풀어 있어요. 특히 아침에 더 심해집니다.','대기'),('RES069','HOSP023','8eca39fd-9052-4545-8dcf-bc3785910df7','test','2025-02-01','09:00','자꾸 구역질이 나고 속이 메스꺼워요. 식사를 하면 더 심해지는 것 같습니다.','대기'),('RES070','HOSP033','f8bbf34d-e1f0-4795-b763-8fec870cf7f4','test','2025-02-19','16:00','식사 후 속이 더부룩하고 소화가 잘 안 돼요. 속쓰림도 있어요.','대기'),('RES071','HOSP001','4fb63188-1578-4a0a-ae21-5a1234cb85cf','test','2025-02-02','16:00','변을 보기가 힘들고 배가 더부룩해요. 일주일 넘게 변이 없었습니다.','대기'),('RES073','HOSP012','452655ac-08db-4309-855a-b207591792eb','test','2025-02-03','15:00','입안이 바싹바싹 마르고 땀을 많이 흘려요','대기'),('RES074','HOSP008','0015b7e8-6d3a-40a9-8dca-fc5f4318a48c','test','2025-02-05','15:00','복부가 아프고 소화가 잘 안 돼요. 밥 먹고 2~3시간이 지나도 소화가 잘 되지 않아요','대기'),('RES075','HOSP001','4fb63188-1578-4a0a-ae21-5a1234cb85cf','test','2025-02-04','14:00','최근 혈압이 자주 변동하고 어지러움이 심해요. ','대기'),('RES078','HOSP018','17c0d8bd-3d7e-4374-9385-86f29baf4058','test','2024-11-13','14:30','지방간 당뇨병 고혈압 약 받아야 해요','대기'),('RES079','HOSP033','f8bbf34d-e1f0-4795-b763-8fec870cf7f4','test','2024-12-18','11:00','가슴이 쪼이는 듯한 통증이 있고, 호흡이 좀 어렵습니다.','대기'),('RES080','HOSP023','8eca39fd-9052-4545-8dcf-bc3785910df7','test','2024-12-22','14:00','땀이 많이 나고, 특히 밤에 자는 동안 땀을 많이 흘려요.','대기'),('RES081','HOSP001','4fb63188-1578-4a0a-ae21-5a1234cb85cf','test','2024-12-02','11:30','조금만 움직여도 숨이 차고 가슴이 답답해요. 식은땀도 많이 나는 것 같아요.','대기'),('RES082','HOSP013','3b1fbe25-7838-47aa-9eab-0f3843b4c0e8','test','2025-02-04','11:00','몸이 부어오르고 전신부종이 있는것 같아요','대기'),('RES083','HOSP033','f8bbf34d-e1f0-4795-b763-8fec870cf7f4','test','2025-02-10','14:00','목 통증이 심하고 두통이 있어요. 땀도 많이 나는 것 같아요.','대기'),('RES085','HOSP011','c37b2983-c6d2-4ad8-8257-2e77f5f10d0a','test','2025-01-09','11:00','속이 안 좋고 식도가 아파요.','대기'),('RES086','HOSP016','dc288d41-b757-4a7a-ae64-29a67e05f99e','test','2025-01-29','16:00','복부에 통증이 있고, 오른쪽 아래가 특히 아파요.','대기'),('RES087','HOSP005','65ac736e-f465-418d-a87f-51cbf71d7d17','test','2025-02-05','14:00','유방에 이상이 있는거 같아요.','대기'),('RES088','HOSP005','65ac736e-f465-418d-a87f-51cbf71d7d17','test','2024-12-02','16:00','피부에 종양을 제거해야 해요.','대기'),('RES089','HOSP005','65ac736e-f465-418d-a87f-51cbf71d7d17','test','2025-01-01','09:00','치아가 아프고 잇몸이 부풀어 올랐어요.','대기'),('RES090','HOSP016','dc288d41-b757-4a7a-ae64-29a67e05f99e','test','2025-02-04','09:00','대변에 혈액이 섞여 나오고 체중이 감소했어요.','대기'),('RES091','HOSP016','dc288d41-b757-4a7a-ae64-29a67e05f99e','test','2025-02-02','09:00','항문 주위에 고름이 나고 통증이 있어요.','대기'),('RES092','HOSP016','dc288d41-b757-4a7a-ae64-29a67e05f99e','test','2025-02-07','16:00','식사 후 소화가 잘 안 되고 체중이 줄어들었어요.','대기'),('RES093','HOSP016','dc288d41-b757-4a7a-ae64-29a67e05f99e','test','2024-12-17','11:30','오른쪽 하복부에 심한 통증이 있고 구토가 있어요.','대기'),('RES094','HOSP016','dc288d41-b757-4a7a-ae64-29a67e05f99e','test','2024-12-25','14:00','복부가 팽만하고 심한 복통이 있어요. 변을 보지 못했어요.','대기'),('RES095','HOSP016','dc288d41-b757-4a7a-ae64-29a67e05f99e','test','2024-12-13','11:00','유방에 덩어리가 만져지고 피부가 변화했어요.','대기'),('RES096','HOSP016','dc288d41-b757-4a7a-ae64-29a67e05f99e','test','2024-12-03','14:00','유방에 통증이 없지만 덩어리가 있어요. 유방이 붓고 아프며 열이 나요.','대기'),('RES097','HOSP016','dc288d41-b757-4a7a-ae64-29a67e05f99e','test','2024-12-15','11:00','다리에 부풀어 오르고 통증이 느껴져요.','대기'),('RES098','HOSP016','dc288d41-b757-4a7a-ae64-29a67e05f99e','test','2024-12-01','14:30','다리에 붓고 통증이 있으며 발적이 있어요.','대기'),('RES099','HOSP016','dc288d41-b757-4a7a-ae64-29a67e05f99e','test','2024-12-29','13:00','위가 쓰리고 통증이 있어요. 특히 공복에 더 심해요.','대기'),('RES100','HOSP016','dc288d41-b757-4a7a-ae64-29a67e05f99e','test','2024-09-03','16:00','구토할 때 피가 섞여 나오고 피로감이 심해요.','대기'),('RES101','HOSP016','dc288d41-b757-4a7a-ae64-29a67e05f99e','test','2024-11-05','16:00','배변 시 통증이 심하고 출혈이 있어요.','대기'),('RES102','HOSP016','dc288d41-b757-4a7a-ae64-29a67e05f99e','test','2024-12-10','14:30','복부에 덩어리가 만져지고 황달 증상이 있어요.','대기'),('RES103','HOSP016','dc288d41-b757-4a7a-ae64-29a67e05f99e','test','2024-12-25','14:30',' 소화가 안 되고 오른쪽 상복부 통증이 있어요.','대기'),('RES104','HOSP024','56b51cc6-ebd9-400d-89a3-63dfd318db50','dhgn206','2024-12-03','16:00','거리 감각의 손상으로 물체가 멀게 느껴져요.','대기'),('RES105','HOSP024','56b51cc6-ebd9-400d-89a3-63dfd318db50','dhgn206','2024-12-04','16:30','눈부심이 심해 햇빛 아래에서 잘 보이지 않아요.','대기'),('RES106','HOSP024','56b51cc6-ebd9-400d-89a3-63dfd318db50','dhgn206','2024-11-06','11:30','후광 현상이 나타나서 불빛 주위에 빛의 고리가 보여요.','대기'),('RES107','HOSP024','56b51cc6-ebd9-400d-89a3-63dfd318db50','dhgn206','2024-11-18','11:00','야맹증이 심해 어두운 곳에서 잘 보이지 않아요.','대기'),('RES108','HOSP029','80f28d0b-fd56-4305-8153-a540464c632f','dhgn206','2025-01-05','16:30','색맹으로 빨강과 초록을 구분하기 어려워요.','대기'),('RES109','HOSP029','80f28d0b-fd56-4305-8153-a540464c632f','dhgn206','2024-12-09','16:00','광과민증으로 밝은 빛에 노출되면 눈이 아파요.','대기'),('RES110','HOSP029','80f28d0b-fd56-4305-8153-a540464c632f','dhgn206','2024-12-09','11:30','눈이 가려워서 자주 비비게 돼요.','대기'),('RES111','HOSP029','80f28d0b-fd56-4305-8153-a540464c632f','dhgn206','2024-12-08','14:30','건성안 증상으로 눈이 뻑뻑하고 불편해요.','대기'),('RES112','HOSP024','56b51cc6-ebd9-400d-89a3-63dfd318db50','dhgn206','2025-01-27','16:30','눈 외형의 변화로 눈꺼풀이 부풀어 올랐어요.','대기'),('RES113','HOSP024','56b51cc6-ebd9-400d-89a3-63dfd318db50','dhgn206','2025-02-04','16:00','시야가 흐릿해져서 글씨를 읽기 힘들어요.','대기'),('RES114','HOSP029','80f28d0b-fd56-4305-8153-a540464c632f','dhgn206','2025-02-02','16:00','눈물이 자주 나고 눈가가 붉어져요.','대기'),('RES115','HOSP029','80f28d0b-fd56-4305-8153-a540464c632f','dhgn206','2025-02-04','14:30','시력 저하로 물체가 뚜렷하게 보이지 않아요.','대기'),('RES116','HOSP024','56b51cc6-ebd9-400d-89a3-63dfd318db50','dhgn206','2025-02-04','14:30','밤에 운전할 때 시야가 어두워져서 위험해요.','대기'),('RES117','HOSP029','80f28d0b-fd56-4305-8153-a540464c632f','dhgn206','2025-02-04','16:30','눈 주위에 붓기가 생겨서 불편해요.','대기'),('RES118','HOSP024','56b51cc6-ebd9-400d-89a3-63dfd318db50','dhgn206','2025-03-01','11:00','시야에 점이나 번쩍이는 것이 보여서 신경이 쓰여요.','대기'),('RES119','HOSP024','56b51cc6-ebd9-400d-89a3-63dfd318db50','dhgn206','2025-02-04','16:30','라식 하고 싶어요.','대기'),('RES120','HOSP029','80f28d0b-fd56-4305-8153-a540464c632f','dhgn206','2025-02-04','16:00','스마일 라식 하고 싶어요.','대기'),('RES121','HOSP029','80f28d0b-fd56-4305-8153-a540464c632f','dhgn206','2025-02-04','14:00','눈에 검은 점이 떠다니거나 벌레가 날아다니는거 같아요.','대기'),('RES122','HOSP029','80f28d0b-fd56-4305-8153-a540464c632f','dhgn206','2025-02-04','11:30','눈에 다래끼가 생긴거 같아요 그리고 눈이 자꾸 부어요 붓기가 잘 안빠져요','대기'),('RES123','HOSP015','599ac6c4-3a99-41d9-87fb-1c57c6ffe72a','dhgn206','2025-01-27','09:00','유방의 변화 유방의 모양이나 크기가 변해서 걱정이에요.','대기'),('RES124','HOSP015','599ac6c4-3a99-41d9-87fb-1c57c6ffe72a','dhgn206','2025-01-29','09:00','배뇨통 소변을 볼 때 통증이 느껴져서 힘들어요.','대기'),('RES125','HOSP028','346687a5-6ed1-4657-a130-f21c9130c270','dhgn206','2025-01-27','09:30','복통 하복부에 지속적인 통증이 있어요.','대기'),('RES126','HOSP015','599ac6c4-3a99-41d9-87fb-1c57c6ffe72a','dhgn206','2025-01-30','11:00','불임 문제 임신이 잘 되지 않아서 고민이에요.','대기'),('RES127','HOSP028','346687a5-6ed1-4657-a130-f21c9130c270','dhgn206','2025-01-26','10:00','피임 방법 상담 어떤 피임 방법이 좋을지 상담받고 싶어요.','대기'),('RES128','HOSP015','599ac6c4-3a99-41d9-87fb-1c57c6ffe72a','dhgn206','2025-02-06','09:00','자궁 출혈 생리 외에 출혈이 있어 걱정이에요.','대기'),('RES129','HOSP028','346687a5-6ed1-4657-a130-f21c9130c270','dhgn206','2025-01-28','09:30','호르몬 변화 최근에 기분 변화가 심해져서 불안해요.','대기'),('RES130','HOSP015','599ac6c4-3a99-41d9-87fb-1c57c6ffe72a','dhgn206','2025-01-30','11:30','임신 중 증상 임신 중에 이상 증상이 나타나서 걱정이에요.','대기'),('RES131','HOSP028','346687a5-6ed1-4657-a130-f21c9130c270','dhgn206','2025-01-26','10:30','산후 우울증 출산 후 기분이 우울해져서 힘들어요.','대기'),('RES132','HOSP015','599ac6c4-3a99-41d9-87fb-1c57c6ffe72a','dhgn206','2025-02-01','09:00','자궁경부 이상 자궁경부에 이상이 생겨서 걱정이에요.','대기'),('RES133','HOSP015','599ac6c4-3a99-41d9-87fb-1c57c6ffe72a','dhgn206','2024-12-29','11:00','난소 통증 난소 쪽에 통증이 느껴져서 불안해요.','대기'),('RES134','HOSP028','346687a5-6ed1-4657-a130-f21c9130c270','dhgn206','2025-01-28','10:00','생리 전 증후군 생리 전에 기분이 너무 나빠져서 힘들어요.','대기'),('RES135','HOSP015','599ac6c4-3a99-41d9-87fb-1c57c6ffe72a','dhgn206','2025-01-26','09:30','성병 증상 성관계 후에 이상한 증상이 나타나서 불안해요.','대기'),('RES136','HOSP019','8a88934e-9864-478a-97e5-015c55bc6f13','dhgn206','2025-01-26','09:00','코 모양 불만 코가 너무 크거나 모양이 마음에 들지 않아요.','대기'),('RES137','HOSP019','8a88934e-9864-478a-97e5-015c55bc6f13','dhgn206','2024-11-03','09:00','눈꺼풀 처짐 눈꺼풀이 처져서 피곤해 보인다는 말을 들어요.','대기'),('RES138','HOSP019','8a88934e-9864-478a-97e5-015c55bc6f13','dhgn206','2024-10-29','09:00','주름 얼굴에 주름이 생겨서 나이가 들어 보이는 것 같아요.','대기'),('RES139','HOSP027','84b3e93e-4a97-453f-9a13-8bafc5ab1067','dhgn206','2025-01-26','09:00','볼륨 부족 볼이나 입술에 볼륨이 부족해서 고민이에요.','대기'),('RES140','HOSP027','84b3e93e-4a97-453f-9a13-8bafc5ab1067','dhgn206','2024-12-01','09:00','턱선 불만 턱선이 뚜렷하지 않아서 얼굴이 둥글어 보이는 것 같아요.','대기'),('RES141','HOSP019','8a88934e-9864-478a-97e5-015c55bc6f13','dhgn206','2024-10-09','09:00','피부 탄력 저하 피부가 처지고 탄력이 없어져서 고민이에요.','대기'),('RES142','HOSP032','3cd720c1-f855-411c-8e81-abf95962e04d','dhgn206','2024-12-03','09:00','흉터 과거의 흉터가 신경 쓰여서 제거하고 싶어요.','대기'),('RES143','HOSP019','8a88934e-9864-478a-97e5-015c55bc6f13','dhgn206','2024-12-02','09:00','비대칭 얼굴이 비대칭이라서 교정하고 싶어요.','대기'),('RES144','HOSP027','84b3e93e-4a97-453f-9a13-8bafc5ab1067','dhgn206','2025-01-26','09:30','체중 변화 체중 변화로 인해 몸매가 망가져서 성형을 고려하고 있어요.\n','대기'),('RES145','HOSP027','84b3e93e-4a97-453f-9a13-8bafc5ab1067','dhgn206','2024-12-13','09:30','가슴 크기 불만 가슴이 너무 작아서 자신감이 떨어져요.','대기'),('RES146','HOSP019','8a88934e-9864-478a-97e5-015c55bc6f13','dhgn206','2024-12-04','16:00','지방 제거 특정 부위의 지방이 신경 쓰여서 제거하고 싶어요.','대기'),('RES147','HOSP027','84b3e93e-4a97-453f-9a13-8bafc5ab1067','dhgn206','2025-01-27','10:00','피부 톤 불균형 피부 톤이 고르지 않아서 고민이에요.','대기'),('RES148','HOSP019','8a88934e-9864-478a-97e5-015c55bc6f13','dhgn206','2024-12-12','09:00','이마 주름 이마에 깊은 주름이 생겨서 고민이에요.','대기'),('RES149','HOSP019','8a88934e-9864-478a-97e5-015c55bc6f13','dhgn206','2024-12-01','09:00','코끝 교정 코끝이 처져서 교정하고 싶어요.','대기'),('RES150','HOSP019','8a88934e-9864-478a-97e5-015c55bc6f13','dhgn206','2024-12-29','09:00','눈매 교정 눈매가 작아서 더 크게 보이게 하고 싶어요.','대기'),('RES151','HOSP027','84b3e93e-4a97-453f-9a13-8bafc5ab1067','dhgn206','2025-01-28','09:00','턱 보형물 턱을 더 뚜렷하게 만들고 싶어서 보형물을 고려하고 있어요.','대기'),('RES152','HOSP019','8a88934e-9864-478a-97e5-015c55bc6f13','dhgn206','2025-01-26','09:30','리프팅 얼굴 리프팅을 통해 젊어 보이고 싶어요.','대기'),('RES153','HOSP019','8a88934e-9864-478a-97e5-015c55bc6f13','dhgn206','2024-12-29','09:30','피부 재생 피부 재생 치료를 통해 건강한 피부를 원해요.','대기'),('RES154','HOSP032','3cd720c1-f855-411c-8e81-abf95962e04d','dhgn206','2024-12-29','09:30','주사 시술 필러나 보톡스를 통해 주름을 없애고 싶어요.','대기'),('RES155','HOSP027','84b3e93e-4a97-453f-9a13-8bafc5ab1067','dhgn206','2025-02-01','09:00','성형 후 관리 성형 수술 후 관리 방법에 대해 알고 싶어요.','대기'),('RES156','HOSP005','10c2f661-deb4-409f-9cc9-5dd9ff55abd9','dhgn206','2024-12-29','14:00','관절 통증 무릎이나 엉덩이 관절이 아파서 걷기 힘들어요.','대기'),('RES158','HOSP015','69a2f3d4-6c31-4924-83bb-21b9b6adee3e','dhgn206','2025-01-28','11:00','팔꿈치 통증 팔꿈치가 아파서 팔을 움직이기 힘들어요.','대기'),('RES161','HOSP005','10c2f661-deb4-409f-9cc9-5dd9ff55abd9','dhgn206','2024-12-01','11:00','발목 염좌 발목을 삐어서 부풀고 아파요.','대기'),('RES162','HOSP015','69a2f3d4-6c31-4924-83bb-21b9b6adee3e','dhgn206','2024-12-29','14:00','골절 넘어져서 뼈가 부러졌어요.','대기'),('RES163','HOSP005','10c2f661-deb4-409f-9cc9-5dd9ff55abd9','dhgn206','2025-01-26','11:30','퇴행성 관절염 관절이 점점 아프고 움직이기 힘들어요.','대기'),('RES164','HOSP005','10c2f661-deb4-409f-9cc9-5dd9ff55abd9','dhgn206','2024-12-01','11:30','척추 측만증 척추가 휘어서 자세가 안 좋아요.','대기'),('RES165','HOSP005','10c2f661-deb4-409f-9cc9-5dd9ff55abd9','dhgn206','2024-09-01','13:00','근육 경련 운동 후에 근육이 경련을 일으켜요.','대기'),('RES167','HOSP005','10c2f661-deb4-409f-9cc9-5dd9ff55abd9','test','2024-12-29','10:00','손가락이 부러졌어요 손가락 골절 골절됐어요','대기'),('RES168','HOSP005','10c2f661-deb4-409f-9cc9-5dd9ff55abd9','test','2024-02-01','11:00','스포츠 부상 운동 중에 부상을 당했어요.','대기'),('RES169','HOSP015','69a2f3d4-6c31-4924-83bb-21b9b6adee3e','test','2025-02-01','10:00','발목이 삐었어요 발목이 금이 갔어요 발목 골절 발목 부러졌어요 발목 골절됐어요','대기'),('RES170','HOSP017','f1fc0be2-bb8a-4521-82f6-45c195055d9b','test','2025-01-26','09:00','골다공증 골다공증으로 인해 뼈가 약해졌어요.','대기'),('RES171','HOSP029','22648f52-ef24-430c-a7a7-f14991943be8','test','2024-12-01','11:00','무릎 연골 손상 무릎이 아프고 소리가 나요. ','대기'),('RES173','HOSP017','f1fc0be2-bb8a-4521-82f6-45c195055d9b','test','2024-12-29','10:00','관절염 관절이 붓고 아파서 움직이기 힘들어요.','대기'),('RES174','HOSP029','22648f52-ef24-430c-a7a7-f14991943be8','test','2025-01-26','10:00','팔이 부러졌어요 팔에 금이 갔어요 팔 골절 팔이 골절됐어요.','대기'),('RES175','HOSP010','ee2e2f62-6609-4f90-8ce0-85042093558a','test','2024-12-01','09:00','목이 따끔거리고 콧물이 나와요. 감기 콧물 ','대기'),('RES176','HOSP010','ee2e2f62-6609-4f90-8ce0-85042093558a','test','2025-01-26','09:00','귀가 아프고 소리가 잘 들리지 않아요.','대기'),('RES177','HOSP010','ee2e2f62-6609-4f90-8ce0-85042093558a','test','2025-01-26','09:30','귀에서 분비물이 나와서 불편해요.','대기'),('RES178','HOSP010','ee2e2f62-6609-4f90-8ce0-85042093558a','test','2025-01-26','10:00','목이 아프고 열이 나요. 감기 콧물 비염 알레르기 ','대기'),('RES179','HOSP010','ee2e2f62-6609-4f90-8ce0-85042093558a','test','2025-01-26','10:30','편도선이 부풀어 오르고 삼키기 힘들어요. 감기 콧물 비염 알레르기 ','대기'),('RES180','HOSP010','ee2e2f62-6609-4f90-8ce0-85042093558a','test','2025-01-26','11:00','목이 간지럽고 기침이 나요. 감기 콧물 가래 기침 ','대기'),('RES181','HOSP010','ee2e2f62-6609-4f90-8ce0-85042093558a','test','2025-01-26','11:30','귀에서 물이 들어간 것 같은 느낌이 들어요. 기침 가래 콧물 비염 ','대기'),('RES182','HOSP010','ee2e2f62-6609-4f90-8ce0-85042093558a','test','2025-01-26','13:00','알레르기 때문에 눈이 가렵고 부어요. 기침 가래 콧물 비염 알레르기 ','대기'),('RES183','HOSP010','ee2e2f62-6609-4f90-8ce0-85042093558a','test','2025-01-26','13:30','코에서 피가 나와서 걱정이에요. 기침 가래 콧물 아레르기 비염 코피 ','대기'),('RES184','HOSP010','ee2e2f62-6609-4f90-8ce0-85042093558a','test','2024-12-29','13:00','음식을 삼키기가 힘들고 목이 아파요. 물을 삼키기가 힘들어요 .','대기'),('RES185','HOSP027','9de45ace-7612-493f-9506-420998401aeb','test','2025-01-26','14:00','귀에서 윙윙거리는 소리가 들려요. 환청 귀 삐 소리 ','대기'),('RES186','HOSP027','9de45ace-7612-493f-9506-420998401aeb','test','2025-01-26','14:30','기침이 계속 나고 가슴이 답답해요. 기침 가래 콧물 비염 알레르기 ','대기'),('RES187','HOSP027','9de45ace-7612-493f-9506-420998401aeb','test','2025-01-26','15:00','목소리가 쉰 듯하고 목이 아파요. 목이 쉰거 같아요 목소리가 안나와요 목소리 ','대기'),('RES188','HOSP027','9de45ace-7612-493f-9506-420998401aeb','test','2025-01-26','15:30','재채기가 자주 나고 코가 간지러워요. 재채기 코 콧물 가래 기침 알레르기 알러지 비염 꽃 꽃가루 ','대기'),('RES189','HOSP027','9de45ace-7612-493f-9506-420998401aeb','test','2025-01-26','16:00','코가 막혀서 숨쉬기가 힘들어요. 열이 심해요 열 체온 온도 비염 알레르기 콧물 가래 기침 ','대기'),('RES190','HOSP010','ee2e2f62-6609-4f90-8ce0-85042093558a','test','2025-01-26','16:00','기침이 계속 나오고 가래가 있어요 콧물도 나와요. ','대기'),('RES191','HOSP027','9de45ace-7612-493f-9506-420998401aeb','test','2025-01-26','16:30','꽃가루 알레르기 때문에 비염이 심해진거같아요. 비염 알러지 콧물 가래 기침','대기'),('RES192','HOSP010','ee2e2f62-6609-4f90-8ce0-85042093558a','test','2025-01-26','16:30','열이 안내려가고 기침이 많이 나와요 목이 아파요. 목 코 가래 기침 ','대기'),('RES193','HOSP027','9de45ace-7612-493f-9506-420998401aeb','test','2025-01-26','17:00','코가 헐어서 코피가 자주나요 그리고 기침 가래가 생겨요 . 기침 가래 콧물 알레르기 비염 ','대기'),('RES194','HOSP002','4a30eb8b-effe-462c-89be-785d440dbfff','test','2025-02-01','09:00','아이가 열이 나고 기운이 없어요.','승인'),('RES195','HOSP004','44ea9a4d-9424-4b39-8985-1368904decc3','test','2025-02-01','10:00','아이가 배가 아프다고 해서 자꾸 울어요.','대기'),('RES196','HOSP002','4a30eb8b-effe-462c-89be-785d440dbfff','test','2025-02-01','09:30','아이가 기침이 심하고 가래가 나와요.','승인'),('RES197','HOSP002','4a30eb8b-effe-462c-89be-785d440dbfff','test','2025-02-01','10:00','아이가 피부에 발진이 생겼어요.','대기'),('RES198','HOSP002','4a30eb8b-effe-462c-89be-785d440dbfff','test','2025-02-01','10:30','아이가 귀가 아프다고 해서 자꾸 만져요.','대기'),('RES199','HOSP002','4a30eb8b-effe-462c-89be-785d440dbfff','test','2025-02-01','11:00','아이가 목이 아프고 삼키기 힘들어해요.','대기'),('RES200','HOSP002','4a30eb8b-effe-462c-89be-785d440dbfff','test','2025-02-01','11:30','아이가 소변을 자주 보고 배뇨 시 아파해요.','대기'),('RES201','HOSP002','4a30eb8b-effe-462c-89be-785d440dbfff','test','2025-02-01','13:00','아이가 식욕이 없고 체중이 줄어들고 있어요.','대기'),('RES202','HOSP002','4a30eb8b-effe-462c-89be-785d440dbfff','test','2025-02-01','13:30','아이가 잠을 잘 자지 못하고 자주 깨요.','대기'),('RES203','HOSP002','4a30eb8b-effe-462c-89be-785d440dbfff','test','2025-02-01','14:00','아이가 눈이 가렵고 충혈되어 있어요.','대기'),('RES204','HOSP002','4a30eb8b-effe-462c-89be-785d440dbfff','test','2025-02-01','14:30','아이가 기분이 우울하고 무기력해 보여요.','대기'),('RES205','HOSP002','4a30eb8b-effe-462c-89be-785d440dbfff','test','2025-02-01','15:00','아이가 다리가 아프다고 해서 걷기 힘들어해요.','대기'),('RES206','HOSP002','4a30eb8b-effe-462c-89be-785d440dbfff','test','2025-02-01','15:30','아이가 코가 막혀서 숨쉬기가 힘들어해요.','대기'),('RES207','HOSP002','4a30eb8b-effe-462c-89be-785d440dbfff','test','2025-02-01','16:00','아이가 구토를 하고 배가 불편하다고 해요.','대기'),('RES208','HOSP002','4a30eb8b-effe-462c-89be-785d440dbfff','test','2025-02-01','16:30','아이가 손이나 발이 저리고 감각이 이상해요.','대기'),('RES209','HOSP002','4a30eb8b-effe-462c-89be-785d440dbfff','test','2025-02-01','17:00','아이가 학습에 어려움을 겪고 집중을 못해요.','대기'),('RES210','HOSP002','4a30eb8b-effe-462c-89be-785d440dbfff','test','2025-02-01','17:30','아이가 이가 아프다고 해서 음식을 잘 못 먹어요.','대기'),('RES211','HOSP002','4a30eb8b-effe-462c-89be-785d440dbfff','test','2025-02-02','14:30','아이가 피곤해하고 쉽게 지쳐해요.','대기'),('RES212','HOSP004','44ea9a4d-9424-4b39-8985-1368904decc3','test','2025-02-01','16:00','아이가 목소리가 쉰 듯하고 기침이 나요.','대기'),('RES213','HOSP004','44ea9a4d-9424-4b39-8985-1368904decc3','test','2025-02-01','14:30','아이가 어지럽다고 해서 자꾸 누워있으려 해요.','대기'),('RES214','HOSP006','661ca1ef-61cc-4a09-bfff-029833c6065a','dhgn206','2025-02-01','09:00','우울감 최근에 아무것도 하고 싶지 않고, 하루 종일 우울한 기분이 들어요.','대기'),('RES215','HOSP006','661ca1ef-61cc-4a09-bfff-029833c6065a','dhgn206','2025-02-01','09:30','불안감 사소한 일에도 불안해지고, 심장이 두근거려서 일상생활이 힘들어요.','대기'),('RES216','HOSP006','661ca1ef-61cc-4a09-bfff-029833c6065a','dhgn206','2025-02-01','10:00','공황 발작 갑자기 숨이 막히고, 가슴이 답답해지면서 죽을 것 같은 느낌이 들어요.','대기'),('RES217','HOSP006','661ca1ef-61cc-4a09-bfff-029833c6065a','dhgn206','2025-02-01','10:30','강박 증상 손을 씻지 않으면 불안해져서 하루에 여러 번 씻어야 해요.','대기'),('RES218','HOSP006','661ca1ef-61cc-4a09-bfff-029833c6065a','dhgn206','2025-02-01','11:00','수면 장애 밤에 잠이 오지 않아서 새벽까지 뒤척이다가 결국 잠을 못 자요.','대기'),('RES219','HOSP006','661ca1ef-61cc-4a09-bfff-029833c6065a','dhgn206','2025-02-01','11:30','식욕 변화 스트레스를 받아서 식사를 거르거나, 반대로 과식하게 돼요.','대기'),('RES220','HOSP006','661ca1ef-61cc-4a09-bfff-029833c6065a','dhgn206','2025-02-01','13:00','집중력 저하 일이나 공부를 할 때 집중이 잘 안 되고, 자꾸 딴 생각이 나요.','대기'),('RES221','HOSP006','661ca1ef-61cc-4a09-bfff-029833c6065a','dhgn206','2025-02-01','13:30','피로감 아무것도 하지 않았는데도 항상 피곤하고, 에너지가 없어요.','대기'),('RES222','HOSP006','661ca1ef-61cc-4a09-bfff-029833c6065a','dhgn206','2025-02-01','14:00','사회적 회피 친구들과의 모임이 부담스러워서 자꾸 피하게 돼요.','대기'),('RES223','HOSP006','661ca1ef-61cc-4a09-bfff-029833c6065a','dhgn206','2025-02-01','14:30','자살 생각 이런 고통에서 벗어나고 싶어서 가끔 자살에 대한 생각이 들어요.','대기'),('RES224','HOSP006','661ca1ef-61cc-4a09-bfff-029833c6065a','dhgn206','2025-02-01','15:00','감정 기복 하루에도 기분이 수시로 바뀌어서, 나 자신도 혼란스러워요.','대기'),('RES225','HOSP006','661ca1ef-61cc-4a09-bfff-029833c6065a','dhgn206','2025-02-01','15:30','자아 존중감 저하 자신이 무가치하다고 느껴지고, 다른 사람들과 비교할 때 항상 열등감을 느껴요. 우울하고 스트레스가 심해요 스트레스 우울증 우울함 우울감','대기'),('RES226','HOSP006','661ca1ef-61cc-4a09-bfff-029833c6065a','dhgn206','2025-02-01','16:00','환각 혼자 있을 때 누군가 내 이름을 부르는 소리를 듣거나, 그림자가 움직이는 것 같아요.\n환각 환청 귀신 ','대기'),('RES227','HOSP006','661ca1ef-61cc-4a09-bfff-029833c6065a','dhgn206','2025-02-01','16:30','망상 내가 누군가에게 감시당하고 있다는 생각이 자꾸 들어서 불안해요.','대기'),('RES228','HOSP006','661ca1ef-61cc-4a09-bfff-029833c6065a','dhgn206','2025-02-01','17:00','스트레스 반응 일이 많아지면 과도한 긴장감과 불안으로 인해 몸이 굳어버려요.','대기'),('RES229','HOSP006','661ca1ef-61cc-4a09-bfff-029833c6065a','dhgn206','2025-02-01','17:30','스트레스가 너무 심하고 스트레스로 인해 머리가 빠지고 힘들어요 우울해요. ','대기'),('RES230','HOSP006','661ca1ef-61cc-4a09-bfff-029833c6065a','dhgn206','2025-02-02','09:00','화를 참을 수 없어요. 분노가 가득해요 스트레스로 인해 분노가 심해져요. 스트레스 분노 우울 우울함 ','대기'),('RES231','HOSP006','661ca1ef-61cc-4a09-bfff-029833c6065a','dhgn206','2025-02-02','09:30','의욕 상실 예전에는 좋아하던 취미도 이제는 전혀 하고 싶지 않아요.','대기'),('RES232','HOSP006','661ca1ef-61cc-4a09-bfff-029833c6065a','dhgn206','2025-02-02','10:00','신체적 증상 스트레스를 받으면 두통이 자주 생기고, 소화도 잘 안 돼요.','대기'),('RES233','HOSP006','661ca1ef-61cc-4a09-bfff-029833c6065a','dhgn206','2025-02-02','10:30','대인 관계 문제 사소한 일로 친구와 갈등이 생기고, 점점 소외감을 느끼고 있어요.','대기'),('RES234','HOSP016','35a4ed47-92d0-412b-ac37-e5fe1634ba15','test','2025-02-01','09:00','피부 아토피 및 습진 있어요.','대기'),('RES235','HOSP028','346687a5-6ed1-4657-a130-f21c9130c270','test','2025-02-01','09:00','임신 초기인데 입덧이 심해요.','대기'),('RES236','HOSP017','a9d97d09-3a24-412d-87e5-eee702a3dc1b','test','2025-02-01','09:00','스트레스가 심하고 자주 우울한 기분이 들어요.','대기'),('RES237','HOSP018','17c0d8bd-3d7e-4374-9385-86f29baf4058','test','2025-02-01','09:00','배에서 계속 소리가 나고 화장실을 자주 가요.','대기'),('RES238','HOSP016','35a4ed47-92d0-412b-ac37-e5fe1634ba15','test','2025-02-08','11:00','피부 발진이 생겨요.','대기'),('RES239','HOSP019','29629872-cf59-42f3-b180-ea78d21c3db7','test','2025-01-25','09:00','복부가 빵빵하고 황달이 생겨요.','대기'),('RES240','HOSP033','f99010d5-cee5-4f45-ade6-59534add53bb','test','2025-02-01','09:00','오줌 쌀 때 찌릿찌릿 아파요.','대기'),('RES241','HOSP027','9de45ace-7612-493f-9506-420998401aeb','test','2025-02-14','09:00','기침 가래 콧물이 생겨요.','대기'),('RES242','HOSP017','a9d97d09-3a24-412d-87e5-eee702a3dc1b','test','2025-02-01','09:30','스트레스가 심해서 자꾸 먹는걸로 스트레스를 풀어요.','대기'),('RES243','HOSP024','56b51cc6-ebd9-400d-89a3-63dfd318db50','test','2025-02-01','09:00','바람을 맞으면 눈에서 눈물이 나요.','대기');
/*!40000 ALTER TABLE `reservation` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `review`
--

DROP TABLE IF EXISTS `review`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `review` (
  `review_sequence` int(11) NOT NULL AUTO_INCREMENT,
  `review_user_id` varchar(12) DEFAULT NULL,
  `review_hospital_code` varchar(12) DEFAULT NULL,
  `review_content` varchar(1000) DEFAULT NULL,
  `review_date` timestamp NULL DEFAULT sysdate(),
  `review_score` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`review_sequence`),
  KEY `fk_review_user_id` (`review_user_id`),
  KEY `fk_review_hospital_code` (`review_hospital_code`),
  CONSTRAINT `fk_review_hospital_code` FOREIGN KEY (`review_hospital_code`) REFERENCES `hospital` (`hospital_code`),
  CONSTRAINT `fk_review_user_id` FOREIGN KEY (`review_user_id`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1284 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `review`
--

LOCK TABLES `review` WRITE;
/*!40000 ALTER TABLE `review` DISABLE KEYS */;
INSERT INTO `review` VALUES (1,'kikiki','HOSP031','시설이 낡았습니다.','2024-12-07 22:00:00','5'),(2,'taekyun','HOSP001','감기걸려서 방문했는데 너무 친절하게 진료해주셨어요','2024-12-06 01:23:18','10'),(3,'angry','HOSP001','굿','2024-12-06 01:29:31','9'),(4,'kikiki','HOSP001','사람많아서 너무 오래 걸렸어요','2024-12-06 01:29:31','7'),(5,'silversoo','HOSP001','나름 괜찮았어요','2024-12-06 01:29:32','8'),(6,'gkgjfj','HOSP001','별로에요','2024-12-06 01:29:33','5'),(7,'silversoo','HOSP001','그냥 그래요','2024-12-06 01:29:33','6'),(8,'test','HOSP001','진료 받았는데 감기가 안나아요','2024-12-06 01:29:34','3'),(9,'taekyun','HOSP001','감기걸려서 방문했는데 너무 친절하게 진료해주셨어요','2024-12-11 06:46:18','10'),(10,'gkgjfj','HOSP001','병원이 청결해요','2024-12-06 01:23:18','7'),(11,'gkgjfj','HOSP002','병원이 청결해요','2024-12-06 01:23:18','7'),(12,'gkgjfj','HOSP003','병원이 청결해요','2024-12-06 01:23:18','7'),(13,'gkgjfj','HOSP004','병원이 청결해요','2024-12-06 01:23:18','7'),(14,'gkgjfj','HOSP005','병원이 청결해요','2024-12-06 01:23:18','7'),(15,'gkgjfj','HOSP006','병원이 청결해요','2024-12-06 01:23:18','7'),(16,'gkgjfj','HOSP007','병원이 청결해요','2024-12-06 01:23:18','7'),(17,'gkgjfj','HOSP008','병원이 청결해요','2024-12-06 01:23:18','7'),(18,'gkgjfj','HOSP009','병원이 청결해요','2024-12-06 01:23:18','7'),(19,'gkgjfj','HOSP010','병원이 청결해요','2024-12-06 01:23:18','7'),(20,'gkgjfj','HOSP011','병원이 청결해요','2024-12-06 01:23:18','7'),(21,'gkgjfj','HOSP012','병원이 청결해요','2024-12-06 01:23:18','7'),(22,'gkgjfj','HOSP013','병원이 청결해요','2024-12-06 01:23:18','7'),(23,'gkgjfj','HOSP015','병원이 청결해요','2024-12-06 01:23:18','7'),(24,'angry','HOSP016','병원이 청결해요','2024-12-06 01:23:18','7'),(25,'angry','HOSP017','병원이 청결해요','2024-12-06 01:23:18','7'),(26,'angry','HOSP018','병원이 청결해요','2024-12-06 01:23:18','7'),(27,'angry','HOSP019','병원이 청결해요','2024-12-06 01:23:18','7'),(28,'angry','HOSP021','병원이 청결해요','2024-12-06 01:23:18','7'),(29,'angry','HOSP023','병원이 청결해요','2024-12-06 01:23:18','7'),(30,'angry','HOSP024','병원이 청결해요','2024-12-06 01:23:18','7'),(31,'angry','HOSP025','병원이 청결해요','2024-12-06 01:23:18','7'),(32,'angry','HOSP026','병원이 청결해요','2024-12-06 01:23:18','7'),(33,'angry','HOSP027','병원이 청결해요','2024-12-06 01:23:18','7'),(34,'angry','HOSP028','병원이 청결해요','2024-12-06 01:23:18','7'),(35,'angry','HOSP029','병원이 청결해요','2024-12-06 01:23:18','7'),(36,'angry','HOSP031','병원이 청결해요','2024-12-06 01:23:18','7'),(37,'angry','HOSP032','병원이 청결해요','2024-12-06 01:23:18','7'),(38,'98jiyong','HOSP033','병원이 청결해요','2024-12-06 01:23:18','7'),(39,'admin','HOSP029','대기 시간이 짧습니다.','2024-12-02 19:00:00','10'),(40,'wjdekq1','HOSP002','대기 시간이 짧습니다.','2024-12-04 23:00:00','10'),(41,'ehdtndnjs1','HOSP008','예약 시스템이 불편합니다.','2024-12-07 22:00:00','3'),(42,'silversoo','HOSP003','대기 시간이 너무 깁니다.','2024-12-01 09:00:00','2'),(43,'98jiyong','HOSP023','시설이 잘 갖춰져 있습니다.','2024-12-05 13:00:00','10'),(44,'yunyul','HOSP002','대기 시간이 너무 깁니다.','2024-12-01 16:00:00','5'),(45,'khgwonjae','HOSP006','대기 시간이 너무 깁니다.','2024-12-02 18:00:00','5'),(46,'jojungon','HOSP028','시설이 잘 갖춰져 있습니다.','2024-11-30 15:00:00','9'),(47,'jojungon','HOSP015','대기 시간이 너무 깁니다.','2024-12-07 21:00:00','2'),(48,'qortjd1','HOSP027','대기 시간이 짧습니다.','2024-12-02 19:00:00','8'),(49,'wjdekq1','HOSP006','진료 설명이 상세합니다.','2024-12-01 18:00:00','10'),(50,'test','HOSP002','직원이 불친절했습니다.','2024-12-01 19:00:00','3'),(51,'wjdekq1','HOSP028','대기 시간이 너무 깁니다.','2024-12-03 19:00:00','5'),(52,'khgwonjae','HOSP001','직원이 불친절했습니다.','2024-12-03 00:00:00','1'),(53,'yunyul','HOSP021','병원이 매우 청결합니다.','2024-12-05 00:00:00','10'),(54,'test','HOSP004','진료 설명이 상세합니다.','2024-12-05 07:00:00','9'),(55,'yunyul','HOSP008','예약 시스템이 불편합니다.','2024-12-04 14:00:00','1'),(56,'kikiki','HOSP004','시설이 낡았습니다.','2024-12-03 04:00:00','5'),(57,'ehdtndnjs1','HOSP027','대기 시간이 너무 깁니다.','2024-12-01 10:00:00','4'),(58,'wjdekq1','HOSP029','예약 시스템이 불편합니다.','2024-12-06 23:00:00','4'),(59,'silversoo','HOSP017','진료 설명이 상세합니다.','2024-12-05 17:00:00','8'),(60,'rlacks1','HOSP015','직원이 불친절했습니다.','2024-12-02 12:00:00','4'),(61,'kikiki','HOSP032','병원이 청결하지 않았습니다.','2024-12-07 01:00:00','5'),(62,'ehdtndnjs1','HOSP028','직원이 불친절했습니다.','2024-12-04 03:00:00','5'),(63,'test','HOSP023','예약 시스템이 불편합니다.','2024-12-04 14:00:00','5'),(64,'98jiyong','HOSP024','병원이 청결하지 않았습니다.','2024-12-07 12:00:00','2'),(65,'test','HOSP016','의사 선생님이 친절합니다.','2024-12-07 13:00:00','9'),(66,'rlacks1','HOSP007','의사 선생님이 친절합니다.','2024-12-04 00:00:00','9'),(67,'admin','HOSP003','병원이 매우 청결합니다.','2024-12-05 05:00:00','10'),(68,'taekyun','HOSP007','시설이 잘 갖춰져 있습니다.','2024-12-06 03:00:00','9'),(69,'kikiki','HOSP012','병원이 매우 청결합니다.','2024-12-06 10:00:00','10'),(70,'yunyul','HOSP011','진료 설명이 부족했습니다.','2024-12-04 01:00:00','3'),(71,'kikiki','HOSP031','직원이 불친절했습니다.','2024-11-30 22:00:00','1'),(72,'silversoo','HOSP019','병원이 매우 청결합니다.','2024-12-04 04:00:00','8'),(73,'silversoo','HOSP021','진료 설명이 부족했습니다.','2024-12-07 16:00:00','3'),(74,'silversoo','HOSP007','진료 설명이 부족했습니다.','2024-12-07 19:00:00','1'),(75,'98jiyong','HOSP005','진료 설명이 부족했습니다.','2024-12-06 10:00:00','1'),(76,'taekyun','HOSP024','대기 시간이 너무 깁니다.','2024-12-02 00:00:00','3'),(77,'kikiki','HOSP009','시설이 잘 갖춰져 있습니다.','2024-12-04 04:00:00','10'),(78,'ehdtndnjs1','HOSP009','병원이 청결하지 않았습니다.','2024-12-07 04:00:00','5'),(79,'ehdtndnjs1','HOSP032','대기 시간이 짧습니다.','2024-12-01 16:00:00','9'),(80,'taekyun','HOSP012','진료 설명이 상세합니다.','2024-12-08 22:00:00','8'),(81,'admin','HOSP011','대기 시간이 너무 깁니다.','2024-12-02 16:00:00','4'),(82,'taekyun','HOSP024','시설이 낡았습니다.','2024-12-02 10:00:00','4'),(83,'qortjd1','HOSP008','병원이 청결하지 않았습니다.','2024-12-06 23:00:00','3'),(84,'yunyul','HOSP023','시설이 낡았습니다.','2024-12-05 04:00:00','4'),(85,'98jiyong','HOSP019','진료 설명이 상세합니다.','2024-12-09 00:00:00','10'),(86,'qortjd1','HOSP007','의사 선생님이 친절합니다.','2024-12-09 04:00:00','8'),(87,'taekyun','HOSP029','대기 시간이 너무 깁니다.','2024-12-08 05:00:00','3'),(88,'silversoo','HOSP011','의사 선생님이 친절합니다.','2024-12-05 18:00:00','9'),(89,'qortjd1','HOSP002','의사 선생님이 친절합니다.','2024-12-05 19:00:00','8'),(90,'wjdekq1','HOSP024','병원이 매우 청결합니다.','2024-12-08 03:00:00','10'),(91,'98jiyong','HOSP027','시설이 잘 갖춰져 있습니다.','2024-12-07 22:00:00','9'),(92,'silversoo','HOSP018','병원이 청결하지 않았습니다.','2024-11-30 15:00:00','1'),(93,'kikiki','HOSP016','병원이 매우 청결합니다.','2024-12-08 09:00:00','10'),(94,'test','HOSP008','진료 설명이 상세합니다.','2024-12-03 15:00:00','8'),(95,'qortjd1','HOSP032','직원이 불친절했습니다.','2024-12-01 09:00:00','1'),(96,'qortjd1','HOSP001','병원이 매우 청결합니다.','2024-12-04 12:00:00','10'),(97,'taekyun','HOSP023','병원이 청결하지 않았습니다.','2024-12-07 09:00:00','2'),(98,'kikiki','HOSP007','시설이 잘 갖춰져 있습니다.','2024-12-06 04:00:00','9'),(99,'admin','HOSP017','진료 설명이 부족했습니다.','2024-12-06 01:00:00','2'),(100,'98jiyong','HOSP025','병원이 매우 청결합니다.','2024-12-07 01:00:00','10'),(101,'taekyun','HOSP017','대기 시간이 너무 깁니다.','2024-12-06 08:00:00','5'),(102,'yunyul','HOSP018','직원이 불친절했습니다.','2024-12-07 16:00:00','3'),(103,'yunyul','HOSP004','병원이 청결하지 않았습니다.','2024-12-05 14:00:00','3'),(104,'taekyun','HOSP024','예약 시스템이 매우 편리합니다.','2024-12-03 11:00:00','10'),(105,'yunyul','HOSP011','예약 시스템이 불편합니다.','2024-12-05 17:00:00','5'),(106,'kikiki','HOSP027','시설이 낡았습니다.','2024-12-04 06:00:00','4'),(107,'wjdekq1','HOSP025','대기 시간이 너무 깁니다.','2024-12-08 19:00:00','3'),(108,'jojungon','HOSP019','병원이 매우 청결합니다.','2024-12-08 00:00:00','8'),(109,'qortjd1','HOSP002','시설이 낡았습니다.','2024-12-01 09:00:00','5'),(110,'khgwonjae','HOSP023','대기 시간이 짧습니다.','2024-11-30 18:00:00','10'),(111,'ehdtndnjs1','HOSP028','진료 설명이 부족했습니다.','2024-12-03 01:00:00','5'),(112,'wjdekq1','HOSP023','진료 설명이 상세합니다.','2024-12-07 21:00:00','8'),(113,'silversoo','HOSP011','의사 선생님이 친절합니다.','2024-12-04 06:00:00','9'),(114,'rlacks1','HOSP008','대기 시간이 너무 깁니다.','2024-12-08 08:00:00','1'),(115,'yunyul','HOSP016','진료 설명이 상세합니다.','2024-12-02 22:00:00','9'),(116,'khgwonjae','HOSP032','병원이 청결하지 않았습니다.','2024-12-04 11:00:00','1'),(117,'ehdtndnjs1','HOSP017','병원이 청결하지 않았습니다.','2024-12-08 23:00:00','3'),(118,'98jiyong','HOSP004','진료 설명이 상세합니다.','2024-12-03 00:00:00','10'),(119,'kikiki','HOSP018','대기 시간이 너무 깁니다.','2024-12-02 01:00:00','1'),(120,'rlacks1','HOSP010','시설이 잘 갖춰져 있습니다.','2024-12-02 01:00:00','10'),(121,'admin','HOSP032','시설이 낡았습니다.','2024-12-03 07:00:00','1'),(122,'yunyul','HOSP010','직원이 불친절했습니다.','2024-12-02 02:00:00','1'),(123,'kikiki','HOSP021','예약 시스템이 매우 편리합니다.','2024-12-04 07:00:00','10'),(124,'kikiki','HOSP011','예약 시스템이 매우 편리합니다.','2024-12-01 01:00:00','9'),(125,'ehdtndnjs1','HOSP007','시설이 잘 갖춰져 있습니다.','2024-12-02 05:00:00','10'),(126,'98jiyong','HOSP015','병원이 매우 청결합니다.','2024-12-01 09:00:00','8'),(127,'98jiyong','HOSP010','직원이 불친절했습니다.','2024-12-02 03:00:00','2'),(128,'khgwonjae','HOSP008','시설이 낡았습니다.','2024-12-05 20:00:00','1'),(129,'yunyul','HOSP015','직원이 불친절했습니다.','2024-12-08 20:00:00','5'),(130,'yunyul','HOSP015','시설이 잘 갖춰져 있습니다.','2024-12-09 12:00:00','10'),(131,'wjdekq1','HOSP018','예약 시스템이 매우 편리합니다.','2024-12-06 16:00:00','9'),(132,'silversoo','HOSP013','의사 선생님이 친절합니다.','2024-12-09 12:00:00','10'),(133,'rlacks1','HOSP019','시설이 잘 갖춰져 있습니다.','2024-12-05 10:00:00','10'),(134,'qortjd1','HOSP002','직원이 불친절했습니다.','2024-12-05 03:00:00','5'),(135,'98jiyong','HOSP010','대기 시간이 짧습니다.','2024-12-07 07:00:00','8'),(136,'wjdekq1','HOSP012','진료 설명이 상세합니다.','2024-12-08 00:00:00','9'),(137,'yunyul','HOSP031','시설이 낡았습니다.','2024-12-05 06:00:00','3'),(138,'wjdekq1','HOSP024','예약 시스템이 매우 편리합니다.','2024-12-04 17:00:00','10'),(139,'kikiki','HOSP001','병원이 매우 청결합니다.','2024-12-05 12:00:00','10'),(140,'98jiyong','HOSP013','시설이 낡았습니다.','2024-12-09 06:00:00','5'),(141,'yunyul','HOSP015','진료 설명이 상세합니다.','2024-12-07 20:00:00','9'),(142,'98jiyong','HOSP029','병원이 매우 청결합니다.','2024-12-01 11:00:00','9'),(143,'qortjd1','HOSP012','진료 설명이 상세합니다.','2024-11-30 20:00:00','8'),(144,'rlacks1','HOSP008','직원이 불친절했습니다.','2024-12-03 22:00:00','5'),(145,'kikiki','HOSP010','진료 설명이 상세합니다.','2024-12-04 01:00:00','10'),(146,'taekyun','HOSP031','직원이 불친절했습니다.','2024-12-05 21:00:00','2'),(147,'ehdtndnjs1','HOSP026','시설이 낡았습니다.','2024-12-03 10:00:00','1'),(148,'rlacks1','HOSP029','진료 설명이 상세합니다.','2024-12-08 20:00:00','10'),(149,'98jiyong','HOSP017','대기 시간이 짧습니다.','2024-12-02 21:00:00','10'),(150,'test','HOSP012','시설이 잘 갖춰져 있습니다.','2024-12-05 10:00:00','8'),(151,'silversoo','HOSP019','병원이 청결하지 않았습니다.','2024-12-06 09:00:00','4'),(152,'admin','HOSP005','병원이 청결하지 않았습니다.','2024-12-06 22:00:00','4'),(153,'wjdekq1','HOSP018','대기 시간이 너무 깁니다.','2024-12-04 02:00:00','3'),(154,'qortjd1','HOSP007','시설이 잘 갖춰져 있습니다.','2024-12-02 03:00:00','8'),(155,'admin','HOSP003','대기 시간이 짧습니다.','2024-12-02 00:00:00','10'),(156,'silversoo','HOSP018','시설이 잘 갖춰져 있습니다.','2024-11-30 22:00:00','8'),(157,'98jiyong','HOSP006','대기 시간이 짧습니다.','2024-12-06 00:00:00','9'),(158,'jojungon','HOSP021','대기 시간이 짧습니다.','2024-12-04 05:00:00','10'),(159,'qortjd1','HOSP013','시설이 낡았습니다.','2024-12-01 02:00:00','1'),(160,'jojungon','HOSP018','예약 시스템이 매우 편리합니다.','2024-12-05 10:00:00','9'),(161,'taekyun','HOSP029','대기 시간이 너무 깁니다.','2024-12-02 08:00:00','5'),(162,'admin','HOSP001','대기 시간이 짧습니다.','2024-11-30 15:00:00','10'),(163,'khgwonjae','HOSP004','병원이 매우 청결합니다.','2024-12-09 11:00:00','10'),(164,'wjdekq1','HOSP029','직원이 불친절했습니다.','2024-12-07 23:00:00','5'),(165,'wjdekq1','HOSP019','시설이 낡았습니다.','2024-12-05 19:00:00','3'),(166,'taekyun','HOSP011','대기 시간이 너무 깁니다.','2024-12-06 22:00:00','1'),(167,'taekyun','HOSP011','대기 시간이 너무 깁니다.','2024-12-08 07:00:00','1'),(168,'ehdtndnjs1','HOSP017','예약 시스템이 불편합니다.','2024-12-05 14:00:00','5'),(169,'98jiyong','HOSP002','진료 설명이 부족했습니다.','2024-12-01 01:00:00','5'),(170,'ehdtndnjs1','HOSP016','병원이 매우 청결합니다.','2024-12-09 12:00:00','10'),(171,'jojungon','HOSP023','예약 시스템이 매우 편리합니다.','2024-12-06 04:00:00','10'),(172,'test','HOSP031','예약 시스템이 매우 편리합니다.','2024-12-04 20:00:00','8'),(173,'qortjd1','HOSP011','시설이 잘 갖춰져 있습니다.','2024-12-05 22:00:00','10'),(174,'98jiyong','HOSP019','의사 선생님이 친절합니다.','2024-12-04 21:00:00','9'),(175,'yunyul','HOSP006','병원이 청결하지 않았습니다.','2024-12-02 20:00:00','3'),(176,'jojungon','HOSP002','진료 설명이 부족했습니다.','2024-12-02 12:00:00','4'),(177,'jojungon','HOSP017','진료 설명이 부족했습니다.','2024-12-02 09:00:00','5'),(178,'kikiki','HOSP004','진료 설명이 상세합니다.','2024-12-05 12:00:00','8'),(179,'silversoo','HOSP007','시설이 낡았습니다.','2024-12-04 23:00:00','1'),(180,'khgwonjae','HOSP002','직원이 불친절했습니다.','2024-12-08 21:00:00','2'),(181,'taekyun','HOSP018','의사 선생님이 친절합니다.','2024-12-05 19:00:00','8'),(182,'qortjd1','HOSP024','대기 시간이 짧습니다.','2024-12-08 16:00:00','10'),(183,'rlacks1','HOSP004','대기 시간이 너무 깁니다.','2024-12-02 13:00:00','2'),(184,'qortjd1','HOSP004','시설이 잘 갖춰져 있습니다.','2024-11-30 17:00:00','9'),(185,'ehdtndnjs1','HOSP004','시설이 낡았습니다.','2024-12-07 22:00:00','3'),(186,'taekyun','HOSP031','대기 시간이 짧습니다.','2024-12-09 03:00:00','9'),(187,'ehdtndnjs1','HOSP001','진료 설명이 부족했습니다.','2024-12-01 05:00:00','1'),(188,'ehdtndnjs1','HOSP033','병원이 매우 청결합니다.','2024-12-01 22:00:00','10'),(189,'yunyul','HOSP001','시설이 낡았습니다.','2024-12-09 06:00:00','5'),(190,'rlacks1','HOSP013','시설이 낡았습니다.','2024-12-07 16:00:00','4'),(191,'yunyul','HOSP009','시설이 잘 갖춰져 있습니다.','2024-12-09 01:00:00','10'),(192,'kikiki','HOSP028','대기 시간이 너무 깁니다.','2024-12-03 14:00:00','4'),(193,'silversoo','HOSP008','병원이 청결하지 않았습니다.','2024-12-03 14:00:00','1'),(194,'qortjd1','HOSP019','예약 시스템이 매우 편리합니다.','2024-12-07 04:00:00','8'),(195,'ehdtndnjs1','HOSP032','시설이 낡았습니다.','2024-12-07 03:00:00','3'),(196,'khgwonjae','HOSP033','진료 설명이 상세합니다.','2024-12-06 20:00:00','10'),(197,'test','HOSP019','예약 시스템이 매우 편리합니다.','2024-12-09 01:00:00','10'),(198,'ehdtndnjs1','HOSP015','병원이 청결하지 않았습니다.','2024-12-06 23:00:00','5'),(199,'rlacks1','HOSP032','의사 선생님이 친절합니다.','2024-12-05 23:00:00','8'),(200,'qortjd1','HOSP008','진료 설명이 상세합니다.','2024-12-06 15:00:00','9'),(201,'qortjd1','HOSP018','병원이 청결하지 않았습니다.','2024-12-08 16:00:00','3'),(202,'taekyun','HOSP008','직원이 불친절했습니다.','2024-12-06 13:00:00','3'),(203,'jojungon','HOSP006','시설이 잘 갖춰져 있습니다.','2024-12-06 01:00:00','10'),(204,'yunyul','HOSP029','병원이 매우 청결합니다.','2024-12-05 09:00:00','10'),(205,'silversoo','HOSP006','시설이 낡았습니다.','2024-12-06 09:00:00','2'),(206,'ehdtndnjs1','HOSP010','진료 설명이 부족했습니다.','2024-12-06 04:00:00','4'),(207,'wjdekq1','HOSP009','진료 설명이 상세합니다.','2024-12-07 13:00:00','8'),(208,'kikiki','HOSP031','진료 설명이 상세합니다.','2024-12-03 18:00:00','9'),(209,'silversoo','HOSP001','의사 선생님이 친절합니다.','2024-12-08 16:00:00','10'),(210,'kikiki','HOSP001','시설이 잘 갖춰져 있습니다.','2024-12-05 08:00:00','8'),(211,'jojungon','HOSP018','시설이 낡았습니다.','2024-12-03 20:00:00','2'),(212,'wjdekq1','HOSP021','의사 선생님이 친절합니다.','2024-12-01 08:00:00','8'),(213,'wjdekq1','HOSP004','대기 시간이 짧습니다.','2024-12-02 09:00:00','8'),(214,'silversoo','HOSP009','진료 설명이 부족했습니다.','2024-11-30 19:00:00','2'),(215,'yunyul','HOSP021','대기 시간이 너무 깁니다.','2024-12-03 15:00:00','5'),(216,'khgwonjae','HOSP032','직원이 불친절했습니다.','2024-12-02 12:00:00','5'),(217,'qortjd1','HOSP010','병원이 매우 청결합니다.','2024-12-04 02:00:00','9'),(218,'admin','HOSP003','시설이 낡았습니다.','2024-12-07 00:00:00','4'),(219,'silversoo','HOSP027','병원이 매우 청결합니다.','2024-12-01 23:00:00','8'),(220,'qortjd1','HOSP013','예약 시스템이 불편합니다.','2024-12-09 11:00:00','3'),(221,'ehdtndnjs1','HOSP011','직원이 불친절했습니다.','2024-12-02 18:00:00','3'),(222,'yunyul','HOSP013','시설이 잘 갖춰져 있습니다.','2024-12-02 20:00:00','8'),(223,'kikiki','HOSP005','진료 설명이 부족했습니다.','2024-12-08 00:00:00','5'),(224,'98jiyong','HOSP006','예약 시스템이 불편합니다.','2024-12-02 10:00:00','5'),(225,'qortjd1','HOSP004','병원이 매우 청결합니다.','2024-12-07 17:00:00','10'),(226,'khgwonjae','HOSP005','의사 선생님이 친절합니다.','2024-12-08 05:00:00','9'),(227,'ehdtndnjs1','HOSP025','직원이 불친절했습니다.','2024-12-06 05:00:00','4'),(228,'khgwonjae','HOSP002','대기 시간이 짧습니다.','2024-12-07 15:00:00','8'),(229,'silversoo','HOSP019','대기 시간이 너무 깁니다.','2024-12-08 04:00:00','4'),(230,'rlacks1','HOSP009','시설이 낡았습니다.','2024-12-03 11:00:00','3'),(231,'jojungon','HOSP006','시설이 잘 갖춰져 있습니다.','2024-12-03 22:00:00','9'),(232,'test','HOSP001','병원이 청결하지 않았습니다.','2024-12-01 18:00:00','4'),(233,'qortjd1','HOSP019','직원이 불친절했습니다.','2024-12-03 08:00:00','3'),(234,'kikiki','HOSP031','직원이 불친절했습니다.','2024-12-01 18:00:00','4'),(235,'khgwonjae','HOSP027','시설이 잘 갖춰져 있습니다.','2024-12-08 20:00:00','8'),(236,'yunyul','HOSP006','진료 설명이 상세합니다.','2024-12-02 22:00:00','10'),(237,'kikiki','HOSP007','시설이 낡았습니다.','2024-12-03 14:00:00','1'),(240,'98jiyong','HOSP009','수납이 빨라요','2024-12-14 13:05:00','7'),(241,'98jiyong','HOSP009','수납이 빨라요','2024-12-14 13:05:00','7');
/*!40000 ALTER TABLE `review` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spring_session`
--

DROP TABLE IF EXISTS `spring_session`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spring_session` (
  `PRIMARY_ID` char(36) NOT NULL,
  `SESSION_ID` char(36) NOT NULL,
  `CREATION_TIME` bigint(20) NOT NULL,
  `LAST_ACCESS_TIME` bigint(20) NOT NULL,
  `MAX_INACTIVE_INTERVAL` int(11) NOT NULL,
  `EXPIRY_TIME` bigint(20) NOT NULL,
  `PRINCIPAL_NAME` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`PRIMARY_ID`),
  UNIQUE KEY `SPRING_SESSION_IX1` (`SESSION_ID`),
  KEY `SPRING_SESSION_IX2` (`EXPIRY_TIME`),
  KEY `SPRING_SESSION_IX3` (`PRINCIPAL_NAME`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spring_session`
--

LOCK TABLES `spring_session` WRITE;
/*!40000 ALTER TABLE `spring_session` DISABLE KEYS */;
/*!40000 ALTER TABLE `spring_session` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spring_session_attributes`
--

DROP TABLE IF EXISTS `spring_session_attributes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spring_session_attributes` (
  `SESSION_PRIMARY_ID` char(36) NOT NULL,
  `ATTRIBUTE_NAME` varchar(200) NOT NULL,
  `ATTRIBUTE_BYTES` blob NOT NULL,
  PRIMARY KEY (`SESSION_PRIMARY_ID`,`ATTRIBUTE_NAME`),
  CONSTRAINT `spring_session_attributes_ibfk_1` FOREIGN KEY (`SESSION_PRIMARY_ID`) REFERENCES `spring_session` (`PRIMARY_ID`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spring_session_attributes`
--

LOCK TABLES `spring_session_attributes` WRITE;
/*!40000 ALTER TABLE `spring_session_attributes` DISABLE KEYS */;
/*!40000 ALTER TABLE `spring_session_attributes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `testboard`
--

DROP TABLE IF EXISTS `testboard`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `testboard` (
  `board_sequence` int(11) NOT NULL,
  `board_user_id` varchar(400) DEFAULT NULL,
  `board_category` varchar(400) DEFAULT NULL,
  `board_title` varchar(100) DEFAULT NULL,
  `board_content` varchar(1000) DEFAULT NULL,
  `board_binary` varchar(100) DEFAULT NULL,
  `board_viewcount` int(11) DEFAULT 0,
  `board_date` timestamp NULL DEFAULT sysdate(),
  `board_goodcount` int(11) DEFAULT 0,
  `board_originalfile` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`board_sequence`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `testboard`
--

LOCK TABLES `testboard` WRITE;
/*!40000 ALTER TABLE `testboard` DISABLE KEYS */;
INSERT INTO `testboard` VALUES (1,'123','오늘의 건강','123','1234','1234',1,'2024-12-09 02:36:49',0,NULL),(2,'123','오늘의 건강','123','1234','1234',0,'2024-12-09 02:36:50',0,NULL),(3,'123','오늘의 건강','123','1234','1234',0,'2024-12-09 02:36:50',0,NULL),(4,'123','오늘의 건강','123','1234','1234',0,'2024-12-09 02:37:53',0,NULL),(5,'123','오늘의 건강','123','1234','1234',0,'2024-12-09 02:37:53',0,NULL),(6,'123','오늘의 건강','123','1234','1234',0,'2024-12-09 02:37:53',0,NULL),(7,'123','오늘의 건강','123','1234','1234',0,'2024-12-09 02:37:53',0,NULL),(8,'123','오늘의 건강','123','1234','1234',0,'2024-12-09 02:37:53',0,NULL),(9,'123','오늘의 건강','123','1234','1234',0,'2024-12-09 02:37:53',0,NULL),(10,'123','오늘의 건강','123','1234','1234',0,'2024-12-09 02:37:53',0,NULL),(11,'123','오늘의 건강','123','1234','1234',0,'2024-12-09 02:37:54',0,NULL),(12,'123','오늘의 건강','123','1234','1234',0,'2024-12-09 02:37:54',0,NULL),(13,'123','오늘의 건강','123','1234','1234',0,'2024-12-09 02:37:54',0,NULL),(14,'123','오늘의 건강','123','1234','1234',0,'2024-12-09 02:37:54',0,NULL),(15,'123','오늘의 건강','123','1234','1234',0,'2024-12-09 02:37:54',0,NULL),(16,'123','오늘의 건강','123','1234','1234',0,'2024-12-09 02:37:54',0,NULL),(17,'123','오늘의 건강','123','1234','1234',0,'2024-12-09 02:37:54',0,NULL),(18,'123','오늘의 건강','123','1234','1234',0,'2024-12-09 02:37:54',0,NULL),(19,'123','오늘의 건강','123','1234','1234',0,'2024-12-09 02:37:54',0,NULL),(20,'123','오늘의 건강','123','1234','1234',0,'2024-12-09 02:37:54',0,NULL),(21,'123','오늘의 건강','123','1234','1234',0,'2024-12-09 02:37:55',0,NULL),(22,'123','오늘의 건강','123','1234','1234',0,'2024-12-09 02:37:55',0,NULL),(23,'123','오늘의 건강','123','1234','1234',0,'2024-12-09 02:37:55',0,NULL),(24,'123','오늘의 건강','123','1234','1234',0,'2024-12-09 02:37:55',0,NULL),(25,'123','오늘의 건강','123','1234','1234',0,'2024-12-09 02:37:55',0,NULL),(26,'123','오늘의 건강','123','1234','1234',0,'2024-12-09 02:37:55',0,NULL),(27,'123','오늘의 건강','123','1234','1234',0,'2024-12-09 02:37:55',0,NULL),(28,'123','오늘의 건강','123','1234','1234',0,'2024-12-09 02:37:55',0,NULL),(29,'123','오늘의 건강','123','1234','1234',0,'2024-12-09 02:37:55',0,NULL),(30,'123','오늘의 건강','123','1234','1234',0,'2024-12-09 02:37:55',0,NULL),(31,'123','오늘의 건강','123','1234','1234',0,'2024-12-09 02:37:55',0,NULL),(32,'123','오늘의 건강','123','1234','1234',0,'2024-12-09 02:37:55',0,NULL),(33,'123','오늘의 건강','123','1234','1234',0,'2024-12-09 02:37:55',0,NULL),(34,'123','오늘의 건강','123','1234','1234',0,'2024-12-09 02:37:56',0,NULL),(35,'123','오늘의 건강','123','1234','1234',0,'2024-12-09 02:37:56',0,NULL),(36,'123','오늘의 건강','123','1234','1234',0,'2024-12-09 02:37:56',0,NULL),(37,'123','오늘의 건강','123','1234','1234',0,'2024-12-09 02:37:56',0,NULL),(38,'123','오늘의 건강','123','1234','1234',0,'2024-12-09 02:37:56',0,NULL),(39,'123','캠페인','123','1234','1234',0,'2024-12-09 02:38:10',0,NULL),(40,'123','캠페인','123','1234','1234',0,'2024-12-09 02:38:10',0,NULL),(41,'123','캠페인','123','1234','1234',0,'2024-12-09 02:38:10',0,NULL),(42,'123','캠페인','123','1234','1234',0,'2024-12-09 02:38:10',0,NULL),(43,'123','캠페인','123','1234','1234',0,'2024-12-09 02:38:12',0,NULL),(44,'123','캠페인','123','1234','1234',0,'2024-12-09 02:38:12',0,NULL),(45,'123','캠페인','123','1234','1234',0,'2024-12-09 02:38:12',0,NULL),(46,'123','캠페인','123','1234','1234',0,'2024-12-09 02:38:12',0,NULL),(47,'123','캠페인','123','1234','1234',0,'2024-12-09 02:38:12',0,NULL),(48,'123','캠페인','123','1234','1234',0,'2024-12-09 02:38:12',0,NULL),(49,'123','캠페인','123','1234','1234',0,'2024-12-09 02:38:13',0,NULL),(50,'123','캠페인','123','1234','1234',0,'2024-12-09 02:38:13',0,NULL),(51,'123','캠페인','123','1234','1234',0,'2024-12-09 02:38:13',0,NULL),(52,'123','캠페인','123','1234','1234',0,'2024-12-09 02:38:13',0,NULL),(53,'123','캠페인','123','1234','1234',0,'2024-12-09 02:38:13',0,NULL),(54,'123','캠페인','123','1234','1234',0,'2024-12-09 02:38:13',0,NULL),(55,'123','캠페인','123','1234','1234',0,'2024-12-09 02:38:13',0,NULL),(56,'123','캠페인','123','1234','1234',0,'2024-12-09 02:38:13',0,NULL),(57,'123','캠페인','123','1234','1234',0,'2024-12-09 02:38:13',0,NULL),(58,'123','캠페인','123','1234','1234',0,'2024-12-09 02:38:13',0,NULL),(59,'123','캠페인','123','1234','1234',0,'2024-12-09 02:38:13',0,NULL),(60,'123','캠페인','123','1234','1234',0,'2024-12-09 02:38:13',0,NULL),(61,'123','캠페인','123','1234','1234',0,'2024-12-09 02:38:14',0,NULL),(62,'123','캠페인','123','1234','1234',0,'2024-12-09 02:38:14',0,NULL),(63,'123','캠페인','123','1234','1234',0,'2024-12-09 02:38:14',0,NULL),(64,'123','캠페인','123','1234','1234',0,'2024-12-09 02:38:14',0,NULL),(65,'123','캠페인','123','1234','1234',0,'2024-12-09 02:38:14',0,NULL),(66,'123','캠페인','123','1234','1234',0,'2024-12-09 02:38:14',0,NULL),(67,'123','캠페인','123','1234','1234',0,'2024-12-09 02:38:14',0,NULL),(68,'123','캠페인','123','1234','1234',0,'2024-12-09 02:38:14',0,NULL),(69,'123','캠페인','123','1234','1234',0,'2024-12-09 02:38:14',0,NULL),(70,'123','캠페인','123','1234','1234',0,'2024-12-09 02:38:14',0,NULL),(71,'123','캠페인','123','1234','1234',0,'2024-12-09 02:38:14',0,NULL),(72,'123','캠페인','123','1234','1234',0,'2024-12-09 02:38:14',0,NULL),(73,'123','캠페인','123','1234','1234',0,'2024-12-09 02:38:14',0,NULL),(74,'123','캠페인','123','1234','1234',0,'2024-12-09 02:38:15',0,NULL),(75,'123','캠페인','123','1234','1234',0,'2024-12-09 02:38:15',0,NULL),(76,'123','캠페인','123','1234','1234',0,'2024-12-09 02:38:15',0,NULL),(77,'123','캠페인','123','1234','1234',0,'2024-12-09 02:38:15',0,NULL),(78,'123','캠페인','123','1234','1234',0,'2024-12-09 02:38:15',0,NULL),(79,'123','의료정보','123','1234','1234',0,'2024-12-09 02:38:29',0,NULL),(80,'123','의료정보','123','1234','1234',0,'2024-12-09 02:38:29',0,NULL),(81,'123','의료정보','123','1234','1234',0,'2024-12-09 02:38:29',0,NULL),(82,'123','의료정보','123','1234','1234',0,'2024-12-09 02:38:30',0,NULL),(83,'123','의료정보','123','1234','1234',0,'2024-12-09 02:38:30',0,NULL),(84,'123','의료정보','123','1234','1234',0,'2024-12-09 02:38:30',0,NULL),(85,'123','의료정보','123','1234','1234',0,'2024-12-09 02:38:30',0,NULL),(86,'123','의료정보','123','1234','1234',0,'2024-12-09 02:38:30',0,NULL),(87,'123','의료정보','123','1234','1234',0,'2024-12-09 02:38:30',0,NULL),(88,'123','의료정보','123','1234','1234',0,'2024-12-09 02:38:30',0,NULL),(89,'123','의료정보','123','1234','1234',0,'2024-12-09 02:38:30',0,NULL),(90,'123','의료정보','123','1234','1234',0,'2024-12-09 02:38:30',0,NULL),(91,'123','의료정보','123','1234','1234',0,'2024-12-09 02:38:30',0,NULL),(92,'123','의료정보','123','1234','1234',0,'2024-12-09 02:38:30',0,NULL),(93,'123','의료정보','123','1234','1234',0,'2024-12-09 02:38:30',0,NULL),(94,'123','의료정보','123','1234','1234',0,'2024-12-09 02:38:32',0,NULL),(95,'123','의료정보','123','1234','1234',0,'2024-12-09 02:38:32',0,NULL),(96,'123','의료정보','123','1234','1234',0,'2024-12-09 02:38:32',0,NULL),(97,'123','의료정보','123','1234','1234',0,'2024-12-09 02:38:32',0,NULL),(98,'123','의료정보','123','1234','1234',0,'2024-12-09 02:38:32',0,NULL),(99,'123','의료정보','123','1234','1234',0,'2024-12-09 02:38:33',0,NULL),(100,'123','의료정보','123','1234','1234',0,'2024-12-09 02:38:33',0,NULL),(101,'123','의료정보','123','1234','1234',0,'2024-12-09 02:38:33',0,NULL),(102,'123','의료정보','123','1234','1234',0,'2024-12-09 02:38:33',0,NULL),(103,'123','의료정보','123','1234','1234',0,'2024-12-09 02:38:33',0,NULL),(104,'123','의료정보','123','1234','1234',0,'2024-12-09 02:38:33',0,NULL),(105,'123','의료정보','123','1234','1234',0,'2024-12-09 02:38:33',0,NULL),(106,'123','의료정보','123','1234','1234',0,'2024-12-09 02:38:33',0,NULL),(107,'123','의료정보','123','1234','1234',0,'2024-12-09 02:38:33',0,NULL),(108,'123','의료정보','123','1234','1234',0,'2024-12-09 02:38:33',0,NULL),(109,'123','의료정보','123','1234','1234',0,'2024-12-09 02:38:33',0,NULL),(110,'123','의료정보','123','1234','1234',0,'2024-12-09 02:38:34',0,NULL),(111,'123','의료정보','123','1234','1234',0,'2024-12-09 02:38:34',0,NULL),(112,'123','의료정보','123','1234','1234',0,'2024-12-09 02:38:34',0,NULL),(113,'123','의료정보','123','1234','1234',0,'2024-12-09 02:38:34',0,NULL),(114,'123','의료정보','123','1234','1234',0,'2024-12-09 02:38:34',0,NULL),(115,'123','의료정보','123','1234','1234',0,'2024-12-09 02:38:34',0,NULL),(116,'123','의료정보','123','1234','1234',0,'2024-12-09 02:38:34',0,NULL),(117,'123','의료정보','123','1234','1234',0,'2024-12-09 02:38:34',0,NULL),(118,'123','의료정보','123','1234','1234',0,'2024-12-09 02:38:34',0,NULL),(119,'123','의료정보','123','1234','1234',0,'2024-12-09 02:38:34',0,NULL),(120,'123','의료정보','123','1234','1234',0,'2024-12-09 02:38:34',0,NULL),(121,'123','의료정보','123','1234','1234',0,'2024-12-09 02:38:34',0,NULL),(122,'123','의료정보','123','1234','1234',0,'2024-12-09 02:38:34',0,NULL),(123,'123','의료정보','123','1234','1234',0,'2024-12-09 02:38:35',0,NULL),(124,'123','의료정보','123','1234','1234',0,'2024-12-09 02:38:35',0,NULL),(125,'123','의료정보','123','1234','1234',0,'2024-12-09 02:38:35',0,NULL),(126,'123','의료정보','123','1234','1234',0,'2024-12-09 02:38:35',0,NULL),(127,'123','의료정보','123','1234','1234',0,'2024-12-09 02:38:35',0,NULL),(128,'123','의료정보','123','1234','1234',0,'2024-12-09 02:38:35',0,NULL),(129,'123','의료정보','123','1234','1234',0,'2024-12-09 02:38:35',0,NULL),(130,'123','의료정보','123','1234','1234',0,'2024-12-09 02:38:35',0,NULL),(131,'123','의료정보','123','1234','1234',0,'2024-12-09 02:38:35',0,NULL),(132,'123','자유게시판','123','1234','1234',0,'2024-12-09 02:38:45',0,NULL),(133,'123','자유게시판','123','1234','1234',0,'2024-12-09 02:38:46',0,NULL),(134,'123','자유게시판','123','1234','1234',0,'2024-12-09 02:38:46',0,NULL),(135,'123','자유게시판','123','1234','1234',0,'2024-12-09 02:38:47',0,NULL),(136,'123','자유게시판','123','1234','1234',0,'2024-12-09 02:38:48',0,NULL),(137,'123','자유게시판','123','1234','1234',0,'2024-12-09 02:38:48',0,NULL),(138,'123','자유게시판','123','1234','1234',0,'2024-12-09 02:38:48',0,NULL),(139,'123','자유게시판','123','1234','1234',0,'2024-12-09 02:38:48',0,NULL),(140,'123','자유게시판','123','1234','1234',0,'2024-12-09 02:38:48',0,NULL),(141,'123','자유게시판','123','1234','1234',0,'2024-12-09 02:38:48',0,NULL),(142,'123','자유게시판','123','1234','1234',0,'2024-12-09 02:38:48',0,NULL),(143,'123','자유게시판','123','1234','1234',0,'2024-12-09 02:38:48',0,NULL),(144,'123','자유게시판','123','1234','1234',0,'2024-12-09 02:38:48',0,NULL),(145,'123','자유게시판','123','1234','1234',0,'2024-12-09 02:38:48',0,NULL),(146,'123','자유게시판','123','1234','1234',0,'2024-12-09 02:38:48',0,NULL),(147,'123','자유게시판','123','1234','1234',0,'2024-12-09 02:38:48',0,NULL),(148,'123','자유게시판','123','1234','1234',0,'2024-12-09 02:38:48',0,NULL),(149,'123','자유게시판','123','1234','1234',0,'2024-12-09 02:38:48',0,NULL),(150,'123','자유게시판','123','1234','1234',0,'2024-12-09 02:38:49',0,NULL),(151,'123','자유게시판','123','1234','1234',0,'2024-12-09 02:38:49',0,NULL),(152,'123','자유게시판','123','1234','1234',0,'2024-12-09 02:38:49',0,NULL),(153,'123','자유게시판','123','1234','1234',0,'2024-12-09 02:38:49',0,NULL),(154,'123','자유게시판','123','1234','1234',0,'2024-12-09 02:38:49',0,NULL),(155,'123','자유게시판','123','1234','1234',0,'2024-12-09 02:38:49',0,NULL),(156,'123','자유게시판','123','1234','1234',0,'2024-12-09 02:38:49',0,NULL),(157,'123','자유게시판','123','1234','1234',0,'2024-12-09 02:38:49',0,NULL),(158,'123','자유게시판','123','1234','1234',0,'2024-12-09 02:38:49',0,NULL),(159,'123','자유게시판','123','1234','1234',0,'2024-12-09 02:38:49',0,NULL),(160,'123','자유게시판','123','1234','1234',0,'2024-12-09 02:38:49',0,NULL),(161,'123','자유게시판','123','1234','1234',0,'2024-12-09 02:38:49',0,NULL),(162,'123','자유게시판','123','1234','1234',0,'2024-12-09 02:38:50',0,NULL),(163,'123','자유게시판','123','1234','1234',0,'2024-12-09 02:38:50',0,NULL),(164,'123','자유게시판','123','1234','1234',0,'2024-12-09 02:38:50',0,NULL),(165,'123','자유게시판','123','1234','1234',0,'2024-12-09 02:38:50',0,NULL),(166,'123','자유게시판','123','1234','1234',0,'2024-12-09 02:38:50',0,NULL),(167,'123','자유게시판','123','1234','1234',0,'2024-12-09 02:38:50',0,NULL),(168,'123','자유게시판','123','1234','1234',0,'2024-12-09 02:38:50',0,NULL),(169,'123','자유게시판','123','1234','1234',0,'2024-12-09 02:38:50',0,NULL),(170,'123','자유게시판','123','1234','1234',0,'2024-12-09 02:38:50',0,NULL),(171,'123','자유게시판','123','1234','1234',0,'2024-12-09 02:38:50',0,NULL),(172,'123','자유게시판','123','1234','1234',0,'2024-12-09 02:38:50',0,NULL),(173,'123','자유게시판','123','1234','1234',0,'2024-12-09 02:38:50',0,NULL),(174,'123','자유게시판','123','1234','1234',0,'2024-12-09 02:38:51',0,NULL),(175,'123','자유게시판','123','1234','1234',0,'2024-12-09 02:38:51',0,NULL),(176,'123','자유게시판','123','1234','1234',0,'2024-12-09 02:38:51',0,NULL),(177,'123','자유게시판','123','1234','1234',0,'2024-12-09 02:38:51',0,NULL),(178,'123','자유게시판','123','1234','1234',0,'2024-12-09 02:38:51',0,NULL),(179,'123','자유게시판','123','1234','1234',0,'2024-12-09 02:38:51',0,NULL),(180,'123','자유게시판','123','1234','1234',0,'2024-12-09 02:38:51',0,NULL),(181,'123','자유게시판','123','1234','1234',0,'2024-12-09 02:38:51',0,NULL),(182,'123','자유게시판','123','1234','1234',0,'2024-12-09 02:38:51',0,NULL),(183,'123','자유게시판','123','1234','1234',0,'2024-12-09 02:38:51',0,NULL),(184,'123','자유게시판','123','1234','1234',0,'2024-12-09 02:38:51',0,NULL),(185,'123','자유게시판','123','1234','1234',0,'2024-12-09 02:38:51',0,NULL),(186,'123','자유게시판','123','1234','1234',0,'2024-12-09 02:38:52',0,NULL),(187,'123','자유게시판','123','1234','1234',0,'2024-12-09 02:38:52',0,NULL),(188,'123','자유게시판','123','1234','1234',0,'2024-12-09 02:38:52',0,NULL),(189,'123','자유게시판','123','1234','1234',0,'2024-12-09 02:38:52',0,NULL),(190,'123','자유게시판','123','1234','1234',0,'2024-12-09 02:38:52',0,NULL),(191,'123','자유게시판','123','1234','1234',0,'2024-12-09 02:38:52',0,NULL),(192,'123','자유게시판','123','1234','1234',0,'2024-12-09 02:38:52',0,NULL),(193,'123','자유게시판','123','1234','1234',0,'2024-12-09 02:38:52',0,NULL),(194,'123','자유게시판','123','1234','1234',0,'2024-12-09 02:38:52',0,NULL),(195,'123','자유게시판','123','1234','1234',0,'2024-12-09 02:38:52',0,NULL),(196,'123','자유게시판','123','1234','1234',0,'2024-12-09 02:38:52',0,NULL),(197,'123','자유게시판','123','1234','1234',0,'2024-12-09 02:38:53',0,NULL),(198,'123','자유게시판','123','1234','1234',0,'2024-12-09 02:38:53',0,NULL),(199,'123','자유게시판','123','1234','1234',1,'2024-12-09 02:38:53',0,NULL),(200,'123','자유게시판','123','1234','1234',1,'2024-12-09 02:38:53',0,NULL),(201,'123','자유게시판','123','1234','1234',0,'2024-12-09 02:38:53',0,NULL),(202,'123','자유게시판','123','1234','1234',0,'2024-12-09 02:38:53',0,NULL),(203,'123','오늘의 건강','123','1234','1234',1,'2024-12-09 02:39:02',0,NULL),(204,'123','오늘의 건강','123','1234','1234',2,'2024-12-09 02:39:03',1,NULL),(205,'123','오늘의 건강','123','1234','1234',6,'2024-12-09 02:39:03',1,NULL),(206,'123','오늘의 건강','123','1234','1234',1,'2024-12-09 02:39:03',1,NULL),(207,'123','오늘의 건강','123','1234','1234',1,'2024-12-09 02:39:03',0,NULL),(208,'123','오늘의 건강','123','1234','1234',1,'2024-12-09 02:39:03',0,NULL),(209,'123','오늘의 건강','123','1234','1234',2,'2024-12-09 02:39:03',0,NULL),(210,'123','오늘의 건강','123','1234','1234',0,'2024-12-09 02:39:03',0,NULL),(211,'123','오늘의 건강','123','1234','1234',0,'2024-12-09 02:39:03',0,NULL),(212,'123','오늘의 건강','123','1234','1234',0,'2024-12-09 02:39:03',0,NULL),(213,'123','오늘의 건강','123','1234','1234',0,'2024-12-09 02:39:03',0,NULL),(214,'123','오늘의 건강','123','1234','1234',1,'2024-12-09 02:39:05',1,NULL),(215,'123','자유게시판','123','1234','1234',0,'2024-12-09 02:39:13',0,NULL),(216,'123','자유게시판','123','1234','1234',0,'2024-12-09 02:39:14',0,NULL),(217,'123','자유게시판','123','1234','1234',0,'2024-12-09 02:39:14',0,NULL),(218,'123','자유게시판','123','1234','1234',0,'2024-12-09 02:39:14',0,NULL),(219,'123','자유게시판','123','1234','1234',0,'2024-12-09 02:39:14',0,NULL),(220,'123','자유게시판','123','1234','1234',0,'2024-12-09 02:39:14',0,NULL),(221,'123','자유게시판','123','1234','1234',0,'2024-12-09 02:39:14',0,NULL),(222,'123','자유게시판','123','1234','1234',0,'2024-12-09 02:39:14',0,NULL),(223,'123','자유게시판','123','1234','1234',0,'2024-12-09 02:39:14',0,NULL),(224,'123','자유게시판','123','1234','1234',0,'2024-12-09 02:39:14',0,NULL),(225,'123','자유게시판','123','1234','1234',0,'2024-12-09 02:39:16',0,NULL),(226,'123','자유게시판','123','1234','1234',0,'2024-12-09 02:39:16',0,NULL),(227,'123','자유게시판','123','1234','1234',0,'2024-12-09 02:39:16',0,NULL),(228,'123','자유게시판','123','1234','1234',0,'2024-12-09 02:39:16',0,NULL),(229,'123','자유게시판','123','1234','1234',0,'2024-12-09 02:39:16',0,NULL),(230,'123','자유게시판','123','1234','1234',0,'2024-12-09 02:39:16',0,NULL),(231,'123','자유게시판','123','1234','1234',0,'2024-12-09 02:39:16',0,NULL),(232,'123','자유게시판','123','1234','1234',22,'2024-12-09 02:39:17',0,NULL),(233,'123','의료정보','123','1234','1234',0,'2024-12-09 02:39:29',0,NULL),(234,'123','의료정보','123','1234','1234',0,'2024-12-09 02:39:29',0,NULL),(235,'123','의료정보','123','1234','1234',0,'2024-12-09 02:39:31',0,NULL),(236,'123','의료정보','123','1234','1234',0,'2024-12-09 02:39:31',0,NULL),(237,'123','의료정보','123','1234','1234',0,'2024-12-09 02:39:31',0,NULL),(238,'123','의료정보','123','1234','1234',0,'2024-12-09 02:39:31',0,NULL),(239,'123','의료정보','123','1234','1234',0,'2024-12-09 02:39:31',0,NULL),(240,'123','의료정보','123','1234','1234',0,'2024-12-09 02:39:31',0,NULL),(241,'123','의료정보','123','1234','1234',0,'2024-12-09 02:39:31',0,NULL),(242,'123','의료정보','123','1234','1234',0,'2024-12-09 02:39:31',0,NULL),(243,'123','의료정보','123','1234','1234',0,'2024-12-09 02:39:31',0,NULL),(244,'123','의료정보','123','1234','1234',0,'2024-12-09 02:39:32',0,NULL),(245,'123','의료정보','123','1234','1234',0,'2024-12-09 02:39:32',0,NULL),(246,'123','의료정보','123','1234','1234',0,'2024-12-09 02:39:32',0,NULL),(247,'123','의료정보','123','1234','1234',0,'2024-12-09 02:39:32',0,NULL),(248,'123','의료정보','123','1234','1234',0,'2024-12-09 02:39:32',0,NULL),(249,'123','의료정보','123','1234','1234',0,'2024-12-09 02:39:32',0,NULL),(250,'123','의료정보','123','1234','1234',0,'2024-12-09 02:39:32',0,NULL),(251,'123','의료정보','123','1234','1234',0,'2024-12-09 02:39:32',0,NULL),(252,'123','의료정보','123','1234','1234',0,'2024-12-09 02:39:32',0,NULL),(253,'123','의료정보','123','1234','1234',0,'2024-12-09 02:39:32',0,NULL),(254,'123','의료정보','123','1234','1234',0,'2024-12-09 02:39:32',0,NULL),(255,'123','의료정보','123','1234','1234',0,'2024-12-09 02:39:32',0,NULL),(256,'123','의료정보','123','1234','1234',0,'2024-12-09 02:39:32',0,NULL),(257,'123','의료정보','123','1234','1234',0,'2024-12-09 02:39:33',0,NULL),(258,'123','의료정보','123','1234','1234',0,'2024-12-09 02:39:33',0,NULL),(259,'123','의료정보','123','1234','1234',0,'2024-12-09 02:39:33',0,NULL),(260,'123','의료정보','123','1234','1234',0,'2024-12-09 02:39:33',0,NULL),(261,'123','의료정보','123','1234','1234',0,'2024-12-09 02:39:33',0,NULL),(262,'123','의료정보','123','1234','1234',0,'2024-12-09 02:39:33',0,NULL),(263,'123','의료정보','123','1234','1234',0,'2024-12-09 02:39:33',0,NULL),(264,'123','캠페인','123','1234','1234',0,'2024-12-09 02:39:38',0,NULL),(265,'123','캠페인','123','1234','1234',0,'2024-12-09 02:39:38',0,NULL),(266,'123','캠페인','123','1234','1234',0,'2024-12-09 02:39:38',0,NULL),(267,'123','캠페인','123','1234','1234',0,'2024-12-09 02:39:38',0,NULL),(268,'123','캠페인','123','1234','1234',0,'2024-12-09 02:39:38',0,NULL),(269,'123','캠페인','123','1234','1234',0,'2024-12-09 02:39:38',0,NULL),(270,'123','캠페인','123','1234','1234',0,'2024-12-09 02:39:38',0,NULL),(271,'123','캠페인','123','1234','1234',0,'2024-12-09 02:39:38',0,NULL),(272,'123','캠페인','123','1234','1234',0,'2024-12-09 02:39:38',0,NULL),(273,'123','캠페인','123','1234','1234',0,'2024-12-09 02:39:38',0,NULL),(274,'123','캠페인','123','1234','1234',0,'2024-12-09 02:39:39',0,NULL),(275,'123','캠페인','123','1234','1234',0,'2024-12-09 02:39:39',0,NULL),(276,'123','캠페인','123','1234','1234',0,'2024-12-09 02:39:39',0,NULL),(277,'123','캠페인','123','1234','1234',0,'2024-12-09 02:39:39',0,NULL),(278,'123','캠페인','123','1234','1234',0,'2024-12-09 02:39:39',0,NULL),(279,'123','캠페인','123','1234','1234',0,'2024-12-09 02:39:39',0,NULL),(280,'123','캠페인','123','1234','1234',0,'2024-12-09 02:39:39',0,NULL),(281,'123','캠페인','123','1234','1234',0,'2024-12-09 02:39:39',0,NULL),(282,'123','캠페인','123','1234','1234',0,'2024-12-09 02:39:39',0,NULL),(283,'123','캠페인','123','1234','1234',0,'2024-12-09 02:39:39',0,NULL),(284,'123','캠페인','123','1234','1234',0,'2024-12-09 02:39:39',0,NULL),(285,'123','캠페인','123','1234','1234',0,'2024-12-09 02:39:39',0,NULL),(286,'123','캠페인','123','1234','1234',0,'2024-12-09 02:39:39',0,NULL),(287,'123','캠페인','123','1234','1234',102,'2024-12-09 02:39:40',3,NULL),(288,'123','캠페인','123','1234','1234',0,'2024-12-09 02:39:40',0,NULL),(289,'123','캠페인','123','1234','1234',0,'2024-12-09 02:39:40',0,NULL),(290,'123','캠페인','123','1234','1234',0,'2024-12-09 02:39:40',0,NULL),(291,'123','캠페인','123','1234','1234',0,'2024-12-09 02:39:40',0,NULL),(292,'123','캠페인','123','1234','1234',1,'2024-12-09 02:39:40',1,NULL),(293,'123','캠페인','123','1234','1234',0,'2024-12-09 02:39:40',0,NULL),(294,'123','캠페인','123','1234','1234',0,'2024-12-09 02:39:40',0,NULL),(295,'123','캠페인','123','1234','1234',0,'2024-12-09 02:39:40',0,NULL),(296,'123','캠페인','123','1234','1234',0,'2024-12-09 02:39:40',0,NULL),(297,'123','캠페인','123','1234','1234',9,'2024-12-09 02:39:40',0,NULL),(298,'123','캠페인','123','1234','1234',10,'2024-12-09 02:39:40',0,NULL),(299,'123','캠페인','test','1234','1234',266,'2024-12-09 05:47:38',1,NULL),(300,NULL,'오늘의 건강','fdsa','fdsa',NULL,17,'2024-12-09 10:37:52',1,NULL),(301,NULL,'오늘의 건강','fdas','fdas',NULL,38,'2024-12-09 10:44:37',2,NULL),(302,NULL,'오늘의 건강','ㅕㅛㅅ','ㅕㅛㅅ',NULL,75,'2024-12-10 07:35:51',1,NULL),(303,NULL,'캠페인','fdsa','fdsafdsa',NULL,1,'2024-12-10 13:36:54',0,NULL),(306,'taekyun','자유게시판','fdsa','fda',NULL,29,'2024-12-11 02:06:41',0,NULL),(307,NULL,'자유게시판','라꾸라꾸','침대는 라꾸라꾸\r\n생각나 자꾸자꾸\r\n~',NULL,41,'2024-12-11 03:02:02',1,NULL),(308,'taekyun','캠페인','캠페인','캠페인',NULL,16,'2024-12-11 10:12:24',0,NULL),(1302,'taekyun','오늘의 건강','test','test',NULL,3,'2024-12-12 04:22:42',0,NULL),(1303,'taekyun','오늘의 건강','fdsa','fdsa',NULL,12,'2024-12-12 04:24:25',1,NULL),(1304,'98jiyong','오늘의 건강','목소리가 안나오는 이유','감기가 걸렸을 때 목소리가 안나오는 이유는?\r\n진동을 울려야하는 공간이 필요한데 성대가 부어서 울릴 수 있는 공간이 사라진다.\r\n라고 생각합니다.',NULL,15,'2024-12-13 13:45:05',2,NULL),(1305,'taekyun','자유게시판','파일이 올라가나','안올라가나',NULL,3,'2024-12-14 02:24:27',0,NULL),(1306,'taekyun','자유게시판','이제는 파일이 올라가겠지?','안올라가면 화냄',NULL,4,'2024-12-14 02:25:59',0,NULL),(1307,'taekyun','캠페인','쿼리 누가바꿔놧어','','taekyun',6,'2024-12-14 02:31:03',0,NULL),(1308,'taekyun','오늘의 건강','왜 안돼','ㄹㅇㄴㅁ','taekyun',3,'2024-12-14 02:33:36',0,NULL),(1309,'taekyun','캠페인','왜 파일에 아이디가 올라가','','taekyun',2,'2024-12-14 02:37:22',0,NULL),(1310,'taekyun','의료정보','System.out.println','제발','taekyun',3,'2024-12-14 02:39:11',0,NULL),(1311,'taekyun','자유게시판','잘 들어갔는데 ','왜 db저장만 아이디로 되냐고\r\n이제 제대로 들어간다 ㅎㅎ\r\n\r\n파일명 제대로 들어감ㅎㅎㅎ\r\n다운로드도 잘하면 될거 같은데 시간없으니까\r\n이따 돌아와서 해야지\r\n','dd7ad95d-7671-436e-b8a0-1f7c29939f28.jpg',6,'2024-12-14 02:43:31',0,NULL),(2302,'test','오늘의 건강','제발','','null',1,'2024-12-15 11:09:10',0,''),(2303,'test','오늘의 건강','한번에 되면 좋겠다','오류 싫어요','0e0bd651-11bc-4dc4-b10e-e5d7285cf078.jpg',30,'2024-12-15 11:09:31',0,'1번 이미지.jpg'),(2304,'test','오늘의 건강','ㄹㅇㄴㅁ','ㄹㅇㄴㅁ','e81bc736-bc75-48da-90ad-a25e6e18897d.png',1,'2024-12-15 11:20:30',0,'free-icon-account-12102111.png');
/*!40000 ALTER TABLE `testboard` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_doctor`
--

DROP TABLE IF EXISTS `user_doctor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_doctor` (
  `user_doctor_code` varchar(50) NOT NULL,
  `user_doctor_id` varchar(12) DEFAULT NULL,
  `user_doctor_hospital_code` varchar(12) DEFAULT NULL,
  `user_doctor_medical` varchar(10) DEFAULT NULL,
  `user_doctor_career` varchar(100) DEFAULT NULL,
  `user_doctor_graduate` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`user_doctor_code`),
  KEY `fk_user_doctor_id` (`user_doctor_id`),
  KEY `fk_user_doctor_hospital_code` (`user_doctor_hospital_code`),
  CONSTRAINT `fk_user_doctor_hospital_code` FOREIGN KEY (`user_doctor_hospital_code`) REFERENCES `hospital` (`hospital_code`),
  CONSTRAINT `fk_user_doctor_id` FOREIGN KEY (`user_doctor_id`) REFERENCES `users` (`user_id`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_doctor`
--

LOCK TABLES `user_doctor` WRITE;
/*!40000 ALTER TABLE `user_doctor` DISABLE KEYS */;
INSERT INTO `user_doctor` VALUES ('0015b7e8-6d3a-40a9-8dca-fc5f4318a48c','tjdnfskdl1','HOSP008','내과','신경과 전문의 8년 경력','부산대 의대 졸업'),('003e9123-f31a-400b-b877-41ac647b341f','ehdtndnjs2','HOSP031','외과','신경외과 전문의 7년 경력','강원대 의대 졸업'),('00ab3b7e-ae2e-42cf-bcba-81db0c1bb5a9','qptmxkq2','HOSP013','비뇨기과','비뇨기과 전문의 7년 경력','중앙대 의대 졸업'),('064236a4-a6e1-4110-9122-faa1a6eded30','ghkdlxm2','HOSP026','내과','내과 전문의 12년 경력','한양대 의대 졸업'),('0d41a58f-6cff-44bb-9324-c7badea3c1c6','chdltm2','HOSP012','성형외과','성형외과 전문의 16년','성균관대 의대 졸업'),('0ed1b71e-107d-46fe-9337-c275d5431a27','qortjd1','HOSP018','피부과','피부과 전문의 13년 경력','경북대 의대 졸업'),('10c2f661-deb4-409f-9cc9-5dd9ff55abd9','tjdah1','HOSP005','정형외과','정형외과 전문의 18년 경력','연세대 의대 졸업'),('17c0d8bd-3d7e-4374-9385-86f29baf4058','qortjd2','HOSP018','내과','내분비내과 전문의 9년 경력','서울의대 졸업'),('22648f52-ef24-430c-a7a7-f14991943be8','wjdekq1','HOSP029','정형외과','정형외과 전문의 6년 경력','경희대 의대 졸업'),('29629872-cf59-42f3-b180-ea78d21c3db7','tjdnf881','HOSP019','외과','신경외과 전문의 5년 경력','서울대 의대 졸업'),('2a118d12-3520-4198-96c5-e4219098cf36','dkwn2','HOSP032','피부과','피부과 전문의 13년 경력','전남대 의대 졸업'),('2f32a036-814c-4bde-ad8d-c2135be376c5','ghkdlxm1','HOSP026','소아청소년과','소아과 전문의 9년 경력','고려대 의대 졸업'),('346687a5-6ed1-4657-a130-f21c9130c270','tnlwm1','HOSP028','산부인과','산부인과 전문의 11년 경력','경희대 의대 졸업'),('35a4ed47-92d0-412b-ac37-e5fe1634ba15','rlacks1','HOSP016','피부과','피부과 전문의 11년 경력','한양대 의대 졸업'),('39859300-ef55-47cf-bb8b-84cd44d9e9d7','dmlfyqjqdls2','HOSP009','비뇨기과','비뇨기과 전문의 10년 경력','울산대 의대 졸업'),('3b1fbe25-7838-47aa-9eab-0f3843b4c0e8','qptmxkq1','HOSP013','내과','내과 전문의 15년 경력','경북대 의대 졸업'),('3cd720c1-f855-411c-8e81-abf95962e04d','dkwn1','HOSP032','성형외과','성형외과 전문의 8년','아주대 의대 졸업'),('3d1a1632-0b25-423e-ad30-7514b7cd4dc4','tkatjdxkq2','HOSP007','안과','안과 전문의 10년 경력','경희대 의대 졸업'),('446b6fb6-9ec9-49ee-8f10-f5d3d1b8655b','rkdskadutjd1','HOSP021','소아청소년과','소아심장과 전문의 12년 경력','서울대 의대 졸업'),('44ea9a4d-9424-4b39-8985-1368904decc3','aoxkstkatjd2','HOSP004','소아청소년과','소아과 전문의 15년 경력','부산대 의대 졸업'),('452655ac-08db-4309-855a-b207591792eb','chdltm1','HOSP012','내과','알레르기내과 전문의 8년 경력','부산대 의대 졸업'),('4a30eb8b-effe-462c-89be-785d440dbfff','rlaalsgml2','HOSP002','소아청소년과','경력 8년차','서울대의대/박사학위'),('4fb63188-1578-4a0a-ae21-5a1234cb85cf','jojungon','HOSP001','내과','23년','일산동고등학교/졸업'),('4fb63188-1578-4a0a-ae21-5a2786cb85cf','gkgjfj','HOSP001','산부인과','33년','수원고등학교/졸업'),('56b51cc6-ebd9-400d-89a3-63dfd318db50','gksehr2','HOSP024','안과','안과 전문의 10년 경력','경희대 의대 졸업'),('5774a2ca-7708-41c8-afa3-ba00112a5429','xndb1','HOSP025','정신건강의학과','정신건강의학과 경력 16년','부산대 의대 졸업'),('599ac6c4-3a99-41d9-87fb-1c57c6ffe72a','rkxhfflr2','HOSP015','산부인과','산부인과 전문의 20년 경력','고려대 의대 졸업'),('65ac736e-f465-418d-a87f-51cbf71d7d17','tjdah2','HOSP005','외과','신경외과 전문의 5년 경력','서울대 의대 졸업'),('661ca1ef-61cc-4a09-bfff-029833c6065a','tndnjstjd1','HOSP006','정신건강의학과','심리상담 전문의 17년 경력','울산대 의대 졸업'),('6720afef-cbe9-46bb-9fdf-9d67c0e4bc54','gksehr1','HOSP024','비뇨기과','비뇨기과 전문의 7년 경력','고려대 의대 졸업'),('6762533e-d1cb-42b7-8467-bf1f26f3374f','gotjd1','HOSP023','외과','외과 전문의 12년 경력','연세대 의대 졸업'),('69a2f3d4-6c31-4924-83bb-21b9b6adee3e','rkxhfflr1','HOSP015','정형외과','정형외과 전문의 12년 경력','한양대 의대 졸업'),('7a1b5666-03c9-4254-9edf-750046fa4986','ehdtndnjs1','HOSP031','소아청소년과','소아청소년과 14년 경력','가천대 의대 졸업'),('7ba6e64d-a496-4639-825c-49460241bd11','dmlfyqjqdls1','HOSP009','피부과','피부과 전문의 11년 경력','한양대 의대 졸업'),('80f28d0b-fd56-4305-8153-a540464c632f','wjdekq2','HOSP029','안과','안과 전문의 13년 경력','고려대 의대 졸업'),('84b3e93e-4a97-453f-9a13-8bafc5ab1067','dnfl1','HOSP027','성형외과','성형외과 전문의 8년','연세대 의대 졸업'),('8a88934e-9864-478a-97e5-015c55bc6f13','tjdnf882','HOSP019','성형외과','마취과 전문의 11년 경력','서울의대 졸업'),('8eca39fd-9052-4545-8dcf-bc3785910df7','gotjd2','HOSP023','내과','호흡기내과 전문의 6년 경력','중앙대 의대 졸업'),('905304db-6291-4568-bfba-239030e7a652','tjdnfskdl2','HOSP008','정형외과','정형외과 전문의 18년 경력','중앙대 의대 졸업'),('9c5a6e81-4e6f-4d44-9978-7fef48a13e0c','rlawjddh1','HOSP003','피부과','피부과 전문의 8년 경력','고려대 의대 졸업'),('9d8b6cd0-cff4-49c3-a982-8374d5eceecb','aoxkstkatjd1','HOSP004','내과','심장내과 전문의 10년 경력','경북대 의대 졸업'),('9de45ace-7612-493f-9506-420998401aeb','dnfl2','HOSP027','이비인후과','이비인후과 전문의 16년 경력','서울대 의대 졸업'),('a9d97d09-3a24-412d-87e5-eee702a3dc1b','gksmfakdma1','HOSP017','정신건강의학과','심리상담 전문의 15년 경력','연세대 의대 졸업'),('b33ada18-c2e4-4049-ab71-a0b1aa151657','rlawjddh2','HOSP003','안과','안과 전문의 10년 경력','경희대 의대 졸업'),('b8d686db-b265-4546-a262-862f851d5e34','rkdskadutjd2','HOSP021','피부과','피부과 전문의 11년 경력','한양대 의대 졸업'),('bd66e593-6663-48e4-baea-872a29df3529','tndnjstjd2','HOSP006','정신건강의학과','정신과 전문의 25년 경력','연세대 의대 졸업'),('c37b2983-c6d2-4ad8-8257-2e77f5f10d0a','tjdnfQNfl1','HOSP011','외과','신경외과 전문의 9년 경력','경희대 의대 졸업'),('cb31cc3b-b399-46ac-9f68-95783a86676e','tnlwm2','HOSP028','피부과','피부과 전문의 8년 경력','부산대 의대 졸업'),('dc288d41-b757-4a7a-ae64-29a67e05f99e','rlacks2','HOSP016','외과','위장관외과 전문의 16년 경력','고려대 의대 졸업'),('e039dcc3-491c-489f-8e90-7ac41addb550','rlaalsgml1','HOSP002','피부과','경력 10년차','가톨릭대학교/석사학위'),('ee2e2f62-6609-4f90-8ce0-85042093558a','aodgotjd1','HOSP010','이비인후과','이비인후과 전문의 13년 경력','가천대 의대 졸업'),('ee40e5bc-b7d4-4fd4-a933-f45b1ce279e4','aodgotjd2','HOSP010','피부과','피부과 전문의 11년 경력','한양대 의대 졸업'),('f1fc0be2-bb8a-4521-82f6-45c195055d9b','gksmfakdma2','HOSP017','정형외과','재활의학과 전문의 11년 경력','성균관대 의대 졸업'),('f251a752-208c-4c5e-96d4-8c7e4e5ced8b','tjdnfQnfl2','HOSP011','외과','치과 전문의 10년 경력','서울대 의대 졸업'),('f8bbf34d-e1f0-4795-b763-8fec870cf7f4','tjdfn1','HOSP033','내과','소화기내과 6년 경력','인하대 의대 졸업'),('f99010d5-cee5-4f45-ade6-59534add53bb','tjdnf2','HOSP033','비뇨기과','비뇨기과 전문의 21년 경력','한양대 의대 졸업'),('faf970e5-4e7b-4003-8732-f7deaf809f3c','tkatjdxkq1','HOSP007','내과','내분비내과 전문의 14년 경력','서울의대 졸업'),('fe621b55-f517-4346-b6c8-ee294c904cac','xndb2','HOSP025','외과','신경외과 전문의 5년 경력','경희대 의대 졸업');
/*!40000 ALTER TABLE `user_doctor` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users` (
  `user_id` varchar(12) NOT NULL,
  `user_password` varchar(100) DEFAULT NULL,
  `user_name` varchar(10) DEFAULT NULL,
  `user_name_eng` varchar(20) DEFAULT NULL,
  `user_register_number` varchar(15) DEFAULT NULL,
  `user_tel` varchar(13) DEFAULT NULL,
  `user_addr` varchar(100) DEFAULT NULL,
  `user_email` varchar(30) DEFAULT NULL,
  `user_authority` varchar(12) DEFAULT NULL,
  `user_info_agreement` varchar(300) DEFAULT NULL,
  `user_image` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`user_id`),
  UNIQUE KEY `user_register_number` (`user_register_number`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES ('98jiyong','jung3202','정지용','Jeong Jiyong','980814-1111111','010-8740-5966','16475,경기 수원시 팔달구 인계로 21,수원센트럴아이파크자이 113동 1404호, (인계동)','98jiyong@gmail.com','client','agree','client_image.jpg'),('admin','admin','관리자','ADMIN ','111111-1111111','111-1111-1111','16475,경기 수원시 팔달구 인계로 21,수원센트럴아이파크자이 113동 1404호, (인계동)','98jiyong@gmail.com','admin','agree','client_image.jpg'),('angry','123','김지훈','123 123','123123-1231231','123-123-123','21982,인천 연수구 송도과학로27번길 55,, (송도동, 롯데캐슬 캠퍼스타운)','jojungon@gmail.com','doctor','agree','doctor_image.jpg'),('aodgotjd1','aodgotjd1','이윤아','qtqt qtqt','121646-4899746','010-5249-4456','55713,전북특별자치도 남원시 아영면 광주대구고속도로 76-1,,','stk131@naver.com','doctor','agree','doctor_image.jpg'),('aodgotjd2','aodgotjd2','백성원','vdvd vdvd','123465-4654899','010-1356-4941','63534,제주특별자치도 서귀포시 가가로 28-19,, (상예동)','stk131@naver.com','doctor','agree','doctor_image.jpg'),('aoxkstkatjd1','aoxkstkatjd1','최지우','uyrt uyrt','449878-4564564','010-3545-4899','13586,경기 성남시 분당구 분당로201번길 17,, (서현동, 효자촌)','stk131@naver.com','doctor','agree','doctor_image.jpg'),('aoxkstkatjd2','aoxkstkatjd2','이준호','asdf asdf','123444-4546589','010-3548-7894','08362,서울 구로구 부광로 88,ㅁㄴㅇㄹ, (항동)','stk131@naver.com','doctor','agree','doctor_image.jpg'),('chdltm1','chdltm1','김현지','rqrq rqqrq','rqrq-rqqr','010-1648-4985','10293,경기 고양시 덕양구 수원문산고속도로 56,, (성사동)','stk131@naver.com','doctor','agree','doctor_image.jpg'),('chdltm2','chdltm2','구지은','lili lili','498784-4566516','010-1649-4987','12758,경기 광주시 경안로 13-7,, (경안동)','stk131@naver.com','doctor','agree','doctor_image.jpg'),('dhgn206','dhgn206','천장미','Cheon Jangmee','980208-2163482','010-1234-1234','14537,경기 부천시 원미구 계남로 104,, (중동)','98jiyong1@naver.com','client','agree',NULL),('dkwn1','dkwn1','문지영','jiyung mun','876498-3649849','010-3426-5987','63534,제주특별자치도 서귀포시 가가로27번길 6,, (상예동)','stk131@naver.com','doctor','agree','doctor_image.jpg'),('dkwn2','dkwn2','최성훈','sunghoon choi','865495-1254987','010-659-4638','37862,경북 포항시 남구 괴동로 6,, (장흥동)','stk131@naver.com','doctor','agree','doctor_image.jpg'),('dmlfyqjqdls1','dmlfyqjqdls1','이정훈','thth thth','164489-4895656','010-1234-6543','48060,부산 해운대구 APEC로 68,, (우동)','stk131@naver.com','doctor','agree','doctor_image.jpg'),('dmlfyqjqdls2','dmlfyqjqdls2','정수민','azaza azza','156456-8589484','010-2546-9546','03693,서울 서대문구 가재울로 12,, (남가좌동)','stk131@naver.com','doctor','agree','doctor_image.jpg'),('dnfl1','dnfl1','이지훈','jihoon lee','765432-1564896','010-1354-1357','04419,서울 용산구 독서당로 101,, (한남동)','stk131@naver.com','doctor','agree','doctor_image.jpg'),('dnfl2','dnfl2','홍성호','sungho hong','735468-4324156','010-4359-6158','01051,서울 강북구 노해로22길 7-9,, (수유동)','stk131@naver.com','doctor','agree','doctor_image.jpg'),('ehdtndnjs1','ehdtndnjs1','양혜린','hyerin yang','765987-6549865','010-1349-4168','24235,강원특별자치도 춘천시 가래매기길 11-1,, (사농동)','stk131@naver.com','doctor','agree','doctor_image.jpg'),('ehdtndnjs2','ehdtndnjs2','정소은','soeun jung','963547-5454986','010-1359-6489','31067,충남 천안시 동남구 가마골1길 43,, (신부동)','stk131@naver.com','doctor','agree','doctor_image.jpg'),('ghkdlxm1','ghkdlxm1','김세정','sejung kim','964535-5489634','010-6486-9876','03139,서울 종로구 돈화문로5길 36,, (낙원동)','stk131@naver.com','doctor','agree','doctor_image.jpg'),('ghkdlxm2','ghkdlxm2','최지현','jihyun choi','864521-6874465','010-4684-3125','17743,경기 평택시 가재길 102,, (가재동)','stk131@naver.com','doctor','agree','doctor_image.jpg'),('gkgjfj','2121','최진석','Jungon Jo','950718-1245781','010-6880-3477','21982,인천 연수구 송도과학로27번길 55,101동 3604호, (송도동, 롯데캐슬 캠퍼스타운)','jojungon@gmail.com','doctor','agree','85a0637d-4202-4913-8851-63162b7b8b98.jpg'),('gksehr1','gksehr1','임찬호','pupu pupu','984898-8945648','010-4687-6521','54002,전북특별자치도 군산시 가도로 14,, (오식도동)','stk131@naver.com','doctor','agree','doctor_image.jpg'),('gksehr2','gksehr2','오수진','qwer rewer','765215-4564145','010-9876-1546','13473,경기 성남시 분당구 서판교로 164,, (판교동)','stk131@naver.com','doctor','agree','doctor_image.jpg'),('gksmfakdma1','gksmfakdma1','장도현','ynyn ynyn','768496-4964846','010-8647-1354','36751,경북 안동시 충효로 4459,, (정하동)','stk131@naver.com','doctor','agree','doctor_image.jpg'),('gksmfakdma2','gksmfakdma2','조하늘','egeg egeg','976549-4663415','010-1687-6486','55945,전북특별자치도 임실군 삼계면 순천완주고속도로 71,,','stk131@naver.com','doctor','agree','doctor_image.jpg'),('gotjd1','gotjd1','신서진','rkrk rkrk','864135-9684564','010-6469-4687','39214,경북 구미시 선기동 748-1,,','stk131@naver.com','doctor','agree','doctor_image.jpg'),('gotjd2','gotjd2','임지혜','bi sang','795489-3434864','010-1468-7496','12647,경기 여주시 세종대왕면 광대1길 10-8,,','stk131@naver.com','doctor','agree','doctor_image.jpg'),('jjg123','123','전민수','123 123','123-123','123-123-123','21982,인천 연수구 송도과학로27번길 55,101동 3604호, (송도동, 롯데캐슬 캠퍼스타운)','jojungon@gmail.com','doctor','agree','0ce0f070-4df5-4552-af6a-daca2736023c.'),('jojungon','1234','조준곤','Jungon Jo','950718-1234567','010-6880-3477','21982,인천 연수구 송도과학로27번길 55,101동 3604호, (송도동, 롯데캐슬 캠퍼스타운)','jojungon@naver.com','doctor','agree','doctor_image.jpg'),('khgwonjae','dnjswo123','이원재','Lee Wonjae','980814-1231231','010-2818-2716','16475,경기 수원시 팔달구 인계로 21,수원센트럴아이파크자이 113동 1404호, (인계동)','98jiyong@gmail.com','client','agree','client_image.jpg'),('kikiki','123','윤호영','1231 123','950718-asdfasd','123-123-123','21982,인천 연수구 송도과학로27번길 55,101동 3604호, (송도동, 롯데캐슬 캠퍼스타운)','jojungon@gmail.com','doctor','agree','doctor_image.jpg'),('qortjd1','qortjd1','박경미','tqtqtq tqtqtq','796486-4684646','010-4687-4686','25953,강원특별자치도 삼척시 가곡면 가곡천로 481-6,,','stk131@naver.com','doctor','agree','doctor_image.jpg'),('qortjd2','qortjd2','오윤석','tbtb tbtb','799846-6548965','010-7684-3468','11684,경기 의정부시 가금로 57-9,, (가능동','stk131@naver.com','doctor','agree',NULL),('qptmxkq1','qptmxkq1','유정훈','miyaong miyaong','976546-4135498','010-8975-3574','10544,경기 고양시 덕양구 가양대로 110,, (덕은동)','stk131@naver.com','doctor','agree','doctor_image.jpg'),('qptmxkq2','qptmxkq2','송민경','gtgt gtgt','498494-3218998','010-4987-3648','40240,경북 울릉군 울릉읍 독도이사부길 63,,','stk131@naver.com','doctor','agree','doctor_image.jpg'),('rkdskadutjd1','rkdskadutjd2','서민정','mung mung','449878-7684648','010-5468-3468','61639,광주 남구 천변좌로 394-1,, (사동)','stk131@naver.com','doctor','agree','doctor_image.jpg'),('rkdskadutjd2','rkdskadutjd2','김유라','doolki bi','999999-9999999','010-9999-9999','14912,경기 시흥시 비둘기공원로 8,, (대야동)','stk131@naver.com','doctor','agree','doctor_image.jpg'),('rkxhfflr1','rkxhfflr1','전서윤','su shi','987464-4984687','010-7498-7958','48485,부산 남구 석포로127번길 35,, (대연동)','stk131@naver.com','doctor','agree','doctor_image.jpg'),('rkxhfflr2','rkxhfflr2','김도영','jmjm jmjm','987646-4561541','010-6498-4987','40222,경북 울릉군 울릉읍 도동2길 10,,','stk131@naver.com','doctor','agree','doctor_image.jpg'),('rlaalsgml1','rlaalsgml1','이상윤','Lee Sangyoon','980810-1111111','010-8740-5966','16475,경기 수원시 팔달구 인계로 21,수원센트럴아이파크자이 113동 1404호, (인계동)','98jiyong@gmail.com','doctor','agree','doctor_image.jpg'),('rlaalsgml2','rlaalsgml2','노상협','Noh Sanghyeop','981201-1111111','010-9264-0687','06271,서울 강남구 남부순환로 2641,202동 1101호, (도곡동)','98jiyong@gmail.com','doctor','agree','doctor_image.jpg'),('rlacks1','rlacks1','조혜진','yhyh yhyh','126345-4687446','010-3186-4684','18510,경기 화성시 경기동로 439,, (장지동)','stk131@naver.com','doctor','agree','doctor_image.jpg'),('rlacks2','rlacks2','배지현','ghgh ghgh','780324-6498465','010-9764-1354','25953,강원특별자치도 삼척시 가곡면 가곡천로 481-10,,','stk131@naver.com','doctor','agree','doctor_image.jpg'),('rlawjddh1','rlawjddh1','최승현','qwer qwer','780324-1346884','010-1354-4684','13607,경기 성남시 분당구 내정로 54,, (정자동, 한솔마을주공6단지아파트)','stk131@naver.com','doctor','agree','doctor_image.jpg'),('rlawjddh2','rlawjddh2','정영진','rewq rewq','126345-1231211','010-1236-1234','13617,경기 성남시 분당구 미금로 246,ㄱㄷㅈㅂ, (금곡동, 청솔마을주공6단지아파트)','stk131@naver.com','doctor','agree','doctor_image.jpg'),('silversoo','dmstn123','김은수','KIm Eunsoo','123123-0987654','010-1234-1234','13543,경기 성남시 분당구 대왕판교로 364,, (백현동)','98jiyong1@naver.com','client','agree',NULL),('taekyun','4321','신태균','Taekyun Sin','111111-11111111','010-1111-1111','16475,경기 수원시 팔달구 인계로 21,113동 1404호, (인계동)','stk131@naver.com','doctor','agree','doctor_image.jpg'),('test','test','테스트','test test','123456-1234567','010-1234-1234','16475,경기 수원시 팔달구 인계로 21,113동 1404호, (인계동)','98jiyong@gmail.com','client','agree','doctor_image.jpg'),('tjdah1','tjdah1','양수빈','gfds gfds','789789-4564654','010-3564-4548','03011,서울 종로구 북악산로 221,, (평창동)','stk131@naver.com','doctor','agree','doctor_image.jpg'),('tjdah2','tjdah2','박서연','asas asas','746456-1456165','010-3156-1215','61402,광주 동구 필문대로 2,, (계림동)','stk131@naver.com','doctor','agree','doctor_image.jpg'),('tjdfn1','tjdnf1','이형진','hyungjin lee','863246-1655428','010-6812-4638','58762,전남 목포시 고하대로 20,, (달동)','stk131@naver.com','doctor','agree','doctor_image.jpg'),('tjdnf2','tjdnf2','오경아','kyunga oh','649765-6359846','010-4689-6432','28002,충북 괴산군 불정면 한불로요막1길 2,,','stk131@naver.com','doctor','agree','doctor_image.jpg'),('tjdnf881','tjdnf881','나지호','opop opop','764996-4965846','010-4686-7979','54921,전북특별자치도 전주시 덕진구 백제대로 680,, (금암동)','stk131@naver.com','doctor','agree','doctor_image.jpg'),('tjdnf882','tjdnf882','최지영','btbt btbt','764984-7498464','010-7649-1648','15888,경기 군포시 건건로 243-2,, (대야미동)','stk131@naver.com','doctor','agree','doctor_image.jpg'),('tjdnfQNfl1','tjdnfQnfl1','장미정','trtr trtrt','974685-1638549','010-4987-4652','12609,경기 여주시 대신면 광주원주고속도로 26,,','stk131@naver.com','doctor','agree','doctor_image.jpg'),('tjdnfQnfl2','tjdnfQNfl2','한예린','popop popo','464849-4984685','010-6489-4987','25508,강원특별자치도 강릉시 가작로 13,, (교동)','stk131@naver.com','doctor','agree','doctor_image.jpg'),('tjdnfskdl1','tjdnfskdl1','권소영','gtgt gtgt','123154-8974564','010-5265-1854','05503,서울 송파구 한가람로 129,, (잠실동)','stk131@naver.com','doctor','agree','doctor_image.jpg'),('tjdnfskdl2','tjdnfskdl2','박태희','hyhy hyhy','hyhy-hyhy','010-4156-7789','05537,서울 송파구 강동대로 59-8,, (풍납동)','stk131@naver.com','doctor','agree','doctor_image.jpg'),('tkatjdxkq1','tkatjdxkq1','이지은','jhjh jhjh','112315-56+5464','010-2325-4155','15382,경기 안산시 단원구 라성안길 11,, (원곡동)','stk131@naver.com','doctor','agree','doctor_image.jpg'),('tkatjdxkq2','tkatjdxkq2','홍지윤','gfgf gfgf','124564-4774449','010-1354-7894','34000,대전 유성구 라온1길 61,, (신동)','stk131@naver.com','doctor','agree','doctor_image.jpg'),('tndnjstjd1','tndnjstjd1','문성호','fsfs fsfs','121464-4644984','010-3516-4646','05237,서울 강동구 아리수로 46,, (암사동)','stk131@naver.com','doctor','agree','doctor_image.jpg'),('tndnjstjd2','tndnjstjd2','강민수','dsds dsds','415241-4156465','010-3546-1231','26382,강원특별자치도 원주시 로아노크로 1,, (단계동)','stk131@naver.com','doctor','agree','doctor_image.jpg'),('tnlwm1','tnlwm1','박선미','sunmi park','126345-7654318','010-9765-3666','23103,인천 옹진군 백령면 백령로 866-10,,','stk131@naver.com','doctor','agree','doctor_image.jpg'),('tnlwm2','tnlwm2','김태경','taekyung kim','462635-1368587','010-6489-6733','32597,충남 공주시 가나무정길 62,, (상왕동)','stk131@naver.com','doctor','agree','doctor_image.jpg'),('wjdekq1','wjdekq1','한유나','yuna han','764534-6548954','010-3458-6876','55783,전북특별자치도 남원시 주생면 광주대구고속도로 43,,','stk131@naver.com','doctor','agree','doctor_image.jpg'),('wjdekq2','wjdekq2','서정민','jungmin soe','684976-2164896','010-6489-9354','11900,경기 구리시 담터길32번길 111,, (갈매동)','stk131@naver.com','doctor','agree','doctor_image.jpg'),('xndb1','xndb1','유진우','fgfg fgfg','780324-7645494','010-6315-8465','16661,경기 수원시 권선구 경수대로 89-6,, (대황교동)','stk131@naver.com','doctor','agree','doctor_image.jpg'),('xndb2','xndb2','한상민','ewew ewew','746598-4564165','010-4358-4684','16069,경기 의왕시 사천로 11,, (왕곡동)','stk131@naver.com','doctor','agree','doctor_image.jpg'),('yunyul','yunyul841','윤율','yun yul','123456-7894561','010-1234-5678','16457,경기 수원시 팔달구 향교로 93,101호, (매산로3가)','98jiyong1@naver.com','client','agree',NULL);
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `vaccine`
--

DROP TABLE IF EXISTS `vaccine`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `vaccine` (
  `vaccine_code` varchar(10) DEFAULT NULL,
  `vaccine_list` varchar(10) DEFAULT NULL,
  `vaccine_ex` varchar(30) DEFAULT NULL,
  `vaccine_possible` varchar(10) DEFAULT NULL,
  KEY `fk_vaccine_code` (`vaccine_code`),
  CONSTRAINT `fk_vaccine_code` FOREIGN KEY (`vaccine_code`) REFERENCES `hospital` (`hospital_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `vaccine`
--

LOCK TABLES `vaccine` WRITE;
/*!40000 ALTER TABLE `vaccine` DISABLE KEYS */;
/*!40000 ALTER TABLE `vaccine` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Final view structure for view `hospital_doctor`
--

/*!50001 DROP VIEW IF EXISTS `hospital_doctor`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_unicode_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `hospital_doctor` AS (select `hd`.`hospital_code` AS `hospital_code`,`hd`.`hospital_name` AS `hospital_name`,`hd`.`hospital_addr` AS `hospital_addr`,`hd`.`hospital_tel` AS `hospital_tel`,`hd`.`hospital_date` AS `hospital_date`,`hd`.`hospital_time` AS `hospital_time`,`hd`.`hospital_notice` AS `hospital_notice`,`hd`.`hospital_intro` AS `hospital_intro`,`hd`.`user_doctor_code` AS `user_doctor_code`,`hd`.`user_doctor_id` AS `user_doctor_id`,`hd`.`user_doctor_hospital_code` AS `user_doctor_hospital_code`,`hd`.`user_doctor_medical` AS `user_doctor_medical`,`hd`.`user_doctor_career` AS `user_doctor_career`,`hd`.`user_doctor_graduate` AS `user_doctor_graduate`,`u`.`user_id` AS `user_id`,`u`.`user_password` AS `user_password`,`u`.`user_name` AS `user_name`,`u`.`user_name_eng` AS `user_name_eng`,`u`.`user_register_number` AS `user_register_number`,`u`.`user_tel` AS `user_tel`,`u`.`user_addr` AS `user_addr`,`u`.`user_email` AS `user_email`,`u`.`user_authority` AS `user_authority`,`u`.`user_info_agreement` AS `user_info_agreement`,`u`.`user_image` AS `user_image` from ((select `h`.`hospital_code` AS `hospital_code`,`h`.`hospital_name` AS `hospital_name`,`h`.`hospital_addr` AS `hospital_addr`,`h`.`hospital_tel` AS `hospital_tel`,`h`.`hospital_date` AS `hospital_date`,`h`.`hospital_time` AS `hospital_time`,`h`.`hospital_notice` AS `hospital_notice`,`h`.`hospital_intro` AS `hospital_intro`,`ud`.`user_doctor_code` AS `user_doctor_code`,`ud`.`user_doctor_id` AS `user_doctor_id`,`ud`.`user_doctor_hospital_code` AS `user_doctor_hospital_code`,`ud`.`user_doctor_medical` AS `user_doctor_medical`,`ud`.`user_doctor_career` AS `user_doctor_career`,`ud`.`user_doctor_graduate` AS `user_doctor_graduate` from (`hospital` `h` left join `user_doctor` `ud` on(`ud`.`user_doctor_hospital_code` = `h`.`hospital_code`))) `hd` left join `users` `u` on(`hd`.`user_doctor_id` = `u`.`user_id`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-02-24 11:06:24
