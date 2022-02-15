{{ config(materialized='table') }}

with customers as (
    select id, concat(first_name, ' ', last_name) as name from public.jaffle_shop_customer
), customer_info as (
    select b.user_id,
        min(b.order_date) as first_date,
        max(b.order_date) as last_date,
        round(avg(case when b.status != 'returned' then a.credit_card_amount + a.bank_transfer_amount + a.coupon_amount + a.gift_card_amount else 0 end), 2) as avg_order_amount
        from  {{ ref('stg_success_orders') }} a join {{ ref('stg_order') }} b on a.id = b.id
        group by b.user_id
)   

select customers.id, customers.name, 
    customer_info.first_date as first_order_date, 
    customer_info.last_date as last_order_date, 
    coalesce(customer_info.avg_order_amount, 0) as avg_order_amount
    from customers left join customer_info on customers.id = customer_info.user_id