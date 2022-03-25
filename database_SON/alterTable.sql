alter table Course
add constraint fk_course foreign key(instructor_id) references Instructor(acc_id) on delete cascade;

alter table Personal
add constraint fk_personal_addr foreign key(addr_id) references Address(addr_id) on delete cascade;

alter table Personal
add constraint fk_personal_cv foreign key(cv_id) references Cv(cv_id) on delete cascade;

alter table Personal
add constraint fk_personal_account foreign key(acc_id) references Account(acc_id) on delete cascade;

alter table Post
add constraint fk_post_profile foreign key(post_owner_id) references Profile(profile_id) on delete cascade;

alter table Post
add constraint fk_post_group foreign key(group_id) references PersonGroup(group_id) on delete cascade;

alter table Enrolls
add constraint fk_enroll_student foreign key(student_id) references Student(acc_id) on delete cascade;

alter table Enrolls
add constraint fk_enroll_course foreign key(course_id) references Course(course_id) on delete cascade;

alter table GroupMembers
add constraint fk_member_person foreign key(member_id) references Personal(acc_id) on delete cascade;

alter table GroupMembers
add constraint fk_member_group foreign key(group_id) references PersonGroup(group_id) on delete cascade;

alter table WorkExperience
add constraint fk_work_org foreign key(works_in) references Organisation(acc_id) on delete cascade;

alter table WorkExperience
add constraint fk_work_cv foreign key(cv_id) references Cv(cv_id) on delete cascade;

alter table Messages
add constraint fk_message_acc foreign key(sender_acc_id) references Account(acc_id) on delete cascade;

alter table Messages
add constraint fk_message_recv foreign key(receive_acc_id) references Account(acc_id) on delete cascade;

alter table Reacts
add constraint fk_react_profile foreign key(profile_id) references Profile(profile_id) on delete cascade;

alter table Reacts
add constraint fk_react_post foreign key(post_id) references Post(post_id) on delete cascade;

alter table Comments
add constraint fk_comment_profile foreign key(profile_id) references Profile(profile_id) on delete cascade;

alter table Comments
add constraint fk_comment_post foreign key(post_id) references Post(post_id) on delete cascade;

alter table Connects
add constraint fk_connect_person1 foreign key(person_sender_id) references Personal(acc_id) on delete cascade;

alter table Connects
add constraint fk_connect_person2 foreign key(person_receiver_id) references Personal(acc_id) on delete cascade;

alter table Document
add constraint fk_document_uploader foreign key(uploader_id) references Instructor(acc_id);

alter table Document
add constraint fk_document_course foreign key(course_id) references Course(course_id) on delete cascade;

alter table Follower
add constraint fk_follower_person foreign key(person_id) references Personal(acc_id) on delete cascade;

alter table Follower
add constraint fk_follower_org foreign key(org_id) references Organisation(acc_id) on delete cascade;

alter table Content
add constraint fk_content_post foreign key(post_id) references Post(post_id) on delete cascade;

alter table ProfileViews
add constraint fk_view_profile1 foreign key(seeker_profile) references Profile(profile_id) on delete cascade;

alter table ProfileViews
add constraint fk_view_profile2 foreign key(seen_profile) references Profile(profile_id) on delete cascade;

alter table CvViewers
add constraint fk_cvview_org foreign key(org_id) references Organisation(acc_id) on delete cascade;

alter table CvViewers
add constraint fk_cvview_cv foreign key(cv_id) references Cv(cv_id) on delete cascade;

alter table Education
add constraint fk_edu_cv foreign key(cv_id) references Cv(cv_id) on delete cascade;

alter table GroupManagers
add constraint fk_manager_person foreign key(manager_id) references Personal(acc_id) on delete cascade;

alter table GroupManagers
add constraint fk_manager_group foreign key(group_id) references PersonGroup(group_id) on delete cascade;

alter table Instructor
add constraint fk_instructor_person foreign key(acc_id) references Personal(acc_id) on delete cascade;

alter table Organisation
add constraint fk_org_acc foreign key(acc_id) references Account(acc_id) on delete cascade;

alter table Organisation
add constraint fk_org_address foreign key(work_address_id) references WorkAddress(addr_id) on delete cascade;

alter table Profile
add constraint fk_profile_acc foreign key(acc_id) references Account(acc_id) on delete cascade;

alter table Shares
add constraint fk_share_profile foreign key(profile_id) references Profile(profile_id) on delete cascade;

alter table Shares
add constraint fk_share_post foreign key(post_id) references Post(post_id) on delete cascade;

alter table Student
add constraint fk_student_acc foreign key(acc_id) references Personal(acc_id) on delete cascade;

alter table Student
add constraint fk_student_advisor foreign key(advisor) references Instructor(acc_id) on delete cascade;
