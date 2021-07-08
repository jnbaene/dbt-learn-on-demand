with orders as (
    select * from {{ref('stg_orders')}}
),

payments as (
    select * from {{ref('stg_payments')}}
),

order_payments as (

    select
        order_id,
        sum(case when status = 'success' then amount end) as amount

    from payments
    group by order_id
),

final as (

    select
        orders.customer_id,
        orders.order_id,
        order_payments.amount,
        orders.order_date

    from orders
    left join order_payments using (order_id)

)

select * from final