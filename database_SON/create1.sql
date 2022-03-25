use LinkedinMoodle;

#Account(acc_id, acc_name, password, type)

create table if not exists Account(
	acc_id			int auto_increment not null,		#primary key
    acc_name 		varchar(20) not null,
    acc_password 	varchar(160) not null,
    acc_type		enum('Personal', 'Org') default 'Personal',

    constraint pk_account	primary key(acc_id),
    unique key unique_account (acc_name),
    check ((length(acc_name) > 3) and (locate(' ', acc_name) != 1))			#Hesap ismi en az 6 karakter olabilir.
);

#Course(course_id, semester, name, department, year, enroll_key, instructor_id)

create table if not exists Course(
	course_id 		int auto_increment not null, 		#primary key
    semester 		enum('FALL', 'SPRING') not null,
    course_name 	varchar(30) not null,
    department 		varchar(30) not null,
    course_year 	year,
    enroll_key 		varchar(20) not null,
    instructor_id 	int,
    
    constraint pk_course 	primary key(course_id)
);

#Personal(acc_id, department, fname, minit, lname, addr_id, cv_id)

create table if not exists Personal(
	acc_id 			int not null, 						#primary key
    department 		varchar(30),
    fname 			varchar(10) not null,
    minit 			char,
    lname 			varchar(10) not null,
    addr_id			int,
    cv_id			int,
    
    constraint pk_personal	primary key (acc_id)
);

#Content(post_id, isText, text, isMedia, is_video, media)

create table if not exists Content(
    post_id 		int not null,						#primary key
    isText			bool not null,
    text			varchar(1000),
    isMedia			bool not null,
    is_video		bool,
	media 			VARCHAR(45) NOT NULL,	#name of the image
	constraint pk_media		PRIMARY KEY (post_id),
    check((isText or isMedia) = true)
);

#Post(post_id, post_owner_id, post_date, isGroup, group_id)

create table if not exists Post(
	post_id			int auto_increment not null,		#primary key
    post_owner_id	int not null,
    post_date		datetime default current_timestamp,
    isGroup			bool not null,
    group_id		int,
    
    constraint pk_post		primary key(post_id)
);

#Group(group_id, group_sector, establish_date, member_count, group_name)

create table if not exists PersonGroup(					#Group is a keyword.
	group_id		int auto_increment not null, 		#primary key
    group_sector	varchar(30),
    establish_date	datetime default current_timestamp,
    member_count	int default 0,						#default 0
    group_name		varchar(40)	not null,
    
    constraint pk_group		primary key(group_id)
);

#Enrolls(student_id, course_id) 

create table if not exists Enrolls(
	student_id		int not null,						#primary key
    course_id 		int not null,						#primary key
    enroll_key		varchar(20),
    
    constraint pk_enrolls	primary key(student_id, course_id)
);

#GroupMembers(member_id, group_id)

create table if not exists GroupMembers(
	member_id 		int,								#primary key
    group_id		int,								#primary key
    
    constraint pk_groupMembers primary key(member_id, group_id)
);

#WorkExperience(cv_id, works_in, rank, job_start, job_end)

create table if not exists WorkExperience(
	cv_id			int not null,						#primary key
    works_in		int not null,						#primary key
    job_rank		varchar(30) not null,				#primary key
    job_start		date not null,
    job_end			date,
    
    constraint pk_experience	primary key(cv_id, works_in, job_rank)
);

#Messages(sender_acc_id, receive_acc_id, message_id, message_date, msg_text)

create table if not exists Messages(
    message_id		int auto_increment not null,		#primary key
	sender_acc_id	int not null,
    receive_acc_id	int not null,
    msg_text		varchar(200) not null,
    message_date	datetime default current_timestamp,
    
    constraint pk_messages		primary key(message_id),
    check((length(msg_text) > 1) or (length(msg_text)=1 and locate(' ', msg_text)))			#Check constraint. Mesaj uzunluğu 0'dan fazla olmalı ve boşluk gönderilemez
);

#Reacts(profile_id, post_id, type)

create table if not exists Reacts(
	profile_id 		int not null,						#primary key
    post_id			int not null,						#primary key
    react_type		enum('like', 'applause', 'help', 'love', 'info', 'think') not null,
    
    constraint pk_reacts		primary key(profile_id, post_id)
);

#Address(addr_id, country, zip)

CREATE TABLE IF NOT EXISTS Address (
  addr_id			INT auto_increment NOT NULL,			#primary key
  country 			VARCHAR(20) NOT NULL,
  state 			varchar(20),
  
  constraint pk_address	PRIMARY KEY (addr_id)
  );

#Comments(profile_id, post_id, comment_id, comment_date)

CREATE TABLE IF NOT EXISTS Comments (
  comment_id 		INT auto_increment NOT NULL,			#primary key
  profile_id 		INT NOT NULL,
  post_id 			INT NOT NULL,
  comment_date 		datetime default current_timestamp,
  text				varchar(100) not null,
  
  constraint pk_comments PRIMARY KEY (comment_id),
  check((length(text) > 1) or (length(text)=1 and locate(' ', text)))	#Comment sadece boşlukla yapılamaz ve uzunluğu 0dan fazla olmalı.
  );
  
#Connects(person_sender_id, person_receiver_id, connection_date) 

CREATE TABLE IF NOT EXISTS Connects (
  person_sender_id 		INT NOT NULL,					#primary key
  person_receiver_id 	INT NOT NULL,					#primary key
  connection_date 		datetime default current_timestamp,
  constraint pk_connection	PRIMARY KEY (person_sender_id, person_receiver_id)
);
  
#Cv(cv_id, create_date, last_update_date)

CREATE TABLE IF NOT EXISTS Cv (
  cv_id 				INT auto_increment NOT NULL,	#primary key
  create_date 			datetime default current_timestamp,
  last_update 			datetime default current_timestamp,
  constraint pk_cv		PRIMARY KEY (cv_id)
);

#Document(doc_id, doc_name, share_date, last_update, visibility, uploader_id, course_id)

CREATE TABLE IF NOT EXISTS Document (
  doc_id 			INT auto_increment NOT NULL,		#primary key
  doc_name 			VARCHAR(50) NOT NULL,
  share_date 		datetime default current_timestamp,
  last_update 		datetime default current_timestamp,
  uploader_id 		INT NOT NULL,
  course_id 		INT NOT NULL,
  visibility 		bool NULL,
  constraint pk_document	primary KEY (doc_id)
);

#Follower(person_id, org_id)

CREATE TABLE IF NOT EXISTS Follower (
  person_id 		INT NOT NULL,						#primary key
  org_id 			INT NOT NULL,						#primary key
  constraint pk_follow 		PRIMARY KEY (person_id, org_id)
);

#ProfileViews(seeker_profile, seen_profile, view_date)

CREATE TABLE IF NOT EXISTS ProfileViews (
  seeker_profile 	INT NOT NULL,						#primary key
  seen_profile 		INT NOT NULL,						#primary key
  view_date 		datetime default current_timestamp,
  PRIMARY KEY (seeker_profile, seen_profile)
);

#CvViewers(org_id, cv_id)

CREATE TABLE IF NOT EXISTS CvViewers (
  org_id 			int NOT NULL,					#primary key
  cv_id 			int NOT NULL,					#primary key
  constraint pk_cv_view		PRIMARY KEY (org_id,cv_id)
);

#Education(cv_id, graduated_from, degree, start_date, end_date)

CREATE TABLE IF NOT EXISTS Education (
  cv_id 			int NOT NULL,					#primary key
  graduated_from 	varchar(30) NOT NULL,			#primary key
  degree 			enum('bachelor', 'master', 'doctorate') NOT NULL,	#primary key
  start_date 		date not null,
  end_date 			date,
  constraint pk_education	PRIMARY KEY (cv_id, graduated_from, degree)
);

#GroupManagers(manager_id, group_id)

CREATE TABLE IF NOT EXISTS GroupManagers (
  manager_id 		int NOT NULL,
  group_id 			int NOT NULL,
  constraint pk_group_managers PRIMARY KEY (manager_id,group_id)
);

#Instructor(acc_id, title, start_date)

CREATE TABLE IF NOT EXISTS Instructor (
  acc_id 			int NOT NULL,			#primary key
  title 			enum('prof.', 'dr.', 'asc. prof.') DEFAULT 'prof.',
  start_date 		year default null,
  constraint pk_instr	PRIMARY KEY (acc_id)
);

#Organisation(acc_id, phone_no, sector, name, employee_count, org_owner_id)

CREATE TABLE IF NOT EXISTS Organisation (
  acc_id 			int NOT NULL,									#primary key
  phone_no 			char(12) DEFAULT NULL,
  sector 			varchar(20) DEFAULT NULL,
  org_name 			varchar(40) not NULL,
  employee_count 	int DEFAULT 0,
  work_address_id 	int NOT NULL,
  org_owner_id		int not null,
  constraint pk_org 	PRIMARY KEY (acc_id)
);

#Profile(profile_id, acc_id, last_update, bio)

CREATE TABLE IF NOT EXISTS Profile (
  profile_id 		int auto_increment NOT NULL,			#primary key
  acc_id 			int NOT NULL,
  last_update 		datetime default current_timestamp,
  bio 				varchar(100) DEFAULT NULL,
  constraint pk_profile	PRIMARY KEY (profile_id),
  UNIQUE KEY acc_id_UNIQUE (acc_id)
);

#Shares(profile_id, post_id, share_date)

CREATE TABLE IF NOT EXISTS Shares (
  profile_id 		int NOT NULL,				#primary key
  post_id 			int NOT NULL,				#primary key
  share_date 		datetime default current_timestamp,
  constraint pk_share 	PRIMARY KEY (profile_id,post_id)
);

#Student(student_id, student_no, class, advisor) 

CREATE TABLE IF NOT EXISTS Student (
  acc_id 			int NOT NULL,				#primary key
  student_no 		int NOT NULL,
  class 			int DEFAULT NULL,
  advisor			int not null,
  constraint pk_student		PRIMARY KEY (acc_id),
  UNIQUE KEY student_no_UNIQUE (student_no)
);

#WorkAddress(addr_id, country, zip, full_address)

CREATE TABLE IF NOT EXISTS WorkAddress (
  addr_id 			int auto_increment NOT NULL,				#primary key
  country 			varchar(20) DEFAULT NULL,
  state 			varchar(20),
  full_address 		varchar(100) DEFAULT NULL,
  constraint pk_work		PRIMARY KEY (addr_id)
);