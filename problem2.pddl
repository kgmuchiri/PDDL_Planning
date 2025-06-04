(define (problem mission2)
    (:domain domain1)

    (:objects
        ;submarines
        sub1 sub2 - submarine
        ;deep water locations
        deep-water1 deep-water2 deep-water3 - deep
        ;land locations
        land1 land2 land3 - land
        ;shallow water locations
        command1 shallow1 shallow2 - shallow
        ;pilots
        pilot1 pilot2 - pilot
        ;engineers
        engineer1 engineer2 - engineer
        ;scientist
        scientist1 scientist2 - scientist
        ;structure kits
        s_kit1 s_kit2 s_kit3 s_kit4 - structure_kit
        ;energy cable kits
        e_kit1 e_kit2 - energy_cable_kit
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
        (support-sub sub2)
        ;all subs at command centre
        (at-sub sub1 command1)
        (at-sub sub2 command1)
        ;all personnel at command centre
        (at pilot1 command1)
        (at engineer1 command1)
        (at scientist1 command1)
        (at pilot2 command1)
        (at engineer2 command1)
        (at scientist2 command1)
        ;All kits at command centre
        (at-kit s_kit1 command1)
        (at-kit s_kit2 command1)
        (at-kit s_kit3 command1)
        (at-kit s_kit4 command1)
        (at-kit e_kit1 command1)
        (at-kit e_kit2 command1)
        ;makes sure submarine has no personnel inside
        (empty sub1)
        (empty sub2)
        
        
    )

    (:goal
        (and
            ;survey all locations
            (surveyed shallow1)
            (surveyed shallow2)
            (surveyed deep-water1)
            (surveyed deep-water2)
            (surveyed deep-water3)
            ;all shields should be turned off by the end of a mission
            (not(energy_shield_on sub1))
            (not(energy_shield_on sub2))
            ;a mission is complete when all personnel return to command centre
            (at-sub sub1 command1)
            (at-sub sub2 command1)
            (at engineer1 command1)
            (at engineer2 command1)
            (at scientist1 command1)
            (at scientist2 command1)
            (at pilot1 command1)
            (at pilot2 command1)

            
        )
    )
)
