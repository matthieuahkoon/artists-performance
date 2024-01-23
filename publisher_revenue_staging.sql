
SELECT *,
CASE
  WHEN age >=0 AND age <10 THEN '0-9'
  WHEN age >=10 AND age <20 THEN '10-19'
  WHEN age >=20 AND age <30 THEN '20-29'
  WHEN age >=30 AND age <40 THEN '30-39'
  WHEN age >=40 AND age <50 THEN '40-49'
  WHEN age >=50 AND age <60 THEN '50-59'
  WHEN age >=60 AND age <70 THEN '60-69'
  WHEN age >=70 AND age <80 THEN '70-79'
  WHEN age >=80 AND age <90 THEN '80-89'
  WHEN age >=90 AND age <100 THEN '90-99'
  WHEN age >=100  THEN '100+'
END AS age_group,
CASE
  WHEN membership_duration_in_days <= 364 THEN 'Less than 1 Year'
  WHEN membership_duration_in_days >= 365 AND membership_duration_in_days <= 1095 THEN '1 - 3 Years'
  WHEN membership_duration_in_days >= 1096 AND membership_duration_in_days <= 2189 THEN '3-5 Years'
  WHEN membership_duration_in_days >= 2190 AND membership_duration_in_days <= 3649 THEN '6-9 Years'
  WHEN membership_duration_in_days >= 3650 AND membership_duration_in_days <= 7299 THEN '10-19 Years'
  WHEN membership_duration_in_days >= 7300 AND membership_duration_in_days <= 10949 THEN '20-29 Years'
  WHEN membership_duration_in_days >= 10950 AND membership_duration_in_days <= 14599 THEN '30-39 Years'
  WHEN membership_duration_in_days >= 14600 AND membership_duration_in_days <= 18249 THEN '40-49 Years'
  WHEN membership_duration_in_days >= 18250 AND membership_duration_in_days <= 21899 THEN '50-59 Years'
  WHEN membership_duration_in_days >= 21900 THEN '60+ Years'
END AS tenure_group


FROM (
SELECT
*,
DATEDIFF('day', sign_date, CAST('2023-12-31' AS DATE)) AS membership_duration_in_days,
CAST(ROUND(DATEDIFF('day', birthdate, CAST('2023-12-31' AS DATE))  / 365, 0) AS INT) AS age
FROM (
SELECT
r.author_id,
r.song_id,
r.year,
r.format,
r.revenue,
CAST(STRPTIME(a.birthdate, '%d/%m/%Y') AS DATE) AS birthdate,
CAST(STRPTIME(a.sign_date, '%d/%m/%Y') AS DATE) AS sign_date

FROM revenue_song AS r
LEFT JOIN author AS a
ON r.author_id = a.author_id
))
