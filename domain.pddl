(define (domain CafeDomain)
     (:requirements :typing :fluents :durative-actions :duration-inequalities) 
     (:types order dish shelf chef - object)
     (:predicates 
          (delivered ?o - order ?d - dish)
          (p_w_available ?o - order)
          (p_w_open ?o - order)
          (ready ?o - order ?d - dish)
          (ordered ?o - order ?d - dish)
          (order_placed ?o - order ?d - dish)
          (free ?s - shelf)
          (chef_free ?c - chef)
          (prepared ?o - order ?d - dish)

    )
    
    (:functions 
        (cooking_time ?d - dish) 
        (preparation_time ?d - dish)
    )

          
     (:durative-action PREPARATION_WINDOW
          :parameters (?o - order)
          :duration (<= ?duration 35)
          :condition (and
               (at start (p_w_available ?o)))
          :effect (and 
               (at start (not (p_w_available ?o)))
               (at start (p_w_open ?o))
               (at end (not (p_w_open ?o)))
          )
    )

    (:durative-action PREPARE_DISH
          :parameters (?d - dish ?o - order ?c - chef)
          :duration (= ?duration (preparation_time ?d))
          :condition (and 
               (at start (chef_free ?c))
               (over all (p_w_open ?o))
               (at start (order_placed ?o ?d))
               (at start (ordered ?o ?d))
               )
          :effect (and 
               (at start (not (chef_free ?c)))
               (at end (chef_free ?c))
               (at start (not (order_placed ?o ?d)))
               (at end (prepared ?o ?d))
            )
    )
    
    
     (:durative-action COOK_DISH
          :parameters (?d - dish ?o - order ?s - shelf)
          :duration (= ?duration (cooking_time ?d))
          :condition (and 
               (at start (free ?s))
               (over all (p_w_open ?o))
               ;(at start (ordered ?o ?d))
               (at start (prepared ?o ?d))
               )
          :effect (and 
               (at start (not (free ?s)))
               (at end (free ?s))
               (at start (not (prepared ?o ?d)))
               (at end (ready ?o ?d))
            )
    )
               
    (:durative-action DELIVER_DISH
          :parameters (?o - order ?d - dish)
          :duration (= ?duration 2)
          :condition (and
               (over all(p_w_open ?o))
               (at start (ready ?o ?d))
               (at start (ordered ?o ?d))
               )
          :effect (and 
                (at start (not (ready ?o ?d)))
                (at end (delivered ?o ?d))
               )
               
    )
    
     ;(:durative-action DELIVER_ORDER
     ;     :parameters (?o - order ?t - table)
     ;     :duration (= ?duration 2)
     ;     :condition (and
     ;          (over all(d_w_open ?t))
     ;          (at start (forall ?d - dish (implies (or (ordered ?o ?d) (ready ?d ?o)))))
     ;          )
     ;     :effect (and 
     ;          (not (ready ?d ?o))
     ;          (at end (delivered ?o))
     ;          )
     ;)
               
)
