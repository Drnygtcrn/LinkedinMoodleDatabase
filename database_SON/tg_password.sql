drop trigger if exists tg_password;

delimiter $$
create trigger tg_password before insert on Account
for each row

begin
	if length(new.acc_password) > 5 then 
		set new.acc_password = sha1(new.acc_password);
    else
		signal sqlstate '45000' set message_text = 'Password should be at least 6 chars long.';
end if;
end$$