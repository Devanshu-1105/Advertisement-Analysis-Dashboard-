
select * from ad_campaign_performance

-- check row count (dataset size)
select count (*) as total_rows
from ad_campaign_performance;

--Overall Business KPIs 

select sum(ad_spend) as total_ad_spend, sum(revenue) as total_revenue, sum(conversions) as total_conversions,
round(sum(revenue)/sum(ad_spend):: numeric, 2) as roas,
round(sum(ad_spend)/sum(conversions):: numeric, 2) as cpa
from ad_campaign_performance;

--Platform level spend and revenue  

select platform , sum(ad_spend) as total_ad_spend ,
sum(revenue) as total_revenue
from ad_campaign_performance
group by platform
order by total_revenue desc;

--platform level Roas 

select
    platform,
    round(sum(revenue) / sum(ad_spend)::numeric, 2) as per_platform_roas
from ad_campaign_performance
group by platform
order by per_platform_roas desc;

--platform level cpa
select platform, 
round(sum(ad_spend) / sum(conversions):: numeric , 2) as per_platform_cpa
from ad_campaign_performance
group by platform
order by per_platform_cpa desc;

-- Conversion Contribution by platform 
 select platform, sum(conversions) as total_conversions
 from ad_campaign_performance
 group by platform
 order by total_conversions desc;

 --campaing level performance 

 select platform, campaign_type, sum(ad_spend) as campaign_spend,
 sum(revenue) as campaign_revenue,
 sum(conversions) as campaign_conversions,
 round(sum(revenue)/sum(ad_spend):: numeric , 2) as roas , 
 round(sum(ad_spend)/sum(conversions):: numeric , 2) as cpa 
 from ad_campaign_performance
 group by platform, campaign_type;


-- High spend and low roas campaigns 

select
    platform,
    campaign_type,
    sum(ad_spend) as spend,
    ROUND(sum(revenue) / sum(ad_spend)::numeric, 2) as roas
from ad_campaign_performance
group by platform, campaign_type 
having sum(ad_spend) > 50000
  and (sum(revenue) / sum(ad_spend)) < 4
order by spend desc;

--exporting the data
select
    date,
    platform,
    campaign_type,
    impressions,
    clicks,
    conversions,
    ad_spend,
    revenue
from ad_campaign_performance;

