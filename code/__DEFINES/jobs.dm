#define JOB_AVAILABLE 0
#define JOB_UNAVAILABLE_GENERIC 1
#define JOB_UNAVAILABLE_BANNED 2
#define JOB_UNAVAILABLE_PLAYTIME 3
#define JOB_UNAVAILABLE_ACCOUNTAGE 4
#define JOB_UNAVAILABLE_SLOTFULL 5

#define DEFAULT_RELIGION "Christianity"
#define DEFAULT_DEITY "Space Jesus"
#define DEFAULT_BIBLE "Default Bible Name"

#define JOB_DISPLAY_ORDER_DEFAULT 0

#define JOB_DISPLAY_ORDER_ASSISTANT 1
#define JOB_DISPLAY_ORDER_CAPTAIN 2
#define JOB_DISPLAY_ORDER_HEAD_OF_PERSONNEL 3
#define JOB_DISPLAY_ORDER_BARTENDER 4
#define JOB_DISPLAY_ORDER_BOTANIST 5
#define JOB_DISPLAY_ORDER_COOK 6
#define JOB_DISPLAY_ORDER_JANITOR 7
#define JOB_DISPLAY_ORDER_CLOWN 8
#define JOB_DISPLAY_ORDER_MIME 9
#define JOB_DISPLAY_ORDER_CURATOR 10
#define JOB_DISPLAY_ORDER_LAWYER 11
#define JOB_DISPLAY_ORDER_CHAPLAIN 12
#define JOB_DISPLAY_ORDER_PSYCHOLOGIST 13
#define JOB_DISPLAY_ORDER_ARMS_DEALER 14
#define JOB_DISPLAY_ORDER_DISC_JOCKEY 15
#define JOB_DISPLAY_ORDER_AI 16
#define JOB_DISPLAY_ORDER_CYBORG 17
#define JOB_DISPLAY_ORDER_CHIEF_ENGINEER 18
#define JOB_DISPLAY_ORDER_STATION_ENGINEER 19
#define JOB_DISPLAY_ORDER_ATMOSPHERIC_TECHNICIAN 20
#define JOB_DISPLAY_ORDER_QUARTERMASTER 21
#define JOB_DISPLAY_ORDER_CARGO_TECHNICIAN 22
#define JOB_DISPLAY_ORDER_SHAFT_MINER 23
#define JOB_DISPLAY_ORDER_CHIEF_MEDICAL_OFFICER 24
#define JOB_DISPLAY_ORDER_MEDICAL_DOCTOR 25
#define JOB_DISPLAY_ORDER_PARAMEDIC 26
#define JOB_DISPLAY_ORDER_CHEMIST 27
#define JOB_DISPLAY_ORDER_VIROLOGIST 28
#define JOB_DISPLAY_ORDER_RESEARCH_DIRECTOR 29
#define JOB_DISPLAY_ORDER_SCIENTIST 30
#define JOB_DISPLAY_ORDER_ROBOTICIST 31
#define JOB_DISPLAY_ORDER_GENETICIST 32
#define JOB_DISPLAY_ORDER_HEAD_OF_SECURITY 33
#define JOB_DISPLAY_ORDER_WARDEN 34
#define JOB_DISPLAY_ORDER_DETECTIVE 35
#define JOB_DISPLAY_ORDER_SECURITY_OFFICER 36
#define JOB_DISPLAY_ORDER_PRISONER 37
#define JOB_DISPLAY_ORDER_RED_TEAM_ADMIRAL 38
#define JOB_DISPLAY_ORDER_RED_TEAM_MEMBER 39
#define JOB_DISPLAY_ORDER_BLUE_TEAM_ADMIRAL 40
#define JOB_DISPLAY_ORDER_BLUE_TEAM_MEMBER 41


#define DEPARTMENT_SECURITY (1<<0)
#define DEPARTMENT_COMMAND (1<<1)
#define DEPARTMENT_SERVICE (1<<2)
#define DEPARTMENT_CARGO (1<<3)
#define DEPARTMENT_ENGINEERING (1<<4)
#define DEPARTMENT_SCIENCE (1<<5)
#define DEPARTMENT_MEDICAL (1<<6)
#define DEPARTMENT_SILICON (1<<7)

/* Job datum job_flags */
/// Whether the mob is announced on arrival.
#define JOB_ANNOUNCE_ARRIVAL (1<<0)
/// Whether the mob is added to the crew manifest.
#define JOB_CREW_MANIFEST (1<<1)
/// Whether the mob is equipped through SSjob.EquipRank() on spawn.
#define JOB_EQUIP_RANK (1<<2)
/// Whether the job is considered a regular crew member of the station. Equipment such as AI and cyborgs not included.
#define JOB_CREW_MEMBER (1<<3)
/// Whether this job can be joined through the new_player menu.
#define JOB_NEW_PLAYER_JOINABLE (1<<4)

#define FACTION_NONE "None"
#define FACTION_STATION "Station"
#define FACTION_SVS "SVS"
