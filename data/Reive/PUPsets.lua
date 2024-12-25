function init_gear_sets()
    --Table of Contents
    ---Gear Variables
    ---Master Only Sets
    ---Hybrid Only Sets
    ---Pet Only Sets
    ---Misc Sets

    -------------------------------------------------------------------------
    --  _____                  __      __        _       _     _
    -- / ____|                 \ \    / /       (_)     | |   | |
    --| |  __  ___  __ _ _ __   \ \  / /_ _ _ __ _  __ _| |__ | | ___  ___
    --| | |_ |/ _ \/ _` | '__|   \ \/ / _` | '__| |/ _` | '_ \| |/ _ \/ __|
    --| |__| |  __/ (_| | |       \  / (_| | |  | | (_| | |_) | |  __/\__ \
    -- \_____|\___|\__,_|_|        \/ \__,_|_|  |_|\__,_|_.__/|_|\___||___/
    -------------------------------------------------------------------------
    --[[
        This section is best ultilized for defining gear that is used among multiple sets
        You can simply use or ignore the below
    ]]
	organizer_items = {
		p2="Animator P II +1",
		p1="Animator P +1",
		p3="Neo Animator",
		oil1="Automat. Oil +3",
		oil2="Automat. Oil +2",
		--kara="Karambit",
		--ohtas={ name="Ohtas", augments={'Accuracy+70','Pet: Accuracy+70','Pet: Haste+10%',}},
		sakpata="Sakpata's Fists",
		--gnafron="Gnafron's Adargas",
		godhands="Godhands",
		xiucoatl="Xiucoatl",
	}

    --Adjust to your reforge level
    --Sets up a Key, Value Pair
    Artifact_Foire = {}
    Artifact_Foire.Head_PRegen = "Foire Taj +1"
    Artifact_Foire.Body_WSD_PTank = "Foire Tobe +1"
    Artifact_Foire.Hands_Mane_Overload = "Foire Dastanas +3"
    Artifact_Foire.Legs_PCure = "Foire Churidars +1"
    Artifact_Foire.Feet_Repair_PMagic = "Foire Babouches +1"

    Relic_Pitre = {}
    Relic_Pitre.Head_PRegen = "Pitre Taj +3" --Enhances Optimization
    Relic_Pitre.Body_PTP = "Pitre Tobe +3" --Enhances Overdrive
    Relic_Pitre.Hands_WSD = "Pitre Dastanas +3" --Enhances Fine-Tuning
    Relic_Pitre.Legs_PMagic = "Pitre Churidars +3" --Enhances Ventriloquy
    Relic_Pitre.Feet_PMagic = "Pitre Babouches +3" --Role Reversal

    Empy_Karagoz = {}
    Empy_Karagoz.Head_PTPBonus = "Karagoz Capello +1"
    Empy_Karagoz.Body_Overload = "Karagoz Farsetto +1"
    Empy_Karagoz.Hands = "Karagoz Guanti +1"
    Empy_Karagoz.Legs_Combat = "Karagoz Pantaloni +1"
    Empy_Karagoz.Feet_Tatical = "Karagoz Scarpe +1"

    Visucius = {}
	Visucius.StrCrit = {
		name = "Visucius's Mantle",
		augments = {
			'STR+20',
			'Accuracy+20 Attack+20',
			'STR+10',
			'Crit.hit rate+10',
		}
	}
	Visucius.StrDA = {
		name = "Visucius's Mantle", 
		augments={
			'STR+20',
			'Accuracy+20 Attack+20',
			'STR+10',
			'"Dbl.Atk."+10',
			'Damage taken-5%',
		}
	}
    Visucius.PetMagic = {
		name="Visucius's Mantle",
		augments={
			'Pet: M.Acc.+20 Pet: M.Dmg.+20',
			'Eva.+20 /Mag. Eva.+20',
			'Pet: Mag. Acc.+10',
			'Pet: "Regen"+10',
			'Pet: Damage taken -5%',
		}
    }
	Visucius.PetHaste = {
		name="Visucius's Mantle", 
		augments={
			'Pet: Acc.+20 Pet: R.Acc.+20 Pet: Atk.+20 Pet: R.Atk.+20',
			'Accuracy+20 Attack+20',
			'Pet: Accuracy+10 Pet: Rng. Acc.+10',
			'Pet: Haste+10',
			'System: 1 ID: 1246 Val: 4',
		}
	}
	
    --------------------------------------------------------------------------------
    --  __  __           _               ____        _          _____      _
    -- |  \/  |         | |             / __ \      | |        / ____|    | |
    -- | \  / | __ _ ___| |_ ___ _ __  | |  | |_ __ | |_   _  | (___   ___| |_ ___
    -- | |\/| |/ _` / __| __/ _ \ '__| | |  | | '_ \| | | | |  \___ \ / _ \ __/ __|
    -- | |  | | (_| \__ \ ||  __/ |    | |__| | | | | | |_| |  ____) |  __/ |_\__ \
    -- |_|  |_|\__,_|___/\__\___|_|     \____/|_| |_|_|\__, | |_____/ \___|\__|___/
    --                                                  __/ |
    --                                                 |___/
    ---------------------------------------------------------------------------------
    --This section is best utilized for Master Sets
    --[[
        Will be activated when Pet is not active, otherwise refer to sets.idle.Pet
    ]]
    sets.idle = {
		head={ name="Nyame Helm", augments={'Path: B',}},
		body={ name="Nyame Mail", augments={'Path: B',}},
		hands={ name="Nyame Gauntlets", augments={'Path: B',}},
		legs={ name="Nyame Flanchard", augments={'Path: B',}},
		feet={ name="Nyame Sollerets", augments={'Path: B',}},
		neck="Yngvi Choker",
		waist="Moonbow Belt +1",
		left_ear="Etiolation Earring",
		right_ear="Eabani Earring",
		left_ring="Defending Ring",
		right_ring="Shneddick Ring +1",
		back=Visucius.PetMagic,
	}

    -------------------------------------Fastcast
    sets.precast.FC = {
		body="Zendik Robe",
		neck="Baetyl Pendant",
		left_ear="Etiolation Earring",
		right_ear="Loquac. Earring",
    }

    -------------------------------------Midcast
    sets.midcast = {} --Can be left empty

    sets.midcast.FastRecast = {
       -- Add your set here 
    }

    -------------------------------------Kiting
    sets.Kiting = {}

    -------------------------------------JA
    sets.precast.FC.Utsusemi = sets.precast.FC--set_combine(sets.precast.FC, {neck = "Magoraga Beads", body = "Passion Jacket"})

    -- Precast sets to enhance JAs
    sets.precast.JA = {} -- Can be left empty

    sets.precast.JA["Tactical Switch"] = {feet = Empy_Karagoz.Feet_Tatical}

    sets.precast.JA["Ventriloquy"] = {legs = Relic_Pitre.Legs_PMagic}

    sets.precast.JA["Role Reversal"] = {feet = Relic_Pitre.Feet_PMagic}

    sets.precast.JA["Overdrive"] = {body = Relic_Pitre.Body_PTP}

    sets.precast.JA["Repair"] = {
		head={ name="Herculean Helm", augments={'Pet: Mag. Acc.+13','"Repair" potency +8%','Pet: AGI+9',}},
		body="Foire Tobe +1",
		hands={ name="Herculean Gloves", augments={'"Repair" potency +7%','Pet: "Mag.Atk.Bns."+3',}},
		legs={ name="Desultor Tassets", augments={'"Repair" potency +10%','"Phantom Roll" ability delay -5',}},
		feet="Foire Babouches +3",
		left_ear="Pratik Earring",
		right_ear="Guignol Earring",
		right_ring="Overbearing Ring",
    }

    sets.precast.JA["Maintenance"] = set_combine(sets.precast.JA["Repair"], {})

    sets.precast.JA.Maneuver = {
        neck = "Buffoon's Collar +1",
        body = Empy_Karagoz.Body_Overload,
        hands = Artifact_Foire.Hands_Mane_Overload,
        back = "Visucius's Mantle",
        ear2 = "Burana Earring"
    }

    sets.precast.JA["Activate"] = {feet="Mpaca's Boots", back="Visucius's Mantle"}

    sets.precast.JA["Deus Ex Automata"] = sets.precast.JA["Activate"]

    sets.precast.JA["Provoke"] = {}

    --Waltz set (chr and vit)
    sets.precast.Waltz = {
       -- Add your set here 
    }

    sets.precast.Waltz["Healing Waltz"] = {}

    -------------------------------------WS
    -- Weaponskill sets
    -- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS = {
    }

    -- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
    sets.precast.WS["Stringing Pummel"] = {
	    head={ name="Mpaca's Cap", augments={'Path: A',}},
		body={ name="Mpaca's Doublet", augments={'Path: A',}},
		hands={ name="Ryuo Tekko +1", augments={'STR+12','DEX+12','Accuracy+20',}},
		legs={ name="Mpaca's Hose", augments={'Path: A',}},
		feet={ name="Mpaca's Boots", augments={'Path: A',}},
		neck="Fotia Gorget",
		waist="Fotia Belt",
		left_ear={ name="Schere Earring", augments={'Path: A',}},
		right_ear={ name="Moonshade Earring", augments={'"Mag.Atk.Bns."+4','TP Bonus +250',}},
		left_ring="Gere Ring",
		right_ring="Niqmaddu Ring",
		back=Visucius.StrCrit,
	}
		
    sets.precast.WS["Victory Smite"] = {
	    head={ name="Mpaca's Cap", augments={'Path: A',}},
		body={ name="Mpaca's Doublet", augments={'Path: A',}},
		hands={ name="Ryuo Tekko +1", augments={'STR+12','DEX+12','Accuracy+20',}},
		legs={ name="Mpaca's Hose", augments={'Path: A',}},
		feet={ name="Mpaca's Boots", augments={'Path: A',}},
		neck="Fotia Gorget",
		waist="Moonbow Belt +1",
		left_ear={ name="Schere Earring", augments={'Path: A',}},
		right_ear={ name="Moonshade Earring", augments={'"Mag.Atk.Bns."+4','TP Bonus +250',}},
		left_ring="Gere Ring",
		right_ring="Niqmaddu Ring",
		back=Visucius.StrCrit,
	}

    sets.precast.WS["Shijin Spiral"] = {
	    head={ name="Mpaca's Cap", augments={'Path: A',}},
		body={ name="Mpaca's Doublet", augments={'Path: A',}},
		hands={ name="Nyame Gauntlets", augments={'Path: B',}},
		legs={ name="Nyame Flanchard", augments={'Path: B',}},
		feet={ name="Nyame Sollerets", augments={'Path: B',}},
		neck="Fotia Gorget",
		waist="Moonbow Belt +1",
		left_ear={ name="Schere Earring", augments={'Path: A',}},
		right_ear="Mache Earring +1",
		left_ring="Gere Ring",
		right_ring="Niqmaddu Ring",
		back=Visucius.StrDA,
    }

    sets.precast.WS["Howling Fist"] ={
	    head={ name="Mpaca's Cap", augments={'Path: A',}},
		body={ name="Nyame Mail", augments={'Path: B',}},
		hands={ name="Nyame Gauntlets", augments={'Path: B',}},
		legs={ name="Nyame Flanchard", augments={'Path: B',}},
		feet={ name="Nyame Sollerets", augments={'Path: B',}},
		neck="Fotia Gorget",
		waist="Moonbow Belt +1",
		left_ear={ name="Schere Earring", augments={'Path: A',}},
		right_ear={ name="Moonshade Earring", augments={'"Mag.Atk.Bns."+4','TP Bonus +250',}},
		left_ring="Gere Ring",
		right_ring="Niqmaddu Ring",
		back=Visucius.StrDA,
	}
		
	sets.precast.WS["Raging Fist"] ={
		head={ name="Mpaca's Cap", augments={'Path: A',}},
		body={ name="Mpaca's Doublet", augments={'Path: A',}},
		hands={ name="Ryuo Tekko +1", augments={'STR+12','DEX+12','Accuracy+20',}},
		legs={ name="Mpaca's Hose", augments={'Path: A',}},
		feet={ name="Mpaca's Boots", augments={'Path: A',}},
		neck="Fotia Gorget",
		waist="Moonbow Belt +1",
		left_ear={ name="Schere Earring", augments={'Path: A',}},
		right_ear={ name="Moonshade Earring", augments={'"Mag.Atk.Bns."+4','TP Bonus +250',}},
		left_ring="Gere Ring",
		right_ring="Niqmaddu Ring",
		back=Visucius.StrDA,
	}
	
	sets.precast.WS['Aeolian Edge'] = {
	}

    -------------------------------------Idle
    --[[
        Pet is not active
        Idle Mode = MasterDT
    ]]
    sets.idle.MasterDT = {
       -- Add your set here 
    }

    -------------------------------------Engaged
    --[[
        Offense Mode = Master
        Hybrid Mode = Normal
    ]]
    sets.engaged.Master = {
		head="Malignance Chapeau",
		body={ name="Mpaca's Doublet", augments={'Path: A',}},
		hands="Malignance Gloves",
		legs={ name="Samnuha Tights", augments={'STR+10','DEX+10','"Dbl.Atk."+3','"Triple Atk."+3',}},
		feet="Malignance Boots",
		neck="Shulmanu Collar",
		waist="Moonbow Belt +1",
		left_ear={ name="Schere Earring", augments={'Path: A',}},
		right_ear="Telos Earring",
		left_ring="Gere Ring",
		right_ring="Niqmaddu Ring",
		back=Visucius.StrDA,
    }

    -------------------------------------Acc
    --[[
        Offense Mode = Master
        Hybrid Mode = Acc
    ]]
    sets.engaged.Master.Acc = {
       -- Add your set here 
    }

    -------------------------------------TP
    --[[
        Offense Mode = Master
        Hybrid Mode = TP
    ]]
    sets.engaged.Master.TP = {
       -- Add your set here
    }

    -------------------------------------DT
    --[[
        Offense Mode = Master
        Hybrid Mode = DT
    ]]
    sets.engaged.Master.DT = set_combine(sets.engaged.Master, {
		legs="Malignance Tights",
		neck={ name="Loricate Torque +1", augments={'Path: A',}},
    })

    ----------------------------------------------------------------------------------
    --  __  __         _           ___     _     ___      _
    -- |  \/  |__ _ __| |_ ___ _ _| _ \___| |_  / __| ___| |_ ___
    -- | |\/| / _` (_-<  _/ -_) '_|  _/ -_)  _| \__ \/ -_)  _(_-<
    -- |_|  |_\__,_/__/\__\___|_| |_| \___|\__| |___/\___|\__/__/
    -----------------------------------------------------------------------------------

    --[[
        These sets are designed to be a hybrid of player and pet gear for when you are
        fighting along side your pet. Basically gear used here should benefit both the player
        and the pet.
    ]]
    --[[
        Offense Mode = MasterPet
        Hybrid Mode = Normal
    ]]
    sets.engaged.MasterPet = {
		head="Heyoka Cap",
		body="Mpaca's Doublet",
		hands="Mpaca's Gloves",
		legs="Heyoka Subligar",
		feet="Mpaca's Boots",
		neck="Shulmanu Collar",
		waist="Moonbow Belt +1",
		left_ear="Crep. Earring",
		right_ear="Telos Earring",
		--Pup +2
		left_ring="Gere Ring",
		right_ring="Niqmaddu Ring",
		back=Visucius.PetHaste,
    }

    -------------------------------------Acc
    --[[
        Offense Mode = MasterPet
        Hybrid Mode = Acc
    ]]
    sets.engaged.MasterPet.Acc = set_combine(sets.engaged.MasterPet,{
    })

    -------------------------------------TP
    --[[
        Offense Mode = MasterPet
        Hybrid Mode = TP
    ]]
    sets.engaged.MasterPet.TP = set_combine(sets.engaged.MasterPet,{
       -- Add your set here s
    })

    -------------------------------------DT
    --[[
        Offense Mode = MasterPet
        Hybrid Mode = DT
    ]]
    sets.engaged.MasterPet.DT = set_combine(sets.engaged.MasterPet,{
       neck="Loricate Torque +1",
	   right_ear="Telos Earring",
	   left_ring="Defending Ring",
    })

    -------------------------------------Regen
    --[[
        Offense Mode = MasterPet
        Hybrid Mode = Regen
    ]]
    sets.engaged.MasterPet.Regen = set_combine(sets.engaged.MasterPet,{
       -- Add your set here 
    })

    ----------------------------------------------------------------
    --  _____     _      ____        _          _____      _
    -- |  __ \   | |    / __ \      | |        / ____|    | |
    -- | |__) |__| |_  | |  | |_ __ | |_   _  | (___   ___| |_ ___
    -- |  ___/ _ \ __| | |  | | '_ \| | | | |  \___ \ / _ \ __/ __|
    -- | |  |  __/ |_  | |__| | | | | | |_| |  ____) |  __/ |_\__ \
    -- |_|   \___|\__|  \____/|_| |_|_|\__, | |_____/ \___|\__|___/
    --                                  __/ |
    --                                 |___/
    ----------------------------------------------------------------

    -------------------------------------Magic Midcast
    sets.midcast.Pet = {
		feet="Mpaca's Boots",
    }

    sets.midcast.Pet.Cure = set_combine(sets.midcast.Pet, {
		--main="Sakpata's Fists",
		--head="Naga Somen", 
		--body="Naga Samue",
		--hands="Naga Tekko", 
		--legs="Foire Churidars +1",
		--feet="Naga Kyahan",
		--waist="Ukko Sash",
		--back=Visucius.PetMagic 
    })

    sets.midcast.Pet["Healing Magic"] = set_combine(sets.midcast.Pet, {
    })

    sets.midcast.Pet["Elemental Magic"] = set_combine(sets.midcast.Pet, {
		--head="Nyame Helm",
		--body="Udug Jacket",
		--hands="Nyame Gauntlets",
		--legs="Pitre Churidars +3",
		--feet="Pitre Babouches +3",
		--neck="Adad Amulet",
		--waist="Ukko Sash",
		--left_ear="Burana Earring",
		--right_ear="Enmerkar Earring",
		--left_ring="Varar Ring +1",
		--right_ring="C. Palug Ring",
		--back=Visucius.PetMagic 
	})

    sets.midcast.Pet["Enfeebling Magic"] = set_combine(sets.midcast.Pet, {
	   -- head="Nyame Helm",
		--body="Udug Jacket", 
		--hands="Nyame Gauntlets",
		--legs="Nyame Flanchard",
		--feet="Mpaca's Boots",
		--neck="Adad Amulet",
		--waist="Ukko Sash",
		--left_ear="Crep. Earring",
		--right_ear="Enmerkar Earring",
		--left_ring="Defending Ring",
		--right_ring="C. Palug Ring",
		--back=Visucius.PetMagic 
    })

    sets.midcast.Pet["Dark Magic"] = set_combine(sets.midcast.Pet, {
    })

    sets.midcast.Pet["Divine Magic"] = set_combine(sets.midcast.Pet, {
    })

    sets.midcast.Pet["Enhancing Magic"] = set_combine(sets.midcast.Pet, {
    })

    -------------------------------------Idle
    --[[
        This set will become default Idle Set when the Pet is Active 
        and sets.idle will be ignored
        Player = Idle and not fighting
        Pet = Idle and not fighting
        Idle Mode = Idle
    ]]
    sets.idle.Pet = {
		head={ name="Pitre Taj +3", augments={'Enhances "Optimization" effect',}},
		body={ name="Nyame Mail", augments={'Path: B',}},
		hands={ name="Nyame Gauntlets", augments={'Path: B',}},
		legs={ name="Nyame Flanchard", augments={'Path: B',}},
		feet={ name="Mpaca's Boots", augments={'Path: A',}},
		neck={ name="Loricate Torque +1", augments={'Path: A',}},
		waist="Moonbow Belt +1",
		left_ear="Etiolation Earring",
		right_ear="Enmerkar Earring",
		left_ring="C. Palug Ring",
		right_ring="Shneddick Ring +1",
		back=Visucius.PetMagic
    }

    --[[
        If pet is active and you are idle and pet is idle
        Player = idle and not fighting
        Pet = idle and not fighting
        Idle Mode = MasterDT
    ]]
    sets.idle.Pet.MasterDT =  sets.idle.Pet

    -------------------------------------Enmity
    sets.pet = {} -- Not Used

    --Equipped automatically
    sets.pet.Enmity = {
	   -- head="Heyoka Cap",
	--	body="Heyoka Harness",
	--	hands="Heyoka Mittens",
	--	legs="Heyoka Subligar",
	--	feet="Heyoka Leggings",
	--	right_ear="Rimeice Earring",
	--	left_ear="Domes. Earring",
    }

    --[[
        Activated by Alt+D or
        F10 if Physical Defense Mode = PetDT
    ]]
    sets.pet.EmergencyDT = {}

    -------------------------------------Engaged for Pet Only
    --[[
      For Technical Users - This is layout of below
      sets.idle[idleScope][state.IdleMode][ Pet[Engaged] ][CustomIdleGroups] 
      For Non-Technical Users:
      If you the player is not fighting and your pet is fighting the first set that will activate is sets.idle.Pet.Engaged
      You can further adjust this by changing the HyrbidMode using Ctrl+F9 to activate the Acc/TP/DT/Regen/Ranged sets
    ]]
    --[[
        Idle Mode = Idle
        Hybrid Mode = Normal
    ]]
    sets.idle.Pet.Engaged = {
		head={ name="Anwig Salade", augments={'Accuracy+3','Pet: Haste+5','Attack+3','Pet: Damage taken -10%',}},
		body={ name="Taeon Tabard", augments={'Pet: Accuracy+24 Pet: Rng. Acc.+24','Pet: "Dbl. Atk."+5','Pet: Damage taken -4%',}},
		hands={ name="Mpaca's Gloves", augments={'Path: A',}},
		legs={ name="Taeon Tights", augments={'Pet: Accuracy+25 Pet: Rng. Acc.+25','Pet: "Dbl. Atk."+5','Pet: Damage taken -4%',}},
		feet={ name="Mpaca's Boots", augments={'Path: A',}},
		neck="Shulmanu Collar",
		waist="Klouskap Sash +1",
		left_ear="Crep. Earring",
		right_ear="Enmerkar Earring",
		left_ring="C. Palug Ring",
		right_ring="Varar Ring +1",
		back=Visucius.PetHaste,
    }

    --[[
        Idle Mode = Idle
        Hybrid Mode = Acc
    ]]
    sets.idle.Pet.Engaged.Acc = {
       -- Add your set here 
    }

    --[[
        Idle Mode = Idle
        Hybrid Mode = TP
    ]]
	
	--Bruiser Tank
    sets.idle.Pet.Engaged.TP = {

    }

    --[[
        Idle Mode = Idle
        Hybrid Mode = DT
    ]]
	--Turtle Tank
    sets.idle.Pet.Engaged.DT = {

    }

    --[[
        Idle Mode = Idle
        Hybrid Mode = Regen
    ]]
    sets.idle.Pet.Engaged.Regen = {
       -- Add your set here 
    }

    --[[
        Idle Mode = Idle
        Hybrid Mode = Ranged
    ]]
    sets.idle.Pet.Engaged.Ranged ={
	    head={ name="Pitre Taj +3", augments={'Enhances "Optimization" effect',}},
		body={ name="Pitre Tobe +3", augments={'Enhances "Overdrive" effect',}},
		hands={ name="Mpaca's Gloves", augments={'Path: A',}},
		legs="Kara. Pantaloni +1",
		feet={ name="Mpaca's Boots", augments={'Path: A',}},
		neck="Shulmanu Collar",
		waist="Klouskap Sash +1",
		left_ear="Crep. Earring",
		right_ear="Enmerkar Earring",
		left_ring="Varar Ring +1",
		right_ring="Varar Ring +1",
		back=Visucius.PetHaste,
	}

    -------------------------------------WS
    --[[
        WSNoFTP is the default weaponskill set used
    ]]
    sets.midcast.Pet.WSNoFTP = {
        --head = Empy_Karagoz.Head_PTPBonus,
       -- Add your set here
    }

    --[[
        If we have a pet weaponskill that can benefit from WSFTP
        then this set will be equipped
    ]]
    sets.midcast.Pet.WSFTP = {
        --head = Empy_Karagoz.Head_PTPBonus,
       -- Add your set here
    }

    --[[
        Base Weapon Skill Set
        Used by default if no modifier is found
    ]]
    sets.midcast.Pet.WS = {

    }

    --Chimera Ripper, String Clipper
    sets.midcast.Pet.WS["STR"] = set_combine(sets.midcast.Pet.WSNoFTP, {})

    -- Bone crusher, String Shredder
    sets.midcast.Pet.WS["VIT"] =
        set_combine(
        sets.midcast.Pet.WSFTP,
        {
		
        }
    )

    -- Cannibal Blade
    sets.midcast.Pet.WS["MND"] = set_combine(sets.midcast.Pet.WSNoFTP, {})

    -- Armor Piercer, Armor Shatterer
    sets.midcast.Pet.WS["DEX"] = set_combine(sets.midcast.Pet.WSNoFTP, {})

    -- Arcuballista, Daze
    sets.midcast.Pet.WS["DEXFTP"] =
        set_combine(
        sets.midcast.Pet.WSFTP,
        {
            -- Add your gear here that would be different from sets.midcast.Pet.WSFTP
        }
    )
	
	-- Knockout
	sets.midcast.Pet.WS["AGI"] = set_combine(sets.midcast.Pet.WSFTP,
        {

		}
	)

    ---------------------------------------------
    --  __  __ _             _____      _
    -- |  \/  (_)           / ____|    | |
    -- | \  / |_ ___  ___  | (___   ___| |_ ___
    -- | |\/| | / __|/ __|  \___ \ / _ \ __/ __|
    -- | |  | | \__ \ (__   ____) |  __/ |_\__ \
    -- |_|  |_|_|___/\___| |_____/ \___|\__|___/
    ---------------------------------------------
    -- Town Set
    sets.idle.Town = sets.idles

    -- Resting sets
    sets.resting = {
       -- Add your set here
    }

    sets.defense.MasterDT = sets.idle.MasterDT

    sets.defense.PetDT = sets.pet.EmergencyDT

    sets.defense.PetMDT = set_combine(sets.pet.EmergencyDT, {})
	
	sets.overdrive = {
	    head="Karagoz Capello +1",
		body={ name="Pitre Tobe +3", augments={'Enhances "Overdrive" effect',}},
		hands={ name="Mpaca's Gloves", augments={'Path: A',}},
		legs="Kara. Pantaloni +1",
		feet="Tali'ah Crackows +2",
		neck="Shulmanu Collar",
		waist="Klouskap Sash +1",
		left_ear="Crep. Earring",
		right_ear="Enmerkar Earring",
		left_ring="C. Palug Ring",
		right_ring="Varar Ring +1",
		back={ name="Dispersal Mantle", augments={'STR+1','DEX+3','Pet: TP Bonus+500',}},
	}
	
	sets.overdrive2 = {
		head={ name="Taeon Chapeau", augments={'Pet: Accuracy+24 Pet: Rng. Acc.+24','Pet: "Dbl. Atk."+5','Pet: Damage taken -4%',}},
		body={ name="Taeon Tabard", augments={'Pet: Accuracy+24 Pet: Rng. Acc.+24','Pet: "Dbl. Atk."+5','Pet: Damage taken -4%',}},
		hands={ name="Taeon Gloves", augments={'Pet: Accuracy+24 Pet: Rng. Acc.+24','Pet: "Dbl. Atk."+5','Pet: Damage taken -4%',}},
		legs="Heyoka Subligar",
		feet={ name="Mpaca's Boots", augments={'Path: A',}},
		neck="Shulmanu Collar",
		waist="Klouskap Sash +1",
		left_ear="Crep. Earring",
		right_ear="Enmerkar Earring",
		left_ring="Varar Ring +1",
		right_ring="C. Palug Ring",
		back=Visucius.PetHaste,
	}
end