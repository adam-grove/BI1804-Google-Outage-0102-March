

-- By month
with channel_performance as 
(
  select 
  date,
  sum(spend) as spend,
  sum(total_revenue) as total_revenue
  from `data_marts.channel_performance`
  where 1=1
    and date between date_sub(current_date(), interval 6 month) and current_date() -1 
    and default_channel_grouping = "Social Organic"
    and TPW_Channels = "Social Organic"
    and country = "UK"
  group by date
),
sessions_summary as 
(
  select 
  date,
  sum(sessions) as sessions
  from `data_marts.sessions_summary`
  where 1=1
    and date between date_sub(current_date(), interval 6 month) and current_date() -1 
    and TPW_channels = "Social Organic"
    and country = "UK"
group by date
)
select
  ifnull(t1.date,t2.date) as date,
  spend,
  total_revenue,
  sessions
from channel_performance t1
full outer join sessions_summary t2 
  on t1.date = t2.date

