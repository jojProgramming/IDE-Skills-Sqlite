-- Total the illustrative CPU value of all crates delivered to each town.
-- An unknown unit price makes the town total NULL instead of understating it.
SELECT c.destination AS town,
       COUNT(*) AS crate_count,
       SUM(c.quantity) AS cpu_count,
       COUNT(*) - COUNT(t.unit_cost_gbp) AS crates_with_unknown_price,
       CASE WHEN COUNT(*) = COUNT(t.unit_cost_gbp)
            THEN ROUND(SUM(c.quantity * t.unit_cost_gbp), 2)
            ELSE NULL
       END AS total_cost_gbp
FROM CpuCrate AS c
JOIN CpuType AS t ON t.cpu_type_id = c.cpu_type_id
GROUP BY c.destination
ORDER BY total_cost_gbp DESC;