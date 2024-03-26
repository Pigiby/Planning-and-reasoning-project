(define (domain harvest_planning)
(:requirements :strips :fluents :typing :conditional-effects :negative-preconditions :equality :universal-preconditions)
(:types 
    good tractor place farmer - object
    vegetable fruit - good
    soil farm gas_station depot - place
    
)


(:predicates 
    (farmer_at ?x - farmer ?y - place)
    (tractor_at ?x - tractor ?y - place)
    (farmer_on ?f -farmer ?t - tractor )
    (linked ?l1 ?l2 -place)
)

(:functions 
    (free_capacity ?t - tractor)
    (carrying ?g - good ?t - tractor)
    (demand_good ?g - good)
    (distance_km ?p1 ?p2 - place)
    (left_fuel ?t - tractor)
    (max_fuel ?t - tractor)
    (consume_per_km ?t - tractor)
    (contain ?x - soil ?y - good)
    (good_at_depot ?g - good ?d - depot)
    (total_path)
)

(:action goto
    :parameters (?f - farmer ?t - tractor ?p1 ?p2 - place)
    :precondition (and (linked ?p1 ?p2)(farmer_at ?f ?p1)(tractor_at ?t ?p1)(farmer_on ?f ?t )(> (left_fuel ?t)(*(distance_km ?p1 ?p2)(consume_per_km ?t)))) ;the farmer and the tractor are in p1 and the farmer is on the truck
    :effect (and 
                (not(farmer_at ?f ?p1))(not(tractor_at ?t ?p1)) ;not anymore in place p1
                (farmer_at ?f ?p2)(tractor_at ?t ?p2) ;not anymore in place p2
                (decrease (left_fuel ?t) (*(consume_per_km ?t)(distance_km ?p1 ?p2))) ;decrease the left fuel of the quantity used in the path
                (increase (total_path) (distance_km ?p1 ?p2))
    )    
)

(:action get_on
    :parameters (?f - farmer ?t - tractor)
    :precondition (and (forall(?tr - tractor) (not (farmer_on ?f ?tr )))(forall(?fa - farmer) (not (farmer_on ?fa ?t )))(exists (?p - place)(and(farmer_at ?f ?p)(tractor_at ?t ?p))))
    :effect (and (farmer_on ?f ?t ))
)


(:action get_off
    :parameters (?f - farmer ?t - tractor)
    :precondition (and (farmer_on ?f ?t ))
    :effect (and (not (farmer_on ?f ?t )))
)


(:action get_gas
    :parameters (?f - farmer ?p - gas_station ?t - tractor)
    :precondition (and (farmer_at ?f ?p)(tractor_at ?t ?p)(not (farmer_on ?f ?t )))
    :effect (and (increase (left_fuel ?t) (-(max_fuel ?t)(left_fuel ?t))))
)


(:action collect_good
    :parameters (?s - soil ?g - good ?t - tractor ?fa - farmer)
    :precondition (and (forall (?t1 - tractor)(not (farmer_on ?fa ?t1))) (farmer_at ?fa ?s)(tractor_at ?t ?s)(> (contain ?s ?g) 0)(> (free_capacity ?t) 0)(> (demand_good ?g) 0))
    :effect (and
            (when 
                (and(>= (demand_good ?g) (contain ?s ?g))(>= (free_capacity ?t)(contain ?s ?g)))
                      (and (decrease (free_capacity ?t) (contain ?s ?g))(decrease (demand_good ?g) (contain ?s ?g))(increase (carrying ?g ?t) (contain ?s ?g))(assign (contain ?s ?g) 0)))
            (when 
                (and(>= (demand_good ?g) (contain ?s ?g))(< (free_capacity ?t)(contain ?s ?g)))
                        (and (decrease (contain ?s ?g) (free_capacity ?t))(decrease (demand_good ?g) (free_capacity ?t))(increase (carrying ?g ?t) (free_capacity ?t))(assign (free_capacity ?t) 0)))
            (when 
                (and (< (demand_good ?g) (contain ?s ?g))(>= (free_capacity ?t)(demand_good ?g)))
                        (and (decrease (contain ?s ?g) (demand_good ?g))(decrease (free_capacity ?t) (demand_good ?g))(increase (carrying ?g ?t) (demand_good ?g))(assign (demand_good ?g) 0)))
            (when 
                (and (< (demand_good ?g) (contain ?s ?g))(< (free_capacity ?t)(demand_good ?g)))
                    (and (decrease (contain ?s ?g) (free_capacity ?t))(decrease (demand_good ?g) (free_capacity ?t))(increase (carrying ?g ?t) (free_capacity ?t)) (assign (free_capacity ?t) 0)))
                    )
            )


(:action release
    :parameters (?d - depot ?t - tractor ?f - farmer)
    :precondition (and (farmer_on ?f ?t)(farmer_at ?f ?d)(tractor_at ?t ?d)(exists (?g - good) (> (carrying ?g ?t) 0)))
    :effect (forall (?g - good) (when (> (carrying ?g ?t) 0)(and (increase (good_at_depot ?g ?d) (carrying ?g ?t))(increase (free_capacity ?t) (carrying ?g ?t))(assign (carrying ?g ?t) 0))))
)
)