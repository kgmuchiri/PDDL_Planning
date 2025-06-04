(define (domain domain1)
    (:requirements
        :strips :conditional-effects :typing :negative-preconditions :disjunctive-preconditions
    )

    (:types
        ;pilots, scientists and engineers are considered as personnel
        pilot scientist engineer - personnel
        ;a location is either on land or in water
        land water - location
        ;a water location is either shallow or deep
        shallow deep - water
        ;All submarines are of this type
        submarine - object
        ;There are structure kits and energy cable kits
        structure_kit energy_cable_kit - kit
        ;there are two types of scans subsea survey and research scan
        subsea_survey research_scan - scan
        
    )

    (:predicates
        ;defines whether the submarine is at a given location
        (at-sub ?sub - submarine ?l - location)
        ;defines whether personnel is at a given location
        (at ?x - personnel ?l - location)
        ;defines whether personnel is in a submarine
        (in ?x - personnel ?sub - submarine)
        ;used to keep track of the number of people onboard a submarine
        (empty ?sub - submarine)
        (half-full ?sub - submarine)
        (full ?sub - submarine)
        ;state that gives the location of a kit
        (in-kit ?k - kit ?sub - submarine)
        (at-kit ?k - kit ?l - location)
        ;defines if there is a kit in a given submarine
        (has-kit ?sub - submarine)
        ;states that location l1 is adjacent to location l2
        (adjacent ?l1 - location ?l2 - location)
        ;scan status
        (scan_done ?s - scan ?l - water)
        (scan_ongoing ?s - scan ?sub - submarine)
        ;location has been surveyed
        (surveyed ?l - location)
        ;location has been scanned by research scan
        (scanned ?l - water)
        ;states that a shallow location is adjacent to land
        (adjacent-to-land ?l1 - shallow)
        ;states the shallow location has a tidal powered generator
        (has-generator ?l - water)
        (has-cable ?l - water)
        ;is true for command centre
        (is_command ?l - water)
        ;location is adjacent to generator or offshore cable
        (adjacent-to-generator-cable ?l - water)
        ;location is a research base
        (is_research_base ?l - water)
        ;when a structure kit is used
        (used-kit ?k - kit)
        ;makes a location command centre as long as it meets requirements
        (makeCommand ?l - water)
        ;results of research scan at research base
        (scan-Results-At-Base ?l - water)
        ;results from scans analysed
        (location-analysed ?l - water)
        ;location has a kraken
        (has_kraken ?l - water)
        ;submarine energy shield is on - protected by shield
        (energy_shield_on ?sub - submarine)
        ;sonar array switched on at location
        (sonar_array_on ?l - water)
        ;location is marine protected
        (marine-protected ?l - water)
        ;a submarine of support type - acts as second submarine during research base construction
        (support-sub ?sub - submarine)
        ;when sub is protected by shield or sonar
        (sub-protected ?sub - submarine)
        ;when sub is protected by sonar only
        (sub-protected-by-sonar ?sub - submarine)
        ;location is either a command centre or a research base
        (command-base ?l - water)
  
    )

    ;Onboard personnel as long as they are at a research base or command centre
    (:action board-Personnel
        :parameters 
            (?p - personnel ?sub - submarine ?l - water)
        :precondition
            (and (at-sub ?sub ?l) (at ?p ?l) 
                (not(full ?sub))
                (command-base ?l)
            )
        :effect
            (and
                (in ?p ?sub)
                (not (at ?p ?l))
                (when (empty ?sub)
                      (and
                          (not (empty ?sub))
                          (half-full ?sub)
                      )
                )
                (when (half-full ?sub)
                      (and
                          (not (half-full ?sub))
                          (full ?sub)
                      )
                )
            )
    )

    ;moves a submarine from one location to an adjacent location as long as there is a pilot on board
    (:action move-Sub
        :parameters
            (?sub - submarine ?l1 - water ?l2 - water ?p - pilot)
        :precondition
            (and
                (at-sub ?sub ?l1)
                (or(adjacent ?l1 ?l2)(adjacent ?l2 ?l1))
                (in ?p ?sub)
                (forall (?scan - scan)
                    (not (scan_ongoing ?scan ?sub))
                )
                (or (not (has_kraken ?l2))(sub-protected ?sub))
            )
        :effect
            (and
                (not (at-sub ?sub ?l1))
                (at-sub ?sub ?l2)
            )
    )

    ;Offboards personnel as long as the submarine is at the command centre or the research base
    (:action offBoard-Personnel
    :parameters
        (?p - personnel ?sub - submarine ?l - water)
    :precondition
        (and
            (at-sub ?sub ?l)
            (in ?p ?sub)
            (command-base ?l)
        )
    :effect
        (and
            (not (in ?p ?sub))
            (at ?p ?l)
            (when (full ?sub)
                  (and
                      (not (full ?sub))
                      (half-full ?sub)
                  )
            )
            (when (half-full ?sub)
                  (and
                      (not (half-full ?sub))
                      (empty ?sub)
                  )
            )
        )
    )
    ;Offboards all personnel as long as the submarine is at the command centre or the research base
    (:action offBoard-AllPersonnel
        :parameters
            (?sub - submarine ?l - location)
        :precondition
            (and
		        (at-sub ?sub ?l)
                (not (empty ?sub))
                (full ?sub)
            )
        :effect
            (and
                (forall (?p - personnel)
                    (when (in ?p ?sub)
                          (and
                              (at ?p ?l)
                              (not (in ?p ?sub))
                          )
                    )
                )
                (empty ?sub)
                (not (half-full ?sub))
                (not (full ?sub))
            )
    )

    ;load kit on to submarine as long as it is at the command centre
    (:action load-Kit
        :parameters 
            (?k - kit ?sub - submarine ?l - water ?e - engineer)
        :precondition
            (and
                (at-sub ?sub ?l)
                (at-kit ?k ?l)
                (not(has-kit ?sub))
                (is_command ?l)
                (at ?e ?l)
                (not (used-kit ?k))
            )
        :effect
            (and
                (in-kit ?k ?sub)
                (not (at-kit ?k ?l))
                (has-kit ?sub)
            )
    )

    ;offload kit from submarine to command centre
    (:action offload-Kit
        :parameters
            (?k - kit ?sub - submarine ?l - water ?e - engineer)
        :precondition
            (and
                (at-sub ?sub ?l)
                (in-kit ?k ?sub)
                (is_command ?l)
                (has-kit ?sub)
                (at ?e ?l)
            )
        :effect
            (and
                (not (in-kit ?k ?sub))
                (at-kit ?k ?l)
                (not(has-kit ?sub))
            )
    )

    ;performs subsea survey
    (:action perform-Survey
        :parameters
            (?sub - submarine ?l - water ?s - scientist ?scan - subsea_survey)
        :precondition
            (and
                (at-sub ?sub ?l)
                (in ?s ?sub)
                (not (scan_ongoing ?scan ?sub))
                (not (is_command ?l))
            )
        :effect
            (and
                (scan_ongoing ?scan ?sub)
            )
    )

    ;performs research scan as long as submarine is at research base
    (:action perform-Research-Scan
        :parameters
            (?sub - submarine ?l - water ?s - scientist ?scan - research_scan)
        :precondition
            (and
                (at-sub ?sub ?l)
                (in ?s ?sub)
                (not (scan_ongoing ?scan ?sub))
                (not (is_command ?l))
                (is_research_base ?l)
            )
        :effect
            (and
                (scan_ongoing ?scan ?sub)
            )
    )

    ;completes survey and marks location as surveyed
    (:action finish-Survey
        :parameters
            (?sub - submarine ?scan - subsea_survey ?l - water)
        :precondition
            (and
                (scan_ongoing ?scan ?sub)
                (at-sub ?sub ?l)
             )
        :effect
            (and
                (scan_done ?scan ?l)
                (not (scan_ongoing ?scan ?sub))
                (surveyed ?l)
            )
            
    )

    ;completes research scan  and marks location as surveyed
    (:action finish-Research-Scan
        :parameters
            (?sub - submarine ?scan - research_scan ?l - water)
        :precondition
            (and
                (scan_ongoing ?scan ?sub)
                (at-sub ?sub ?l)
             )
        :effect
            (and
                (scan_done ?scan ?l)
                (not (scan_ongoing ?scan ?sub))
                (scanned ?l)
            )
            
    )
    
    ;sets a location as the command centre as long as it is a location adjacent to land
    (:action make-Command-Centre
        :parameters
            (?l - shallow)
        :precondition
            (and
                (makeCommand ?l)
                (adjacent-to-land ?l)
            )
            
        :effect
        (and
            (is_command ?l)
            (command-base ?l)
        )
            
    )
    ;constructs a power generator at a shallow water location adjacent to land
    (:action construct-Power-Generator
        :parameters
            (?sub - submarine ?l - shallow ?k - structure_kit ?e - engineer)
        :precondition
            (and
                (at-sub ?sub ?l)
                (not (has-generator ?l))
                (not(marine-protected ?l))
                (in ?e ?sub)
                (surveyed ?l)
                (adjacent-to-land ?l)
                (not(used-kit ?k))
                (in-kit ?k ?sub)
            )
        :effect
            (and
                (has-generator ?l)
                (used-kit ?k)
            )
    )
    ;sets shallow to adjacent to land when 
    (:action mark-Shallow-Land-Adjacency
        :parameters
            (?sh - shallow ?l - land)
        :precondition
            (or(adjacent ?sh ?l) (adjacent ?l ?sh))
        :effect
            (adjacent-to-land ?sh)
    )
    
    (:action install-Offshore-Energy-Cable
        :parameters
            (?sub - submarine ?l - water ?k - energy_cable_kit ?e - engineer)
        :precondition
            (and
                (at-sub ?sub ?l)
                (not (has-cable ?l))
                (not (has-generator ?l))
                (not(marine-protected ?l))
                (in ?e ?sub)
                (surveyed ?l)
                (adjacent-to-generator-cable ?l)
                (in-kit ?k ?sub)
            )
        :effect
            (and
                (has-cable ?l)
            )
    )
    ;marks water locations adjacent to cables
    (:action mark-Cable-Adjacency
        :parameters
            (?l1 - water ?l2 - water)
        :precondition
            (and
                (has-cable ?l2)
                (or(adjacent ?l1 ?l2)(adjacent ?l2 ?l1))
            )
           
        :effect
            (adjacent-to-generator-cable ?l1)
    )
    ;establish water locations adjacent to generators
    (:action mark-Generator-Adjacency
        :parameters
            (?l1 - water ?l2 - shallow)
        :precondition
            (and
                (has-generator ?l2)
                (or(adjacent ?l1 ?l2)(adjacent ?l2 ?l1))
            )
        :effect
            (adjacent-to-generator-cable ?l1)
    )
    ;constructs research base with two submarines
    (:action construct-Research-Base
        :parameters
            (?sub1 - submarine ?sub2 - submarine ?l - deep ?e1 - engineer ?e2 - engineer ?k1 - structure_kit ?k2 - structure_kit)
        :precondition
            (and
                (not(support-sub ?sub1))
                (support-sub ?sub2)
                (not(marine-protected ?l))
                (at-sub ?sub1 ?l)
                (at-sub ?sub2 ?l)
                (in ?e1 ?sub1)
                (in ?e2 ?sub2)
                (in-kit ?k1 ?sub1)
                (in-kit ?k2 ?sub2)
                (not(used-kit ?k1))
                (not(used-kit ?k2))
                (surveyed ?l)
                (has-cable ?l)
                (not (is_research_base ?l))
            )
        :effect
            (and
                (is_research_base ?l)
                (command-base ?l)
                (used-kit ?k1)
                (used-kit ?k2)
            )
    )
    ;transfers the result of a research scan to the research base computer
    (:action transfer-Scan-Results-To-Base-Computer
        :parameters 
            (?sub - submarine ?l - water ?s - scientist)
        :precondition 
            (and
                (scanned ?l) 
                (at-sub ?sub ?l)
                (in ?s ?sub)
            )
        :effect (scan-Results-At-Base ?l)
    )
    ;Results of scan are analysed at base by scientist
    (:action analyse-Scan-Results
        :parameters
            (?s - scientist ?l - water)
        :precondition 
            (and
                (at ?s ?l)
                (scan-Results-At-Base ?l)
            )
        :effect (location-analysed ?l)
    )
    ;Turns on sonar array provided that there are two research bases
    (:action turn-on-sonar-array
        :parameters 
        (?l - water ?e - engineer ?l2 - water)
        :precondition 
            (and 
                (is_research_base ?l)
                (at ?e ?l)
                (is_research_base ?l2)
                (not (sonar_array_on ?l))
                (not(at ?e ?l2))
            )
        :effect 
            (and
            (sonar_array_on ?l)
            (forall (?sub - submarine)
                (and
                    (sub-protected ?sub)
                    (sub-protected-by-sonar ?sub)
                )
            )
            )
    )
    ;Turns on energy shield on submarine to protect submarine from kraken
    (:action turn-on-shield
        :parameters (?sub - submarine ?p - pilot)
        :precondition 
            (and 
                (in ?p ?sub)
                (not (energy_shield_on ?sub))
                (not(sub-protected ?sub))
                )
                
        :effect 
        (and
            (energy_shield_on ?sub)
            (sub-protected ?sub)
        )
    )
    ;turns off shield on submarine if the shield is on,
    ;or it is protected by sonar,
    ;or it is at a location that does not have kracken
    (:action turn-off-shield
        :parameters 
        (?sub - submarine ?p - pilot ?l - water)
        :precondition 
            (and 
                (in ?p ?sub)
                (energy_shield_on ?sub)
                (or (sub-protected-by-sonar ?sub) (and(at-sub ?sub ?l)
                (not(has_kraken ?l)))
                )
            )
        :effect 
            (and
                (not (energy_shield_on ?sub))
                (when (not(sub-protected-by-sonar ?sub))
                    (not(sub-protected ?sub)))
            )

    )
    

    
)
