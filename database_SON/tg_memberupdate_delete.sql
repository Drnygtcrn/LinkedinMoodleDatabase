drop trigger if exists tg_groupmembers_insert;

delimiter $$

create trigger tg_groupmembers_delete before delete on groupmembers
for each row

begin
	declare members int;
    select count(*) into members from groupmembers where group_id=old.group_id;
    update persongroup
    set member_count=members;
end$$