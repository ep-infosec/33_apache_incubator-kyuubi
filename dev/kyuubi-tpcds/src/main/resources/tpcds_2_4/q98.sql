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

--q98.sql--

select i_item_desc, i_category, i_class, i_current_price
      ,sum(ss_ext_sales_price) as itemrevenue
      ,sum(ss_ext_sales_price)*100/sum(sum(ss_ext_sales_price)) over
          (partition by i_class) as revenueratio
from
	 store_sales, item, date_dim
where
	ss_item_sk = i_item_sk
  	and i_category in ('Sports', 'Books', 'Home')
  	and ss_sold_date_sk = d_date_sk
	and d_date between cast('1999-02-22' as date)
				and (cast('1999-02-22' as date) + interval '30' day)
group by
	i_item_id, i_item_desc, i_category, i_class, i_current_price
order by
	i_category, i_class, i_item_id, i_item_desc, revenueratio
            
