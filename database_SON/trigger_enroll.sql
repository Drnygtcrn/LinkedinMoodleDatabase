delimiter $$
create trigger tg_enroll before insert on Enrolls
for each row
begin
	if new.enroll_key not in (select C.enroll_key from Course C where C.course_id=New.course_id)
    then
		signal sqlstate '45000' set message_text = 'Can not enroll. Enroll key is not correct.';
    end if;
end$$
