SELECT country, bomb_damage_assessment ,AVG(attacking_aircraft) AS average_damage
FROM mission
WHERE bombing_aircraft > 5
GROUP BY country, bomb_damage_assessment;


"country"	    "bomb_damage_assessment"	                                                                            "average_damage"
"AUSTRALIA"		                                                                                                        7.3888888888888889
"GREAT BRITAIN"		                                                                                                    26.5680426624530911
"SOUTH AFRICA"		                                                                                                    6.3333333333333333
"USA"	        "1 DIRECT HIT ON BATTLESHIP, 2 NEAR MISSES. TRANSPORT SUNK."	                                        6.0000000000000000
"USA"	        "1 TRANSPORT SEEN TO CAPSIZE FROM BOMBING"	                                                            9.0000000000000000
"USA"	        "3 LARGE FIRES"	                                                                                        6.0000000000000000
"USA"	        "4 BOMBS MISSED ENEMY CRUISER, 3 BOMBS STRUCK TRANSPORT NEAR SHORE - DIRECT HITS, TRANSPORT BURNING"	8.0000000000000000
"USA"	        "4 SHIPS IN GULF TARGETED.  RESULTS UNCERTAINDUE TO CLOUDS"	                                            9.0000000000000000
"USA"	        "ATTACKED TRANSPORTS AND DESTROYER, RESULTS UNKNOWN"	                                                6.0000000000000000
"USA"	        "BDA NOT PERFORMED DUE TO ENEMY INTERCEPTORS"	                                                        6.0000000000000000
"USA"	        "BDA NOT PERFORMED DUE TO ENEMY SEARCHLIGHTS AND AA FIRE"	                                            6.0000000000000000
"USA"	        "DOCKS WERE HIT.  LARGE FIRE BURNING BEFORE AND AFTER ATTACK."	                                        7.0000000000000000
"USA"	        "EXCELLENT"	                                                                                            8.0000000000000000
"USA"	        "GOOD"	                                                                                                8.0000000000000000
"USA"	        "HITS ON RUNWAY AND PARKING AREA."	                                                                    9.0000000000000000
"USA"	        "NO HITS"	                                                                                            6.0000000000000000
"USA"	        "NOT STATED, LANDED AT MINDANEO"	                                                                    9.0000000000000000
"USA"		                                                                                                            18.4035664234282124
		                                                                                                                16.5182405910875087

EXPLAIN
SELECT country, AVG(attacking_aircraft) AS average_damage
FROM mission
WHERE bombing_aircraft > 5
GROUP BY country;

"QUERY PLAN"
"Finalize GroupAggregate  (cost=5888.46..5889.74 rows=5 width=38)"
"  Group Key: country"
"  ->  Gather Merge  (cost=5888.46..5889.63 rows=10 width=38)"
"        Workers Planned: 2"
"        ->  Sort  (cost=4888.43..4888.45 rows=5 width=38)"
"              Sort Key: country"
"              ->  Partial HashAggregate  (cost=4888.33..4888.38 rows=5 width=38)"
"                    Group Key: country"
"                    ->  Parallel Seq Scan on mission  (cost=0.00..4780.55 rows=21556 width=10)"
"                          Filter: (bombing_aircraft > 5)"

EXPLAIN ANALYZE
SELECT country, AVG(attacking_aircraft) AS average_damage
FROM mission
WHERE bombing_aircraft > 5
GROUP BY country;

"QUERY PLAN"
"Finalize GroupAggregate  (cost=5888.46..5889.74 rows=5 width=38) (actual time=26.267..29.661 rows=5 loops=1)"
"  Group Key: country"
"  ->  Gather Merge  (cost=5888.46..5889.63 rows=10 width=38) (actual time=26.261..29.652 rows=11 loops=1)"
"        Workers Planned: 2"
"        Workers Launched: 2"
"        ->  Sort  (cost=4888.43..4888.45 rows=5 width=38) (actual time=9.946..9.947 rows=4 loops=3)"
"              Sort Key: country"
"              Sort Method: quicksort  Memory: 25kB"
"              Worker 0:  Sort Method: quicksort  Memory: 25kB"
"              Worker 1:  Sort Method: quicksort  Memory: 25kB"
"              ->  Partial HashAggregate  (cost=4888.33..4888.38 rows=5 width=38) (actual time=9.919..9.920 rows=4 loops=3)"
"                    Group Key: country"
"                    Batches: 1  Memory Usage: 24kB"
"                    Worker 0:  Batches: 1  Memory Usage: 24kB"
"                    Worker 1:  Batches: 1  Memory Usage: 24kB"
"                    ->  Parallel Seq Scan on mission  (cost=0.00..4780.55 rows=21556 width=10) (actual time=0.013..7.872 rows=17450 loops=3)"
"                          Filter: (bombing_aircraft > 5)"
"                          Rows Removed by Filter: 41977"
"Planning Time: 0.088 ms"
"Execution Time: 29.692 ms"

CREATE INDEX idx_bombing_aircraft_country ON mission (bombing_aircraft, country);

"QUERY PLAN"
"HashAggregate  (cost=5342.60..5342.67 rows=5 width=38) (actual time=13.916..13.919 rows=5 loops=1)"
"  Group Key: country"
"  Batches: 1  Memory Usage: 24kB"
"  ->  Bitmap Heap Scan on mission  (cost=585.24..5083.93 rows=51735 width=10) (actual time=1.535..5.834 rows=52351 loops=1)"
"        Recheck Cond: (bombing_aircraft > 5)"
"        Heap Blocks: exact=3275"
"        ->  Bitmap Index Scan on idx_bombing_aircraft_country  (cost=0.00..572.31 rows=51735 width=0) (actual time=1.284..1.284 rows=52351 loops=1)"
"              Index Cond: (bombing_aircraft > 5)"
"Planning Time: 1.246 ms"
"Execution Time: 13.995 ms"

DROP INDEX IF EXISTS idx_bombing_aircraft_country;

--לפני יצירת האינדקס: השאילתה השתמשה ב-Parallel Seq Scan, עם זמן ביצוע כולל של 29.692 ms.
--אחרי יצירת האינדקס: השאילתה השתמשה ב-Bitmap Heap Scan ו-Bitmap Index Scan, וזמן הביצוע הכולל ירד ל-13.995 ms.
