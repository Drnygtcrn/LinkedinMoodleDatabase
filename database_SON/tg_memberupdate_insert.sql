drop trigger if exists tg_groupmembers_insert;

delimiter $$
create trigger tg_groupmembers_insert after insert on groupmembers
for each row
begin
	declare members int;
    declare group_ int;
    
    set group_ = new.group_id;
    
    select count(*) into members from groupmembers where group_id=new.group_id;
    update persongroup
    set member_count=members where persongroup.group_id=group_;

end$$