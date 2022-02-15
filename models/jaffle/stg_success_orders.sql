{{ config(materialized='view') }}

select order_id as id, 
        sum(case when payment='credit_card' then amount else 0 end) as credit_card_amount,
        sum(case when payment='bank_transfer' then amount else 0 end) as bank_transfer_amount,
        sum(case when payment='coupon' then amount else 0 end) as coupon_amount,
        sum(case when payment='gift_card' then amount else 0 end) as gift_card_amount
    from public.stripe_payment where status = 'success' group by order_id