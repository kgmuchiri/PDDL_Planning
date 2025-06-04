# Automated Planning Problem

## Introduction
AK Underwater has decided to continue its exploration activities in the sea. Mission operations will be controlled by plans generated using an automated planner that will direct the activities of personnel and
underwater vehicles. The area of operation is divided into a series of grid-based locations involving land and water. A command centre, which acts as a base of operations, is in one of the water locations near the land. Several types of personnel serve at the command centre, including engineers, scientists, and pilots. The main activities are performed by advanced subs, which can travel underwater and perform various types of exploration and construction tasks.

## Operations

All personnel and subs initially begin at the command centre. Some of the operations of the underwater mission are described in the following list (which isn’t exhaustive):
1. Each location in the area of operation can be either land, shallow water, or deep water.
2. A sub can only move in shallow or deep water and must have a pilot on board in order to move. A sub can only move to an adjacent location from its current location (i.e., it may take multiple moves to reach distant locations).
3. Subs are big enough to carry two people at a time.
4. Subs can carry at most one construction kit at a time: a structure kit or an energy cable kit. Kits can be loaded or unloaded to/from subs by engineers at the command centre.
5. A sub can perform two types of underwater scans. A sub can perform a subsea survey of a location, to make sure the location is safe for construction. A sub can also perform a more intensive research scan of a location, to gather data for further analysis. A scientist must be on board the sub to perform a scan and only one type of scan can be performed at a time.
6. A tidal power generator can be constructed by a sub provided the location has been surveyed and an engineer is on the sub. A tidal power generator can only be built in shallow water in a location adjacent to land. The sub must be carrying a structure kit which is used up by constructing the power generator.
7. An offshore energy cable can be installed by a sub in a water location (deep or shallow) provided the location has been surveyed and an engineer is on the sub. An energy cable can only be installed in a location provided the location is adjacent to a tidal power generator or another energy cable. The sub must also be carrying an energy cable kit, but the kit can be reused any number of times.
8. An underwater research base can be constructed by two subs operating in the same deep water location. The location must have been surveyed and both subs must have engineers on board. An offshore energy cable must also be in the location before the research base can be built. Each sub must also be carrying a structure kit which is used up by constructing the research base.
9. Some locations of shallow and deep water are marine protected areas. Subs are permitted to travel through marine protected areas, but no construction or installation of offshore energy cables is permitted in a marine protected area.
10. Personnel can move between the command centre and a sub, or an underwater research base and a sub, provided the command centre/research base and sub are in the same location.
11. The results of a research scan can be transferred from a sub into the computer system of an underwater research base if the sub is at the same location as the base. The results of a research scan can be analysed by a scientist at an underwater research base if the results have been transferred to the base computers.
12. A sub has a protective energy shield that can be turn on or off by the pilot.
13. Several locations are home to a kraken. If a sub passes through a location with a kraken without having its energy shield on, then the sub will be destroyed by the kraken.
14. If two underwater research bases are operational then a special sonar array can be turned on by an engineer at one of the bases. The sonar array confuses any kraken, allowing subs to pass through a location with a kraken, even if their energy shield is turned off.
15. All personnel, subs, and kits start at the command centre. The command centre must be situated in a water location adjacent to a land location. There are a finite number of personnel, subs, and kits. No tidal power generators, offshore energy cables, or underwater research bases are initially built/installed. At least one location must contain a kraken and at least one location must be a marine protected area.

## Implementation
Fast Forward (FF) or the Fast Downward were used at this [website](http://planning.domains/)
