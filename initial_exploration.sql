-- Identfying the problem
select * 
from `tpw-data-warehouse.data_marts.channel_performance`
where 1=1
  and date between "2025-03-01" and "2025-03-02"
  and default_channel_grouping = "Paid Search"
  and country = "UK"
order by
  date,
  TPW_Channels
