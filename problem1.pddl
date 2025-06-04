(define (problem mission1)
    (:domain domain1)

    (:objects
        ;submarines
        sub1 - submarine
        ;deep water locations
        deep-water1 deep-water2 deep-water3 - deep
        ;land locations
        land1 land2 land3 - land
        ;shallow water locations
        command1 shallow1 shallow2 - shallow
        ;pilots
        pilot1 - pilot
        ;engineers
        engineer1 - engineer
        ;scientist
        scientist1 - scientist
        ;structure kits
        s_kit1 - structure_kit
        ;energy cable kits
        e_kit1 - energy_cable_kit
        ;survey
        survey - subsea_survey
        ;research scan
        research_scanner1 - research_scan
    )

    (:init
        ;setting up location grid
        (adjacent land1 land2)
        (adjacent land2 land3)
        (adjacent land1 shallow1)
        (adjacent land2 command1)
        (adjacent shallow1 command1)
        (adjacent shallow1 deep-water1)
        (adjacent command1 deep-water2)
        (adjacent deep-water2 deep-water1)
        (adjacent command1 shallow2)
        (adjacent shallow2 deep-water3)
        (adjacent deep-water2 deep-water3)
        (adjacent land3 shallow2)
        ;assigning characteristics to objects
        (makeCommand command1)
        (marine-protected deep-water3)
        (has_kraken shallow2)
        (has_kraken shallow1)
        ;all subs at command centre
        (at-sub sub1 command1)
        ;all personnel at command centre
        (at pilot1 command1)
        (at engineer1 command1)
        (at scientist1 command1)

        ;All kits at command centre
        (at-kit s_kit1 command1)
        (at-kit e_kit1 command1)
    
        ;makes sure submarine has no personnel inside
        (empty sub1)
    )

    (:goal
        (and
           ;survey all water locations
           ;construct a generator site in shallow water location shallow1 
           ;and install an off-shore energy cable in deep water location deep-water1
            (surveyed shallow1)
            (surveyed shallow2)
            (surveyed deep-water1)
            (surveyed deep-water2)
            (surveyed deep-water3)
            (has-generator shallow1)
            (has-cable deep-water1)
            ;all shields should be turned off by the end of a mission
            (not(energy_shield_on sub1))
            ;a mission is complete when all personnel return to command centre
            (at-sub sub1 command1)
            (at engineer1 command1)
            (at scientist1 command1)
            (at pilot1 command1)
            
            
            
        )
    )
)
