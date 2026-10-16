create or replace force editionable view sales.order_totals_v (
    order_id,
    customer_id,
    customer,
    order_date,
    status,
    total,
    total_with_vat
) as
    select
        o.order_id,
        o.customer_id,
        c.name as customer,
        o.order_date,
        o.status,
        nvl(
            sum(l.quantity * l.unit_price),
            0
        )      as total,
        round(nvl(sum(l.quantity * l.unit_price), 0) * 1.11, 2) as total_with_vat
    from
             orders o
        join customers   c on c.customer_id = o.customer_id
        left join order_lines l on l.order_id = o.order_id
    group by
        o.order_id,
        o.customer_id,
        c.name,
        o.order_date,
        o.status;
