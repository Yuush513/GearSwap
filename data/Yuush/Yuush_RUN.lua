
-- Initialization function for this job file.
function get_sets()
    mote_include_version = 2
	include('organizer-lib.lua')
    -- Load and initialize the include file.
    include('Mote-Include.lua')
    res = require 'resources'
end

-- Setup vars that are user-independent.
function job_setup()
	include('Mote-TreasureHunter')
    -- /BLU Spell Maps
    blue_magic_maps = {}

    blue_magic_maps.Enmity = S{'Blank Gaze', 'Geist Wall', 'Jettatura', 'Soporific',
        'Poison Breath', 'Blitzstrahl', 'Sheep Song', 'Chaotic Eye'}
    blue_magic_maps.Cure = S{'Wild Carrot'}
    blue_magic_maps.Buffs = S{'Cocoon', 'Refueling'}

    no_swap_gear = S{"Warp Ring", "Dim. Ring (Dem)", "Dim. Ring (Holla)", "Dim. Ring (Mea)",
              "Trizek Ring", "Echad Ring", "Facility Ring", "Capacity Ring"}

    rayke_duration = 35
    gambit_duration = 96

    lockstyleset = 20

end

-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

function user_setup()
    state.OffenseMode:options('Normal', 'Damage', 'Acc')
    state.WeaponskillMode:options('Normal', 'Acc')
    state.HybridMode:options('Normal', 'DT', 'HybridDT')
    state.CastingMode:options('Normal', 'Resistant')
    state.IdleMode:options('Normal', 'DT', 'Evasion')
    state.PhysicalDefenseMode:options('PDT', 'NonEngaged')
    state.MagicalDefenseMode:options('MDT')

    state.Knockback = M(false, 'Knockback')

    state.WeaponSet = M{['description'] = 'Weapon Set', 'Epeolatry', 'Lionheart', 'Aettir', 'Lycurgos'}
    state.AttackMode = M{['description'] = 'Attack', 'Uncapped', 'Capped'}
    state.WeaponLock = M(false, 'Weapon Lock')

    state.Runes = M{['description'] = 'Runes', 'Ignis', 'Gelus', 'Flabra', 'Tellus', 'Sulpor', 'Unda', 'Lux', 'Tenebrae'}

    -- Additional local binds
	send_command('bind ^home gs c cycle treasuremode')
	send_command('bind ^- gs c cycleback Runes')
    send_command('bind ^=  gs c cycle Runes')
	send_command('bind !f9 gs c cycle AttackMode')
    send_command('bind ^f11 gs c cycle MagicalDefenseMode')
	send_command('bind ^insert gs c cycle WeaponSet')
    send_command('bind ^delete gs c cycleback WeaponSet')

    select_default_macro_book()
    set_lockstyle()

end

function user_unload()
	send_command('unbind ^home')
    send_command('unbind ^-')
	send_command('unbind ^=')
    send_command('unbind !f9')
    send_command('unbind ^f11')
    send_command('unbind ^insert')
    send_command('unbind ^delete')
end

-- Define sets and vars used by this job file.
function init_gear_sets()

    ------------------------------------------------------------------------------------------------
    ---------------------------------------- Precast Sets ------------------------------------------
    ------------------------------------------------------------------------------------------------
	
	sets.TreasureHunter =  {
		hands = HerculeanHands.TH,
		legs = HerculeanLegs.TH,
		waist = "Chaac Belt",
	}
	
    -- Enmity sets
    sets.Enmity = {
		ammo="Sapience Orb",
		head="Halitus Helm",
		body="Emet Harness +1",
		hands="Kurys Gloves",
		legs="Eri. Leg Guards +1",
		feet="Ahosi Leggings",
		neck="Moonlight Necklace",
		waist="Kasiri Belt",
		left_ear="Cryptic Earring",
		right_ear="Trux Earring",
		left_ring="Eihwaz Ring",
		right_ring="Supershear Ring",
		back={ name="Ogma's Cape", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','Enmity+10','Phys. dmg. taken-10%',}},
        }

    sets.Enmity.DT = set_combine(sets.Enmity, {
		ammo="Staunch Tathlum +1",
		feet="Erilaz Greaves +1",
		neck="Futhark Torque +2",
		right_ear="Odnowa Earring +1",
		right_ring="Gelatinous Ring +1",
        })

	sets.precast.JA['Vallation'] = set_combine(sets.Enmity, {body="Runeist's Coat +3", legs="Futhark Trousers +3", back=Ogma.PDT,})
    sets.precast.JA['Valiance'] = sets.precast.JA['Vallation']
    sets.precast.JA['Pflug'] = set_combine(sets.Enmity, {})
    sets.precast.JA['Battuta'] = set_combine(sets.Enmity, {head = "Fu. Bandeau +3"})
    sets.precast.JA['Liement'] = set_combine(sets.Enmity, {body = "Futhark Coat +3"})

    sets.precast.JA['Lunge'] = {    
		ammo="Seeth. Bomblet +1",
		head="Agwu's Cap",
		body="Agwu's Robe",
		hands="Agwu's Gages",
		legs="Agwu's Slops",
		feet="Agwu's Pigaches",
		neck="Baetyl Pendant",
		waist="Skrymir Cord",
		left_ear="Hecate's Earring",
		right_ear="Friomisi Earring",
		left_ring="Mujin Band",
		right_ring="Shiva Ring +1",
		back=Ogma.MAB,
		}
	
    sets.precast.JA['Swipe'] = sets.precast.JA['Lunge']
	
    sets.precast.JA['Gambit'] = set_combine(sets.Enmity.HP, {hands="Runeist Mitons +3"})
    sets.precast.JA['Rayke'] = set_combine(sets.Enmity.HP, {feet="Futhark Boots +3"})
    sets.precast.JA['Elemental Sforzo'] = set_combine(sets.Enmity, {body="Futhark Coat +3"})
    sets.precast.JA['Swordplay'] = set_combine(sets.Enmity, {hands="Futhark Mitons +3"})
	
	--Every 10 skill +1tier
    sets.precast.JA['Vivacious Pulse'] = set_combine(sets.Enmity.HP, { })
		
	sets.precast.JA['One For All'] = set_combine(sets.Enmity.HP, {})
	
	sets.precast.JA['Provoke'] = set_combine(sets.Enmity, {})
    sets.precast.JA['Warcry'] = set_combine(sets.Enmity, {})
    sets.precast.JA['Berserk'] = set_combine(sets.Enmity, {})
    sets.precast.JA['Defender'] = set_combine(sets.Enmity, {})
    sets.precast.JA['Aggressor'] = set_combine(sets.Enmity, {})
    sets.precast.JA['Last Resort'] = set_combine(sets.Enmity, {})
    sets.precast.JA['Weapon Bash'] = set_combine(sets.Enmity, {})
    sets.precast.JA['Souleater'] = set_combine(sets.Enmity, {})

    -- Fast cast sets for spells
    sets.precast.FC = {
		ammo="Sapience Orb", --2
		head="Rune. Bandeau +3", --14
		body="Adhemar Jacket +1", --10
		hands="Leyline Gloves", --8
		legs="Agwu's Slops", --7
		feet="Carmine Greaves +1", --8
		neck="Orunmila's Torque", --5
		waist="Gold Mog. Belt",
		left_ear="Loquac. Earring", --2
		right_ear="Etiolation Earring", --1
		left_ring="Kishar Ring", --4
		right_ring="Gelatinous Ring +1",
		back=Ogma.FC, --10
        } --71

    sets.precast.FC.HP = set_combine(sets.precast.FC, {left_ear="Odnowa Earring +1",})

    sets.precast.FC['Enhancing Magic'] = set_combine(sets.precast.FC, {
		legs = "Futhark Trousers +3",
		waist="Gold Mog. Belt",
		left_ear="Odnowa Earring +1",
		left_ring="Moonlight Ring", 
		})

    sets.precast.FC.Cure = set_combine(sets.precast.FC, {})

    sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, {})


    ------------------------------------------------------------------------------------------------
    ------------------------------------- Weapon Skill Sets ----------------------------------------
    ------------------------------------------------------------------------------------------------

    sets.precast.WS = {
        ammo="Knobkierrie",
		head=HerculeanHead.STR_WSD,
		body=HerculeanBody.WSD,
		hands="Meg. Gloves +2",
		legs="Meg. Chausses +2",
		feet=HerculeanFeet.STR_WSD,
		neck="Fotia Gorget",
		waist="Fotia Belt",
		left_ear="Sherida Earring",
		right_ear="Moonshade Earring",
		left_ring="Karieyh Ring +1",
		right_ring="Regal Ring",
		back=Ogma.STR,
		}

    sets.precast.WS.Acc = set_combine(sets.precast.WS, {
        body="Nyame Mail",
		legs="Nyame Flanchard",
		})

    sets.precast.WS.Capped = set_combine(sets.precast.WS, {
        legs="Samnuha Tights",
		right_ring="Niqmaddu Ring",
		})

	sets.precast.WS.Safe = set_combine(sets.precast.WS, {
		body="Nyame Mail",
		legs="Nyame Flanchard",
		neck="Futhark Torque +2",
		left_ring={name="Moonlight Ring", bag="wardrobe1"},
		right_ring={name="Moonlight Ring", bag="wardrobe2"},
	})
	
	--Great Sword--
	
    sets.precast.WS['Resolution'] = {
		ammo="Seeth. Bomblet +1",
		head="Lustratio Cap +1",
		body="Lustr. Harness +1",
		hands=HerculeanHands.STR_TA,
		legs="Meg. Chausses +2",
		feet=LustratioFeet.A,
		neck="Fotia Gorget",
		waist="Fotia Belt",
		left_ear="Sherida Earring",
		right_ear="Moonshade Earring",
		left_ring="Regal Ring",
		right_ring="Niqmaddu Ring",
		back=Ogma.DA,
        }

    sets.precast.WS['Resolution'].Acc = set_combine(sets.precast.WS['Resolution'], {})

    sets.precast.WS['Resolution'].Capped = set_combine(sets.precast.WS['Resolution'], {
		legs="Samnuha Tights",
		feet=LustratioFeet.D,
		left_ring="Epona's Ring",
        })

    sets.precast.WS['Resolution'].Safe = set_combine(sets.precast.WS['Resolution'], {
		head="Nyame Helm",
		body="Nyame Mail",
		feet="Nyame Sollerets",
		left_ear="Odnowa Earring +1",
		right_ring={name="Moonlight Ring", bag="wardrobe2"},
		})

    sets.precast.WS['Dimidiation'] = {
		ammo="Knobkierrie",
		head=HerculeanHead.DEX_WSD,
		body=HerculeanBody.WSD,
		hands="Meg. Gloves +2",
		legs="Lustr. Subligar +1",
		feet=LustratioFeet.D,
		neck="Caro Necklace",
		waist="Grunfeld Rope",
		left_ear="Sherida Earring",
		right_ear="Moonshade Earring",
		left_ring="Karieyh Ring +1",
		right_ring="Regal Ring",
		back=Ogma.DEX,
        }

    sets.precast.WS['Dimidiation'].Acc = set_combine(sets.precast.WS['Dimidiation'], {
        body="Ashera Harness",
		left_ear="Odr Earring",
		})

    sets.precast.WS['Dimidiation'].Capped = set_combine(sets.precast.WS['Dimidiation'], {
		neck="Fotia Gorget",
		waist="Fotia Belt",
		right_ring="Niqmaddu Ring",
        })

    sets.precast.WS['Dimidiation'].Safe = set_combine(sets.precast.WS['Dimidiation'], {
		ammo="Knobkierrie",
		head="Turms Cap +1",
		body="Ashera Harness",
		legs="Nyame Flanchard",
		feet="Nyame Sollerets",
		neck="Futhark Torque +2",
		left_ring={name="Moonlight Ring", bag="wardrobe1"},
		right_ring="Regal Ring",
		back=Ogma.DEX,
		})

    sets.precast.WS['Herculean Slash'] = set_combine(sets.precast.JA['Lunge'], {
		left_ring="Karieyh Ring +1",
		right_ring="Niqmaddu Ring",
		})
		
    sets.precast.WS.Acc = set_combine(sets.precast.WS['Herculean Slash'], {})
    sets.precast.WS.Capped = set_combine(sets.precast.WS['Herculean Slash'], {})
	sets.precast.WS.Safe = set_combine(sets.precast.WS['Herculean Slash'], {})


    sets.precast.WS['Shockwave'] = {
		ammo="Yamarang",
		head="Nyame Helm",
		body="Nyame Mail",
		hands="Nyame Gauntlets",
		legs="Nyame Flanchard",
		feet="Nyame Sollerets",
		neck="Fotia Gorget",
		waist="Fotia Belt",
		left_ear="Moonshade Earring",
		right_ear="Sherida Earring",
		left_ring="Karieyh Ring +1",
		right_ring="Niqmaddu Ring",
		back=Ogma.STR,
        }

    sets.precast.WS.Acc = set_combine(sets.precast.WS['Shockwave'], {})
    sets.precast.WS.Capped = set_combine(sets.precast.WS['Shockwave'], {})
	sets.precast.WS.Safe = set_combine(sets.precast.WS['Shockwave'], {})

	--Great Axe--

    sets.precast.WS['Fell Cleave'] = {
		ammo="Knobkierrie",
		head="Lustratio Cap +1",
		body="Lustr. Harness +1",
		hands="Meg. Gloves +2",
		legs="Nyame Flanchard",
		feet=LustratioFeet.D,
		neck="Futhark Torque +2",
		waist="Sailfi Belt +1",
		left_ear="Sherida Earring",
		right_ear="Moonshade Earring",
		left_ring="Karieyh Ring +1",
		right_ring="Regal Ring",
		back=Ogma.STR
        }

    sets.precast.WS['Fell Cleave'].Acc = set_combine(sets.precast.WS['Fell Cleave'], {})
	sets.precast.WS['Fell Cleave'].Capped = set_combine(sets.precast.WS['Fell Cleave'], {})
	
    sets.precast.WS['Fell Cleave'].Safe = set_combine(sets.precast.WS['Fell Cleave'], {
		head=HerculeanHead.STR_WSD,
		body=HerculeanBody.WSD,
		feet=HerculeanFeet.STR_WSD,
		left_ear="Odnowa Earring +1",
		left_ring={name="Moonlight Ring", bag="wardrobe1"},
		})

    sets.precast.WS['Steel Cyclone'] = {
		ammo="Knobkierrie",
		head=HerculeanHead.STR_WSD,
		body="Nyame Mail",
		hands="Meg. Gloves +2",
		legs="Nyame Flanchard",
		feet="Nyame Sollerets",
		neck="Futhark Torque +2",
		waist="Sailfi Belt +1",
		left_ear="Odnowa Earring +1",
		right_ear="Moonshade Earring",
		left_ring="Karieyh Ring +1",
		right_ring="Regal Ring",
		back=Ogma.STR,
		}
	
    sets.precast.WS['Steel Cyclone'].Acc = sets.precast.WS['Fell Cleave'].Acc
    sets.precast.WS['Steel Cyclone'].Safe = sets.precast.WS['Fell Cleave'].Safe

    sets.precast.WS['Upheaval'] = sets.precast.WS['Resolution']
    sets.precast.WS['Upheaval'].Acc = sets.precast.WS['Resolution'].Acc
    sets.precast.WS['Upheaval'].Safe = sets.precast.WS['Resolution'].Safe

    sets.precast.WS['Shield Break'] = sets.precast.WS['Shockwave']
    sets.precast.WS['Armor Break'] = sets.precast.WS['Shockwave']
    sets.precast.WS['Weapon Break'] = sets.precast.WS['Shockwave']
    sets.precast.WS['Full Break'] = sets.precast.WS['Shockwave']

	--Sword--
	--Axe--

    ------------------------------------------------------------------------------------------------
    ---------------------------------------- Midcast Sets ------------------------------------------
    ------------------------------------------------------------------------------------------------

    sets.midcast.FastRecast = sets.precast.FC
	
	sets.midcast.SpellInterrupt = {
		ammo="Staunch Tathlum +1",
		head="Agwu's Cap",
		body="Nyame Mail",
		hands="Regal Gauntlets",
		legs="Carmine Cuisses +1",
		feet={ name="Taeon Boots", augments={'Mag. Evasion+20','Spell interruption rate down -10%','HP+49',}},
		neck="Moonlight Necklace",
		waist="Audumbla Sash",
		left_ear="Magnetic Earring",
		right_ear="Odnowa Earring +1",
		left_ring="Defending Ring",
		right_ring="Gelatinous Ring +1",
		back=Ogma.PDT,
	}
	
    sets.midcast.SIRDenmity = set_combine(sets.midcast.SpellInterrupt, {
		body="Emet Harness +1", 
		left_ear="Cryptic Earring",
		left_ring="Eihwaz Ring",
		right_ring="Supershear Ring",
        })

    sets.midcast.Cure = {}

    sets.midcast['Enhancing Magic'] = {
		ammo="Staunch Tathlum +1",
		head="Carmine Mask +1",
		body="Manasa Chasuble",
		hands="Runeist Mitons +3",
		legs="Carmine Cuisses +1",
		feet="Nyame Sollerets",
		neck="Incanter's Torque",
		waist="Olympus Sash",
		left_ear="Mimir Earring",
		right_ear="Andoaa Earring",
		left_ring="Stikini Ring +1",
		right_ring="Stikini Ring",
		back="Moonlight Cape",
        }

    sets.midcast.EnhancingDuration = {
        head = "Erilaz Galea +1",
        hands = "Regal Gauntlets",
        legs = "Futhark Trousers +3",
        }
	
	--28 + Floor( (473 - 300) / 28.5)
	-- [34 + 23] = 57
    sets.midcast['Phalanx'] = {
		ammo="Staunch Tathlum +1",
		head="Fu. Bandeau +3",
		body=HerculeanBody.Phalanx,
		hands=HerculeanHands.Phalanx,
		legs=HerculeanLegs.Phalanx,
		feet=HerculeanFeet.Phalanx,
		neck="Incanter's Torque",
		waist="Audumbla Sash",
		left_ear="Mimir Earring",
		right_ear="Odnowa Earring +1",
		left_ring="Stikini Ring +1",
		right_ring="Gelatinous Ring +1",
		back="Moonlight Cape",
        }

    sets.midcast['Aquaveil'] = sets.midcast.SpellInterrupt

    sets.midcast['Regen'] = set_combine(sets.midcast['Enhancing Magic'], {head="Rune. Bandeau +3", neck = "Sacro Gorget"})
    sets.midcast.Refresh = set_combine(sets.midcast.EnhancingDuration, {head="Erilaz Galea +1", waist="Gishdubar Sash"})
    sets.midcast.Stoneskin = set_combine(sets.midcast['Enhancing Magic'], {})
    sets.midcast.Protect = set_combine(sets.midcast['Enhancing Magic'], {ear2="Brachyura Earring"})
    sets.midcast.Shell = sets.midcast.Protect
	
    sets.midcast['Divine Magic'] = {}

    sets.midcast.Flash = sets.Enmity
    sets.midcast.Foil = sets.Enmity
    sets.midcast.Stun = sets.Enmity
    sets.midcast.Utsusemi = sets.midcast.SpellInterrupt

    sets.midcast['Blue Magic'] = {}
    sets.midcast['Blue Magic'].Enmity = sets.Enmity
    sets.midcast['Blue Magic'].Cure = sets.midcast.Cure
    sets.midcast['Blue Magic'].Buff = sets.midcast['Enhancing Magic']


    ------------------------------------------------------------------------------------------------
    ----------------------------------------- Idle Sets --------------------------------------------
    ------------------------------------------------------------------------------------------------

    sets.idle = {
		ammo="Staunch Tathlum +1",
		head="Turms Cap +1",
		body="Runeist Coat +3",
		hands="Nyame Gauntlets",
		legs="Nyame Flanchard",
		feet="Nyame Sollerets",
		neck={ name="Futhark Torque +2", augments={'Path: A',}},
		waist="Engraved Belt",
		left_ear="Eabani Earring",
		right_ear={ name="Odnowa Earring +1", augments={'Path: A',}},
		left_ring="Defending Ring",
		right_ring="Shneddick Ring +1",
		back={ name="Ogma's Cape", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','Enmity+10','Phys. dmg. taken-10%',}},
		}
	
	sets.idle.DT = {
		ammo="Brigantia Pebble",
		head="Nyame Helm",
		body="Nyame Mail",
		hands="Nyame Gauntlets",
		legs="Carmine Cuisses +1",
		feet="Nyame Sollerets",
		neck="Loricate Torque +1",
		waist="Engraved Belt",
		left_ear="Tuisto Earring",
		right_ear="Odnowa Earring +1",
		left_ring="Moonlight Ring",
		right_ring="Gelatinous Ring +1",
		back=Ogma.DEF,
		}

    sets.idle.Evasion = {
		--sub="Kupayopl",
		ammo="Yamarang",
		head="Turms Cap +1",
		body="Nyame Mail",
		hands="Nyame Gauntlets",
		legs="Nyame Flanchard",
		feet="Nyame Sollerets",
		neck="Bathy Choker +1",
		waist="Svelt. Gouriz +1",
		left_ear="Eabani Earring",
		right_ear="Infused Earring",
		left_ring="Defending Ring",
		right_ring="Gelatinous Ring +1",
		back=Ogma.Eva,
		}

    ------------------------------------------------------------------------------------------------
    ---------------------------------------- Defense Sets ------------------------------------------
    ------------------------------------------------------------------------------------------------

    sets.defense.Knockback = {}

	--Only issue is this set is Tanky Offense but not Haste Capped.
    sets.defense.PDT = {
		ammo="Yamarang",
		head="Nyame Helm",
		body="Nyame Mail",
		hands="Turms Mittens +1",
		legs="Nyame Flanchard",
		feet="Turms Leggings +1",
		neck={ name="Futhark Torque +2", augments={'Path: A',}},
		waist="Engraved Belt",
		left_ear="Tuisto Earring",
		right_ear={ name="Odnowa Earring +1", augments={'Path: A',}},
		left_ring="Defending Ring",
		right_ring={ name="Gelatinous Ring +1", augments={'Path: A',}},
		back={ name="Ogma's Cape", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','Enmity+10','Parrying rate+5%',}},
        }
	
    sets.defense.MDT = {
		ammo="Yamarang",
		head="Nyame Helm",
		body="Runeist Coat +3",
		hands="Nyame Gauntlets",
		legs="Nyame Flanchard",
		feet="Nyame Sollerets",
		neck={ name="Futhark Torque +2", augments={'Path: A',}},
		waist="Engraved Belt",
		left_ear="Sanare Earring",
		right_ear={ name="Odnowa Earring +1", augments={'Path: A',}},
		left_ring="Shadow Ring",
		right_ring={ name="Gelatinous Ring +1", augments={'Path: A',}},
		back={ name="Ogma's Cape", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','Enmity+10','Phys. dmg. taken-10%',}},
        }

    sets.defense.NonEngaged = {
		ammo="Brigantia Pebble",
		head="Nyame Helm",
		body="Nyame Mail",
		hands="Nyame Gauntlets",
		legs="Nyame Flanchard",
		feet="Nyame Sollerets",
		neck="Loricate Torque +1",
		waist="Flume Belt +1",
		left_ear="Tuisto Earring",
		right_ear="Odnowa Earring +1",
		left_ring="Moonlight Ring",
		right_ring="Gelatinous Ring +1",
		back=Ogma.DEF,
	}

    ------------------------------------------------------------------------------------------------
    ---------------------------------------- Engaged Sets ------------------------------------------
    ------------------------------------------------------------------------------------------------

	sets.engaged = {
		ammo="Coiste Bodhar",
		head=AdhemarHead.D,
		body="Ashera Harness",
		hands="Adhemar Wrist. +1",
		legs="Samnuha Tights",
		feet=HerculeanFeet.TA,
		neck="Futhark Torque +2",
		waist="Sailfi Belt +1", 
		left_ear="Sherida Earring",
		right_ear="Telos Earring",
		left_ring="Moonlight Ring",
		right_ring="Niqmaddu Ring",
		back=Ogma.DA,
		}

    sets.engaged.Damage = {
		ammo="Coiste Bodhar",
		head=AdhemarHead.B,
		body="Ashera Harness",
		hands="Adhemar Wrist. +1",
		legs="Samnuha Tights",
		feet=HerculeanFeet.TA,
		neck="Anu Torque",
		waist="Windbuffet Belt +1",
		left_ear="Telos Earring",
		right_ear="Sherida Earring",
		left_ring="Epona's Ring",
		right_ring="Niqmaddu Ring",
		back=Ogma.DA,
        }

    sets.engaged.Acc = set_combine(sets.engaged, {})

    sets.engaged.Aftermath = {
		feet=HerculeanFeet.STP,
		left_ear="Dedition Earring",
        }


    ------------------------------------------------------------------------------------------------
    ---------------------------------------- Hybrid Sets -------------------------------------------
    ------------------------------------------------------------------------------------------------

    sets.Hybrid = {}

--TankDamage
    sets.engaged.DT = {
		ammo="Coiste Bodhar",
		head="Nyame Helm",
		body="Ashera Harness",
		hands="Nyame Gauntlets",
		legs="Nyame Flanchard",
		feet="Nyame Sollerets",
		neck="Anu Torque",
		waist="Sailfi Belt +1",
		left_ear="Sherida Earring",
		right_ear="Brutal Earring",
		left_ring="Moonlight Ring",
		right_ring="Niqmaddu Ring",
		back=Ogma.DA,
		}
		
    sets.engaged.Acc.DT = set_combine(sets.engaged.DT, {})
    
	sets.engaged.Aftermath.DT = set_combine(sets.engaged.DT, {
		ammo="Yamarang",
		right_ear="Dedition Earring",
		back=Ogma.STP,
		})

--DamageTank
	sets.engaged.HybridDT = {    
		ammo="Staunch Tathlum +1",
		head=AdhemarHead.D,
		body="Ashera Harness",
		hands="Adhemar Wrist. +1",
		legs="Meg. Chausses +2",
		feet=HerculeanFeet.TA,
		neck="Futhark Torque +2",
		waist="Sailfi Belt +1",
		left_ear="Sherida Earring",
		right_ear="Odnowa Earring +1",
		left_ring="Moonlight Ring",
		right_ring="Moonlight Ring",
		back=Ogma.DA,
		}
		
	sets.engaged.Acc.HybridDT = set_combine(sets.engaged.HybridDT, {})
    
	sets.engaged.Aftermath.HybridDT = set_combine(sets.engaged.HybridDT, {
		ammo="Yamarang",
		head="Aya. Zucchetto +2",
		legs="Nyame Flanchard",
		feet="Carmine Greaves +1",
		right_ear="Telos Earring",
		back=Ogma.STP,
		})
	
    ------------------------------------------------------------------------------------------------
    ---------------------------------------- Special Sets ------------------------------------------
    ------------------------------------------------------------------------------------------------

    sets.buff.Doom = {
        neck = "Nicander's Necklace", --20
        ring1 = "Purity Ring", --7
        ring2 = "Eshmun's Ring", --20
        waist = "Gishdubar Sash", --10
        }

    sets.Embolden = set_combine(sets.midcast.EnhancingDuration, {back = "Evasionist's Cape"})
    sets.Obi = {waist = "Hachirin-no-Obi"}

    sets.Epeolatry = {main="Epeolatry", sub="Utu Grip"}
    sets.Lionheart = {main = "Lionheart", sub="Utu Grip"}
    sets.Aettir = {main = "Aettir", sub="Utu Grip"}
    sets.Lycurgos = {main = "Lycurgos", sub="Utu Grip"}
	
	sets.Phalanx = {
	    head={ name="Fu. Bandeau +3", augments={'Enhances "Battuta" effect',}},
		body={ name="Herculean Vest", augments={'Pet: Attack+9 Pet: Rng.Atk.+9','"Store TP"+3','Phalanx +4','Accuracy+13 Attack+13','Mag. Acc.+5 "Mag.Atk.Bns."+5',}},
		hands={ name="Herculean Gloves", augments={'AGI+2','Attack+4','Phalanx +4',}},
		legs={ name="Herculean Trousers", augments={'Rng.Acc.+18','STR+7','Phalanx +5',}},
		feet={ name="Herculean Boots", augments={'Chance of successful block +1','Haste+2','Phalanx +4','Accuracy+4 Attack+4',}},
		back={ name="Evasionist's Cape", augments={'Enmity+6','"Embolden"+15','Damage taken-1%',}},
	}
	
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------

function job_precast(spell, action, spellMap, eventArgs)
    equip(sets[state.WeaponSet.current])

    if buffactive['terror'] or buffactive['petrification'] or buffactive['stun'] or buffactive['sleep'] then
        add_to_chat(167, 'Stopped due to status.')
        eventArgs.cancel = true
        return
    end
--	if rune_enchantments:contains(spell.english) then
--        eventArgs.handled = true
--    end
    if state.DefenseMode.value ~= 'None' then
        currentSpell = spell.english
        eventArgs.handled = true
        if spell.action_type == 'Magic' then
            equip(sets.precast.FC.HP)
        elseif spell.action_type == 'Ability' then
            equip(sets.Enmity.DT)
            equip(sets.precast.JA[currentSpell])
        end
--    else
 --       if spell.action_type == 'Ability' then
 --           equip(sets.precast.JA[spell])
 --           equip(sets.Enmity)
 --       end
    end
    if spell.english == 'Lunge' then
        local abil_recasts = windower.ffxi.get_ability_recasts()
        if abil_recasts[spell.recast_id] > 0 then
            send_command('input /jobability "Swipe" <t>')
--            add_to_chat(122, '***Lunge Aborted: Timer on Cooldown -- Downgrading to Swipe.***')
            eventArgs.cancel = true
            return
        end
    end
    if spell.english == 'Valiance' then
        local abil_recasts = windower.ffxi.get_ability_recasts()
        if abil_recasts[spell.recast_id] > 0 then
            send_command('input /jobability "Vallation" <me>')
            eventArgs.cancel = true
            return
        elseif spell.english == 'Valiance' and buffactive['vallation'] then
            cast_delay(0.2)
            send_command('cancel Vallation') -- command requires 'cancel' add-on to work
        end
    end
    if spellMap == 'Utsusemi' then
        if buffactive['Copy Image (3)'] or buffactive['Copy Image (4+)'] then
            cancel_spell()
            add_to_chat(123, '**!! '..spell.english..' Canceled: [3+ IMAGES] !!**')
            eventArgs.handled = true
            return
        elseif buffactive['Copy Image'] or buffactive['Copy Image (2)'] then
            send_command('cancel 66; cancel 444; cancel Copy Image; cancel Copy Image (2)')
        end
    end
end
function job_post_precast(spell, action, spellMap, eventArgs)
    if spell.english == 'Vivacious Pulse' then
        if buffactive['poison'] or buffactive['paralysis'] or buffactive['blindness'] or buffactive['silence']
        or buffactive['curse'] or buffactive['bane'] or buffactive['doom'] or buffactive['disease'] or buffactive['plague'] then
             equip(sets.precast.JA['Vivacious Pulse'].Status)
        end
    end
end
function job_midcast(spell, action, spellMap, eventArgs)
    if state.DefenseMode.value ~= 'None' and spell.english ~=  "Phalanx" then
        eventArgs.handled = true
        if spell.action_type == 'Magic' then
            if spell.english == 'Flash' or spell.english == 'Foil' or spell.english == 'Stun'
                or blue_magic_maps.Enmity:contains(spell.english) then
                equip(sets.Enmity.DT)
            elseif spell.skill == 'Enhancing Magic' then
                equip(sets.midcast.EnhancingDuration)
            end
        end
    end
end

-- Run after the default midcast() is done.
-- eventArgs is the same one used in job_midcast, in case information needs to be persisted.
function job_post_midcast(spell, action, spellMap, eventArgs)
    if spell.english == 'Lunge' or spell.english == 'Swipe' then
        if (spell.element == world.day_element or spell.element == world.weather_element) then
            equip(sets.Obi)
        end
    end
	--[[
    if state.DefenseMode.value == 'None' then
        if spell.skill == 'Enhancing Magic' and classes.NoSkillSpells:contains(spell.english) then
            equip(sets.midcast.EnhancingDuration)
            if spellMap == 'Refresh' then
                equip(sets.midcast.Refresh)
            end
        end
	]]--	
    if spell.english == 'Phalanx' and buffactive['Embolden'] then
        equip(sets.midcast.EnhancingDuration)
    end
end

function job_aftercast(spell, action, spellMap, eventArgs)
    equip(sets[state.WeaponSet.current])

    if spell.name == 'Rayke' and not spell.interrupted then
        send_command('@timers c "Rayke ['..spell.target.name..']" '..rayke_duration..' down spells/00136.png')
        send_command('wait '..rayke_duration..';input /echo [Rayke just wore off!];')
    elseif spell.name == 'Gambit' and not spell.interrupted then
        send_command('@timers c "Gambit ['..spell.target.name..']" '..gambit_duration..' down spells/00136.png')
        send_command('wait '..gambit_duration..';input /echo [Gambit just wore off!];')
    end
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for non-casting events.
-------------------------------------------------------------------------------------------------------------------

-- Called when the player's status changes.
function job_state_change(field, new_value, old_value)
    classes.CustomDefenseGroups:clear()
    classes.CustomMeleeGroups:clear()
end

function job_buff_change(buff,gain)

    if buff == "terror" then
        if gain then
            equip(sets.defense.PDT)
        end
    end

    if buff == "doom" then
        if gain then
            equip(sets.buff.Doom)
            send_command('@input /p Doomed.')
             disable('ring1','ring2','waist','neck')
        else
            enable('ring1','ring2','waist','neck')
            handle_equipping_gear(player.status)
        end
    end

    if buff == 'Embolden' then
        if gain then
            equip(sets.Embolden)
            disable('head','legs','hands','back')
        else
            enable('head','legs','hands','back')
            status_change(player.status)
        end
    end

    if buff:startswith('Aftermath') then
        state.Buff.Aftermath = gain
        customize_melee_set()
        handle_equipping_gear(player.status)
    end
--[[
    if buff == 'Battuta' and not gain then
        status_change(player.status)
    end
]]--
end

-- Handle notifications of general user state change.
function job_state_change(stateField, newValue, oldValue)
    if state.WeaponLock.value == true then
        disable('main','sub')
    else
        enable('main','sub')
    end

    equip(sets[state.WeaponSet.current])

end

-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------

function job_handle_equipping_gear(playerStatus, eventArgs)
    check_gear()
end

function job_update(cmdParams, eventArgs)
    equip(sets[state.WeaponSet.current])
    handle_equipping_gear(player.status)
end

-- Modify the default idle set after it was constructed.
function customize_idle_set(idleSet)

    return idleSet
end

-- Modify the default melee set after it was constructed.
function customize_melee_set(meleeSet)
    if buffactive['Aftermath: Lv.3'] and player.equipment.main == "Epeolatry"
        and state.DefenseMode.value == 'None' then
        if state.HybridMode.value == "DT" then
            meleeSet = set_combine(meleeSet, sets.engaged.Aftermath.DT)
        elseif state.HybridMode.value == "HybridDT" then
			meleeSet = set_combine(meleeSet, sets.engaged.Aftermath.HybridDT)
        else
			meleeSet = set_combine(meleeSet, sets.engaged.Aftermath)
        end
    end

    return meleeSet
end

function customize_defense_set(defenseSet)
--[[
    if buffactive['Battuta'] then
        defenseSet = set_combine(defenseSet, sets.defense.Parry)
    end
]]--
    return defenseSet
end

-- Function to display the current relevant user state when doing an update.
-- Set eventArgs.handled to true if display was handled, and you don't want the default info shown.
function display_current_job_state(eventArgs)
    local r_msg = state.Runes.current
    local r_color = ''
    if state.Runes.current == 'Ignis' then r_color = 167
    elseif state.Runes.current == 'Gelus' then r_color = 210
    elseif state.Runes.current == 'Flabra' then r_color = 204
    elseif state.Runes.current == 'Tellus' then r_color = 050
    elseif state.Runes.current == 'Sulpor' then r_color = 215
    elseif state.Runes.current == 'Unda' then r_color = 207
    elseif state.Runes.current == 'Lux' then r_color = 001
    elseif state.Runes.current == 'Tenebrae' then r_color = 160 end

    local cf_msg = ''
    if state.CombatForm.has_value then
        cf_msg = ' (' ..state.CombatForm.value.. ')'
    end

    local m_msg = state.OffenseMode.value
    if state.HybridMode.value ~=  'Normal' then
        m_msg = m_msg .. '/' ..state.HybridMode.value
    end

    local am_msg = '(' ..string.sub(state.AttackMode.value,1,1).. ')'

    local ws_msg = state.WeaponskillMode.value

    local d_msg = 'None'
    if state.DefenseMode.value ~=  'None' then
        d_msg = state.DefenseMode.value .. state[state.DefenseMode.value .. 'DefenseMode'].value
    end

    local i_msg = state.IdleMode.value

    local msg = ''
    if state.Knockback.value == true then
        msg = msg .. ' Knockback Resist |'
    end
    if state.Kiting.value then
        msg = msg .. ' Kiting: On |'
    end

    add_to_chat(r_color, string.char(129,121).. '  ' ..string.upper(r_msg).. '  ' ..string.char(129,122)
        ..string.char(31,210).. ' Melee' ..cf_msg.. ': ' ..string.char(31,001)..m_msg.. string.char(31,002).. ' |'
        ..string.char(31,207).. ' WS' ..am_msg.. ': ' ..string.char(31,001)..ws_msg.. string.char(31,002)..  ' |'
        ..string.char(31,060)
        ..string.char(31,004).. ' Defense: ' ..string.char(31,001)..d_msg.. string.char(31,002).. ' |'
        ..string.char(31,008).. ' Idle: ' ..string.char(31,001)..i_msg.. string.char(31,002).. ' |'
        ..string.char(31,002)..msg)

    eventArgs.handled = true
end

-------------------------------------------------------------------------------------------------------------------
-- General hooks for other events.
-------------------------------------------------------------------------------------------------------------------
function job_get_spell_map(spell, default_spell_map)
    if spell.skill == 'Blue Magic' then
        for category,spell_list in pairs(blue_magic_maps) do
            if spell_list:contains(spell.english) then
                return category
            end
        end
    end
end

-------------------------------------------------------------------------------------------------------------------
-- User code that supplements self-commands.
-------------------------------------------------------------------------------------------------------------------

function get_custom_wsmode(spell, action, spellMap)
    if spell.type == 'WeaponSkill' then
        if state.AttackMode.value == 'Capped' and state.DefenseMode.value == 'None' and state.HybridMode.value == 'Normal' then
            return "Capped"
        elseif state.DefenseMode.value ~=  'None' then
            return "Safe"
        end
    end
end

-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

function job_self_command(cmdParams, eventArgs)
   -- gearinfo(cmdParams, eventArgs)
    if cmdParams[1]:lower() == 'rune' then
        send_command('@input /ja '..state.Runes.value..' <me>')
    end
	if cmdParams[1] == 'ambu' then
		send_command('input //gs c rune; wait 1; input /ma "Crusade" <me>; wait 4; input //gs c rune; wait 1;' ..
		'input /ma "Phalanx" <me>; wait 4; input //gs c rune; wait 1; input /ma "Aquaveil" <me>; wait 6;' ..
		'input /ja "Swordplay" <me>; wait 1; input /ma "Shock Spikes" <me>; wait 4; input /ma "Temper" <me>')
		add_to_chat(158, 'casting ambu entry buffs')
	end
	if cmdParams[1] == 'warp' then
		send_command('input /equip ring1 "Warp ring"; wait 12; input /item "Warp ring" <me>')
        add_to_chat(158,'warp ring')
	elseif cmdParams[1] == 'dem' then
		send_command('input /equip ring2 "Dimensional ring (Dem)"; wait 12; input /item "Dimensional ring (Dem)" <me>')
        add_to_chat(158,'dem ring')
	end
end

function check_gear()
    if no_swap_gear:contains(player.equipment.left_ring) then
        disable("ring1")
    else
        enable("ring1")
    end
    if no_swap_gear:contains(player.equipment.right_ring) then
        disable("ring2")
    else
        enable("ring2")
    end
end

windower.register_event('zone change',
    function()
        if no_swap_gear:contains(player.equipment.left_ring) then
            enable("ring1")
            equip(sets.idle)
        end
        if no_swap_gear:contains(player.equipment.right_ring) then
            enable("ring2")
            equip(sets.idle)
        end
    end
)

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
     -- Default macro set/book: (set, book)
     if player.sub_job == 'BLU' then
          set_macro_page(1, 3)
     elseif player.sub_job == 'DRK' then
          set_macro_page(2, 3)
     elseif player.sub_job == 'WAR' then
          set_macro_page(3, 3)
     else
          set_macro_page(4, 3)
     end
end

function set_lockstyle()
     send_command('wait 4; input /lockstyleset 20')
end