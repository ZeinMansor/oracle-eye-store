create table sales.order_lines (
    order_id   number(10, 0) not null enable,
    line_no    number(4, 0) not null enable,
    sku        varchar2(30 byte) not null enable,
    quantity   number(8, 0) not null enable,
    unit_price number(12, 2) not null enable
);

alter table sales.order_lines
    add constraint order_lines_pk primary key ( order_id,
                                                line_no )
        using index enable;

alter table sales.order_lines add constraint order_lines_qty_ck check ( quantity > 0 ) enable;
