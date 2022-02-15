{{ config(materialized='table') }}

with orders as (
    select * from {{ ref('stg_order') }}
), success_orders as (
    select * from {{ ref('stg_success_orders') }}
)

select success_orders.*, orders.order_date as date, orders.user_id as customer_id
from success_orders join orders on success_orders.id = orders.id
