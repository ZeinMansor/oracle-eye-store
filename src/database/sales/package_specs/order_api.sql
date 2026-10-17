create or replace package sales.order_api as
    function create_order (
        p_customer_id in number
    ) return number;

    procedure add_line (
        p_order_id   in number,
        p_sku        in varchar2,
        p_quantity   in number,
        p_unit_price in number
    );

    procedure confirm (
        p_order_id in number
    );

    -- Sets the discount of an order that is not shipped yet (percent, 0 to 100).
    procedure apply_discount (
        p_order_id     in number,
        p_discount_pct in number
    );

end order_api;
/
