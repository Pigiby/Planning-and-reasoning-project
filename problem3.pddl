(define (problem harvest) 
(:domain harvest_planning)
(:objects 
    t1 t2 - tractor
    f1 f2 - farmer
    s1 s2 s3 - soil
    farm - farm
    d1 - depot
    g1 - gas_station
    eggplant - vegetable
    apple - fruit
)

(:init

    (tractor_at t1 farm)
    (tractor_at t2 farm)
    (farmer_at f1 farm)
    (farmer_at f2 farm)
    (=(free_capacity t1) 30)
    (=(free_capacity t2) 50)
    (=(carrying  eggplant t1) 0)
    (=(carrying apple t1) 0)
    (=(carrying  eggplant t2) 0)
    (=(carrying apple t2) 0)
    (=(demand_good eggplant) 31)
    (=(demand_good apple) 22)
    (=(contain s1 apple)12)
    (=(contain s2 apple)14)
    (=(contain s3 apple)13)
    (=(contain s1 eggplant)16)
    (=(contain s2 eggplant)17)
    (=(contain s3 eggplant)9)
    (=(distance_km farm s1)11)
    (=(distance_km s1 farm)11)
    (=(distance_km s1 s2)9)
    (=(distance_km s2 s1)9)
    (=(distance_km s1 s3)8)
    (=(distance_km s3 s1)8)
    (=(distance_km s1 g1)7)
    (=(distance_km g1 s1)7)
    (=(distance_km s2 d1)15)
    (=(distance_km d1 s2)15) 
    (=(max_fuel t1) 100)
    (=(left_fuel t1) 50)
    (=(max_fuel t2) 150)
    (=(left_fuel t2) 60)
    (=(consume_per_km t1) 1.5)
    (=(consume_per_km t2) 3.2)
    (=(good_at_depot apple d1) 0)
    (=(good_at_depot eggplant d1) 0)
    (linked farm s1)
    (linked s1 farm)
    (linked s1 s2)
    (linked s2 s1)
    (linked s1 s3)
    (linked s3 s1)
    (linked s1 g1)
    (linked g1 s1)
    (linked s2 d1)
    (linked d1 s2)

        (=(total_path)0)
)

(:goal (and
    (=(good_at_depot eggplant d1) 31)
    (=(good_at_depot apple d1) 22)
    )

    )
)
