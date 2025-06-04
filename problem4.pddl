(define (problem mission4)
    (:domain domain1)

    (:objects
        ;submarines
        sub1 sub2 sub3 - submarine
        ;deep water locations
        deep-water1 deep-water2 deep-water3 - deep
        ;land locations
        land1 land2 land3 - land
        ;shallow water locations
        command1 shallow1 shallow2 - shallow
        ;pilots
        pilot1 pilot2 pilot3 - pilot
        ;engineers
        engineer1 engineer2 - engineer
        ;scientist
        scientist1 scientist2 - scientist
        ;structure kits
        s_kit1 s_kit2 s_kit3 s_kit4 s_kit5 - structure_kit
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
        (support-sub sub3)
        ;all subs at command centre
        (at-sub sub1 command1)
        (at-sub sub2 command1)
        (at-sub sub3 command1)
        ;all personnel at command centre
        (at pilot1 command1)
        (at engineer1 command1)
        (at scientist1 command1)
        (at pilot2 command1)
        (at engineer2 command1)
        (at scientist2 command1)
        (at pilot3 command1)
        ;All kits at command centre
        (at-kit s_kit1 command1)
        (at-kit s_kit2 command1)
        (at-kit s_kit3 command1)
        (at-kit s_kit4 command1)
        (at-kit s_kit5 command1)
        (at-kit e_kit1 command1)
        (at-kit e_kit2 command1)
        ;makes sure submarine has no personnel inside
        (empty sub1)
        (empty sub2)
        (empty sub3)
        
    )

    (:goal
        (and
            ;construct a generator at shallow water location shallow 1
            ;install off-shore cables at deep water locations deep-water1 and deep-water2
            ;construct research bases at deep-water1 and deep-water2
            ;analyse location deep-water1 and deep-water-2
            (has-generator shallow1)
            (has-cable deep-water1)
            (has-cable deep-water2)
            (is_research_base deep-water1)
            (is_research_base deep-water2)
            (location-analysed deep-water1)
            (location-analysed deep-water2)
            ;all shields should be turned off by the end of a mission
            (not(energy_shield_on sub1))
            (not(energy_shield_on sub2))
            (not(energy_shield_on sub3))
            ;a mission is complete when all personnel return to command centre
            (at-sub sub1 command1)
            (at-sub sub2 command1)
            (at-sub sub3 command1)
            (at engineer1 command1)
            (at engineer2 command1)
            (at scientist1 command1)
            (at scientist2 command1)
            (at pilot1 command1)
            (at pilot2 command1)
            (at pilot3 command1)
            
        )
    )
)
