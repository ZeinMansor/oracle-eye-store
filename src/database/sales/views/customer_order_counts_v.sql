create or replace force editionable view sales.customer_order_counts_v (
    customer_id,
    order_count
) as
    select
        c.customer_id,
        count(o.order_id) as order_count
    from
        sales.customers c
        left join sales.orders    o on o.customer_id = c.customer_id
    group by
        c.customer_id;
