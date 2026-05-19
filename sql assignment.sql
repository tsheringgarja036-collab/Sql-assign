use employees;
select* from employees;
desc employees;

create procedure getuserdetails
(
    in user_name varchar(30),
    out salary decimal(10,2)
)
begin
    select phone
    into c_phone
    from employees
    where emp_name = user_name;
end $$

delimiter ;
call getuserdetails ('sita', @phones);
select @phones;
create table account (
    account_id int primary key,
    c_name varchar(30),
    phone char(10),
    balance decimal(10,2),
    account_type varchar(20)
);
INSERT INTO account VALUES
(6,  'Kabir',   '9861234567', 53000.00, 'saving'),
(7,  'Nisha',   '9872345678', 41000.00, 'current'),
(8,  'Rajesh',  '9883456789', 68000.00, 'saving'),
(9,  'Pooja',   '9894567890', 29000.00, 'current'),
(10, 'Santosh', '9805678901', 85000.00, 'saving');

delimiter $$

create procedure getuserdetails
(
    in user_name varchar(30),
    out user_balance decimal(10,2)
)
begin
    select balance
    into user_balance
    from account
    where c_name = user_name;
end $$

delimiter ;
call userdetails('kabir'@ user_balamce);
select @user_balance;

