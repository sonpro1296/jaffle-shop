select * from {{ ref('fct_order')}} where isdate(date) = 0
