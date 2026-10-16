create or replace package body sales.order_api as

    function create_order (
        p_customer_id in number
    ) return number is
        l_id orders.order_id%type := orders_seq.nextval;
    begin
        insert into orders (
            order_id,
            customer_id
        ) values
            ( l_id,
              p_customer_id );

        return l_id;
    end create_order;

    procedure add_line (
        p_order_id   in number,
        p_sku        in varchar2,
        p_quantity   in number,
        p_unit_price in number
    ) is
        l_line order_lines.line_no%type;
    begin
        select
            nvl(
                max(line_no),
                0
            ) + 1
        into l_line
        from
            order_lines
        where
            order_id = p_order_id;

        insert into order_lines (
            order_id,
            line_no,
            sku,
            quantity,
            unit_price
        ) values
            ( p_order_id,
              l_line,
              p_sku,
              p_quantity,
              p_unit_price );

    end add_line;

    procedure confirm (
        p_order_id in number
    ) is
    begin
        update orders
        set
            status = 'CONFIRMED'
        where
                order_id = p_order_id
            and status = 'NEW';

        if sql%rowcount = 0 then
            raise_application_error(-20001, 'Order '
                                            || p_order_id
                                            || ' cannot be confirmed: it is not NEW');  -- clearer message for the UI
        end if;

    end confirm;

end order_api;
/
