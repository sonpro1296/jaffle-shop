{{ config(materialized='view') }}

select * from public.jaffle_shop_order