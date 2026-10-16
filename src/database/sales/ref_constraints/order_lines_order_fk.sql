alter table sales.order_lines
    add constraint order_lines_order_fk
        foreign key ( order_id )
            references sales.orders ( order_id )
                on delete cascade
        enable;
