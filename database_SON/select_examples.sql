#1li
select course_id from Course where Course.semester ="FALL";						#Güz döneminde verilen derslerin idleri


###########################################################################
#1li
SELECT 
    id as 'Kullanıcı ID', SUM(takip) as 'Takip Sayısı'
FROM
    ((SELECT 
        person_sender_id AS id, COUNT(person_receiver_id) AS 'takip'
    FROM
        connects
    GROUP BY person_sender_id) 
    UNION ALL 
    (SELECT 
        person_receiver_id, COUNT(person_sender_id)
    FROM
        connects
    GROUP BY person_receiver_id)) AS totalTable
GROUP BY id
ORDER BY SUM(takip) DESC;


###########################################################################
#1li
select group_name from PersonGroup where PersonGroup.member_count <10; 			#10 kişiden az kullanıcısı bulunan grupların isimleri

###########################################################################
#2li
SELECT 
    doc_name
FROM
    document,
    course
WHERE
    document.course_id = course.course_id
        AND visibility = TRUE;


###########################################################################
#2li	
SELECT 
    post_id, post_date
FROM
    post
WHERE
    post.post_owner_id = (SELECT 
            acc_id
        FROM
            personal
        WHERE
			personal.fname LIKE 'F%'
        LIMIT 1)
ORDER BY post.post_date DESC
LIMIT 1;


###########################################################################
#2li

#CvViewers(org_id, cv_id)
#Personal(acc_id, department, fname, minit, lname, addr_id, cv_id)
select personal.fname, personal.lname, count(org_id) from cvviewers, personal where personal.cv_id=cvviewers.cv_id group by cvviewers.cv_id order by count(org_id) desc;

###########################################################################
#2li

select acc_id, org_name, country, full_address from organisation, workaddress where organisation.work_address_id=workaddress.addr_id and workaddress.country='USA';

###########################################################################
#3lü		En az bir ders veren öğretim görevlilerinin bilgileri. Tekrar edenleri almıyor.
SELECT 
    fname, lname, title, start_date
FROM
    instructor,
    personal
WHERE
    EXISTS( SELECT 
            course.instructor_id
        FROM
            course
        WHERE
            instructor.acc_id = course.instructor_id)
        AND instructor.acc_id = personal.acc_id;


###########################################################################
#3lü
SELECT 
    personal.fname,
    personal.lname,
    address.addr_id,
    country,
    state
FROM
    address,
    personal,
    organisation
WHERE
    personal.addr_id = address.addr_id
        AND org_owner_id = personal.acc_id;


###########################################################################
#3lü
SELECT 
    profile_id, bio, fname, lname
FROM
    profile,
    account,
    personal
WHERE
    account.acc_id = profile.acc_id
        AND LENGTH(bio) > 30
        AND personal.acc_id = account.acc_id;
        

###########################################################################
select * from document;

insert into Document (doc_name, uploader_id, course_id, visibilty) values ('Mux', 8, 6, false);
update Document set visibilty=true where doc_name='Mux';
delete from document where exists (select * from course where course.course_id=document.course_id and course.course_year=2021);


###########################################################################
select * from comments;

insert into Comments(profile_id, post_id, text) values (36, 20, 'Ben cede');
update Comments set text='Bencede' where post_id=20 and profile_id=36;
delete from Comments where profile_id=36 and post_id=20;


###########################################################################
select * from post;
select * from content;

insert into Post(post_owner_id, isGroup, group_id) values ((select acc_id from personal where personal.department='Matematik' and personal.fname like 'M%' limit 1), false, null);
insert into Content(post_id, isText, text, isMedia, is_video, media) values ((select post_id from post where post.post_owner_id=(select acc_id from personal where personal.department='Matematik' and personal.fname like 'M%' limit 1) order by post.post_date desc limit 1), true, 'x=y+z', false, false, '');

update Content set text='x=y+z Çözümü:', isMedia=true, media='çözüm' where post_id=(select post_id from post where post.post_owner_id=(select acc_id from personal where personal.department='Matematik' and personal.fname like 'M%' limit 1) order by post.post_date desc limit 1);
delete from post where post_id=50;


###########################################################################
# Sayıca en çok öğretim üyelerinin bulunduğu ülkedeki öğretim üyelerinin bilgileri
select instructor.title, personal.fname, personal.lname, address.country from instructor as ins, instructor, personal, address, address as insAddr where personal.acc_id=instructor.acc_id and personal.addr_id=address.addr_id and personal.acc_id=ins.acc_id and ins.addr_id=insAddress.addr_id and address.country=insAddress.country;

SELECT 
    instructor.title,
    personal.fname,
    personal.lname,
    address.country
FROM
    instructor,
    personal,
    address
WHERE
    personal.acc_id = instructor.acc_id
        AND personal.addr_id = address.addr_id
        AND address.country = (SELECT 
            addr.country
        FROM
            address addr,
            instructor,
            personal
        WHERE
            personal.acc_id = instructor.acc_id
                AND addr.addr_id = personal.addr_id
        GROUP BY addr.country
        ORDER BY COUNT(addr.addr_id) DESC
        LIMIT 1);


###########################################################################
# Öğrencilerin paylaştığı postları beğenen öğretmenlerin bilgisi

SELECT 
    instructor.acc_id 'Öğretmen hesap ID',
    personal.fname 'Öğretmen Adı',
    personal.lname 'Öğretmen Soyadı',
    profile.bio 'Öğretmen Bio',
    post.post_id 'Tepki verilen post ID',
    reacts.react_type 'Tepki türü'
FROM
    instructor,
    post,
    student,
    reacts,
    profile,
    personal
WHERE
    post.post_owner_id = student.acc_id
        AND post.post_id = reacts.post_id
        AND reacts.profile_id = profile.profile_id
        AND profile.acc_id = instructor.acc_id
        AND personal.acc_id=instructor.acc_id;


###########################################################################
# Bir öğretim görevlisiyle bağlantısı bulunan öğrenciler

insert into Connects (person_sender_id, person_receiver_id) values (78, 7);
insert into Connects (person_sender_id, person_receiver_id) values (79, 8);
insert into Connects (person_sender_id, person_receiver_id) values (41, 78);

(select connects.person_sender_id 'StudentID', connects.person_receiver_id 'InstructorID' from connects, student, instructor where person_sender_id=student.acc_id and person_receiver_id=instructor.acc_id)
union
(select connects.person_receiver_id, connects.person_sender_id from connects, student, instructor where person_receiver_id=student.acc_id and person_sender_id=instructor.acc_id);

###########################################################################
# Öğrencinin advisor ile aralarındaki mesajlar

insert into Messages(sender_acc_id, receive_acc_id, msg_text) values (78, 53, 'Merhaba hocam');
delete from messages where sender_acc_id=78 and receive_acc_id=53;

(select message_id,messages.sender_acc_id'Mesajı gönderen id',messages.receive_acc_id'Mesajı alan id',msg_text 'Mesaj içeriği' from messages,account,student where messages.sender_acc_id=student.acc_id and messages.receive_acc_id = student.advisor) UNION (select message_id,messages.sender_acc_id'Mesajı gönderen id',messages.receive_acc_id'Mesajı alan id',msg_text 'Mesaj içeriği' from messages,account,student where messages.sender_acc_id=student.advisor and messages.receive_acc_id = student.acc_id);


###########################################################################
# Öğrencilerin gruplarda paylaştığı postlar

SELECT 
    post_id 'Post id',
    post.group_id 'Postun paylaşıldığı grup id',
    post_owner_id 'Postu paylaşan kişi id'
FROM
    post,
    student,
    groupmembers,
    persongroup
WHERE
    post.post_owner_id = student.acc_id
        AND groupmembers.member_id = student.acc_id
        AND persongroup.group_id = groupmembers.group_id
        AND post.group_id = persongroup.group_id;