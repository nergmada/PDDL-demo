(define (problem CafeProblem1)
     (:domain CafeDomain)
     (:objects 
	order1 order2 - order
	lasagne chicken - dish
	chef1 chef2 - chef 
        ovenshelf1 ovenshelf2 ovenshelf3 - shelf
     )
     (:init
	;two longs order
	(p_w_available order1)
	(ordered order1 lasagne)
	(ordered order1 chicken)
	(order_placed order1 lasagne)
	(order_placed order1 chicken)
        (free ovenshelf1)
        (free ovenshelf2)
        (free ovenshelf3)
        (chef_free chef1)
        (chef_free chef2)
	(= (preparation_time lasagne) 4)
	(= (cooking_time lasagne) 28)
	(= (preparation_time chicken) 2)
	(= (cooking_time chicken) 30)
)
     (:goal (and
	 		(delivered order1 lasagne)
			(delivered order1 chicken)
		)
          
     )
     (:metric minimize (total-time))
     
)
