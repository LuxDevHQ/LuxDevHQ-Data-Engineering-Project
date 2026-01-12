>>> Installation of a psql database  >>> 
          >>> IAutomatically it comes with public schema 
          
---- When you create a table, without specifiying, the schema >>> public schema 
          by default  
          
create schema staging;
          


select *
from
staging.cdr_usage;

----Total Number of unique counties 
select count( distinct county )
from
staging.cdr_usage;




create table staging.cdr_usage(
	cdr_id INT, 
	msisdn VARCHAR(12), 
	subscriber_name VARCHAR(100), 
	county VARCHAR(70),
	network VARCHAR(100),
	call_type VARCHAR(15),
	call_direction VARCHAR(15),
	duration_seconds INT, 
	data_mb NUMERIC(10,2),
	amount_charged NUMERIC(10,2),
	transaction_date TIMESTAMP
); 



INSERT INTO staging.cdr_usage VALUES
(1,'254700000001','Subscriber_1','Nairobi','Safaricom','VOICE','OUTGOING',180,0,25.00,'2025-12-01 08:10:00');
INSERT INTO staging.cdr_usage VALUES
(2,'254700000002','Subscriber_2','Kiambu','Safaricom','DATA','OUTGOING',0,120.50,80.00,'2025-12-01 08:15:00');
INSERT INTO staging.cdr_usage VALUES
(3,'254700000003','Subscriber_3','Machakos','Airtel','SMS','OUTGOING',0,0,5.00,'2025-12-01 08:20:00');
INSERT INTO staging.cdr_usage VALUES
(4,'254700000004','Subscriber_4','Nairobi','Safaricom','VOICE','INCOMING',300,0,0.00,'2025-12-01 08:30:00');
INSERT INTO staging.cdr_usage VALUES
(5,'254700000005','Subscriber_5','Kisumu','Telkom','DATA','OUTGOING',0,350.75,150.00,'2025-12-01 08:40:00');
INSERT INTO staging.cdr_usage VALUES
(6,'254700000006','Subscriber_6','Nakuru','Safaricom','VOICE','OUTGOING',220,0,30.00,'2025-12-01 08:50:00');
INSERT INTO staging.cdr_usage VALUES
(7,'254700000007','Subscriber_7','Mombasa','Airtel','DATA','OUTGOING',0,500.00,200.00,'2025-12-01 09:00:00');
INSERT INTO staging.cdr_usage VALUES
(8,'254700000008','Subscriber_8','Kiambu','Safaricom','SMS','OUTGOING',0,0,5.00,'2025-12-01 09:10:00');
INSERT INTO staging.cdr_usage VALUES
(9,'254700000009','Subscriber_9','Nairobi','Safaricom','VOICE','OUTGOING',420,0,60.00,'2025-12-01 09:20:00');
INSERT INTO staging.cdr_usage VALUES
(10,'254700000010','Subscriber_10','Uasin Gishu','Telkom','DATA','OUTGOING',0,250.25,120.00,'2025-12-01 09:30:00');

INSERT INTO staging.cdr_usage VALUES
(11,'254700000011','Subscriber_11','Nakuru','Airtel','VOICE','INCOMING',600,0,0.00,'2025-12-02 08:00:00');
INSERT INTO staging.cdr_usage VALUES
(12,'254700000012','Subscriber_12','Machakos','Safaricom','DATA','OUTGOING',0,800.00,300.00,'2025-12-02 08:10:00');
INSERT INTO staging.cdr_usage VALUES
(13,'254700000013','Subscriber_13','Kiambu','Safaricom','SMS','OUTGOING',0,0,5.00,'2025-12-02 08:20:00');
INSERT INTO staging.cdr_usage VALUES
(14,'254700000014','Subscriber_14','Nairobi','Airtel','VOICE','OUTGOING',180,0,20.00,'2025-12-02 08:30:00');
INSERT INTO staging.cdr_usage VALUES
(15,'254700000015','Subscriber_15','Mombasa','Safaricom','DATA','OUTGOING',0,1024.00,350.00,'2025-12-02 08:40:00');
INSERT INTO staging.cdr_usage VALUES
(16,'254700000016','Subscriber_16','Kisumu','Safaricom','VOICE','OUTGOING',300,0,40.00,'2025-12-02 08:50:00');
INSERT INTO staging.cdr_usage VALUES
(17,'254700000017','Subscriber_17','Nakuru','Telkom','DATA','OUTGOING',0,600.00,220.00,'2025-12-02 09:00:00');
INSERT INTO staging.cdr_usage VALUES
(18,'254700000018','Subscriber_18','Kiambu','Airtel','SMS','OUTGOING',0,0,5.00,'2025-12-02 09:10:00');
INSERT INTO staging.cdr_usage VALUES
(19,'254700000019','Subscriber_19','Nairobi','Safaricom','VOICE','OUTGOING',480,0,70.00,'2025-12-02 09:20:00');
INSERT INTO staging.cdr_usage VALUES
(20,'254700000020','Subscriber_20','Machakos','Safaricom','DATA','OUTGOING',0,400.00,180.00,'2025-12-02 09:30:00');


INSERT INTO staging.cdr_usage VALUES
(21,'254700000021','Subscriber_21','Nairobi','Safaricom','VOICE','OUTGOING',240,0,35.00,'2025-12-03 08:00:00');
INSERT INTO staging.cdr_usage VALUES
(22,'254700000022','Subscriber_22','Kiambu','Airtel','DATA','OUTGOING',0,300.00,150.00,'2025-12-03 08:10:00');
INSERT INTO staging.cdr_usage VALUES
(23,'254700000023','Subscriber_23','Nakuru','Telkom','SMS','OUTGOING',0,0,5.00,'2025-12-03 08:20:00');
INSERT INTO staging.cdr_usage VALUES
(24,'254700000024','Subscriber_24','Mombasa','Safaricom','VOICE','INCOMING',360,0,0.00,'2025-12-03 08:30:00');
INSERT INTO staging.cdr_usage VALUES
(25,'254700000025','Subscriber_25','Kisumu','Safaricom','DATA','OUTGOING',0,720.50,260.00,'2025-12-03 08:40:00');
INSERT INTO staging.cdr_usage VALUES
(26,'254700000026','Subscriber_26','Machakos','Airtel','VOICE','OUTGOING',180,0,25.00,'2025-12-03 08:50:00');
INSERT INTO staging.cdr_usage VALUES
(27,'254700000027','Subscriber_27','Nairobi','Safaricom','SMS','OUTGOING',0,0,5.00,'2025-12-03 09:00:00');
INSERT INTO staging.cdr_usage VALUES
(28,'254700000028','Subscriber_28','Kiambu','Telkom','DATA','OUTGOING',0,450.00,190.00,'2025-12-03 09:10:00');
INSERT INTO staging.cdr_usage VALUES
(29,'254700000029','Subscriber_29','Nakuru','Safaricom','VOICE','OUTGOING',420,0,65.00,'2025-12-03 09:20:00');
INSERT INTO staging.cdr_usage VALUES
(30,'254700000030','Subscriber_30','Mombasa','Airtel','DATA','OUTGOING',0,520.75,210.00,'2025-12-03 09:30:00');

INSERT INTO staging.cdr_usage VALUES
(31,'254700000031','Subscriber_31','Uasin Gishu','Safaricom','VOICE','OUTGOING',300,0,45.00,'2025-12-04 08:00:00');
INSERT INTO staging.cdr_usage VALUES
(32,'254700000032','Subscriber_32','Nairobi','Safaricom','DATA','OUTGOING',0,880.00,320.00,'2025-12-04 08:10:00');
INSERT INTO staging.cdr_usage VALUES
(33,'254700000033','Subscriber_33','Kiambu','Airtel','SMS','OUTGOING',0,0,5.00,'2025-12-04 08:20:00');
INSERT INTO staging.cdr_usage VALUES
(34,'254700000034','Subscriber_34','Machakos','Safaricom','VOICE','INCOMING',540,0,0.00,'2025-12-04 08:30:00');
INSERT INTO staging.cdr_usage VALUES
(35,'254700000035','Subscriber_35','Kisumu','Telkom','DATA','OUTGOING',0,640.25,230.00,'2025-12-04 08:40:00');
INSERT INTO staging.cdr_usage VALUES
(36,'254700000036','Subscriber_36','Nakuru','Safaricom','VOICE','OUTGOING',210,0,30.00,'2025-12-04 08:50:00');
INSERT INTO staging.cdr_usage VALUES
(37,'254700000037','Subscriber_37','Mombasa','Airtel','DATA','OUTGOING',0,900.00,340.00,'2025-12-04 09:00:00');
INSERT INTO staging.cdr_usage VALUES
(38,'254700000038','Subscriber_38','Kiambu','Safaricom','SMS','OUTGOING',0,0,5.00,'2025-12-04 09:10:00');
INSERT INTO staging.cdr_usage VALUES
(39,'254700000039','Subscriber_39','Nairobi','Safaricom','VOICE','OUTGOING',480,0,75.00,'2025-12-04 09:20:00');
INSERT INTO staging.cdr_usage VALUES
(40,'254700000040','Subscriber_40','Machakos','Safaricom','DATA','OUTGOING',0,560.00,205.00,'2025-12-04 09:30:00');

INSERT INTO staging.cdr_usage VALUES
(41,'254700000041','Subscriber_41','Nakuru','Airtel','VOICE','INCOMING',600,0,0.00,'2025-12-05 08:00:00');
INSERT INTO staging.cdr_usage VALUES
(42,'254700000042','Subscriber_42','Kisumu','Safaricom','DATA','OUTGOING',0,780.00,290.00,'2025-12-05 08:10:00');
INSERT INTO staging.cdr_usage VALUES
(43,'254700000043','Subscriber_43','Kiambu','Safaricom','SMS','OUTGOING',0,0,5.00,'2025-12-05 08:20:00');
INSERT INTO staging.cdr_usage VALUES
(44,'254700000044','Subscriber_44','Mombasa','Telkom','VOICE','OUTGOING',260,0,35.00,'2025-12-05 08:30:00');
INSERT INTO staging.cdr_usage VALUES
(45,'254700000045','Subscriber_45','Nairobi','Safaricom','DATA','OUTGOING',0,1000.00,360.00,'2025-12-05 08:40:00');
INSERT INTO staging.cdr_usage VALUES
(46,'254700000046','Subscriber_46','Machakos','Airtel','VOICE','OUTGOING',190,0,28.00,'2025-12-05 08:50:00');
INSERT INTO staging.cdr_usage VALUES
(47,'254700000047','Subscriber_47','Kiambu','Safaricom','SMS','OUTGOING',0,0,5.00,'2025-12-05 09:00:00');
INSERT INTO staging.cdr_usage VALUES
(48,'254700000048','Subscriber_48','Kisumu','Safaricom','DATA','OUTGOING',0,420.00,170.00,'2025-12-05 09:10:00');
INSERT INTO staging.cdr_usage VALUES
(49,'254700000049','Subscriber_49','Nairobi','Safaricom','VOICE','OUTGOING',510,0,80.00,'2025-12-05 09:20:00');
INSERT INTO staging.cdr_usage VALUES
(50,'254700000050','Subscriber_50','Nakuru','Telkom','DATA','OUTGOING',0,610.00,225.00,'2025-12-05 09:30:00');





















INSERT INTO staging.cdr_usage VALUES
(51,'254700000051','Subscriber_51','Nyeri','Safaricom','VOICE','OUTGOING',210,0,30.00,'2025-12-06 08:00:00');
INSERT INTO staging.cdr_usage VALUES
(52,'254700000052','Subscriber_52','Meru','Airtel','DATA','OUTGOING',0,480.00,190.00,'2025-12-06 08:10:00');
INSERT INTO staging.cdr_usage VALUES
(53,'254700000053','Subscriber_53','Embu','Safaricom','SMS','OUTGOING',0,0,5.00,'2025-12-06 08:20:00');
INSERT INTO staging.cdr_usage VALUES
(54,'254700000054','Subscriber_54','Kirinyaga','Safaricom','VOICE','INCOMING',360,0,0.00,'2025-12-06 08:30:00');
INSERT INTO staging.cdr_usage VALUES
(55,'254700000055','Subscriber_55','Murang’a','Telkom','DATA','OUTGOING',0,620.00,230.00,'2025-12-06 08:40:00');
INSERT INTO staging.cdr_usage VALUES
(56,'254700000056','Subscriber_56','Laikipia','Safaricom','VOICE','OUTGOING',190,0,28.00,'2025-12-06 08:50:00');
INSERT INTO staging.cdr_usage VALUES
(57,'254700000057','Subscriber_57','Kajiado','Airtel','DATA','OUTGOING',0,540.00,210.00,'2025-12-06 09:00:00');
INSERT INTO staging.cdr_usage VALUES
(58,'254700000058','Subscriber_58','Narok','Safaricom','SMS','OUTGOING',0,0,5.00,'2025-12-06 09:10:00');
INSERT INTO staging.cdr_usage VALUES
(59,'254700000059','Subscriber_59','Bomet','Safaricom','VOICE','OUTGOING',420,0,65.00,'2025-12-06 09:20:00');
INSERT INTO staging.cdr_usage VALUES
(60,'254700000060','Subscriber_60','Kericho','Telkom','DATA','OUTGOING',0,700.00,260.00,'2025-12-06 09:30:00');

INSERT INTO staging.cdr_usage VALUES
(61,'254700000061','Subscriber_61','Bungoma','Safaricom','VOICE','OUTGOING',300,0,45.00,'2025-12-07 08:00:00');
INSERT INTO staging.cdr_usage VALUES
(62,'254700000062','Subscriber_62','Kakamega','Airtel','DATA','OUTGOING',0,520.00,205.00,'2025-12-07 08:10:00');
INSERT INTO staging.cdr_usage VALUES
(63,'254700000063','Subscriber_63','Busia','Safaricom','SMS','OUTGOING',0,0,5.00,'2025-12-07 08:20:00');
INSERT INTO staging.cdr_usage VALUES
(64,'254700000064','Subscriber_64','Siaya','Safaricom','VOICE','INCOMING',480,0,0.00,'2025-12-07 08:30:00');
INSERT INTO staging.cdr_usage VALUES
(65,'254700000065','Subscriber_65','Homa Bay','Telkom','DATA','OUTGOING',0,460.00,175.00,'2025-12-07 08:40:00');
INSERT INTO staging.cdr_usage VALUES
(66,'254700000066','Subscriber_66','Migori','Safaricom','VOICE','OUTGOING',260,0,38.00,'2025-12-07 08:50:00');
INSERT INTO staging.cdr_usage VALUES
(67,'254700000067','Subscriber_67','Kisii','Airtel','DATA','OUTGOING',0,580.00,220.00,'2025-12-07 09:00:00');
INSERT INTO staging.cdr_usage VALUES
(68,'254700000068','Subscriber_68','Nyamira','Safaricom','SMS','OUTGOING',0,0,5.00,'2025-12-07 09:10:00');
INSERT INTO staging.cdr_usage VALUES
(69,'254700000069','Subscriber_69','Trans Nzoia','Safaricom','VOICE','OUTGOING',510,0,80.00,'2025-12-07 09:20:00');
INSERT INTO staging.cdr_usage VALUES
(70,'254700000070','Subscriber_70','Elgeyo Marakwet','Telkom','DATA','OUTGOING',0,630.00,235.00,'2025-12-07 09:30:00');

INSERT INTO staging.cdr_usage VALUES
(71,'254700000071','Subscriber_71','Nandi','Safaricom','VOICE','OUTGOING',240,0,35.00,'2025-12-08 08:00:00');
INSERT INTO staging.cdr_usage VALUES
(72,'254700000072','Subscriber_72','West Pokot','Airtel','DATA','OUTGOING',0,410.00,165.00,'2025-12-08 08:10:00');
INSERT INTO staging.cdr_usage VALUES
(73,'254700000073','Subscriber_73','Turkana','Safaricom','SMS','OUTGOING',0,0,5.00,'2025-12-08 08:20:00');
INSERT INTO staging.cdr_usage VALUES
(74,'254700000074','Subscriber_74','Samburu','Safaricom','VOICE','INCOMING',360,0,0.00,'2025-12-08 08:30:00');
INSERT INTO staging.cdr_usage VALUES
(75,'254700000075','Subscriber_75','Marsabit','Telkom','DATA','OUTGOING',0,350.00,140.00,'2025-12-08 08:40:00');
INSERT INTO staging.cdr_usage VALUES
(76,'254700000076','Subscriber_76','Isiolo','Safaricom','VOICE','OUTGOING',200,0,30.00,'2025-12-08 08:50:00');
INSERT INTO staging.cdr_usage VALUES
(77,'254700000077','Subscriber_77','Garissa','Airtel','DATA','OUTGOING',0,480.00,190.00,'2025-12-08 09:00:00');
INSERT INTO staging.cdr_usage VALUES
(78,'254700000078','Subscriber_78','Wajir','Safaricom','SMS','OUTGOING',0,0,5.00,'2025-12-08 09:10:00');
INSERT INTO staging.cdr_usage VALUES
(79,'254700000079','Subscriber_79','Mandera','Safaricom','VOICE','OUTGOING',420,0,65.00,'2025-12-08 09:20:00');
INSERT INTO staging.cdr_usage VALUES
(80,'254700000080','Subscriber_80','Tana River','Telkom','DATA','OUTGOING',0,560.00,210.00,'2025-12-08 09:30:00');

INSERT INTO staging.cdr_usage VALUES
(81,'254700000081','Subscriber_81','Lamu','Safaricom','VOICE','OUTGOING',180,0,25.00,'2025-12-09 08:00:00');
INSERT INTO staging.cdr_usage VALUES
(82,'254700000082','Subscriber_82','Kilifi','Airtel','DATA','OUTGOING',0,690.00,255.00,'2025-12-09 08:10:00');
INSERT INTO staging.cdr_usage VALUES
(83,'254700000083','Subscriber_83','Kwale','Safaricom','SMS','OUTGOING',0,0,5.00,'2025-12-09 08:20:00');
INSERT INTO staging.cdr_usage VALUES
(84,'254700000084','Subscriber_84','Taita Taveta','Safaricom','VOICE','INCOMING',300,0,0.00,'2025-12-09 08:30:00');
INSERT INTO staging.cdr_usage VALUES
(85,'254700000085','Subscriber_85','Kitui','Telkom','DATA','OUTGOING',0,470.00,180.00,'2025-12-09 08:40:00');
INSERT INTO staging.cdr_usage VALUES
(86,'254700000086','Subscriber_86','Makueni','Safaricom','VOICE','OUTGOING',260,0,38.00,'2025-12-09 08:50:00');
INSERT INTO staging.cdr_usage VALUES
(87,'254700000087','Subscriber_87','Tharaka Nithi','Airtel','DATA','OUTGOING',0,520.00,205.00,'2025-12-09 09:00:00');
INSERT INTO staging.cdr_usage VALUES
(88,'254700000088','Subscriber_88','Vihiga','Safaricom','SMS','OUTGOING',0,0,5.00,'2025-12-09 09:10:00');
INSERT INTO staging.cdr_usage VALUES
(89,'254700000089','Subscriber_89','Pokot','Safaricom','VOICE','OUTGOING',480,0,75.00,'2025-12-09 09:20:00');
INSERT INTO staging.cdr_usage VALUES
(90,'254700000090','Subscriber_90','Nairobi','Telkom','DATA','OUTGOING',0,850.00,310.00,'2025-12-09 09:30:00');

INSERT INTO staging.cdr_usage VALUES
(91,'254700000091','Subscriber_91','Kiambu','Safaricom','VOICE','OUTGOING',300,0,45.00,'2025-12-10 08:00:00');
INSERT INTO staging.cdr_usage VALUES
(92,'254700000092','Subscriber_92','Machakos','Airtel','DATA','OUTGOING',0,610.00,225.00,'2025-12-10 08:10:00');
INSERT INTO staging.cdr_usage VALUES
(93,'254700000093','Subscriber_93','Mombasa','Safaricom','SMS','OUTGOING',0,0,5.00,'2025-12-10 08:20:00');
INSERT INTO staging.cdr_usage VALUES
(94,'254700000094','Subscriber_94','Kisumu','Safaricom','VOICE','INCOMING',540,0,0.00,'2025-12-10 08:30:00');
INSERT INTO staging.cdr_usage VALUES
(95,'254700000095','Subscriber_95','Nakuru','Telkom','DATA','OUTGOING',0,780.00,290.00,'2025-12-10 08:40:00');
INSERT INTO staging.cdr_usage VALUES
(96,'254700000096','Subscriber_96','Uasin Gishu','Safaricom','VOICE','OUTGOING',360,0,55.00,'2025-12-10 08:50:00');
INSERT INTO staging.cdr_usage VALUES
(97,'254700000097','Subscriber_97','Narok','Airtel','DATA','OUTGOING',0,640.00,235.00,'2025-12-10 09:00:00');
















