(define (problem harvest) 
(:domain harvest_planning)
(:objects 
    t1 - tractor
    f1 - farmer
    s1 s2 - soil
    farm - farm
    d1 - depot
    g1 - gas_station
    eggplant - vegetable
    apple - fruit
)

(:init

    (tractor_at t1 farm)
    (farmer_at f1 farm)
    (=(free_capacity t1) 30)
    (=(carrying  eggplant t1) 0)
    (=(carrying apple t1) 0)
    (=(demand_good eggplant) 10)
    (=(demand_good apple) 5)
    (=(contain s1 apple) 15)
    (=(contain s2 apple) 11)
    (=(contain s1 eggplant) 5)
    (=(contain s2 eggplant) 6)
    (=(distance_km s2 s1)11)
    (=(distance_km s1 s2)11)
    (=(distance_km farm s1)7)
    (=(distance_km s1 farm)7)
    (=(distance_km g1 s1)5)
    (=(distance_km s1 g1)5)
    (=(distance_km d1 s2)17)
    (=(distance_km s2 d1)17)
    (=(max_fuel t1) 100)
    (=(left_fuel t1) 1000)
    (=(consume_per_km t1) 1.5)
    (=(good_at_depot apple d1) 0)
    (=(good_at_depot eggplant d1) 0)
    (linked s2 s1)
    (linked s1 s2)
    (linked farm s1)
    (linked s1 farm)
    (linked g1 s1)
    (linked s1 g1)
    (linked d1 s2)
    (linked s2 d1)
    (=(total_path)0)
)

(:goal (and
    (=(good_at_depot eggplant d1) 10)(=(good_at_depot apple d1) 5)
    
    )
    )

)
