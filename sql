SELECT l.account_id, l.dt, h.date_from, f.form_id
FROM public.pro2unsubscribed l
LEFT JOIN rpt.user_subscription_history h
ON l.account_id=h.account_id
AND l.dt BETWEEN h.date_from and h.date_to
LEFT JOIN dwh.dim_form f
ON f.account_id = l.account_id
AND f.created_at BETWEEN h.date_from and l.dt
JOIN(
	SELECT form_id, count(*) as c, count(distinct(ip)) as cip
	FROM dwh.dim_responses r
	
	HAVING count(*)>2 AND count(distinct(ip))>2
)
ON form_id
;