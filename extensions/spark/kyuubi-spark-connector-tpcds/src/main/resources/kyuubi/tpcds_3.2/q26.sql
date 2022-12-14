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
-- q26 --
select
  i_item_id,
  avg(cs_quantity) agg1,
  avg(cs_list_price) agg2,
  avg(cs_coupon_amt) agg3,
  avg(cs_sales_price) agg4
from
  catalog_sales,
  customer_demographics,
  date_dim,
  item,
  promotion
where
  cs_sold_date_sk = d_date_sk
  and cs_item_sk = i_item_sk
  and cs_bill_cdemo_sk = cd_demo_sk
  and cs_promo_sk = p_promo_sk
  and cd_gender = 'F'
  and cd_marital_status = 'W'
  and cd_education_status = 'Primary'
  and (
    p_channel_email = 'N'
    or p_channel_event = 'N'
  )
  and d_year = 1998
group by
  i_item_id
order by
  i_item_id
limit
  100;
