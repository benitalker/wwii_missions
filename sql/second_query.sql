select target_country, bomb_damage_assessment, count(target_country) from mission
where bomb_damage_assessment is not null
and airborne_aircraft > 5
group by target_country, bomb_damage_assessment
order by count(bomb_damage_assessment) desc limit 1;

"target_country"	"bomb_damage_assessment"	"count"
"BURMA"	            "EXCELLENT"	                7

EXPLAIN
select target_country, bomb_damage_assessment, count(target_country) from mission
where bomb_damage_assessment is not null
and airborne_aircraft > 5
group by target_country, bomb_damage_assessment
order by count(bomb_damage_assessment) desc limit 1;

"QUERY PLAN"
"Limit  (cost=5785.52..5785.52 rows=1 width=48)"
"  ->  Sort  (cost=5785.52..5785.61 rows=37 width=48)"
"        Sort Key: (count(bomb_damage_assessment)) DESC"
"        ->  Finalize GroupAggregate  (cost=5780.86..5785.33 rows=37 width=48)"
"              Group Key: target_country, bomb_damage_assessment"
"              ->  Gather Merge  (cost=5780.86..5784.66 rows=30 width=48)"
"                    Workers Planned: 2"
"                    ->  Partial GroupAggregate  (cost=4780.84..4781.18 rows=15 width=48)"
"                          Group Key: target_country, bomb_damage_assessment"
"                          ->  Sort  (cost=4780.84..4780.88 rows=15 width=32)"
"                                Sort Key: target_country, bomb_damage_assessment"
"                                ->  Parallel Seq Scan on mission  (cost=0.00..4780.55 rows=15 width=32)"
"                                      Filter: ((bomb_damage_assessment IS NOT NULL) AND (airborne_aircraft > '5'::numeric))"

EXPLAIN ANALYZE
select target_country, bomb_damage_assessment, count(target_country) from mission
where bomb_damage_assessment is not null
and airborne_aircraft > 5
group by target_country, bomb_damage_assessment
order by count(bomb_damage_assessment) desc limit 1;

"QUERY PLAN"
"Limit  (cost=5785.52..5785.52 rows=1 width=48) (actual time=36.799..39.553 rows=1 loops=1)"
"  ->  Sort  (cost=5785.52..5785.61 rows=37 width=48) (actual time=36.797..39.551 rows=1 loops=1)"
"        Sort Key: (count(bomb_damage_assessment)) DESC"
"        Sort Method: top-N heapsort  Memory: 25kB"
"        ->  Finalize GroupAggregate  (cost=5780.86..5785.33 rows=37 width=48) (actual time=36.751..39.526 rows=21 loops=1)"
"              Group Key: target_country, bomb_damage_assessment"
"              ->  Gather Merge  (cost=5780.86..5784.66 rows=30 width=48) (actual time=36.737..39.508 rows=21 loops=1)"
"                    Workers Planned: 2"
"                    Workers Launched: 2"
"                    ->  Partial GroupAggregate  (cost=4780.84..4781.18 rows=15 width=48) (actual time=10.679..10.685 rows=7 loops=3)"
"                          Group Key: target_country, bomb_damage_assessment"
"                          ->  Sort  (cost=4780.84..4780.88 rows=15 width=32) (actual time=10.671..10.672 rows=11 loops=3)"
"                                Sort Key: target_country, bomb_damage_assessment"
"                                Sort Method: quicksort  Memory: 26kB"
"                                Worker 0:  Sort Method: quicksort  Memory: 25kB"
"                                Worker 1:  Sort Method: quicksort  Memory: 25kB"
"                                ->  Parallel Seq Scan on mission  (cost=0.00..4780.55 rows=15 width=32) (actual time=7.082..10.599 rows=11 loops=3)"
"                                      Filter: ((bomb_damage_assessment IS NOT NULL) AND (airborne_aircraft > '5'::numeric))"
"                                      Rows Removed by Filter: 59416"
"Planning Time: 1.046 ms"
"Execution Time: 39.660 ms"
--
--Before Index:
--
--Total cost: 5785.52
--Rows after filtering: 21
--Total execution time: 39.660 ms
--Execution plan:
--
--Used Sort Method: top-N heapsort and quicksort
--Scan type: Parallel Seq Scan
--Scanned 33 rows after filtering (11 rows * 3 loops)
--Used parallel processing (2 workers)

CREATE INDEX idx_mission_performance ON mission (airborne_aircraft, bomb_damage_assessment, target_country);

"QUERY PLAN"
"Limit  (cost=1556.18..1556.18 rows=1 width=48) (actual time=2.482..2.483 rows=1 loops=1)"
"  ->  Sort  (cost=1556.18..1556.27 rows=37 width=48) (actual time=2.480..2.481 rows=1 loops=1)"
"        Sort Key: (count(bomb_damage_assessment)) DESC"
"        Sort Method: top-N heapsort  Memory: 25kB"
"        ->  GroupAggregate  (cost=1555.16..1556.00 rows=37 width=48) (actual time=2.465..2.472 rows=21 loops=1)"
"              Group Key: target_country, bomb_damage_assessment"
"              ->  Sort  (cost=1555.16..1555.26 rows=37 width=32) (actual time=2.457..2.459 rows=32 loops=1)"
"                    Sort Key: target_country, bomb_damage_assessment"
"                    Sort Method: quicksort  Memory: 26kB"
"                    ->  Index Only Scan using idx_mission_performance on mission  (cost=0.42..1554.20 rows=37 width=32) (actual time=0.016..2.409 rows=32 loops=1)"
"                          Index Cond: ((airborne_aircraft > '5'::numeric) AND (bomb_damage_assessment IS NOT NULL))"
"                          Heap Fetches: 0"
"Planning Time: 0.208 ms"
"Execution Time: 2.522 ms"
--
--After Index:
--
--Total cost: 1556.18
--Rows after filtering: 21
--Total execution time: 2.522 ms
--Execution plan:
--
--Used Sort Method: top-N heapsort and quicksort
--Scan type: Index Only Scan using idx_mission_performance
--Scanned 32 rows using the index
--No parallel processing used
--
--Comparison:
--
--Execution time: Reduced from 39.660 ms to 2.522 ms (improvement of about 93.6%)
--Significant cost reduction: From 5785.52 to 1556.18
--Improved scan type: From Parallel Seq Scan to Index Only Scan, leading to fewer rows scanned and faster processing
--Elimination of parallel processing, as the index made it unnecessary

DROP INDEX IF EXISTS idx_mission_performance;
