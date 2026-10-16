alter table sales.orders
    add constraint orders_customer_fk
        foreign key ( customer_id )
            references sales.customers ( customer_id )
        enable;
