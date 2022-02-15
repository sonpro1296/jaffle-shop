select order_id, sum(credit_card_amount, bank_transfer_amount, coupon_amount, gift_card_amount) as amount
    from {{ ref('fct_order')}}
    having amount <= 0