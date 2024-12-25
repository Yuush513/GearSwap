--Built off of my BLU and RUN GSs.
---Thanks to various sources such as LS members and BlueGartr for the help building this GearSwap.

-------------------------------------
---------                   ---------
------                         ------
---         Start of Gear         ---
------                         ------
---------                   ---------
------------------------------------- 

---------------------------------
--   Start of Augmented Gear   --
---------------------------------
include('Yuush-Globals.lua')
if define_global_sets then
    define_global_sets()
end
include('organizer-lib')
-------------------------------	
--   End of Augmented Gear   --

function get_sets()

	sets.Idle = {}
	--Idle Sets--
	sets.Idle.index = { 'Standard', 'DT' }
	Idle_ind = 1
	sets.Idle.Standard = {
		ammo="Staunch Tathlum +1",
		head="Gleti's Mask",
		body="Gleti's Cuirass",
		hands="Gleti's Gauntlets",
		legs={ name="Carmine Cuisses +1", augments={'HP+80','STR+12','INT+12',}},
		feet="Gleti's Boots",
		neck={ name="Loricate Torque +1", augments={'Path: A',}},
		waist="Carrier's Sash",
		left_ear="Infused Earring",
		right_ear="Etiolation Earring",
		left_ring="Defending Ring",
		right_ring="Karieyh Ring +1",
		back={ name="Brigantia's Mantle", augments={'INT+20','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','Pet: "Regen"+10','Damage taken-5%',}},
	}
	
	sets.Idle.DT = {
		ammo="Staunch Tathlum +1",
		head="Gleti's Mask",
		body="Gleti's Cuirass",
		hands="Gleti's Gauntlets",
		legs={ name="Carmine Cuisses +1", augments={'HP+80','STR+12','INT+12',}},
		feet="Gleti's Boots",
		neck={ name="Loricate Torque +1", augments={'Path: A',}},
		waist="Carrier's Sash",
		left_ear="Infused Earring",
		right_ear="Etiolation Earring",
		left_ring="Defending Ring",
		right_ring="Karieyh Ring +1",
		back={ name="Brigantia's Mantle", augments={'INT+20','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','Pet: "Regen"+10','Damage taken-5%',}},
	}
	
	--Dat Waifu--
	sets.Idle.Town = set_combine(sets.Idle.Standard, {
	--	ring1 = "Matrimony ring",
	})
	
	--Idle Refresh--
	sets.Idle.Refresh = {
	--	head = "Jumalik Helm", 
	--	body = "Chozoron Coselete"
	}
	
	--Best in slot items depend on Acc and if you have SAMs roll or not.
	--Unless the extra accuracy from something like the Shulmanu Collar comes into play.
	
	-----------
	--TP Sets--
	-----------
	sets.TP = {}
	sets.TP.index = {'CapHaste', 'AccuracyLite', 'AccuracyMid', 'AccuracyFull','DW' }
	TP_ind = 1

	sets.TP.CapHaste = {
		ammo = "Coiste Bodhar",
		head = "Flamma Zucchetto +2",
		neck = "Vim Torque +1",
		ear1 = "Dedition Earring",
		ear2 = "Sherida Earring",
		body = "Hjarrandi Breastplate",
		hands = "Flamma Manopolas +2",
		ring1 = "Petrov Ring",
		ring2 = "Niqmaddu Ring",
		back = Brigantia.DA_DEX,
		waist = "Sailfi Belt +1",
		legs = ValorousLegs.STP,
		feet = "Flamma Gambieras +2"
	}
	
	sets.TP.AccuracyLite = set_combine(sets.TP.CapHaste, {
		ear1 = "Telos Earring",
	})

	sets.TP.AccuracyMid = set_combine(sets.TP.AccuracyLite, {
		ring1 = "Flamma Ring",
		hands = "Flamma Manopolas +2",
		legs = "Pteroslaver Brais +3",
	})

	sets.TP.AccuracyFull = set_combine(sets.TP.AccuracyMid, {
		body = "Vishap Mail +3",
		hands = "Emi. Gauntlets +1",
	})
	
	sets.TP.DW = {    
	ammo="Coiste Bodhar",
    head="Flam. Zucchetto +2",
    body={ name="Emicho Haubert +1", augments={'HP+65','STR+12','Attack+20',}},
    hands={ name="Emi. Gauntlets +1", augments={'Accuracy+25','"Dual Wield"+6','Pet: Accuracy+25',}},
    legs={ name="Valorous Hose", augments={'Accuracy+26','"Store TP"+8','DEX+3','Attack+8',}},
    feet="Flam. Gambieras +2",
    neck={ name="Vim Torque +1", augments={'Path: A',}},
    waist={ name="Sailfi Belt +1", augments={'Path: A',}},
    left_ear="Sherida Earring",
    right_ear="Suppanomimi",
    left_ring="Niqmaddu Ring",
    right_ring="Petrov Ring",
    back={ name="Brigantia's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}}}
	
	 --SAM Roll--
     --Changes gearsets while Samurai Roll is on
    
    sets.SAMRoll = {}
    sets.SAMRoll.index = { 'CapHaste', 'AccuracyLite', 'AccuracyMid', 'AccuracyFull','DW' }
    SAMRoll_ind = 1 -- In the same rule as the TP Toggle so it toggles it at the same time

    sets.SAMRoll.CapHaste = set_combine(sets.TP.CapHaste, {      
		body = ValorousBody.DA,
		hands = "Sulevia's Gauntlets +2",
    })

    sets.SAMRoll.AccuracyLite = set_combine(sets.TP.AccuracyLite, {        
		ear1 = "Brutal Earring",
		body = ValorousBody.DA,
		hands = "Sulevia's Gauntlets +2",
    })

    sets.SAMRoll.AccuracyMid = set_combine(sets.TP.AccuracyMid, {        
		ear1 = "Cessance Earring",
		body = ValorousBody.DA,
		hands = "Sulevia's Gauntlets +2",
    })

    sets.SAMRoll.AccuracyFull = set_combine(sets.TP.AccuracyFull, {        
		body = ValorousBody.DA,
		hands = "Sulevia's Gauntlets +2",
    })
	
	sets.SAMRoll.DW = sets.TP.DW
	
	 --DT Sets--
    sets.DT = {}
    sets.DT.index = { 'DT', 'DTHybrid', 'MEVA'  }--'MDTV','DTPet', 'DTAcc'
    DT_ind = 1 
	
	sets.DT.DT = {
		ammo = "Coiste Bodhar",
		head = "Hjarrandi Helm",
		neck = "Anu Torque",
		ear1 = "Telos Earring",
		ear2 = "Sherida Earring",
		body = "Hjarrandi Breastplate",
		hands = "Sulev. Gauntlets +2",
		ring1 = "Defending Ring",
		ring2 = "Niqmaddu Ring",
		back = Brigantia.DA_DEX,
		waist = "Ioskeha Belt +1",
		legs = ValorousLegs.STP,
		feet = "Flamma Gambieras +2"
	}
	
	sets.DT.DTHybrid = {
		ammo = "Coiste Bodhar",
		head = "Hjarrandi Helm",
		neck = "Anu Torque",
		ear1 = "Telos Earring",
		ear2 = "Sherida Earring",
		body = "Hjarrandi Breastplate",
		hands = AcroHands.STP,
		ring1 = "Moonlight Ring",
		ring2 = "Niqmaddu Ring",
		back = Brigantia.DA_DEX,
		waist = "Ioskeha Belt +1",
		legs = ValorousLegs.STP,
		feet = "Flamma Gambieras +2"
	}
    --Shell V on. Need 21% MDT, 19% with sheltered.
	--[[
		sets.DT.MDTV = {
		ammo = "Staunch Tathlum +1",
		head = "Flamma Zucchetto +2",
		neck = "Warder's Charm +1",
		ear1 = "Eabani Earring",
		ear2 = "Sherida Earring",
		body = ValorousBody.STP,
		hands = "Sulevia's Gauntlets +2",
		ring1 = "Defending Ring",
		ring2 = "Shadow Ring",
		back = Brigantia.MEVA,
		waist = "Ioskeha Belt +1",
		legs = "Sulevia's Cuisses +2",
		feet = "Flamma Gambieras +2"
	}
	]]--
	sets.DT.MEVA = {
		ammo = "Staunch Tathlum +1",
		head = "Volte Tiara",
		neck = "Warder's Charm +1",
		ear1 = "Telos Earring",
		ear2 = "Sherida Earring",
		body = "Sacro Breastplate",
		hands = "Leyline Gloves",
		ring1 = "Defending Ring",
		ring2 = "Niqmaddu Ring",
		back = Brigantia.MEVA,
		waist = "Ioskeha Belt +1",
		legs = "Vishap Brais +3",
		feet = "Volte Spats"
	}
	--[[
	sets.DT.DTPet = {
		ammo = "Staunch Tathlum +1",
		head = "Peltast's Mezail +1",
		neck = "Loricate Torque +1",
		ear1 = "Genmei Earring",
		ear2 = "Enmerkar Earring",
		body = "Hjarrandi Breastplate",
		hands = "Sulevia's Gauntlets +2",
		ring1 = "Defending Ring",
		ring2 = "Gelatinous Ring +1",
		back = "Updraft Mantle",
		waist = "Ioskeha Belt +1",
		legs = "Sulevia's Cuisses +2",
		feet = "Flamma Gambieras +2"
	}
	
	sets.DT.DTAcc = {
		ammo = "Staunch Tathlum +1",
		head = "Flamma Zucchetto +2",
		neck = "Loricate Torque +1",
		ear1 = "Telos Earring",
		ear2 = "Sherida Earring",
		body = "Vishap Mail +3",
		hands = "Sulevia's Gauntlets +2",
		ring1 = "Defending Ring",
		ring2 = "Niqmaddu Ring",
		back = Brig.DATP,
		waist = "Ioskeha Belt +1",
		legs = "Sulevia's Cuisses +2",
		feet = "Flamma Gambieras +2"
	}
	]]--
	sets.WS = {}

	sets.Stardiver = {}

	sets.Stardiver.index = { 'AttackUncap', 'AttackCap', 'Accuracy' }
	Stardiver_ind = 1
	
	--1118 Acc, Lowest TP set is 1161, be careful--
	sets.Stardiver.AttackUncap = {
		ammo = "Knobkierrie",
		head = "Pteroslaver Armet +3",
		neck = "Fotia Gorget",
		ear1 = "Moonshade Earring",
		ear2 = "Sherida Earring",
		body = "Emicho Haubert +1",
		--body = "Dagon Breastplate",
		hands = "Sulev. Gauntlets +2",
		ring1 = "Regal Ring",
		ring2 = "Niqmaddu Ring",
		back = Brigantia.DA_STR,
		waist = "Fotia Belt",
		legs = "Sulevia's Cuisses +2",
		feet = LustratioFeet.A 
	}
	
	sets.Stardiver.AttackCap = {
		ammo = "Coiste Bodhar",
		head = "Flamma Zucchetto +2",
		neck = "Dgn. Collar +2",
		ear1 = "Moonshade Earring",
		ear2 = "Sherida Earring",
		body = "Emicho Haubert +1",
		--body = "Dagon Breastplate",
		hands = "Sulev. Gauntlets +2",
		ring1 = "Regal Ring",
		ring2 = "Niqmaddu Ring",
		back = Brigantia.DA_STR,
		waist = "Fotia Belt",
		legs = "Sulevia's Cuisses +2",
		feet = "Flamma Gambieras +2"  
	}

	sets.Stardiver.Accuracy = {
		ammo = "Voluspa Tathlum", 
		head = "Pteroslaver Armet +3",
		neck = "Fotia Gorget",
		ear1 = "Moonshade Earring",
		ear2 = "Sherida Earring",
		body = "Emicho Haubert +1",
		--body = "Dagon Breastplate",
		hands = "Sulev. Gauntlets +2",
		ring1 = "Regal Ring",
		ring2 = "Niqmaddu Ring",
		back = Brigantia.DA_STR,
		waist = "Fotia Belt",
		legs = "Vishap Brais +3",
		feet = "Flamma Gambieras +2" 
		--feet = "Vishap Greaves +3"
	}

	sets.Drakesbane = {}

	sets.Drakesbane.index = { 'AttackUncap', 'AttackCap', 'Accuracy' }
	Drakesbane_ind = 1

	sets.Drakesbane.AttackUncap = {
		ammo = "Knobkierrie",
		head = "Pteroslaver Armet +3",
		--head = "Blistering Sallet +1",
		neck = "Dgn. Collar +2",
		ear1 = "Moonshade Earring",
		ear2 = "Thrud Earring",
		body = "Hjarrandi Breastplate",
		hands = "Flamma Manopolas +2",
		ring1 = "Regal Ring",
		ring2 = "Niqmaddu Ring",
		back = Brigantia.CRIT,
		waist = "Sailfi Belt +1",
		legs = "Peltast's Cuissots +1",
		feet = ValorousFeet.STR_Crit
	}
	
	sets.Drakesbane.AttackCap = {
		ammo = "Knobkierrie",
		head = "Flamma Zucchetto +2",
		--head = "Blistering Sallet +1",
		neck = "Dgn. Collar +2",
		ear1 = "Moonshade Earring",
		ear2 = "Thrud Earring",
		body = "Hjarrandi Breastplate",
		hands = "Flamma Manopolas +2",
		ring1 = "Begrudging Ring",
		ring2 = "Niqmaddu Ring",
		back = Brigantia.CRIT,
		waist = "Sailfi Belt +1",
		legs = "Peltast's Cuissots +1",
		feet = ValorousFeet.STR_Crit
	}
	
	sets.Drakesbane.Accuracy = {
		ammo = "Knobkierrie",
		head = "Flamma Zucchetto +2",
		neck = "Dgn. Collar +2",
		ear1 = "Moonshade Earring",
		ear2 = "Thrud Earring",
		body = "Hjarrandi Breastplate",
		hands = "Flamma Manopolas +2",
		ring1 = "Regal Ring",
		ring2 = "Niqmaddu Ring",
		back = Brigantia.CRIT,
		waist = "Ioskeha Belt +1",
		legs = "Vishap Brais +3",
		feet = "Flamma Gambieras +2" 
		--feet = "Vishap Greaves +3"
	}

	sets.CamlannsTorment = {}

	sets.CamlannsTorment.index = { 'Attack', 'Accuracy' }
	CamlannsTorment_ind = 1

	sets.CamlannsTorment.Attack = {
		ammo = "Knobkierrie",
		head = ValorousHead.WSD,
		neck = "Fotia Gorget",
		ear1 = "Ishvara Earring",
		ear2 = "Thrud Earring",
		body = ValorousBody.WSD,
		hands = "Pteroslaver Finger Gauntlets +3",
		ring1 = "Regal Ring",
		ring2 = "Karieyh Ring +1",
		back = Brigantia.WSD,
		waist = "Fotia Belt",
		legs = "Vishap Brais +3",
		feet = "Sulevia's Leggings +2"
	}	   
							   
	sets.CamlannsTorment.Accuracy = {
		ammo = "Knobkierrie",
		head = ValorousHead.WSD,
		neck = "Fotia Gorget",
		ear1 = "Ishvara Earring",
		ear2 = "Thrud Earring",
		body = ValorousBody.WSD,
		hands = "Pteroslaver Finger Gauntlets +3",
		ring1 = "Regal Ring",
		ring2 = "Karieyh Ring +1",
		back = Brigantia.WSD,
		waist = "Fotia Belt",
		legs = "Vishap Brais +3",
		feet = "Sulevia's Leggings +2"
	}
	
	sets.SonicThrust = {}

	sets.SonicThrust.index = { 'Attack', 'Accuracy' }
	SonicThrust_ind = 1
	sets.SonicThrust.Attack = {
		ammo = "Knobkierrie",
		head = ValorousHead.WSD,
		neck = "Fotia Gorget",
		ear1 = "Moonshade Earring",
		ear2 = "Thrud Earring",
		body = ValorousBody.WSD,
		hands = "Pteroslaver Finger Gauntlets +3",
		ring1 = "Regal Ring",
		ring2 = "Karieyh Ring +1",
		back = Brigantia.WSD,
		waist = "Fotia Belt",
		legs = "Vishap Brais +3",
		feet = "Sulevia's Leggings +2"
	}
	
	sets.SonicThrust.Accuracy = {
		ammo = "Knobkierrie",
		head = ValorousHead.WSD,
		neck = "Fotia Gorget",
		ear1 = "Moonshade Earring",
		ear2 = "Thrud Earring",
		body = ValorousBody.WSD,
		hands = "Pteroslaver Finger Gauntlets +3",
		ring1 = "Regal Ring",
		ring2 = "Karieyh Ring +1",
		back = Brigantia.WSD,
		waist = "Fotia Belt",
		legs = "Vishap Brais +3",
		feet = "Sulevia's Leggings +2"
	}

	sets.LegSweep = {
		ammo = "Pemphredo Tathlum",
		head = "Flamma Zucchetto +2",
		--head = "Blistering Sallet +1",
		neck = "Fotia Gorget",
		ear1 = "Moonshade Earring",
		ear2 = "Dignitary's Earring",
		body = "Vishap Mail +3",
		hands = "Flamma Manopolas +2",
		ring1 = "Regal Ring",
		ring2 = "Flamma Ring",
		back = Brigantia.DA_STR,
		waist = "Fotia Belt",
		legs = "Pteroslaver Brais +3",
		feet = "Flamma Gambieras +2"
	}
	
	sets.SavageBlade = {		
		ammo = "Knobkierrie",
		head = ValorousHead.WSD,
		neck = "Dgn. Collar +2",
		ear1 = "Moonshade Earring",
		ear2 = "Thrud Earring",
		body = ValorousBody.WSD,
		hands = "Pteroslaver Finger Gauntlets +3",
		ring1 = "Regal Ring",
		ring2 = "Karieyh Ring +1",
		back = Brigantia.WSD,
		waist = "Sailfi Belt +1",
		legs = "Vishap Brais +3",
		feet = "Sulevia's Leggings +2"}
	
	--SC DMG Sets-- 34%
	sets.SCDmg = {
		--head = ValorousHead.SCD,
		body = "Sulevia's Platemail +2",
		--hands = ValorousMitts.SCDAcc,
		--ring2 = "Mujin Band",		
		--legs = ValorousHose.SCD,
		--feet = "Emicho Gambieras +1"
	}
	
	--When Allies is on, assumes 20% is being given, caps 50%--
	sets.SCDmgAllies = {
		body = "Sulevia's Platemail +2",
		--hands = ValorousMitts.SCDAcc,
		--ring2 = "Mujin Band",		
		--legs = ValorousHose.SCD,
		--feet = "Emicho Gambieras +1"
	}
	
-------------------------
--   Blue Magic Sets   --
-------------------------
	sets.BlueMagic = {}

	sets.BlueMagic.STR = {
		ammo = "Knobkierrie",
		head = ValorousHead.WSD,
		neck = "Dragoon's Collar +2",
		ear1 = "Telos Earring",
		ear2 = "Sherida Earring",
		body = "Sulevia's Platemail +2",
		hands = "Sulevia's Gauntlets +2",
		ring1 = "Regal Ring",
		ring2 = "Niqmaddu Ring",
		back = Brigantia.DA_STR,
		waist = "Sailfi Belt +1",
		legs = "Sulevia's Cuisses +2",
		feet = "Sulevia's Leggings +2"
	}
	
--------------------------
--   Curing Magic Set   --
--------------------------
	
	sets.Cures = {
		ammo = "",
		head = "",
		neck = "",
		ear1 = "",
		ear2 = "",
		body = "",
		hands = "",
		ring1 = "",
		ring2 = "",
		back = "",
		waist = "",
		legs = "",
		feet = ""
	}
----------------------
--   Utility Sets   --
-----------------------
--   Sets for one thing or another.
--   Macro in game with: 

--   /console gs equip sets.butts.andfronts
--   /console gs c lockgearindex

	sets.Utility = {}

	sets.Utility.Steps = set_combine(sets.TP.AccuracyFull, {})

	sets.Utility.Twilight = {
--		head = "Twilight Helm",
--		body = "Twilight Mail"
	}
	
	sets.Utility.Doom = {
		neck = "Nicander's Necklace", --20
		ring1 = "Eshmun's Ring", --20
        ring2 = "Purity Ring", --7
        waist = "Gishdubar Sash", --10
	}
	
	sets.WSDayBonus = (set_combine(equipSet,{
--		head="Gavialis Helm"
	}))
	
	sets.Utility.TH = {
		waist = "Chaac Belt"
	}	
	
	sets.Utility.DomainInvasionTP = {
--		body = "Hervor Haubert",
--		hands = "Hervor Mouffles"
	}	
	
	sets.Utility.DomainInvasionWS = {
--		body = "Hervor Haubert",
--		hands = "Hervor Mouffles",
--		feet = "Hervor Sollerets"
	}
	
	sets.Utility.DerpDT = {
		ammo = "Staunch Tathlum +1",
		head = "Hjarrandi Helm",
		neck = "Dgn. Collar +2",
		ear1 = "Sanare Earring",
		ear2 = "Odnowa Earring +1",
		body = "Sacro Breastplate",
		hands = "Sulev. Gauntlets +2",
		ring1 = "Defending Ring",
		ring2 = "Gelatinous Ring +1",
		back = Brigantia.MEVA,
		waist = "Asklepian Belt",
		legs = "Sulev. Cuisses +2",
		feet = "Founder's Greaves"
	}
	
	--Shell II only--
	sets.Utility.MDTII = {
		ammo = "",
		head = "",
		neck = "",
		ear1 = "",
		ear2 = "",
		body = "",
		hands = "",
		ring1 = "",
		ring2 = "",
		back = "",
		waist = "",
		legs = "",
		feet = ""
	}

	--No Shell--
	sets.Utility.MDTNO = {
		ammo = "",
		head = "",
		neck = "",
		ear1 = "",
		ear2 = "",
		body = "",
		hands = "",
		ring1 = "",
		ring2 = "",
		back = "",
		waist = "",
		legs = "",
		feet = ""
	}

---------------------
--   Enmity Set   --
---------------------

	sets.Enmity = {
		ammo = "",
		head = "",
		neck = "",
		ear1 = "",
		ear2 = "",
		body = "",
		hands = "",
		ring1 = "",
		ring2 = "",
		back = "",
		waist = "",
		legs = "",
		feet = ""
	}
	
------------------------
--   Enhancing Sets   --
------------------------
	
	sets.Enhancing = {}
	
	sets.Enhancing.Skill = {
		ammo = "",
		head = "",
		neck = "",
		ear1 = "",
		ear2 = "",
		body = "",
		hands = "",
		ring1 = "",
		ring2 = "",
		back = "",
		waist = "",
		legs = "",
		feet = ""
	}
	
	sets.Enhancing.Phalanx = set_combine(sets.Enhancing.Skill, {
	})
	
	sets.Enhancing.Refresh = set_combine(sets.Enhancing.Skill, {
		waist = "Gishdubar Sash",
	})
	
	sets.Enhancing.Regen = set_combine(sets.Enhancing.Skill, {
		--feet = "Taeon Boots",
	})
	
	sets.Enhancing.ProShell = set_combine(sets.Enhancing.Skill, {
		ear1 = "Brachyura Earring",
	})
	
------------------------
--   Healing Breath   --
------------------------

	sets.HB = {}
	--Midcast Set for HB spell triggers--
	sets.HB.Trigger = {
		ammo = "Staunch Tathlum +1",
		head = "Vishap Armet +1",
		neck = "Unmoving Collar +1",
		ear1 = "Tuisto Earring",
		ear2 = "Odnowa Earring +1",
		body = "Hjarrandi Breastplate",
		hands = "Pteroslaver Finger Gauntlets +3",
		ring1 = "Moonlight Ring",
		ring2 = "Gelatinous Ring +1",
		back = "Moonlight Cape",
		waist = "Gold Moogle Belt",
		legs = "Vishap Brais +3",
		feet = "Carmine Greaves +1",
	}
	
	--The Freshmaker--
	sets.HB.Mentos = {
		head = "Pteroslaver Armet +3",
		body = AcroBody.Breath,
		hands = AcroHands.Breath,
		legs = "Vishap Brais +3",
		feet = "Ptero. Greaves +3",
		back = "Updraft Mantle"
	}
	
	--Elemental Breath--
	sets.HB.Ricola = {
		ammo = "Voluspa Tathlum",
		head = "Pteroslaver Armet +3",
		ear1 = "Enmerkar Earring",
		ear2 = "Kyrene's Earring",
		body = AcroBody.Breath,
		hands = AcroHands.Breath,
		ring1 = "Cath Palug Ring",
		legs = AcroLegs.Breath,
		feet = AcroFeet.Breath,
		back = "Updraft Mantle"
	}
	
--------------------------	
--   Job Ability Sets   --
--------------------------
	sets.JA = {}

	sets.JA.SpiritSurge = {
		body = "Pteroslaver Mail +3"
	}

	sets.JA.CallWyvern = {
		hands = "Pteroslaver Mail +3"
	}
	
	sets.JA.AncientCircle = {
		legs = "Vishap Brais +3"
	}
	
	sets.JA.SpiritLink = {
		head = "Vishap Armet +1",
		hands = "Pel. Vambraces +1",
		feet = "Ptero. Greaves +3"
	}
	
	sets.JA.Angon = {
		hands = "Pteroslaver Finger Gauntlets +3"
	}
	--If you actually use DB then you will need to make a buff active rule to make it active--
	sets.JA.DeepBreathing = {
		head = "Pteroslaver Armet +3"
	}

----------------------
--   Precast Sets   --
----------------------
	sets.precast = {}
	
	sets.precast.FastCast = {}

	sets.precast.FastCast.Standard = {
		ammo = "Sapience Orb",
		head = "Carmine Mask +1",
		neck = "Orunmila's Torque",
		ear1 = "Etiolation Earring",
		ear2 = "Loquac. Earring",
		body = TaeonBody.FC,
		hands = "Leyline Gloves",
		feet = "Carmine Greaves +1"
	}
	
end

---End of Gear---------------------------------------------------------------------------------------------------------------------------------------------------------

-------------------------------------
---------                   ---------
------                         ------
---         Start of Maps         ---
------                         ------
---------                   ---------
------------------------------------- 

-------------------------
--   BLU Spells List   --
-------------------------

function maps()
	PhysicalSpells = S {
		'Bludgeon', 'Body Slam', 'Feather Storm', 'Mandibular Bite', 'Queasyshroom',
		'Screwdriver', 'Sickle Slash', 'Smite of Rage', 'Power Attack',
		'Terror Touch', 'Battle Dance', 'Claw Cyclone', 'Grand Slam', 
		'Jet Stream', 'Pinecone Bomb', 'Wild Oats', 'Uppercut'
	}

	MagicalSpells = S {}
	
	BlueMagic_Buffs = S {
		'Refueling'
	}

	BlueMagic_Healing = S {
		'Healing Breeze', 'Pollen', 'Wild Carrot'
	}

	BlueMagic_Enmity = S {
		'Blank Gaze', 'Jettatura', 'Geist Wall', 'Sheep Song', 'Soporific'
	}
	
end

------------------------
--   Sub Mage Table   --
------------------------

mp_jobs = S {"WHM", "BLM", "RDM", "SMN", "BLU", "SCH", "GEO", "PLD", "DRK", "RUN"}

--------------------------------
--   Elemental Breath Table   --
--------------------------------

ElementalBreath = S { "Flame Breath", "Sand Breath", "Hydro Breath", 
"Gust Breath", "Frost Breath", "Lightning Breath", }

-------------------------------
--   WS Chart For Gavialis   --
-------------------------------

check_ws_day = {
Firesday = S {'Liquefaction','Fusion','Light'},
Earthsday= S {'Scission','Gravitation','Darkness'},
Watersday = S {'Reverberation','Distortion','Darkness'},
Windsday = S {'Detonation','Fragmentation','Light'},
Iceday = S {'Induration','Distortion','Darkness'},
Lightningsday = S {'Impaction','Fragmentation','Light'},
Lightsday = S {'Transfixion','Fusion','Light'},
Darksday = S {'Compression','Gravitation','Darkness'},}


---------------------
--   HB Triggers   --
---------------------
Trigger = S {
	'Power Attack', 'Foot Kick', 'Sprout Smack', 'Helldive', 'Cocoon', 'Wild Carrot',
	'Dia', 'Diaga', 'Dia II', 'Sneak', 'Invisible', 'Cure', 'Cure II', 'Cure III', 'Cure IV', 'Cura', 
	'Raise', 'Reraise', 'Poisona', 'Paralyna', 'Blindna', 'Silena', 'Stona', 'Cursna', 'Haste',
	'Regen', 'Regen II', 'Erase', 'Flash'
}

------------------------
--   Town Gear List   --
------------------------

Town = S {
    "Ru'Lude Gardens", "Upper Jeuno", "Lower Jeuno", "Port Jeuno",
    "Port Windurst", "Windurst Waters", "Windurst Woods", "Windurst Walls", "Heavens Tower",
    "Port San d'Oria", "Northern San d'Oria", "Southern San d'Oria", "Chateau d'Oraguille",
	"Port Bastok", "Bastok Markets", "Bastok Mines", "Metalworks",
    "Aht Urhgan Whitegate", "Nashmau",
    "Selbina", "Mhaura", "Norg",  "Kazham", "Tavanazian Safehold",
    "Eastern Adoulin", "Western Adoulin", "Celennia Memorial Library", "Mog Garden"
}

---End of Maps----------------------------------------------------------------------------------------------------------------------------------------------------------


--------------------------------------
---------                    ---------
------                          ------
---         Start of Rules         ---
------                          ------
---------                    ---------
-------------------------------------- 

----------------------------------------------
--   Macro and Style Change on Job Change   --
----------------------------------------------
function set_macros(sheet,book)
    if book then 
        send_command('@input /macro book '..tostring(book)..';wait .1;input /macro set '..tostring(sheet))
        return
    end
    send_command('@input /macro set '..tostring(sheet))
end

function set_style(sheet)
    --send_command('@input ;wait 5.0;input /lockstyleset '..sheet)
	--add_to_chat (56, 'Your lockstyle looks like shit, and you should feel bad.')
	--add_to_chat (55, 'You are on '..('DRG '):color(5)..''..('btw. '):color(55)..''..('Macros set!'):color(121))
	--add_to_chat (23, '"If you are going to LOLDRG, then do it spectacularly"')
	--send_command('@input ;wait 180;input //gs validate')
end

--Page, Book--
set_macros(1,10)
--Use the Lockstyle Number-- 
set_style(20) 
-------------------------------
--         Variables         --
-------------------------------
SetLocked = false --Used to Check if set is locked before changing equipment
LockedEquipSet = {} --Placeholder to store desired lock set
LockGearSet = {}
equipSet = {} --Currently Equiped Gearset
LockGearIndex = false
LockGearIndex = false
TargetDistance = 0
TH = false --TH rule default
DomainInvasion = false
DT = false
SkillchainPending = false 
AllowSkillchainGear = false   --Whether or not hte skillchainPending system should be active upon loading the lua
PetBreathFailover = false
SkillchainTimer = 0

------------------------------------
--         Windower Hooks         --
------------------------------------

function buff_change(n, gain, buff_table)
	local name
    name = string.lower(n)
    if S{"terror","petrification","sleep","stun"}:contains(name) then
        if gain then
            ChangeGear(sets.Utility.DerpDT)
        elseif not has_any_buff_of({"terror","petrification","sleep","stun"}) then
            if player.status == 'Engaged' then
                if LockGearIndex then
                    ChangeGear(LockGearSet)
                elseif not LockGearIndex then
					if DT == true then
                        ChangeGear(sets.DT[sets.DT.index[DT_ind]])
                    elseif SAMRoll == true then
                        ChangeGear(sets.SAMRoll[sets.SAMRoll.index[SAMRoll_ind]])
                    else
                        ChangeGear(sets.TP[sets.TP.index[TP_ind]])
                    end
                end
            elseif player.status == 'Idle' then
                if LockGearIndex then
                    ChangeGear(LockGearSet)
                elseif not LockGearIndex then
                    ChangeGear(sets.Idle[sets.Idle.index[Idle_ind]])
                end
            end
        end
    elseif name == "doom" then
        if gain then
            ChangeGear(sets.Utility.Doom)
            send_command('@input /p Doomed {~o~:} !')
            disable('ring1','ring2','waist')
        else
            if player.status == 'Engaged' then
                if LockGearIndex then
                    send_command('@input /p Doom is off {^_^}')
                    enable('ring1','ring2','waist')
                    ChangeGear(LockGearSet)
                else
                    send_command('@input /p Doom is off {^_^}')
                    enable('ring1','ring2','waist')
					if DT == true then
                        ChangeGear(sets.DT[sets.DT.index[DT_ind]])
                    elseif SAMRoll == true then
                        ChangeGear(sets.SAMRoll[sets.SAMRoll.index[SAMRoll_ind]])
                    else
                        ChangeGear(sets.TP[sets.TP.index[TP_ind]])
                    end
                end
            elseif player.status == 'Idle' then
                if LockGearIndex then
                    send_command('@input /p Doom is off {^_^}')
                    enable('ring1','ring2','waist')
                    ChangeGear(LockGearSet)
                else
                    send_command('@input /p Doom is off {^_^}')
                    enable('ring1','ring2','waist')
                    ChangeGear(sets.Idle[sets.Idle.index[Idle_ind]])
                end
            end
        end
    elseif name == "charm" then
        if gain then
            send_command('@input /p Charmed {<3_<3:} !')
        else
            send_command('@input /p Charm is off {~_^}')
        end
    elseif name == "weakness" then
        if gain then
            enable('ring1','ring2','waist')
        end
	elseif name == "weakness" and player.status == 'Idle' then
        if gain then
			enable('ring1','ring2','waist')
            ChangeGear(sets.Utility.Twilight)
		else
			if player.status == 'Idle' then
                if LockGearIndex then
                    ChangeGear(LockGearSet)
                else
                    ChangeGear(sets.Idle[sets.Idle.index[Idle_ind]])
                end
    
			end
		end
	elseif name == "hasso" then
        if gain then
		else
			send_command('gs c -cd Hasso Lost!')
		end
	end	
	
	if name == "samurai roll" then
        if gain then
            SAMRoll = true
             if LockGearIndex then
                ChangeGear(LockGearSet)
            elseif DT == true then
                ChangeGear(sets.DT[sets.DT.index[DT_ind]])
            else
				if player.status == 'Engaged' then
					ChangeGear(sets.SAMRoll[sets.SAMRoll.index[SAMRoll_ind]])
				end
            end 
        else
            SAMRoll = false
        end
    end
	
	if name == "elvorseal" then
        if gain then
            DomainInvasion = true
        else
            DomainInvasion = false
        end
    end
end

function has_any_buff_of(buff_set)--returns true if you have any of the buffs given
    for i,v in pairs(buff_set) do
        if buffactive[v] ~= nil then return true end
    end
end

---------------------------
--         Binds         --
---------------------------
send_command('bind f9 gs c toggle TP set') -- Hit f9, toggles the sets
send_command('bind f10 gs c toggle DT') --DT on or off
send_command('bind f11 gs c toggle Stardiver set') 
send_command('bind !f11 gs c toggle Camlann set')
send_command('bind f12 gs c toggle Idle set')
send_command('bind ^f10 gs c toggle DT set')
send_command('bind ^f11 empty')
send_command('bind ^f12 gs c AllowSkillchainGear')
send_command('bind !f9 gs c toggle backwards')-- ! means alt. 
send_command('bind !f10 empty')
send_command('bind !f12 gs c lockgearindex')

send_command('bind !t gs c toggle TH') -- alt + t toggles TH mode

--Unload Binds
function file_unload()
	send_command('unbind ^f9')
	send_command('unbind ^f10')
	send_command('unbind ^f11')
	send_command('unbind ^f12')
	send_command('unbind !f9')
	send_command('unbind !f10')
	send_command('unbind !f11')
	send_command('unbind !f12')
	send_command('unbind f9')
	send_command('unbind f10')
	send_command('unbind f11')
	send_command('unbind f12')

	send_command('unbind !t')
end

--------------------------------------
--         Console Commands         --
--------------------------------------
function self_command(command)
	if command == 'togglelock' then
		if SetLocked == false then
			msg("Equipment Set LOCKED !!!")
		else
			SetLocked = false
			msg("Equipment Set UNLOCKED!")
		end
	elseif command == 'lockgearindex' then
		if LockGearIndex == false then
			LockGearIndex = true
			LockGearSet = {
				ammo = player.equipment.ammo,
				head = player.equipment.head,
				neck = player.equipment.neck,
				ear1 = player.equipment.left_ear,
				ear2 = player.equipment.right_ear,
				body = player.equipment.body,
				hands = player.equipment.hands,
				ring1 = player.equipment.left_ring,
				ring2 = player.equipment.right_ring,
				back = player.equipment.back,
				waist = player.equipment.waist,
				legs = player.equipment.legs,
				feet = player.equipment.feet
			}
			msg("Gear Index Locked !!!")
		else
			LockGearIndex = false
			msg("Gear Index Unlocked")
			if player.status == 'Engaged' then
                if DT == true then
                    ChangeGear(sets.DT[sets.DT.index[DT_ind]])
				elseif SAMRoll == true then
                    ChangeGear(sets.SAMRoll[sets.SAMRoll.index[SAMRoll_ind]])
                else
                    ChangeGear(sets.TP[sets.TP.index[TP_ind]])
                end
            else
                ChangeGear(sets.Idle[sets.Idle.index[Idle_ind]])
            end
        end
    end
	if command == 'toggle TP set' then
		if DT == true then
            DT_ind = DT_ind + 1
            if DT_ind > #sets.DT.index then DT_ind = 1 end
            send_command('@input /echo <----- DT Set changed to ' .. sets.DT.index[DT_ind] .. ' ----->')
            ChangeGear(sets.DT[sets.DT.index[DT_ind]])
        elseif DT == false then
        TP_ind = TP_ind + 1
		SAMRoll_ind = SAMRoll_ind + 1
        if TP_ind > #sets.TP.index then TP_ind = 1 end
		if SAMRoll_ind > #sets.SAMRoll.index then SAMRoll_ind = 1 end
        send_command('@input /echo <----- TP Set changed to ' .. sets.TP.index[TP_ind] .. ' ----->')
			if player.status == 'Engaged' then
				if SAMRoll == true then
					ChangeGear(sets.SAMRoll[sets.SAMRoll.index[SAMRoll_ind]])
                else
                    ChangeGear(sets.TP[sets.TP.index[TP_ind]])
                end
            end
		end
	elseif command == 'toggle Idle set' then
        Idle_ind = Idle_ind + 1
        if Idle_ind > #sets.Idle.index then Idle_ind = 1 end
        send_command('@input /echo <----- Idle Set changed to ' .. sets.Idle.index[Idle_ind] .. ' ----->')
        if player.status == 'Idle' then
            ChangeGear(sets.Idle[sets.Idle.index[Idle_ind]])
        end
	elseif command == 'toggle Camlann set' then
		CamlannsTorment_ind = CamlannsTorment_ind + 1
		SonicThrust_ind = SonicThrust_ind + 1
		if CamlannsTorment_ind > #sets.CamlannsTorment.index then CamlannsTorment_ind = 1 end
		send_command('@input /echo <----- Camlanns/Sonic Set changed to ' .. sets.CamlannsTorment.index[CamlannsTorment_ind] .. ' ----->')
	elseif command == 'toggle Stardiver set' then
		Stardiver_ind = Stardiver_ind + 1
		Drakesbane_ind = Drakesbane_ind + 1
		if Stardiver_ind > #sets.Stardiver.index then Stardiver_ind = 1 end
		send_command('@input /echo <----- Stardiver/Drakes Set changed to ' .. sets.Stardiver.index[Stardiver_ind] .. ' ----->')
	elseif command == 'toggle DT set' then
		DT_ind = DT_ind + 1
		if DT_ind > #sets.DT.index then DT_ind = 1 end
		send_command('@input /echo <----- DT Set changed to ' .. sets.DT.index[DT_ind] .. ' ----->')
			if DT == true then
				ChangeGear(sets.DT[sets.DT.index[DT_ind]])
			end
    elseif command == 'toggle DT' then
        if DT == true then
            DT = false
            send_command('@input /echo <----- DT TP: [Off] ----->')
        else
            DT = true
            send_command('@input /echo <----- DT TP: [On] ----->')
        end
        status_change(player.status)
	elseif command == 'toggle TH' then
		if TH == true then
			TH = false
			send_command('@input /echo <----- Treasure Hunter TP: [Off] ----->')
        else
			TH = true
			send_command('@input /echo <----- Treasure Hunter TP: [On] ----->')
		end
		status_change(player.status)
	elseif command == 'toggle backwards' then
        if DT == true then
            DT_ind = DT_ind -1
            if DT_ind == 0 then
                DT_ind = #sets.DT.index
            end
        send_command('@input /echo <----- DT Set changed to ' .. sets.DT.index[DT_ind] .. ' ----->')
        ChangeGear(sets.DT[sets.DT.index[DT_ind]])
        elseif DT == false then
            TP_ind = TP_ind -1
			SAMRoll_ind = SAMRoll_ind -1
            if TP_ind == 0 then
                TP_ind = #sets.TP.index
            end
			if SAMRoll_ind == 0 then
                SAMRoll_ind = #sets.SAMRoll.index
            end
            send_command('@input /echo <----- TP Set changed to ' .. sets.TP.index[TP_ind] .. ' ----->')
            if player.status == 'Engaged' then
                if SAMRoll == true then
                    ChangeGear(sets.SAMRoll[sets.SAMRoll.index[SAMRoll_ind]])
                else
                    ChangeGear(sets.TP[sets.TP.index[TP_ind]])
                end
            end
        end
	elseif command == 'ZoneChange' then
		IdleState()
    elseif command == 'AllowSkillchainGear' then
        AllowSkillchainGear = not AllowSkillchainGear
        add_to_chat (56, 'Allow use of skillchain damage gear: ' ..tostring(AllowSkillchainGear))
    elseif command == 'PetBreathFailover' then
        if PetBreathFailover == true then     --If the PetBreathFailover wasnt reset to false by pet_aftercast then we set it to false here
            PetBreathFailover = false         --And call ac_global to reset our gear
            ac_Global()
        end 
    elseif string.sub(command, 0, 4) == '-cd ' then     --If the first 4 characters of the command are '-cd '
        add_to_chat (30, string.sub(command, 5, string.len(command)))      --add everything after '-cd ' to a message in the chat
	end
end

--------------------------------------
--         Character States         --
--------------------------------------
function IdleState()
	if LockGearIndex then
		ChangeGear(LockGearSet)
	elseif DT == true then
        ChangeGear(sets.DT[sets.DT.index[DT_ind]])
    else
        ChangeGear(sets.Idle[sets.Idle.index[Idle_ind]])
    end
	
	if buffactive['Weakness'] then
		ChangeGear(sets.Utility.Twilight) --Only on during weakened idle, and requires an action after raising to trigger. Use lockgear otherwise.
	elseif mp_jobs:contains(player.sub_job) and player.mpp < 50 then
        ChangeGear(sets.Idle.Refresh)
	else
		ChangeGear(sets.Idle[sets.Idle.index[Idle_ind]])
    end
	
	if Town:contains(world.area) and player.mpp < 65 then
        ChangeGear(set_combine(sets.Idle.Town, sets.Idle.Refresh))
	elseif Town:contains(world.area) then
		ChangeGear(sets.Idle.Town) -- Puts on Waifu/Husbando Band
	end
	
end

windower.raw_register_event('zone change',function()
windower.send_command('@wait 9; input //gs c ZoneChange')
end)

function RestingState()

end

function EngagedState()
	if LockGearIndex then
        ChangeGear(LockGearSet)
    elseif not LockGearIndex then
		if DT == true then
            ChangeGear(sets.DT[sets.DT.index[DT_ind]])
		elseif  buffactive["Elvorseal"] then
			DomainInvasion = true
			ChangeGear(set_combine(sets.TP[sets.TP.index[TP_ind]], sets.Utility.DomainInvasionTP))	
        elseif buffactive["Samurai Roll"] then
            SAMRoll = true
            ChangeGear(sets.SAMRoll[sets.SAMRoll.index[SAMRoll_ind]])
        else
            SAMRoll = false
			DomainInvasion = false
            ChangeGear(sets.TP[sets.TP.index[TP_ind]])
        end
    end
end

-----------------------------
--      Spell control      --
-----------------------------
unusable_buff = {
	spell={'Charm','Mute','Omerta','Petrification','Silence','Sleep','Stun','Terror'},
    ability={'Amnesia','Charm','Impairment','Petrification','Sleep','Stun','Terror'}}
  --check_recast('ability',spell.recast_id)  check_recast('spell',spell.recast_id)
function check_recast(typ,id) --if spell can be cast(not in recast) return true
    local recasts = windower.ffxi['get_'..typ..'_recasts']()
    if id and recasts[id] and recasts[id] == 0 then
        return true
    else
        return false
    end
end
 --return true if spell/ability is unable to be used at this time
function spell_control(spell)
	if spell.type == "Item" then
		return false
	--Stops spell if you do not have a target
	elseif spell.target.name == nil and not spell.target.raw:contains("st") then
		return true
	--Stops spell if a blocking buff is active
	elseif spell.action_type == 'Ability' and spell.type ~= 'WeaponSkill' and (has_any_buff_of(unusable_buff.ability) or not check_recast('ability',spell.recast_id)) then
		return true
	elseif spell.type == 'WeaponSkill' and player.tp < 1000 then
		return true
	elseif spell.type == 'WeaponSkill' and (has_any_buff_of(unusable_buff.ability)) then
		msg("Weapon Skill Canceled, Can't")
		return true
	elseif spell.action_type == 'Magic' and (has_any_buff_of(unusable_buff.spell)
      or not check_recast('spell',spell.recast_id)) then
		return true
    --Stops spell if you do not have enuf mp/tp to use
	elseif spell.mp_cost and spell.mp_cost > player.mp and not has_any_buff_of({'Manawell','Manafont'}) then
        msg("Spell Canceled, Not Enough MP")
		return true
	end
    --Calculate how many finishing moves your char has up to 6
	local fm_count = 0
	for i, v in pairs(buffactive) do
		if tostring(i):startswith('finishing move') or tostring(i):startswith('?????????') then
			fm_count = tonumber(string.match(i, '%d+')) or 1
		end
	end
    --Stops flourishes if you do not have enough finishing moves
	local min_fm_for_flourishes = {['Animated Flourish']=1,['Desperate Flourish']=1,['Violent Flourish']=1,['Reverse Flourish']=1,['Building Flourish']=1,
                                   ['Wild Flourish']=2,['Climactic Flourish']=1,['Striking Flourish']=2,['Ternary Flourish']=3,}
	if min_fm_for_flourishes[spell.en] then
		if min_fm_for_flourishes[spell.en] > fm_count and not buffactive[507] then
			return true
		end
	end
	--Reomves Sneak when casting Spectral Jig
	if spell.en == 'Spectral Jig' then
		send_command('cancel 71')
	end
	if spell.name == 'Utsusemi: Ichi' and overwrite and buffactive['Copy Image (3)'] then
		return true
	end
	if player.tp >= 1000 and player.target and player.target.distance and player.target.distance > 7 and spell.type == 'WeaponSkill' then
		msg("Weapon Skill Canceled  Target Out of Range")
		return true
	end
end

-----------------------------
--         Precast         --
-----------------------------
function pc_JA(spell, act)
    if spell.english == 'Spirit Surge' then
        ChangeGear(sets.JA.SpiritSurge)
    elseif spell.english == 'Call Wyvern' then
        ChangeGear(sets.JA.CallWyvern)
    elseif spell.english == 'Ancient Circle' then
        ChangeGear(sets.JA.AncientCircle)
    elseif spell.english == 'Spirit Link' then
        ChangeGear(sets.JA.SpiritLink)
    elseif spell.english == 'Angon' then
        ChangeGear(sets.JA.Angon)
    elseif spell.english == 'Deep Breathing' then
        ChangeGear(sets.JA.DeepBreathing)
    elseif spell.english == 'Jump' then
        ChangeGear(set_combine(sets.TP[sets.TP.index[TP_ind]],{
			ammo = "Coiste Bodhar",
			head = "Hjarrandi Helm",
			ear1 = "Sherida Earring",
			ear2 = "Telos Earring",
			body = "Pteroslaver Mail +3",
			hands = "Vis. Fng. Gaunt. +3",
			back = Brigantia.STP,
			legs = ValorousLegs.STP,
			waist = "Ioskeha Belt +1",
			feet = "Ostro Greaves"})) --Ostro are better, but the DPS gain for a slot of gear is so low (<10 DPS) and with half the acc+, why bother?
    elseif spell.english == 'High Jump' then
        ChangeGear(set_combine(sets.TP[sets.TP.index[TP_ind]],{
			ammo = "Coiste Bodhar",
			head = "Hjarrandi Helm",
			ear1 = "Sherida Earring",
			ear2 = "Telos Earring",
			body = "Pteroslaver Mail +3",
			hands = "Vis. Fng. Gaunt. +3",
			back = Brigantia.STP,
			waist = "Ioskeha Belt +1",
			legs = "Pteroslaver Brais +3",
			feet = "Ostro Greaves"})) 
    elseif spell.english == 'Spirit Jump' then
        ChangeGear(set_combine(sets.TP[sets.TP.index[TP_ind]],{
			ammo = "Coiste Bodhar",
			head = "Hjarrandi Helm",
			ear1 = "Sherida Earring",
			ear2 = "Telos Earring",
			body = "Pteroslaver Mail +3",
			hands = "Vis. Fng. Gaunt. +3",
			back = Brigantia.STP,
			waist = "Ioskeha Belt +1",
			legs = ValorousLegs.STP,
			feet = "Peltast Schynbalds +1"}))
    elseif spell.english == 'Soul Jump' then
        ChangeGear(set_combine(sets.TP[sets.TP.index[TP_ind]],{
			ammo = "Coiste Bodhar",
			head = "Hjarrandi Helm",
			ear1 = "Sherida Earring",
			ear2 = "Telos Earring",
			body = "Vishap Mail +3",
			hands = "Vis. Fng. Gaunt. +3",
			back = Brigantia.STP,
			waist = "Ioskeha Belt +1",
			legs = ValorousLegs.STP,
			feet = "Ostro Greaves"}))
    elseif spell.english == 'Steady Wing' then
        ChangeGear(sets.HB.Mentos)
    elseif spell.english == 'Provoke' then
        ChangeGear(sets.JA.Provoke)
    end
	
	IgnoreWS = S {"Penta Thrust"}  -- Excluded from Moonshade TP override rule.
	BrutalWS = S {"Stardiver", "Drakesbane", "Shattersoul", "Savage Blade"} 
	
    if spell.type == 'WeaponSkill' then
        if spell.english == 'Stardiver' or spell.english == 'Shattersoul' then
            ChangeGear(sets.Stardiver[sets.Stardiver.index[Stardiver_ind]])
        elseif spell.english == "Camlann's Torment" or spell.english == 'Retribution' then
            ChangeGear(sets.CamlannsTorment[sets.CamlannsTorment.index[CamlannsTorment_ind]])
        elseif spell.english == 'Drakesbane' then
            ChangeGear(sets.Drakesbane[sets.Drakesbane.index[Drakesbane_ind]])
        elseif spell.english == 'Sonic Thrust' then
            ChangeGear(sets.SonicThrust[sets.SonicThrust.index[SonicThrust_ind]])
		elseif spell.english == 'Leg Sweep' then
			ChangeGear(sets.LegSweep)
		elseif spell.english == 'Savage Blade' then
			ChangeGear(sets.SavageBlade)
        end
        if player.tp > 2025 and player.equipment.main == 'Trishula' and buffactive['TP Bonus'] and not buffactive['Sekkanoki'] then
            if IgnoreWS:contains(spell.english) then
                do return end
            elseif BrutalWS:contains(spell.english) then
                equip(set_combine(equipSet, { ear1 = "Brutal Earring" })) --Watch for ear conflicts between TP sets and WS sets
                msg("Brutal Earring equiped !!!!")
            else
                equip(set_combine(equipSet, { ear1 = "Ishvara Earring" }))
                msg("Ishvara Earring equiped !!!!")
            end
        elseif player.tp > 2275 and player.equipment.main == 'Trishula' and not buffactive['Sekkanoki'] then
            if IgnoreWS:contains(spell.english) then
                do return end
			elseif BrutalWS:contains(spell.english) then
                equip(set_combine(equipSet, { ear1 = "Brutal Earring" })) --Watch for ear conflicts between TP sets and WS sets
                msg("Brutal Earring equiped !!!!")
            else
                equip(set_combine(equipSet, { ear1 = "Ishvara Earring" }))
                msg("Ishvara Earring equiped !!!!")
            end
        elseif player.tp > 2550 and buffactive['TP Bonus'] and not buffactive['Sekkanoki'] then
            if IgnoreWS:contains(spell.english) then
                do return end
            elseif BrutalWS:contains(spell.english) then
                equip(set_combine(equipSet, { ear1 = "Brutal Earring" })) --Watch for ear conflicts between TP sets and WS sets
                msg("Brutal Earring equiped !!!!")
            else
                equip(set_combine(equipSet, { ear1 = "Ishvara Earring" }))
                msg("Ishvara Earring equiped !!!!")
            end
        elseif player.tp > 2775 and not buffactive['Sekkanoki'] then
            if IgnoreWS:contains(spell.english) then
                do return end
            elseif BrutalWS:contains(spell.english) then
                equip(set_combine(equipSet, { ear1 = "Brutal Earring" })) --Watch for ear conflicts between TP sets and WS sets
                msg("Brutal Earring equiped !!!!")
            else
                equip(set_combine(equipSet, { ear1 = "Ishvara Earring" }))
                msg("Ishvara Earring equiped !!!!")
            end
        end
    end
	
if spell.english == 'Stardiver' and Stardiver_ind ~= 1 and (check_ws_day[world.day]:contains(spell.skillchain_a) -- Remove the and _ind ~=1 (not equal) for Gavialis if you don't have Ptero +2/3.
    or check_ws_day[world.day]:contains(spell.skillchain_b) 
    or check_ws_day[world.day]:contains(spell.skillchain_c)) then
	ChangeGear(sets.WSDayBonus)
end
--Tested, Aeonic AM Doesn't work with Gavialis, but I will keep the extra rule on ice for now below:
--or (check_ws_day[world.day]:contains("Darkness") and player.equipment.main == 'Trishula' and (buffactive['Aftermath: Lv.3'] or buffactive['Aftermath: Lv.2'] or buffactive['Aftermath: Lv.1']))) then

	if spell.english == 'Box Step' or spell.english == 'Quick Step' then
		ChangeGear(sets.Utility.Steps)
	elseif spell.english == 'Animated Flourish' then
		ChangeGear(sets.Enmity)
	end
end

function pc_Magic(spell, act)
	if spell.action_type == 'Magic' then
		ChangeGear(sets.precast.FastCast.Standard)
	end
end

function pretarget(spell,action)

	if  spell.english =="Call Wyvern" and pet.isvalid then -- Change Call Wyvern To Spirit Link If Wyvern Is Present --
		cancel_spell()
		send_command('Spirit Link')
	end

end


function pc_Item(spell, act)
end


-----------------------------
--         Midcast         --
-----------------------------
function mc_JA(spell, act)
end

function mc_Magic(spell, act)
	if spell.action_type == 'Magic' and player.hpp <= 50 then
		ChangeGear(sets.HB.Trigger)
	elseif Trigger:contains(spell.english) then --Put whatever you want to trigger the helm change in the table above
		ChangeGear(sets.HB.Trigger)
	end

	if spell.skill == 'Enhancing Magic' then
		if spell.english == 'Refresh' then
			ChangeGear(sets.Enhancing.Refresh)
		elseif string.find(spell.english,'Regen')then
			ChangeGear(sets.Enhancing.Regen)
		elseif string.find(spell.english,'Bar') then
			ChangeGear(sets.Enhancing.Skill)
		elseif spell.english=="Phalanx" then
			ChangeGear(sets.Enhancing.Phalanx)
		elseif string.find(spell.english,'Shell') or string.find(spell.english,'Protect') then
			ChangeGear(sets.Enhancing.ProShell)
		end
	end
	
	if PhysicalSpells:contains(spell.english) then
		ChangeGear(sets.BlueMagic.STR)
	end

	if BlueMagic_Enmity:contains(spell.english) then
		ChangeGear(sets.Enmity)
	elseif BlueMagic_Buffs:contains(spell.english) then
		ChangeGear(sets.TP.Tank)
	elseif BlueMagic_Healing:contains(spell.english) or string.find(spell.english,'Cure')then
		ChangeGear(set_combine(sets.Cures, sets.HB.Trigger))
	end
end

function mc_Item(spell, act)
end


--------------------------------
--         After Cast         --
--------------------------------
function ac_JA(spell)
end

function ac_Magic(spell)
end

function ac_Item(spell)
end

function ac_Global()
    if LockGearIndex == true then
        ChangeGear(LockGearSet)
        msg("Lock Gear is ON -- Swapping Gear")
    else
        if player.status == 'Engaged' then
				EngagedState()
        else
            IdleState()
        end
    end
end

------------------------------------
--         Framework Core         --
------------------------------------
function status_change(new, old)
	if new == 'Idle' then
		IdleState()
	elseif new == 'Resting' then
		RestingState()
	elseif new == 'Engaged' then
		EngagedState()
	end
	
	if player.status == 'Engaged' and TH == true then 
		ChangeGear(set_combine(equipSet, sets.Utility.TH))
	end
	
	if DT == true then
        ChangeGear(sets.DT[sets.DT.index[DT_ind]])
    end
	
end

function pet_midcast(spell, act)
	PetBreathFailover = true
    if string.find(spell.english,'Healing Breath')  then
		ChangeGear(sets.HB.Mentos)
	elseif ElementalBreath:contains(spell.english) then
		ChangeGear(sets.HB.Ricola)
    end
    send_command('wait 1.2;gs c PetBreathFailover')
end

function pet_aftercast(spell, act, spellMap, eventArgs)
    PetBreathFailover = false
	if spell.action_type == 'Ability' then
		ac_JA(spell)
	elseif spell.action_type == 'Magic' then
		ac_Magic(spell)
	else
		ac_Item(spell)
	end
	ac_Global()
end
		
function precast(spell, act, spellMap, eventArgs)
	if spell_control(spell) then
        cancel_spell()
        return
    end
	if spell.action_type == 'Ability' then
		pc_JA(spell, act)
	elseif spell.action_type == 'Magic' then
		pc_Magic(spell, act)
	else
		pc_Item(spell, act)
	end
	
	if spell.type:lower() == "weaponskill" and DomainInvasion == true then
		ChangeGear(set_combine(equipSet, sets.Utility.DomainInvasionWS))
	elseif spell.type:lower() == "weaponskill" and SkillchainPending == true then           
        if (os.time() - SkillchainTimer) <= 9 and AllowSkillchainGear == true then
			if buffactive["Allies' Roll"] then
				equip(sets.SCDmgAllies)
			else
				equip(sets.SCDmg)			-- If the current operating system time (in seconds) 
			end								-- minus SkillchainTimer variable is less than 9, equip skillchain gear 
		else
			SkillchainPending = false
		end                                      
    end
end

function midcast(spell, act)
	if spell.action_type == 'Ability' and TH == true then
		ChangeGear(set_combine(equipSet, sets.Utility.TH))
	elseif spell.action_type == 'Ability' then
		mc_JA(spell, act)
	elseif spell.action_type == 'Magic' then
		mc_Magic(spell, act)
	else
		mc_Item(spell, act)
	end
end

function aftercast(spell, act, spellMap, eventArgs)
	if spell.action_type == 'Ability' then
		ac_JA(spell)
	elseif spell.action_type == 'Magic' then
		ac_Magic(spell)
	else
		ac_Item(spell)
	end
	ac_Global()
	
	if player.status == 'Engaged' and DomainInvasion == true then 
		ChangeGear(set_combine(equipSet, sets.Utility.DomainInvasionTP))
	end
	
	--Countdowns--
	if not spell.interrupted then
		if spell.english == "Meditate" then
			send_command('wait 169;gs c -cd '..spell.name..': [Ready In 10 Seconds!];wait 10;gs c -cd '..spell.name..': [Ready !]')
		elseif spell.english == "Sekkanoki" then
			send_command('wait 289;gs c -cd '..spell.name..': [Ready In 10 Seconds!];wait 10;gs c -cd '..spell.name..': [Ready !]')
		elseif spell.english == "Jump" then
			send_command('wait 49;gs c -cd '..spell.name..': [Ready!]')
		elseif spell.english == "High Jump" then
			send_command('wait 100;gs c -cd '..spell.name..': [Ready!!]')
		elseif spell.english == "Spirit Jump" then
			send_command('wait 49;gs c -cd '..spell.name..': [Ready!]')
		elseif spell.english == "Soul Jump" then
			send_command('wait 100;gs c -cd '..spell.name..': [Ready!!]')
		elseif spell.english == "Angon" then
			send_command('timers create "Angon Defense Down" 90 down')
        elseif spell.type == "WeaponSkill" then
            SkillchainPending = true
            SkillchainTimer = os.time()    -- sets SkillchainTimer variable to the current time of the operating system (in seconds)
        end 
    end
end

function ChangeGear(GearSet)
	equipSet = GearSet
	equip(GearSet)
end

function LockGearSet(GearSet)
	LockedEquipSet = GearSet
	equip(GearSet)
	SetLocked = true
end

function UnlockGearSet()
	locked = false
	equip(equipSet)
end

function msg(str)
	send_command('@input /echo <----- ' .. str .. ' ----->')
end

---End of Rules-------------------------------------------------------------------------------------------------------------------------------------------------------