--
-- Licensed to the Apache Software Foundation (ASF) under one or more
-- contributor license agreements.  See the NOTICE file distributed with
-- this work for additional information regarding copyright ownership.
-- The ASF licenses this file to You under the Apache License, Version 2.0
-- (the "License"); you may not use this file except in compliance with
-- the License.  You may obtain a copy of the License at
--
--    http://www.apache.org/licenses/LICENSE-2.0
--
-- Unless required by applicable law or agreed to in writing, software
-- distributed under the License is distributed on an "AS IS" BASIS,
-- WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
-- See the License for the specific language governing permissions and
-- limitations under the License.
--
-- q43 --
select
  s_store_name,
  s_store_id,
  sum(
    case
      when (d_day_name = 'Sunday') then ss_sales_price
      else null
    end
  ) sun_sales,
  sum(
    case
      when (d_day_name = 'Monday') then ss_sales_price
      else null
    end
  ) mon_sales,
  sum(
    case
      when (d_day_name = 'Tuesday') then ss_sales_price
      else null
    end
  ) tue_sales,
  sum(
    case
      when (d_day_name = 'Wednesday') then ss_sales_price
      else null
    end
  ) wed_sales,
  sum(
    case
      when (d_day_name = 'Thursday') then ss_sales_price
      else null
    end
  ) thu_sales,
  sum(
    case
      when (d_day_name = 'Friday') then ss_sales_price
      else null
    end
  ) fri_sales,
  sum(
    case
      when (d_day_name = 'Saturday') then ss_sales_price
      else null
    end
  ) sat_sales
from
  date_dim,
  store_sales,
  store
where
  d_date_sk = ss_sold_date_sk
  and s_store_sk = ss_store_sk
  and s_gmt_offset = -5
  and d_year = 1998
group by
  s_store_name,
  s_store_id
order by
  s_store_name,
  s_store_id,
  sun_sales,
  mon_sales,
  tue_sales,
  wed_sales,
  thu_sales,
  fri_sales,
  sat_sales
limit
  100;
