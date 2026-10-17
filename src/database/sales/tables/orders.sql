create table sales.orders (
    order_id    number(10, 0) not null enable,
    customer_id number not null enable,
    order_date  date default sysdate not null enable,
    status      varchar2(12 byte) default 'NEW' not null enable,
    amount      number,
    discount_pct number(5, 2)
);

alter table sales.orders
    add constraint orders_pk primary key ( order_id )
        using index enable;

alter table sales.orders
    add constraint orders_status_ck
        check ( status in ( 'NEW', 'CONFIRMED', 'SHIPPED', 'CANCELLED' ) ) enable;
