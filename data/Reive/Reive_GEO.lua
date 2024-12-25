
-------------------------------------------------------------------------------------------------------------------
-- Setup functions for this job.  Generally should not be modified.
-------------------------------------------------------------------------------------------------------------------
--[[
ChangeNotes 4/13/22

Added Weaponsets
Added Melee Sets
Debugging 


]]--

-- Initialization function for this job file.
function get_sets()
    mote_include_version = 2

    -- Load and initialize the include file.
    include('Mote-Include.lua')
	include('organizer-lib')
	include('Mote-TreasureHunter')
end

-- Setup vars that are user-independent.  state.Buff vars initialized here will automatically be tracked.
function job_setup()
    geo_timer = ''
    indi_timer = ''
    indi_duration = 308
    entrust_timer = ''
    entrust_duration = 344
    entrust = 0
    newLuopan = 0

    state.Buff.Entrust = buffactive.Entrust or false
    state.Buff['Blaze of Glory'] = buffactive['Blaze of Glory'] or false
	
    -- state.CP = M(false, "Capacity Points Mode")

    state.Auto = M(true, 'Auto Nuke')
    state.Element = M{['description']='Element','Fire','Blizzard','Aero','Stone','Thunder','Water'}
	
	elemental_debuff = S{'Burn','Choke','Frost','Drown','Rasp','Shock'}
	
    degrade_array = {
        ['Fire'] = {'Fire','Fire II','Fire III','Fire IV','Fire V'},
        ['Ice'] = {'Blizzard','Blizzard II','Blizzard III','Blizzard IV','Blizzard V'},
        ['Wind'] = {'Aero','Aero II','Aero III','Aero IV','Aero V'},
        ['Earth'] = {'Stone','Stone II','Stone III','Stone IV','Stone V'},
        ['Lightning'] = {'Thunder','Thunder II','Thunder III','Thunder IV','Thunder V'},
        ['Water'] = {'Water', 'Water II','Water III', 'Water IV','Water V'},
        ['Aspirs'] = {'Aspir','Aspir II','Aspir III'},
        }

    lockstyleset = 18

end

-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
    state.OffenseMode:options('Normal', 'DW')
    state.CastingMode:options('Normal', 'Resistant')
    state.IdleMode:options('Normal', 'R')

    state.WeaponLock = M(false, 'Weapon Lock')
    state.MagicBurst = M(false, 'Magic Burst')

	state.WeaponSet = M{['description']='Weapon Set', 'Idris', 'Xoanon',  'Dagger', 'Daybreak', 'Maxentius'}
	
    -- Additional local binds

    send_command('bind f8 gs c toggle MagicBurst')
	send_command('bind ^insert gs c cycle WeaponSet')
    send_command('bind ^delete gs c cycleback WeaponSet')
    send_command('bind ^home gs c cycleback Element')
    send_command('bind ^end gs c cycle Element')

    send_command('bind ^w gs c toggle WeaponLock')

    select_default_macro_book()
    set_lockstyle()
	
	--
end

function user_unload()
    send_command('unbind f8')
    send_command('unbind ^insert')
    send_command('unbind ^delete')
    send_command('unbind @w')
    
end


-- Define sets and vars used by this job file.
function init_gear_sets()
	Gada={}
	Gada.Indi = { name="Gada", augments={'Indi. eff. dur. +10','STR+5','Mag. Acc.+13',}}
	Gada.Enh = { name="Gada", augments={'Enh. Mag. eff. dur. +6','MND+2','Mag. Acc.+20',}}
	
	Nantosuelta ={}
	Nantosuelta.PetDT={ name="Nantosuelta's Cape", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','Pet: "Regen"+10','Damage taken-5%',}}
	Nantosuelta.PetHybrid={ name="Nantosuelta's Cape", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','Pet: "Regen"+10','Damage taken-5%',}}
    Nantosuelta.PetRegen={ name="Nantosuelta's Cape", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','Pet: "Regen"+10','Pet: "Regen"+5',}}
    
    Nantosuelta.FC={ name="Nantosuelta's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','Mag. Acc.+10','"Fast Cast"+10','Spell interruption rate down-10%',}}
    Nantosuelta.MAB={ name="Nantosuelta's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','INT+10','"Mag.Atk.Bns."+10',}}
    Nantosuelta.Cure={ name="Nantosuelta's Cape", augments={'MND+20','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','"Cure" potency +10%','Phys. dmg. taken-10%',}}
    Nantosuelta.DW={ name="Nantosuelta's Cape", augments={'DEX+20','Accuracy+20 Attack+20','"Dual Wield"+10','Pet: "Regen"+5',}}
    Nantosuelta.DA={ name="Nantosuelta's Cape", augments={'DEX+20','Accuracy+20 Attack+20','"Dbl.Atk."+10','Pet: "Regen"+5',}}
	Nantosuelta.WSD={ name="Nantosuelta's Cape", augments={'MND+20','Accuracy+20 Attack+20','MND+10','Weapon skill damage +10%','Damage taken-5%',}}
	
    ------------------------------------------------------------------------------------------------
    ----------------------------------------- Precast Sets -----------------------------------------
    ------------------------------------------------------------------------------------------------

    -- Precast sets to enhance JAs
    sets.precast.JA.Bolster = { body = "Bagua Tunic +3" }
    sets.precast.JA['Life Cycle'] = {head="Bagua Galero +3", body = "Geomancy Tunic +3", back=Nantosuelta.Pet}
	sets.precast.JA['Radial Arcana'] = { head = "Bagua Galero +3", feet = "Bagua Sandals +3" }
	sets.precast.JA['Full Circle'] = { head = "Azimuth Hood +1" }

    -- Fast cast sets for spells

    sets.precast.FC = {
		range="Dunna",
		head="Amalric Coif +1", 
		body="Zendik Robe",
		hands="Agwu's Gages",
		legs="Geomancy Pants +3",
		feet="Amalric Nails +1",
		neck="Bagua Charm +2",
		waist="Shinjutsu-no-Obi +1",
		left_ear="Malignance Earring",
		right_ear="Etiolation Earring",
		left_ring="Defending Ring",
		right_ring="Kishar Ring",
		back="Fi Follet Cape +1",
        }

    sets.precast.FC['Enhancing Magic'] = set_combine(sets.precast.FC, {})
    sets.precast.FC['Elemental Magic'] = set_combine(sets.precast.FC, {ammo="Ghastly Tathlum +1"})

    sets.precast.FC.Cure = set_combine(sets.precast.FC, {})

    sets.precast.FC.Curaga = sets.precast.FC.Cure
    sets.precast.FC.Impact = set_combine(sets.precast.FC, {head=empty, body="Crepuscular Cloak", waist="Shinjutsu-no-Obi +1",})
    sets.precast.FC.Dispelga = set_combine(sets.precast.FC, {main="Daybreak", sub="Ammurapi Shield", waist="Shinjutsu-no-Obi +1",})

    -- Weaponskill sets
    -- Default set for any weaponskill that isn't any more specifically defined
    
	sets.precast.WS = {
		ammo="Crepuscular Pebble",
		head="Nyame Helm",
		body="Nyame Mail",
		hands="Nyame Gauntlets",
		legs="Nyame Flanchard", 
		feet="Nyame Sollerets",
		neck="Rep. Plat. Medal",
		waist="Grunfeld Rope",
		left_ear="Moonshade Earring",
		right_ear="Regal Earring",
		left_ring="Epaminondas's Ring",
		right_ring="Metamor. Ring +1",
		back={ name="Nantosuelta's Cape", augments={'MND+20','Accuracy+20 Attack+20','MND+10','Weapon skill damage +10%','Damage taken-5%',}},
		}
	
	-----------------------------------
	-------------- Clubs --------------
	-----------------------------------
	
    sets.precast.WS['Flash Nova'] = set_combine(sets.precast.WS, {
		ammo="Sroda Tathlum",
		hands="Jhakri Cuffs +2",
		neck="Sibyl Scarf",
		waist="Orpheus's Sash",
		right_ear="Regal Earring",
		right_ring="Freke Ring",
		})
	
	sets.precast.WS['Exudation'] = set_combine(sets.precast.WS, {})
	
	sets.precast.WS['Hexa Strike'] = set_combine(sets.precast.WS, {})
	
	sets.precast.WS['Realmrazer'] = set_combine(sets.precast.WS, {})
	
	sets.precast.WS['Black Halo'] = set_combine(sets.precast.WS, {})
	
	-----------------------------------
	-------------- Staff --------------
	-----------------------------------
	
	sets.precast.WS['Retribution'] = set_combine(sets.precast.WS, {})
	
	sets.precast.WS['Cataclysm'] = set_combine(sets.precast.WS['Flash Nova'], {
		head="Pixie Hairpin +1",
		left_ring="Archon Ring",
		})
	
	sets.precast.WS['Shell Crusher'] = set_combine(sets.precast.WS, {})
	
	sets.precast.WS['Aeolian Edge'] = sets.precast.WS['Flash Nova']

    ------------------------------------------------------------------------
    ----------------------------- Midcast Sets -----------------------------
    ------------------------------------------------------------------------

    -- Base fast recast for spells
    sets.midcast.FastRecast = set_combine(sets.precast.FC, {}) 
	
	--43 ConserveMP base
   sets.midcast.Geomancy = {
		main="Idris",
		sub="Genmei Shield",
		range="Dunna", 
		ammo=empty,
		head="Bagua Galero +3",
		body="Vedic Coat",
		hands="Azimuth Gloves +2",
		legs={ name="Vanya Slops", augments={'Healing magic skill +20','"Cure" spellcasting time -7%','Magic dmg. taken -3',}},
		feet="Azimuth Gaiters +2",
		neck="Bagua Charm +2",
		waist="Shinjutsu-no-Obi +1",
		left_ear="Magnetic Earring",
		right_ear="Calamitous Earring",
		left_ring="Defending Ring",
		right_ring="Mephitas's Ring +1",
		back={ name="Lifestream Cape", augments={'Geomancy Skill +10','Indi. eff. dur. +20','Pet: Damage taken -3%',}},
        }

    sets.midcast.Geomancy.Indi = set_combine(sets.midcast.Geomancy, {
		head={ name="Telchine Cap", augments={'Mag. Evasion+23','"Conserve MP"+5','Enh. Mag. eff. dur. +10',}},
		hands="Geo. Mitaines +3",
		legs="Bagua Pants +3",
		feet="Azimuth Gaiters +2",
		})

    sets.midcast.Cure = { 
		range="Dunna",
		ammo=empty,
		head="Vanya Hood", 
		body="Vanya Robe",
		hands="Vanya Cuffs", 
		legs="Vanya Slops", 
		feet="Vanya Clogs",
		neck="Bagua Charm +2",
		waist="Shinjutsu-no-Obi +1",
		left_ear="Mendi. Earring",
		right_ear="Meili Earring",
		left_ring={name="Stikini Ring +1", bag="wardrobe1"},
		right_ring="Mephitas's Ring +1", 
		back={ name="Nantosuelta's Cape", augments={'MND+20','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','"Cure" potency +10%','Phys. dmg. taken-10%',}},
        }

    sets.midcast.Curaga = set_combine(sets.midcast.Cure, {})

    sets.midcast.Cursna = set_combine(sets.midcast.Cure, {})

    sets.midcast['Enhancing Magic'] = {
		main={ name="Gada", augments={'Enh. Mag. eff. dur. +6','MND+2','Mag. Acc.+20',}},
        sub="Ammurapi Shield",
		ranged="Dunna",
		head={ name="Telchine Cap", augments={'Mag. Evasion+23','"Conserve MP"+5','Enh. Mag. eff. dur. +10',}},
		body={ name="Telchine Chas.", augments={'Mag. Evasion+23','"Conserve MP"+4','Enh. Mag. eff. dur. +10',}},
		hands={ name="Telchine Gloves", augments={'Mag. Evasion+23','"Conserve MP"+5','Enh. Mag. eff. dur. +10',}},
		legs={ name="Telchine Braconi", augments={'Mag. Evasion+19','"Conserve MP"+5','Enh. Mag. eff. dur. +10',}},
		feet={ name="Telchine Pigaches", augments={'Mag. Evasion+25','Song spellcasting time -7%','Enh. Mag. eff. dur. +10',}},
        neck="Incanter's Torque",
        waist="Embla Sash",
		ear1="Mimir Earring",
        ear2="Andoaa Earring",
        ring1={name="Stikini Ring +1", bag="wardrobe3"},
        ring2={name="Stikini Ring +1", bag="wardrobe4"},
        }

    sets.midcast.EnhancingDuration = set_combine(sets.midcast['Enhancing Magic'], {neck="Bagua Charm +2",})

    sets.midcast.Regen = set_combine(sets.midcast.EnhancingDuration, {main="Bolelabunga", sub="Ammurapi Shield"})

    sets.midcast.Refresh = set_combine(sets.midcast.EnhancingDuration, {head="Amalric Coif +1", waist="Gishdubar Sash",})

    sets.midcast.Stoneskin = set_combine(sets.midcast.EnhancingDuration, {})
    sets.midcast.Aquaveil = set_combine(sets.midcast.EnhancingDuration, {head="Amalric Coif +1",})

    sets.midcast.Protect = set_combine(sets.midcast.EnhancingDuration, {})
    sets.midcast.Protectra = sets.midcast.Protect
    sets.midcast.Shell = sets.midcast.Protect
    sets.midcast.Shellra = sets.midcast.Protect
	

    sets.midcast.MndEnfeebles = {
		main="Contemplator +1",
		sub="Enki Strap",
		range="Dunna",
		head=empty,
		body="Cohort Cloak +1",
		hands="Geo. Mitaines +3",
		legs="Geomancy Pants +3",
		feet="Geo. Sandals +3",
		neck="Bagua Charm +2",
		waist="Luminary Sash",
		left_ear="Malignance Earring",
		right_ear="Regal Earring",
		left_ring={name="Stikini Ring +1", bag="wardrobe1"},
		right_ring="Metamor. Ring +1",
		back="Aurist's Cape +1", 
        } 
	
	--High MagicAcc
	sets.midcast.ElementalDebuffs = {
		main="Idris",
		sub="Ammurapi Shield",
		range="Dunna", 
		head="Geo. Galero +3",
		body="Geomancy Tunic +3",
		hands="Geo. Mitaines +3",
		legs="Agwu's Slops",
		feet="Geo. Sandals +3",
		neck="Bagua Charm +2",
		waist="Acuity Belt +1",
		left_ear="Malignance Earring",
		right_ear="Regal Earring",
		left_ring={name="Stikini Ring +1", bag="wardrobe1"},
		right_ring={name="Stikini Ring +1", bag="wardrobe2"},
		back="Aurist's Cape +1",
		}
		
	--Only enfeeble with dINT 
	sets.midcast['Blind'] = set_combine(sets.midcast.MndEnfeebles, {
		main="Bunzi's Rod",
		waist="Acuity Belt +1",
		right_ring="Kishar Ring",
		})
	
	--Macc
	sets.midcast.IntEnfeebles = set_combine(sets.midcast.MndEnfeebles, {main="Bunzi's Rod", sub="Ammurapi Shield",})
	
    sets.midcast.Dispelga = set_combine(sets.midcast.IntEnfeebles, {main="Daybreak", sub="Ammurapi Shield", waist="Shinjutsu-no-Obi +1",})

    sets.midcast['Dark Magic'] = {    
		main="Rubicundity", 
		sub="Ammurapi Shield",
		range="Dunna",
		head="Bagua Galero +3",
		body="Geomancy Tunic +3",
		hands="Geo. Mitaines +3",
		legs="Geomancy Pants +3",
		feet="Geo. Sandals +3",
		neck="Erra Pendant",
		waist="Sacro Cord",
		left_ear="Malignance Earring",
		right_ear="Regal Earring",
		left_ring={name="Stikini Ring +1", bag="wardrobe1"},
		right_ring="Evanescence Ring",
		back="Aurist's Cape +1",
		}

    sets.midcast.Drain = set_combine(sets.midcast['Dark Magic'] ,{
	    head="Bagua Galero +3",
		body={ name="Merlinic Jubbah", augments={'Mag. Acc.+29','"Drain" and "Aspir" potency +10','MND+5',}},
		hands={ name="Merlinic Dastanas", augments={'Mag. Acc.+29','"Drain" and "Aspir" potency +10','"Mag.Atk.Bns."+15',}},
		legs={ name="Merlinic Shalwar", augments={'Accuracy+25','"Drain" and "Aspir" potency +10','INT+3','Mag. Acc.+14','"Mag.Atk.Bns."+13',}},
		feet="Agwu's Pigaches",
		neck="Erra Pendant",
		waist="Fucho-no-Obi",
		left_ring="Archon Ring",
		})

    sets.midcast.Aspir = sets.midcast.Drain

    sets.midcast.Stun = {
		main="Mpaca's Staff",
		sub="Khonsu",
		range="Dunna",	
		head="Amalric Coif +1",
		body="Zendik Robe",
		hands="Agwu's Gages",
		legs="Geomancy Pants +3",
		feet="Volte Gaiters",
		neck="Bagua Charm +2",
		waist="Witful Belt",
		left_ear="Malignance Earring",
		right_ear="Regal Earring",
		left_ring={name="Stikini Ring +1", bag="wardrobe1"},
		right_ring="Kishar Ring",
		back={ name="Nantosuelta's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','Mag. Acc.+10','"Fast Cast"+10','Spell interruption rate down-10%',}},
		} 
	
    -- Elemental Magic sets

    sets.midcast['Elemental Magic'] = {
		main="Bunzi's Rod",
		sub="Ammurapi Shield",
		ammo="Sroda Tathlum",
		head="Bagua Galero +3",
		body="Amalric Doublet +1",
		hands="Amalric Gages +1",
		legs="Amalric Slops +1",
		feet="Amalric Nails +1", 
		neck="Sibyl Scarf",
		waist="Acuity Belt +1",
		left_ear="Malignance Earring",
		right_ear="Regal Earring",
		left_ring="Freke Ring",
		right_ring="Metamor. Ring +1", 
		back={ name="Nantosuelta's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','INT+10','"Mag.Atk.Bns."+10',}},
        }

    sets.midcast['Elemental Magic'].Resistant = set_combine(sets.midcast['Elemental Magic'], {
		legs="Bagua Pants +3",
		feet="Bagua Sandals +3",
		})

    sets.midcast.GeoElem = set_combine(sets.midcast['Elemental Magic'], {})

    sets.midcast.Impact = {
		main="Bunzi's Rod",
		sub="Ammurapi Shield",
		range="Dunna", 
		head=empty,
		body="Crepuscular Cloak",
		hands="Geo. Mitaines +3",
		legs="Geomancy Pants +3",
		feet="Geo. Sandals +3",
		neck="Bagua Charm +2",
		waist="Acuity Belt +1",
		left_ear="Malignance Earring",
		right_ear="Regal Earring",
		left_ring="Metamor. Ring +1", 
		right_ring={name="Stikini Ring +1", bag="wardrobe4"},
		back={ name="Aurist's Cape +1", augments={'Path: A',}},
        }

    -- Initializes trusts at iLvl 119
    sets.midcast.Trust = sets.precast.FC

    ------------------------------------------------------------------------------------------------
    ------------------------------------------ Idle Sets -------------------------------------------
    ------------------------------------------------------------------------------------------------
	
	--DT Focused
    sets.idle = {
		range="Dunna",
		ammo=empty,
		head="Nyame Helm",
		body="Shamash Robe",
		hands="Nyame Gauntlets",
		legs="Nyame Flanchard",
		feet="Nyame Sollerets",
		neck="Loricate Torque +1",
		waist="Carrier's Sash",
		left_ear="Lugalbanda Earring",
		right_ear="Etiolation Earring",
		left_ring={name="Stikini Ring +1", bag="wardrobe3"},
		right_ring="Shneddick Ring +1",
		back=Nantosuelta.PetHybrid,
        }
	
	--Refresh
	sets.idle.R = set_combine(sets.idle, {})
	
	--Pointless
	sets.idle.Hybrid = set_combine(sets.idle, {})

	
    -- Pet sets are for when Luopan is present.
	-- 38% Pet DT Needed
	
	--Master Focused
    sets.idle.Pet = {
		range="Dunna",
		ammo=empty,
		head="Azimuth Hood +2",
		body="Shamash Robe",
		hands="Nyame Gauntlets",
		legs="Nyame Flanchard",
		feet="Bagua Sandals +3",
		neck="Bagua Charm +2",
		waist="Carrier's Sash",
		left_ear="Hypaspist Earring",
		right_ear="Etiolation Earring",
		left_ring="Defending Ring",
		right_ring="Shneddick Ring +1",
		back=Nantosuelta.PetRegen,
        } 
		
	--Regen Focused Weak Master
	sets.idle.R.Pet = set_combine(sets.idle.Pet, {    
		head={ name="Merlinic Hood", augments={'CHR+8','Pet: "Regen"+4','"Refresh"+2',}},
		body="Shamash Robe",
		hands={ name="Telchine Gloves", augments={'Mag. Evasion+25','Pet: "Regen"+3','Pet: Damage taken -4%',}},
		legs={ name="Telchine Braconi", augments={'Mag. Evasion+25','Pet: "Regen"+3','Pet: Damage taken -4%',}},
		feet="Bagua Sandals +3",
		waist="Isa Belt",
		left_ear="Lugalbanda Earring",
		back=Nantosuelta.PetRegen
	})
	
	--Pet Regen/DT + Master
	sets.idle.Hybrid.Pet = set_combine(sets.idle.Pet, {
		right_ring="Purity Ring",
	})

    sets.PetHP = {head="Bagua Galero +3"}

    -- .Indi sets are for when an Indi-spell is active.
    --sets.idle.Indi = set_combine(sets.idle, {})
    --sets.idle.Pet.Indi = set_combine(sets.idle.Pet, {})
    --sets.idle.DT.Indi = set_combine(sets.idle.DT, {})
    --sets.idle.DT.Pet.Indi = set_combine(sets.idle.DT.Pet, {})
	
    -- Defense sets

    sets.defense.PDT = sets.idle.DT
    sets.defense.MDT = sets.idle.DT

    sets.Kiting = {}

    sets.latent_refresh = {}

    --------------------------------------
    -- Engaged sets
    --------------------------------------

    sets.engaged = {
	    range="Dunna",
		head={ name="Nyame Helm", augments={'Path: B',}},
		body={ name="Nyame Mail", augments={'Path: B',}},
		hands={ name="Nyame Gauntlets", augments={'Path: B',}},
		legs={ name="Nyame Flanchard", augments={'Path: B',}},
		feet={ name="Nyame Sollerets", augments={'Path: B',}},
		neck={ name="Bagua Charm +2", augments={'Path: A',}},
		waist="Cetl Belt",
		left_ear="Telos Earring",
		right_ear="Crep. Earring",
		left_ring="Chirich Ring +1",
		right_ring="Defending Ring",
		back={ name="Nantosuelta's Cape", augments={'DEX+20','Accuracy+20 Attack+20','"Dbl.Atk."+10','Pet: "Regen"+5',}},
	}
	
	sets.engaged.DW = set_combine(sets.engaged, {
		back={ name="Nantosuelta's Cape", augments={'DEX+20','Accuracy+20 Attack+20','"Dual Wield"+10','Pet: "Regen"+5',}},
	})

	
	sets.Idris = {main="Idris", sub="Genmei Shield",}
	sets.Idris.DW = {main="Idris", sub="Ternion Dagger +1",}
	sets.Xoanon = {main="Xoanon", sub="Khonsu",}
	sets.Xoanon.DW = {main="Xoanon", sub="Khonsu",}
	sets.Dagger = {main="Malevolence",  sub="Ammurapi Shield",}
	sets.Dagger.DW = {main="Malevolence",  sub="Bunzi's Rod",}
	sets.Daybreak = {main="Daybreak", sub="Ammurapi Shield",}
	sets.Daybreak.DW = {main="Daybreak", sub="Bunzi's Rod",}
	sets.Maxentius = {main="Maxentius", sub="Ammurapi Shield",}
	sets.Maxentius.DW = {main="Maxentius", sub="Ternion Dagger +1",}
	
    --------------------------------------
    -- Custom buff sets
    --------------------------------------
	-- /blm gives +5 mbd
	
    sets.magic_burst = {
		main={ name="Bunzi's Rod", augments={'Path: A',}},
		sub="Ammurapi Shield",
		ammo={ name="Ghastly Tathlum +1", augments={'Path: A',}},
		head={ name="Bagua Galero +3", augments={'Enhances "Primeval Zeal" effect',}},
		body={ name="Amalric Doublet +1", augments={'MP+80','Mag. Acc.+20','"Mag.Atk.Bns."+20',}},
		hands={ name="Bagua Mitaines +3", augments={'Enhances "Curative Recantation" effect',}},
		legs={ name="Amalric Slops +1", augments={'MP+80','Mag. Acc.+20','"Mag.Atk.Bns."+20',}},
		feet={ name="Agwu's Pigaches", augments={'Path: A',}},
		neck="Mizu. Kubikazari",
		waist="Sacro Cord",
		left_ear="Malignance Earring",
		right_ear="Regal Earring",
		left_ring="Freke Ring",
		right_ring="Mujin Band",
		back={ name="Nantosuelta's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','INT+10','"Mag.Atk.Bns."+10',}},
		} 

	sets.magic_burst.Resistant = {}

    sets.buff.Doom = {		
		neck = "Nicander's Necklace", --20
		ring1 = "Purity Ring", --7
        ring2 = "Eshmun's Ring", --20
		waist = "Gishdubar Sash", --10
		}
		
    sets.Obi = {waist="Hachirin-no-Obi"}

	sets.Vagary = {
	    main="Idris",
		sub="Genmei Shield",
		range="Dunna", 
		head = "Amalric Coif +1",
		neck = "Bagua Charm +2",
        ear1 = "Malignance Earring",
        ear2 = "Loquac. Earring", 
		body = "Geomancy Tunic +3",
		hands = "Bagua Mitaines +3",
        ring1 = "Kishar Ring", 
		ring2 = "Metamor. Ring +1", 
        back = "Lifestream Cape", 
        waist = "Shinjutsu-no-Obi +1", 
        legs = "Geomancy Pants +3", 
		feet = "Geo. Sandals +3",
		}
	
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------

function job_pretarget(spell, spellMap, eventArgs)
    if spell.type == 'Geomancy' then
        if spell.name:startswith('Indi') and state.Buff.Entrust and spell.target.type == 'SELF' then
            add_to_chat(002, 'Entrust active - Select a party member!')
            cancel_spell()
        end
    end
end

function job_precast(spell, action, spellMap, eventArgs)
    if spell.name:startswith('Aspir') then
        refine_various_spells(spell, action, spellMap, eventArgs)
    elseif state.Auto.value == true then
        if spell.skill == 'Elemental Magic' and spell.english ~= 'Impact' and spellMap ~= 'GeoNuke' then
            refine_various_spells(spell, action, spellMap, eventArgs)
        end
    end
end

function job_post_precast(spell, action, spellMap, eventArgs)
    if spell.name == 'Impact' then
        equip(sets.precast.FC.Impact)
    end
end

function job_post_midcast(spell, action, spellMap, eventArgs)
    if spell.skill == 'Elemental Magic' then
        if state.MagicBurst.value then
			if state.CastingMode.value == "Resistant" then
                equip(sets.magic_burst.Resistant)
			else
				equip(sets.magic_burst)
            end         

            if spell.english == "Impact" then
                equip(sets.midcast.Impact)
            end
        end
        if (spell.element == world.day_element or spell.element == world.weather_element) then
            equip(sets.Obi)
        end
    elseif spell.skill == 'Enhancing Magic' and classes.NoSkillSpells:contains(spell.english) then
        equip(sets.midcast.EnhancingDuration)
        if spellMap == 'Refresh' then
            equip(sets.midcast.Refresh)
        end
    elseif spell.skill == 'Geomancy' then
        if state.Buff.Entrust and spell.english:startswith('Indi-') then
            equip({main=Gada.Indi})
            entrust = 1
        end
    end
end

function job_aftercast(spell, action, spellMap, eventArgs)
    if not spell.interrupted then

        if spell.english == "Sleep II" then
            send_command('@timers c "Sleep II ['..spell.target.name..']" 90 down spells/00259.png')
        elseif spell.english == "Sleep" or spell.english == "Sleepga" then -- Sleep & Sleepga Countdown --
            send_command('@timers c "Sleep ['..spell.target.name..']" 60 down spells/00253.png')
        elseif spell.english:startswith('Geo-') or spell.english == "Life Cycle" then
            newLuopan = 1
        end
    end
	if state.WeaponLock.value == false then
        check_weaponset()
    end
end


-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for non-casting events.
-------------------------------------------------------------------------------------------------------------------

-- Called when a player gains or loses a buff.
-- buff == buff gained or lost
-- gain == true if the buff was gained, false if it was lost.
function job_buff_change(buff, gain)
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

end

-- Handle notifications of general user state change.
function job_state_change(stateField, newValue, oldValue)
    if state.WeaponLock.value == true then
        disable('main','sub','range')
    else
        enable('main','sub','range')
    end
	check_weaponset()
end

-- Called when a player gains or loses a pet.
-- pet == pet structure
-- gain == true if the pet was gained, false if it was lost.
function job_pet_change(petparam, gain)
    if gain == false then
        send_command('@timers d "'..geo_timer..'"')
    end
end

-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------

function job_handle_equipping_gear(playerStatus, eventArgs)
    
end

function job_update(cmdParams, eventArgs)
    handle_equipping_gear(player.status)
    classes.CustomIdleGroups:clear()
end

function job_get_spell_map(spell, default_spell_map)
    if spell.action_type == 'Magic' then
        if spell.skill == 'Enfeebling Magic' then
            if spell.type == 'WhiteMagic' then
                return 'MndEnfeebles'
            else
                return 'IntEnfeebles'
            end
        elseif spell.skill == 'Geomancy' then
            if spell.english:startswith('Indi') then
                return 'Indi'
            end
		elseif elemental_debuff:contains(spell.english) then
			return "ElementalDebuffs"
        elseif spell.skill == 'Elemental Magic' then
            if spellMap == 'GeoElem' then
                return 'GeoElem'
            end
        end
    end
end

function customize_idle_set(idleSet)
 --[[  
   if pet.isvalid then
        if pet.hpp > 73 then
            if newLuopan == 1 then
                equip(sets.PetHP)
                disable('head')
            end
			
        elseif pet.hpp <= 73 then
            enable('head')
            newLuopan = 0
        end
    end
]]--
    return idleSet
end

function check_weaponset()
    if state.OffenseMode.value == 'DW' then
        equip(sets[state.WeaponSet.current].DW)
    else
        equip(sets[state.WeaponSet.current])
    end
end

-- Function to display the current relevant user state when doing an update.
function display_current_job_state(eventArgs)
    local c_msg = state.CastingMode.value

    local d_msg = 'None'
    if state.DefenseMode.value ~= 'None' then
        d_msg = state.DefenseMode.value .. state[state.DefenseMode.value .. 'DefenseMode'].value
    end

    local i_msg = state.IdleMode.value

    local msg = ''
    if state.MagicBurst.value then
        msg = ' Burst: On |'
    end
    if state.Auto.value then
        msg = ' Auto: On |'
    end
    if state.Kiting.value then
        msg = msg .. ' Kiting: On |'
    end

    add_to_chat(060, '| Magic: ' ..string.char(31,001)..c_msg.. string.char(31,002)..  ' |'
        ..string.char(31,004).. ' Defense: ' ..string.char(31,001)..d_msg.. string.char(31,002)..  ' |'
        ..string.char(31,008).. ' Idle: ' ..string.char(31,001)..i_msg.. string.char(31,002)..  ' |'
        ..string.char(31,002)..msg)

    eventArgs.handled = true
end

function refine_various_spells(spell, action, spellMap, eventArgs)

    local newSpell = spell.english
    local spell_recasts = windower.ffxi.get_spell_recasts()
    local cancelling = 'All '..spell.english..' are on cooldown. Cancelling.'

    local spell_index

    if spell_recasts[spell.recast_id] > 0 then
        if spell.skill == 'Elemental Magic' and spellMap ~= 'GeoElem' then
            spell_index = table.find(degrade_array[spell.element],spell.name)
            if spell_index > 1 then
                newSpell = degrade_array[spell.element][spell_index - 1]
                send_command('@input /ma '..newSpell..' '..tostring(spell.target.raw))
                eventArgs.cancel = true
            end
        elseif spell.name:startswith('Aspir') then
            spell_index = table.find(degrade_array['Aspirs'],spell.name)
            if spell_index > 1 then
                newSpell = degrade_array['Aspirs'][spell_index - 1]
                send_command('@input /ma '..newSpell..' '..tostring(spell.target.raw))
                eventArgs.cancel = true
            end
        end
    end
end



-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

function job_self_command(cmdParams, eventArgs)
    if cmdParams[1] == 'nuke' and not midaction() then
        send_command('@input /ma "' .. state.Element.current .. ' V" <t>')
    end
	
	if cmdParams[1] == 'warp' then
		send_command('input /equip ring1 "Warp ring"; wait 12; input /item "Warp ring" <me>;')
        add_to_chat(158,'warp ring')
	elseif cmdParams[1] == 'dem' then
		send_command('input /equip ring2 "Dimensional ring (Dem)"; wait 12; input /item "Dimensional ring (Dem)" <me>')
        add_to_chat(158,'dem ring')
	end
   
end


-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    set_macro_page(1, 1)
end

function set_lockstyle()
    send_command('wait 2; input /lockstyleset ' .. lockstyleset)
end