-- Overall revenue over the last 5 weekends

with dates as 
(
  select date from 
    unnest([
      date "2025-03-01", date "2025-03-02", -- ads down
      date "2025-02-22", date "2025-02-23", -- weekend 4
      date "2025-02-15", date "2025-02-16", -- weekend 3
      date "2025-02-08", date "2025-02-09", -- weekend 2
      date "2025-02-01", date "2025-02-02" -- weekend 1
    ]) as date
)

select
case 
when date = "2025-02-01" or date = "2025-02-02" then "weekend_1"
when date = "2025-02-08" or date = "2025-02-09" then "weekend_2"
when date = "2025-02-15" or date = "2025-02-16" then "weekend_3"
when date = "2025-02-22" or date = "2025-02-23" then "weekend_4"
when date = "2025-03-01" or date = "2025-03-02" then "ads_down"
end as weekend,
date,
sum(total_revenue)
from `data_marts.channel_performance`
where 1=1
  and date in (select date from dates)
  and country = "UK"
group by date
order by date asc
