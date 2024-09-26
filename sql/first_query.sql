SELECT air_force, COUNT(*) AS active_missions
FROM mission
WHERE EXTRACT(YEAR FROM mission_date) = :year
GROUP BY air_force
ORDER BY active_missions DESC;

SELECT air_force, COUNT(*) AS active_missions
FROM mission
WHERE EXTRACT(YEAR FROM mission_date) = 1943
GROUP BY air_force
ORDER BY active_missions DESC;

--"air_force"	"active_missions"
--"MTO"	        9953
--"ETO"	        7437
--"PTO"	        3834
--"CBI"	        1585
--[null]	    376
--"EAST AFRICA"	29

EXPLAIN
SELECT air_force, COUNT(*) AS active_missions
FROM mission
WHERE EXTRACT(YEAR FROM mission_date) = 1943
GROUP BY air_force
ORDER BY active_missions DESC;

"QUERY PLAN"
"Sort  (cost=5986.54..5986.55 rows=6 width=12)"
"  Sort Key: (count(*)) DESC"
"  ->  Finalize GroupAggregate  (cost=5982.11..5986.46 rows=6 width=12)"
"        Group Key: air_force"
"        ->  Gather Merge  (cost=5982.11..5986.34 rows=12 width=12)"
"              Workers Planned: 2"
"              ->  Partial GroupAggregate  (cost=4982.09..4984.93 rows=6 width=12)"
"                    Group Key: air_force"
"                    ->  Sort  (cost=4982.09..4983.02 rows=371 width=4)"
"                          Sort Key: air_force"
"                          ->  Parallel Seq Scan on mission  (cost=0.00..4966.26 rows=371 width=4)"
"                                Filter: (EXTRACT(year FROM mission_date) = '1943'::numeric)"

EXPLAIN ANALYZE
SELECT air_force, COUNT(*) AS active_missions
FROM mission
WHERE EXTRACT(YEAR FROM mission_date) = 1943
GROUP BY air_force
ORDER BY active_missions DESC;

"QUERY PLAN"
"Sort  (cost=5986.54..5986.55 rows=6 width=12) (actual time=27.193..27.540 rows=6 loops=1)"
"  Sort Key: (count(*)) DESC"
"  Sort Method: quicksort  Memory: 25kB"
"  ->  Finalize GroupAggregate  (cost=5982.11..5986.46 rows=6 width=12) (actual time=25.055..27.527 rows=6 loops=1)"
"        Group Key: air_force"
"        ->  Gather Merge  (cost=5982.11..5986.34 rows=12 width=12) (actual time=25.043..27.517 rows=6 loops=1)"
"              Workers Planned: 2"
"              Workers Launched: 2"
"              ->  Partial GroupAggregate  (cost=4982.09..4984.93 rows=6 width=12) (actual time=7.480..8.189 rows=2 loops=3)"
"                    Group Key: air_force"
"                    ->  Sort  (cost=4982.09..4983.02 rows=371 width=4) (actual time=7.441..7.682 rows=7738 loops=3)"
"                          Sort Key: air_force"
"                          Sort Method: quicksort  Memory: 769kB"
"                          Worker 0:  Sort Method: quicksort  Memory: 25kB"
"                          Worker 1:  Sort Method: quicksort  Memory: 25kB"
"                          ->  Parallel Seq Scan on mission  (cost=0.00..4966.26 rows=371 width=4) (actual time=0.004..6.727 rows=7738 loops=3)"
"                                Filter: (EXTRACT(year FROM mission_date) = '1943'::numeric)"
"                                Rows Removed by Filter: 51689"
"Planning Time: 0.098 ms"
"Execution Time: 27.635 ms"

--Before Index:
--
--Total cost: 5986.54
--Rows after filtering: 6
--Total execution time: 27.635 ms
--Execution plan:
--
--Used Sort Method: quicksort
--Scan type: Parallel Seq Scan
--Scanned 23,214 rows after filtering (7,738 rows * 3 loops)
--Used parallel processing (2 workers)
--Rows Removed by Filter: 155,067 (51,689 * 3 loops)
--CREATE INDEX idx_mission_date_year ON mission (EXTRACT(YEAR FROM mission_date));

"QUERY PLAN"
"Sort  (cost=2141.60..2141.61 rows=6 width=12) (actual time=4.825..4.826 rows=6 loops=1)"
"  Sort Key: (count(*)) DESC"
"  Sort Method: quicksort  Memory: 25kB"
"  ->  HashAggregate  (cost=2141.46..2141.52 rows=6 width=12) (actual time=4.815..4.817 rows=6 loops=1)"
"        Group Key: air_force"
"        Batches: 1  Memory Usage: 24kB"
"        ->  Bitmap Heap Scan on mission  (cost=19.33..2137.00 rows=891 width=4) (actual time=1.109..2.621 rows=23214 loops=1)"
"              Recheck Cond: (EXTRACT(year FROM mission_date) = '1943'::numeric)"
"              Heap Blocks: exact=949"
"              ->  Bitmap Index Scan on idx_mission_date_year  (cost=0.00..19.10 rows=891 width=0) (actual time=1.026..1.026 rows=23214 loops=1)"
"                    Index Cond: (EXTRACT(year FROM mission_date) = '1943'::numeric)"
"Planning Time: 1.402 ms"
"Execution Time: 4.869 ms"
--
--After Index:
--
--Total cost: 2141.60
--Rows after filtering: 6
--Total execution time: 4.869 ms
--Execution plan:
--
--Used Sort Method: quicksort
--Used HashAggregate instead of GroupAggregate
--Scan type: Bitmap Heap Scan with Bitmap Index Scan
--Scanned 23,214 rows using the index
--No parallel processing used
--
--Comparison:
--
--Execution time: Reduced from 27.635 ms to 4.869 ms (improvement of about 82%)
--Significant cost reduction: From 5986.54 to 2141.60 (reduction of about 64%)
--Improved scan type: From Parallel Seq Scan to Bitmap Index Scan, leading to more efficient row selection
--Elimination of parallel processing, as the index made it unnecessary
--Reduction in the number of rows scanned: From 178,281 (including filtered out rows) to 23,214

DROP INDEX IF EXISTS idx_mission_date_year;
