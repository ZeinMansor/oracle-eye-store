create or replace force editionable view sales.top_customers_v (
    customer_id,
    orders
) as
    select
        customer_id,
        count(*) orders
    from
        sales.orders
    group by
        customer_id
    order by
        2 desc
    fetch first 10 rows only;
