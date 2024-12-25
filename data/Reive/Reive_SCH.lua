-- Original: Motenten / Modified: Arislan

-------------------------------------------------------------------------------------------------------------------
--  Keybinds
-------------------------------------------------------------------------------------------------------------------

--  Modes:      [ F10 ]             Emergency -PDT Mode
--              [ ALT+F10 ]         Toggle Kiting Mode
--              [ F11 ]             Emergency -MDT Mode
--              [ CTRL+F11 ]        Cycle Casting Modes
--              [ F12 ]             Update Current Gear / Report Current Status
--              [ CTRL+F12 ]        Cycle Idle Modes
--              [ ALT+F12 ]         Cancel Emergency -PDT/-MDT Mode
--              [ ALT+` ]           Toggle Magic Burst Mode
--              [ WIN+C ]           Toggle Capacity Points Mode
--              [ WIN+H ]           Cycle Helix Mode
--              [ WIN+R ]           Cycle Regen Mode
--              [ WIN+S ]           Toggle Storm Surge
--
--  Abilities:  [ CTRL+` ]          Immanence
--              [ CTRL+- ]          Light Arts/Addendum: White
--              [ CTRL+= ]          Dark Arts/Addendum: Black
--              [ CTRL+[ ]          Rapture/Ebullience
--              [ CTRL+] ]          Altruism/Focalization
--              [ CTRL+; ]          Celerity/Alacrity
--              [ ALT+[ ]           Accesion/Manifestation
--              [ ALT+] ]           Perpetuance
--              [ ALT+; ]           Penury/Parsimony
--
--  Weapons:    [ CTRL+W ]          Toggles Weapon Lock
--
--  WS:         [ CTRL+Numpad0 ]    Myrkr
--
--
--              (Global-Binds.lua contains additional non-job-related keybinds)


-------------------------------------------------------------------------------------------------------------------
-- Setup functions for this job.  Generally should not be modified.
-------------------------------------------------------------------------------------------------------------------

--              Addendum Commands:
--              Shorthand versions for each strategem type that uses the version appropriate for
--              the current Arts.
--                                          Light Arts                    Dark Arts
--                                          ----------                  ---------
--                gs c scholar light          Light Arts/Addendum
--              gs c scholar dark                                       Dark Arts/Addendum
--              gs c scholar cost           Penury                      Parsimony
--              gs c scholar speed          Celerity                    Alacrity
--              gs c scholar aoe            Accession                   Manifestation
--              gs c scholar power          Rapture                     Ebullience
--              gs c scholar duration       Perpetuance
--              gs c scholar accuracy       Altruism                    Focalization
--              gs c scholar enmity         Tranquility                 Equanimity
--              gs c scholar skillchain                                 Immanence
--              gs c scholar addendum       Addendum: White             Addendum: Black


-------------------------------------------------------------------------------------------------------------------
-- Setup functions for this job.  Generally should not be modified.
-------------------------------------------------------------------------------------------------------------------

-- Initialization function for this job file.
function get_sets()
    mote_include_version = 2

    -- Load and initialize the include file.
    include('Mote-Include.lua')
	include('organizer-lib')
end

-- Setup vars that are user-independent.  state.Buff vars initialized here will automatically be tracked.
function job_setup()
    info.addendumNukes = S{"Stone IV", "Water IV", "Aero IV", "Fire IV", "Blizzard IV", "Thunder IV",
        "Stone V", "Water V", "Aero V", "Fire V", "Blizzard V", "Thunder V"}

    state.Buff['Sublimation: Activated'] = buffactive['Sublimation: Activated'] or false
    state.HelixMode = M{['description']='Helix Mode', 'Potency', 'Duration'}
    state.RegenMode = M{['description']='Regen Mode', 'Potency', 'Duration'}
    state.CP = M(false, "Capacity Points Mode")
	state.BarElement = M{['description']='BarElement', 'Barfire', 'Barblizzard', 'Baraero', 'Barstone', 'Barthunder', 'Barwater'}
    state.BarStatus = M{['description']='BarStatus', 'Baramnesia', 'Barvirus', 'Barparalyze', 'Barsilence', 'Barpetrify', 'Barpoison', 'Barblind', 'Barsleep'}
	state.StormSpell =M{['description']='StormSpell', 'Firestorm II', 'Rainstorm II', 'Sandstorm II', 'Windstorm II', 'Hailstorm II', 'Thunderstorm II', 'Aurorastorm II', 'Voidstorm II'}
	
    update_active_strategems()

    degrade_array = {
        ['Aspirs'] = {'Aspir','Aspir II'}
        }

    lockstyleset = 4

end

-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
    state.OffenseMode:options('Normal', 'Acc')
    state.CastingMode:options('Normal', 'Seidr', 'Resistant')
    state.IdleMode:options('Normal', 'DT')

    state.WeaponLock = M(false, 'Weapon Lock')
    state.MagicBurst = M(false, 'Magic Burst')
    state.StormSurge = M(false, 'Stormsurge')

	send_command('bind f8 gs c toggle MagicBurst')

--    send_command('bind @c gs c toggle CP')
    
	send_command('bind ^- gs c cycle HelixMode')
    send_command('bind ^= gs c cycle RegenMode')
    send_command('bind @s gs c toggle StormSurge')
    send_command('bind @w gs c toggle WeaponLock')
	
	
	send_command('bind ^ins gs c cycle StormSpell')
    send_command('bind ^del gs c cycleback StormSpell')
	send_command('bind ^home gs c cycle BarElement')
    send_command('bind ^end gs c cycleback BarElement')
    send_command('bind ^pageup gs c cycle BarStatus')
    send_command('bind ^pagedown gs c cycleback BarStatus')

    select_default_macro_book()
    set_lockstyle()
end

-- Called when this job file is unloaded (eg: job change)
function user_unload()
    send_command('unbind ^`')
    send_command('unbind !`')
    send_command('unbind ^-')
    send_command('unbind ^=')
    send_command('unbind ^[')
    send_command('unbind ^]')
    send_command('unbind ^;')
    send_command('unbind !w')
    send_command('unbind !o')
    send_command('unbind ![')
    send_command('unbind !]')
    send_command('unbind !;')
    send_command('unbind ^,')
    send_command('unbind !.')
    send_command('unbind @c')
    send_command('unbind @h')
    send_command('unbind @g')
    send_command('unbind @s')
    send_command('unbind @w')
end



-- Define sets and vars used by this job file.
function init_gear_sets()

    ------------------------------------------------------------------------------------------------
    ---------------------------------------- Precast Sets ------------------------------------------
    ------------------------------------------------------------------------------------------------

    -- Precast sets to enhance JAs
    sets.precast.JA['Tabula Rasa'] = {legs="Peda. Pants +3"}
    sets.precast.JA['Enlightenment'] = {body="Peda. Gown +3"}
    sets.precast.JA['Sublimation'] = {
        head = "Acad. Mortar. +2",
        body = "Peda. Gown +3",
		waist = "Embla Sash",
        }

    -- Fast cast sets for spells
    sets.precast.FC = {
    --  /RDM --15
		main="Musa", --10
		sub="Khonsu",
		ammo="Impatiens", --0/2
		head="Amalric Coif +1", --11
		body="Zendik Robe", --13
		hands="Agwu's Gages", --6
		legs="Agwu's Slops", --7
		feet="Amalric Nails +1", --6
		neck="Orunmila's Torque", --5
		waist="Witful Belt", --3/3
		left_ear="Malignance Earring", --4
		right_ear="Etiolation Earring", --1
		left_ring="Lebeche Ring", --0/2
		right_ring="Mephitas's Ring +1",
		back="Fi Follet Cape +1", --10
        } --76/10

    sets.precast.FC.Grimoire = {}
    sets.precast.FC['Enhancing Magic'] = set_combine(sets.precast.FC, {})
    sets.precast.FC['Elemental Magic'] = set_combine(sets.precast.FC, {})

    sets.precast.FC.Cure = set_combine(sets.precast.FC, {})

    sets.precast.FC.Curaga = sets.precast.FC.Cure
    sets.precast.FC.Impact = set_combine(sets.precast.FC, {head=empty, body="Crepuscular Cloak",})
    sets.precast.Storm = set_combine(sets.precast.FC, {})
	
	sets.precast["Dispelga"] = set_combine(sets.precast.FC, {
        main = "Daybreak",
        sub = "Ammurapi Shield"
    })

    ------------------------------------------------------------------------------------------------
    ------------------------------------- Weapon Skill Sets ----------------------------------------
    ------------------------------------------------------------------------------------------------

    sets.precast.WS = {}

    sets.precast.WS['Omniscience'] = set_combine(sets.precast.WS, {})


    sets.precast.WS['Myrkr'] = {
	    ammo={ name="Ghastly Tathlum +1", augments={'Path: A',}},
		head={ name="Amalric Coif +1", augments={'MP+80','Mag. Acc.+20','"Mag.Atk.Bns."+20',}},
		body={ name="Amalric Doublet +1", augments={'MP+80','Mag. Acc.+20','"Mag.Atk.Bns."+20',}},
		hands={ name="Kaykaus Cuffs +1", augments={'MP+80','MND+12','Mag. Acc.+20',}},
		legs={ name="Amalric Slops +1", augments={'MP+80','Mag. Acc.+20','"Mag.Atk.Bns."+20',}},
		feet={ name="Amalric Nails +1", augments={'MP+80','Mag. Acc.+20','"Mag.Atk.Bns."+20',}},
		neck="Orunmila's Torque",
		waist={ name="Shinjutsu-no-Obi +1", augments={'Path: A',}},
		left_ear="Mendi. Earring",
		right_ear="Etiolation Earring",
		left_ring={ name="Metamor. Ring +1", augments={'Path: A',}},
		right_ring={ name="Mephitas's Ring +1", augments={'Path: A',}},
		back={ name="Fi Follet Cape +1", augments={'Path: A',}},
	} -- Max MP


    ------------------------------------------------------------------------------------------------
    ---------------------------------------- Midcast Sets ------------------------------------------
    ------------------------------------------------------------------------------------------------

    sets.midcast.FastRecast = sets.precast.FC

    sets.midcast.Cure = {		
		main="Chatoyant Staff",
		sub="Khonsu",
		ammo="Homiliary",
		head={ name="Kaykaus Mitra +1", augments={'MP+80','"Cure" spellcasting time -7%','Enmity-6',}},
		body={ name="Kaykaus Bliaut", augments={'MP+60','"Cure" spellcasting time -5%','Enmity-5',}},
		hands={ name="Kaykaus Cuffs +1", augments={'MP+80','MND+12','Mag. Acc.+20',}},
		legs={ name="Vanya Slops", augments={'Healing magic skill +20','"Cure" spellcasting time -7%','Magic dmg. taken -3',}},
		feet={ name="Kaykaus Boots +1", augments={'MP+80','"Cure" spellcasting time -7%','Enmity-6',}},
		neck="Incanter's Torque",
		waist={ name="Shinjutsu-no-Obi +1", augments={'Path: A',}},
		left_ear="Meili Earring",
		right_ear="Mendi. Earring",
		left_ring="Menelaus's Ring",
		right_ring="Lebeche Ring",
		back="Moonlight Cape",
		}

    sets.midcast.CureWeather = set_combine(sets.midcast.Cure, {})

    sets.midcast.StatusRemoval = {}

    sets.midcast.Cursna = {    
		main="Musa",
		sub="Khonsu",
		ammo="Staunch Tathlum +1",
		head="Vanya Hood",
		body="Peda. Gown +3",
		hands="Peda. Bracers +3",
		legs="Acad. Pants +3",
		feet="Vanya Clogs",
		neck="Debilis Medallion",
		waist="Bishop's Sash",
		left_ear="Meili Earring",
		right_ear="Beatific Earring",
		left_ring="Menelaus's Ring",
		right_ring="Haoma's Ring",
		back="Oretan. Cape +1",
		}

	--needswork
    sets.midcast['Enhancing Magic'] = {
		main="Musa",
		sub="Khonsu",
		ammo="Staunch Tathlum +1",
		head={ name="Telchine Cap", augments={'Mag. Evasion+23','"Conserve MP"+5','Enh. Mag. eff. dur. +10',}},
		body={ name="Telchine Chas.", augments={'Mag. Evasion+23','"Conserve MP"+4','Enh. Mag. eff. dur. +10',}},
		hands={ name="Telchine Gloves", augments={'Mag. Evasion+23','"Conserve MP"+5','Enh. Mag. eff. dur. +10',}},
		legs="Shedir Seraweels",
		feet={ name="Telchine Pigaches", augments={'Mag. Evasion+25','Song spellcasting time -7%','Enh. Mag. eff. dur. +10',}},
		neck="Incanter's Torque",
		waist="Embla Sash",
		left_ear="Mimir Earring",
		right_ear="Andoaa Earring",
        right_ring={name="Stikini Ring +1", bag="wardrobe3"},
        left_ring={name="Stikini Ring +1", bag="wardrobe4"},
		back="Fi Follet Cape +1",
        }

    sets.midcast.EnhancingDuration = {
		main="Musa",
		sub="Khonsu",
		head={ name="Telchine Cap", augments={'Mag. Evasion+23','"Conserve MP"+5','Enh. Mag. eff. dur. +10',}},
		body={ name="Telchine Chas.", augments={'Mag. Evasion+23','"Conserve MP"+4','Enh. Mag. eff. dur. +10',}},
		hands={ name="Telchine Gloves", augments={'Mag. Evasion+23','"Conserve MP"+5','Enh. Mag. eff. dur. +10',}},
		legs={ name="Telchine Braconi", augments={'Mag. Evasion+19','"Conserve MP"+5','Enh. Mag. eff. dur. +10',}},
		feet={ name="Telchine Pigaches", augments={'Mag. Evasion+25','Song spellcasting time -7%','Enh. Mag. eff. dur. +10',}},
		waist="Embla Sash", 
		}

    sets.midcast.Regen = set_combine(sets.midcast.EnhancingDuration, {
		main="Musa",
		sub="Khonsu",
		head="Arbatel Bonnet +1",
		body={ name="Telchine Chas.", augments={'"Elemental Siphon"+35','"Regen" potency+3',}},
		hands={ name="Telchine Gloves", augments={'Mag. Evasion+23','"Conserve MP"+5','Enh. Mag. eff. dur. +10',}},
		legs={ name="Telchine Braconi", augments={'"Elemental Siphon"+35','"Regen" potency+3',}},
		feet={ name="Telchine Pigaches", augments={'"Elemental Siphon"+35','"Regen" potency+3',}},
		waist="Embla Sash",
		back={ name="Bookworm's Cape", augments={'INT+2','MND+2','Helix eff. dur. +17','"Regen" potency+10',}},
        })

    sets.midcast.RegenDuration = set_combine(sets.midcast.EnhancingDuration, {
		main="Musa",
		sub="Khonsu",
        head="Arbatel Bonnet +1",
		body={ name="Telchine Chas.", augments={'Mag. Evasion+23','"Conserve MP"+4','Enh. Mag. eff. dur. +10',}},
		hands={ name="Telchine Gloves", augments={'Mag. Evasion+23','"Conserve MP"+5','Enh. Mag. eff. dur. +10',}},
		legs={ name="Telchine Braconi", augments={'Mag. Evasion+19','"Conserve MP"+5','Enh. Mag. eff. dur. +10',}},
		feet={ name="Telchine Pigaches", augments={'Mag. Evasion+25','Song spellcasting time -7%','Enh. Mag. eff. dur. +10',}},
		waist="Embla Sash",
		back={ name="Bookworm's Cape", augments={'INT+2','MND+2','Helix eff. dur. +17','"Regen" potency+10',}},
		})

    sets.midcast.Haste = sets.midcast.EnhancingDuration

    sets.midcast.Refresh = set_combine(sets.midcast.EnhancingDuration, {head="Amalric Coif +1", waist="Gishdubar Sash",})

    sets.midcast.Stoneskin = set_combine(sets.midcast.EnhancingDuration, {legs="Shedir Seraweels", waist="Siegel Sash",})

    sets.midcast.Aquaveil = set_combine(sets.midcast.EnhancingDuration, {head="Amalric Coif +1", legs="Shedir Seraweels", waist="Emphatikos Rope"})

    sets.midcast.Storm = sets.midcast.EnhancingDuration

    sets.midcast.Stormsurge = set_combine(sets.midcast.Storm, {feet="Peda. Loafers +3"})

    sets.midcast.Protect = set_combine(sets.midcast.EnhancingDuration, {})
    sets.midcast.Protectra = sets.midcast.Protect
    sets.midcast.Shell = sets.midcast.Protect
    sets.midcast.Shellra = sets.midcast.Shell

    -- Custom spell classes
    sets.midcast.MndEnfeebles = { }

    sets.midcast.IntEnfeebles = set_combine(sets.midcast.MndEnfeebles, {waist = "Sacro Cord",})
	
	sets.midcast["Dispelga"] = set_combine(sets.midcast.IntEnfeebles, {})
	
    sets.midcast.ElementalEnfeeble = sets.midcast.IntEnfeebles

    sets.midcast['Dark Magic'] = {}

    sets.midcast.Kaustra = {}

    sets.midcast.Drain = set_combine(sets.midcast['Dark Magic'], {})
	
    sets.midcast.Aspir = sets.midcast.Drain
	
    sets.midcast.Stun = set_combine(sets.midcast['Dark Magic'], {})
	sets.midcast.Stun.Resistant = sets.midcast.Stun

    -- Elemental Magic
		
    sets.midcast['Elemental Magic'] = {
	    main={ name="Bunzi's Rod", augments={'Path: A',}},
		sub="Ammurapi Shield",
		ammo="Sroda Tathlum",
		head="C. Palug Crown",
		body={ name="Amalric Doublet +1", augments={'MP+80','Mag. Acc.+20','"Mag.Atk.Bns."+20',}},
		hands={ name="Amalric Gages +1", augments={'INT+12','Mag. Acc.+20','"Mag.Atk.Bns."+20',}},
		legs={ name="Amalric Slops +1", augments={'MP+80','Mag. Acc.+20','"Mag.Atk.Bns."+20',}},
		feet={ name="Amalric Nails +1", augments={'MP+80','Mag. Acc.+20','"Mag.Atk.Bns."+20',}},
		neck="Mizu. Kubikazari",
		waist="Orpheus's Sash",
		left_ear="Malignance Earring",
		right_ear="Barkaro. Earring",
		left_ring="Freke Ring",
		right_ring={ name="Metamor. Ring +1", augments={'Path: A',}},
		back={ name="Bookworm's Cape", augments={'INT+2','MND+2','Helix eff. dur. +17','"Regen" potency+10',}},
	}

    sets.midcast['Elemental Magic'].Resistant = set_combine(sets.midcast['Elemental Magic'], {})

    sets.midcast.Impact = set_combine(sets.midcast['Elemental Magic'], {head=empty, body="Crepuscular Cloak",})
	
    sets.midcast.Helix = {}

    sets.midcast.DarkHelix = set_combine(sets.midcast.Helix, {
        head = "Pixie Hairpin +1",
        ring1 = "Archon Ring",
        })

    sets.midcast.LightHelix = set_combine(sets.midcast.Helix,{
		main = "Daybreak",
		sub = "Ammurapi Shield",
		})
	
    sets.magic_burst = {}
		
	sets.Helix_MB = {}
		
	sets.DarkHelix_MB = set_combine(sets.Helix_MB ,{
		head="Pixie Hairpin +1",
        ring1="Archon Ring",
		})
		
	sets.LightHelix_MB = set_combine(sets.Helix_MB ,{
		main="Daybreak",
		sub="Culminus",
		head=MerlinicHead.MB, --10
		})
	

    -- Initializes trusts at iLvl 119
    sets.midcast.Trust = sets.precast.FC


    ------------------------------------------------------------------------------------------------
    ----------------------------------------- Idle Sets --------------------------------------------
    ------------------------------------------------------------------------------------------------

    sets.idle = {
	    main="Musa",
		sub="Khonsu",
		ammo="Homiliary",
		head={ name="Nyame Helm", augments={'Path: B',}},
		body="Shamash Robe",
		hands={ name="Nyame Gauntlets", augments={'Path: B',}},
		legs={ name="Nyame Flanchard", augments={'Path: B',}},
		feet={ name="Nyame Sollerets", augments={'Path: B',}},
		neck="Yngvi Choker",
		waist="Carrier's Sash",
		left_ear="Lugalbanda Earring",
		right_ear="Etiolation Earring",
        right_ring="Shneddick Ring +1",
        left_ring={name="Stikini Ring +1", bag="wardrobe4"},
		back="Moonlight Cape",
	}

    sets.idle.DT = set_combine(sets.idle, {})

    sets.idle.Vagary = sets.midcast['Elemental Magic']

    ------------------------------------------------------------------------------------------------
    ---------------------------------------- Defense Sets ------------------------------------------
    ------------------------------------------------------------------------------------------------

    sets.defense.PDT = sets.idle.DT
    sets.defense.MDT = sets.idle.DT


    ------------------------------------------------------------------------------------------------
    ---------------------------------------- Engaged Sets ------------------------------------------
    ------------------------------------------------------------------------------------------------

    sets.engaged = {}

    ------------------------------------------------------------------------------------------------
    ---------------------------------------- Special Sets ------------------------------------------
    ------------------------------------------------------------------------------------------------


    --sets.buff['Ebullience'] = {head="Arbatel Bonnet +1"}
    sets.buff['Rapture'] = {head="Arbatel Bonnet +1"}
    sets.buff['Perpetuance'] = {hands="Arbatel Bracers +1"}
    sets.buff['Immanence'] = {hands="Arbatel Bracers +1", "Lugh's Cape"}
    sets.buff['Penury'] = {}
    sets.buff['Parsimony'] = {}
    sets.buff['Celerity'] = {feet="Peda. Loafers +3"}
    sets.buff['Alacrity'] = {feet="Peda. Loafers +3"}
    --sets.buff['Klimaform'] = {feet="Arbatel Loafers +1"}

    sets.buff.FullSublimation = {
   --    head="Acad. Mortarboard",
   --    body="Peda. Gown +1",
       }

    sets.buff.Doom = {}

    sets.LightArts = {}
    sets.DarkArts = {}

    sets.Obi = {waist="Hachirin-no-Obi"}
    sets.Bookworm = {}
    sets.CP = {}

end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------

function job_precast(spell, action, spellMap, eventArgs)
    if spellMap == 'Aspir' then
        refine_various_spells(spell, action, spellMap, eventArgs)
    end
end

function job_post_precast(spell, action, spellMap, eventArgs)
    if (spell.type == "WhiteMagic" and (buffactive["Light Arts"] or buffactive["Addendum: White"])) or
        (spell.type == "BlackMagic" and (buffactive["Dark Arts"] or buffactive["Addendum: Black"])) then
        equip(sets.precast.FC.Grimoire)
    elseif spell.name == 'Impact' then
        equip(sets.precast.FC.Impact)
    end
end

-- Run after the general midcast() is done.
function job_post_midcast(spell, action, spellMap, eventArgs)
    if spell.skill == 'Elemental Magic' or spell.english == "Kaustra" then
        if (spell.element == world.day_element or spell.element == world.weather_element) then
            equip(sets.Obi)
            if buffactive['Klimaform'] then
                equip(sets.buff['Klimaform'])
            end
        end
        if spellMap == "Helix" then
            equip(sets.midcast['Elemental Magic'])
            if spell.english:startswith('Lumino') then
                equip(sets.midcast.LightHelix)
            elseif spell.english:startswith('Nocto') then
                equip(sets.midcast.DarkHelix)
            else
                equip(sets.midcast.Helix)
            end
            if state.HelixMode.value == 'Duration' then
                equip(sets.Bookworm)
            end
        end
    end
    if spell.action_type == 'Magic' then
        apply_grimoire_bonuses(spell, action, spellMap, eventArgs)
    end
    if spell.skill == 'Enfeebling Magic' then
        if spell.type == "WhiteMagic" and (buffactive["Light Arts"] or buffactive["Addendum: White"]) then
            equip(sets.LightArts)
        elseif spell.type == "BlackMagic" and (buffactive["Dark Arts"] or buffactive["Addendum: Black"]) then
            equip(sets.DarkArts)
        end
    end
    if spell.skill == 'Elemental Magic' and state.MagicBurst.value then
		if spellMap == "Helix" then
            equip(sets.magic_burst)
            if spell.english:startswith('Lumino') then
                equip(sets.LightHelix_MB)
            elseif spell.english:startswith('Nocto') then
                equip(sets.DarkHelix_MB)
            else
                equip(sets.Helix_MB)
            end
			if state.HelixMode.value == 'Duration' then
                equip(sets.Bookworm)
            end
		else 
			equip(sets.magic_burst)
		end
        if spell.english == "Impact" then
            equip(sets.midcast.Impact)
        end
    end
    if spell.skill == 'Enhancing Magic' then
        if classes.NoSkillSpells:contains(spell.english) then
            equip(sets.midcast.EnhancingDuration)
            if spellMap == 'Refresh' then
                equip(sets.midcast.Refresh)
            end
        end
        if spellMap == "Regen" and state.RegenMode.value == 'Duration' then
            equip(sets.midcast.RegenDuration)
        end
        if state.Buff.Perpetuance then
            equip(sets.buff['Perpetuance'])
        end
        if spellMap == "Storm" and state.StormSurge.value then
            equip (sets.midcast.Stormsurge)
        end
    end
end

function job_aftercast(spell, action, spellMap, eventArgs)
    if not spell.interrupted then
        if spell.english == "Sleep II" then
            send_command('@timers c "Sleep II ['..spell.target.name..']" 90 down spells/00259.png')
        elseif spell.english == "Sleep" or spell.english == "Sleepga" then -- Sleep & Sleepga Countdown --
            send_command('@timers c "Sleep ['..spell.target.name..']" 60 down spells/00253.png')
        elseif spell.english == "Break" then
            send_command('@timers c "Break ['..spell.target.name..']" 30 down spells/00255.png')
        end
    end
end


-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for non-casting events.
-------------------------------------------------------------------------------------------------------------------

-- Called when a player gains or loses a buff.
-- buff == buff gained or lost
-- gain == true if the buff was gained, false if it was lost.
function job_buff_change(buff, gain)
    if buff == "Sublimation: Activated" then
        handle_equipping_gear(player.status)
    end

    if buff == "doom" then
        if gain then
            equip(sets.buff.Doom)
            send_command('@input /p Doomed.')
             disable('ring1','ring2','waist')
        else
            enable('ring1','ring2','waist')
            handle_equipping_gear(player.status)
        end
    end

end

-- Handle notifications of general user state change.
function job_state_change(stateField, newValue, oldValue)
    if state.WeaponLock.value == true then
        disable('main','sub')
    else
        enable('main','sub')
    end
end

-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------

-- Custom spell mapping.
function job_get_spell_map(spell, default_spell_map)
    if spell.action_type == 'Magic' then
        if default_spell_map == 'Cure' or default_spell_map == 'Curaga' then
            if (world.weather_element == 'Light' or world.day_element == 'Light') then
                return 'CureWeather'
            end
        elseif spell.skill == 'Enfeebling Magic' then
            if spell.type == 'WhiteMagic' then
                return 'MndEnfeebles'
            else
                return 'IntEnfeebles'
            end
        end
    end
end

function customize_idle_set(idleSet)
    if state.Buff['Sublimation: Activated'] then
        idleSet = set_combine(idleSet, sets.buff.FullSublimation)
    end
    if player.mpp < 51 then
        idleSet = set_combine(idleSet, sets.latent_refresh)
    end
    if state.CP.current == 'on' then
        equip(sets.CP)
        disable('back')
    else
        enable('back')
    end

    return idleSet
end

-- Called by the 'update' self-command.
function job_update(cmdParams, eventArgs)
    update_active_strategems()
    update_sublimation()
end

-- Function to display the current relevant user state when doing an update.
-- Return true if display was handled, and you don't want the default info shown.
function display_current_job_state(eventArgs)

    local c_msg = state.CastingMode.value

    local h_msg = state.HelixMode.value
    
    local r_msg = state.RegenMode.value

    local d_msg = 'None'
    if state.DefenseMode.value ~= 'None' then
        d_msg = state.DefenseMode.value .. state[state.DefenseMode.value .. 'DefenseMode'].value
    end

    local i_msg = state.IdleMode.value

    local msg = ''
    if state.MagicBurst.value then
        msg = ' Burst: On |'
    end
    if state.Kiting.value then
        msg = msg .. ' Kiting: On |'
    end

    add_to_chat(060, '| Magic: ' ..string.char(31,001)..c_msg.. string.char(31,002)..  ' |'
        ..string.char(31,060).. ' Helix: ' ..string.char(31,001)..h_msg.. string.char(31,002)..  ' |'
        ..string.char(31,060).. ' Regen: ' ..string.char(31,001)..r_msg.. string.char(31,002)..  ' |'
        ..string.char(31,004).. ' Defense: ' ..string.char(31,001)..d_msg.. string.char(31,002)..  ' |'
        ..string.char(31,008).. ' Idle: ' ..string.char(31,001)..i_msg.. string.char(31,002)..  ' |'
        ..string.char(31,002)..msg)

    eventArgs.handled = true
end

-------------------------------------------------------------------------------------------------------------------
-- User code that supplements self-commands.
-------------------------------------------------------------------------------------------------------------------

-- Called for direct player commands.
function job_self_command(cmdParams, eventArgs)
    if cmdParams[1]:lower() == 'scholar' then
        handle_strategems(cmdParams)
        eventArgs.handled = true
    elseif cmdParams[1]:lower() == 'nuke' then
        handle_nuking(cmdParams)
        eventArgs.handled = true
    elseif cmdParams[1]:lower() == 'barelement' then
        send_command('@input /ma '..state.BarElement.value..' <me>')
    elseif cmdParams[1]:lower() == 'barstatus' then
        send_command('@input /ma '..state.BarStatus.value..' <me>')
    elseif cmdParams[1]:lower() == 'stormspell' then
        send_command('@input /ma '..state.GainSpell.value..' <me>')
    end
	
	
	if cmdParams[1] == 'Liquefaction' then
		send_command('input /p Opening SC: Liquefaction  MB: Fire; wait .1; input /ja "Immanence" <me>; wait 1.5; input /ma "Thunder" <t>; wait 4.0;' .. 
		'input /ja "Immanence" <me>; wait 1.5; input /p Closing SC: Liquefaction  MB: Fire; input /ma "Pyrohelix" <t>')
		add_to_chat(158, 'Starting Liquefaction | Fire')
	elseif cmdParams[1] == 'Induration' then
		send_command('input /p Opening SC: Induration  MB: Ice; wait .1; input /ja "Immanence" <me>; wait 1.5; input /ma "Water" <t>; wait 4.0;' .. 
		'input /ja "Immanence" <me>; wait 1.5; input /p Closing SC: Induration  MB: Ice; input /ma "Cryohelix" <t>')
		add_to_chat(158, 'Starting Induration | Ice')
	elseif cmdParams[1] == 'Detonation' then
		send_command('input /p Opening SC: Detonation  MB: Aero; wait .1; input /ja "Immanence" <me>; wait 1.5; input /ma "Thunder" <t>; wait 4.0;' .. 
		'input /ja "Immanence" <me>; wait 1.5; input /p Closing SC: Detonation  MB: Air; input /ma "Anemohelix" <t>')
		add_to_chat(158, 'Starting Wind')
	elseif cmdParams[1] == 'Scission' then
		send_command('input /p Opening SC: Scission  MB: Stone; wait .1; input /ja "Immanence" <me>; wait 1.5; input /ma "Fire" <t>; wait 4.0;' .. 
		'input /ja "Immanence" <me>; wait 1.5; input /p Closing SC: Scission  MB: Stone; input /ma "Geohelix" <t>')
		add_to_chat(158, 'Starting Scission | Earth')
	elseif cmdParams[1] == 'Impaction' then
		send_command('input /p Opening SC: Impaction  MB: Lightning; wait .1; input /ja "Immanence" <me>; wait 1.5; input /ma "Blizzard" <t>; wait 4.0;' .. 
		'input /ja "Immanence" <me>; wait 1.5; input /p Closing SC: Impaction  MB: Lightning; input /ma "Ionohelix" <t>')
		add_to_chat(158, 'Starting Impaction | Thunder')
	elseif cmdParams[1] == 'Reverberation' then
		send_command('input /p Opening SC: Reverberation  MB: Water; wait .1; input /ja "Immanence" <me>; wait 1.5; input /ma "Stone" <t>; wait 4.0;' ..
		'input /ja "Immanence" <me>; wait 1.5; input /p Closing SC: Reverberation  MB: Water; input /ma "Hydrohelix" <t>')
		add_to_chat(158, 'Starting Reverberation | Water')
	elseif cmdParams[1] == 'Transfixion' then
		send_command('input /p Opening SC: Transfixion  MB: Light; wait .1; input /ja "Immanence" <me>; wait 1.5; input /ma "Noctohelix" <t>; wait 4.0;' .. 
		'input /ja "Immanence" <me>; wait 1.5; input /p Closing SC: Transfixion  MB: Light; input /ma "Luminohelix" <t>')
		add_to_chat(158, 'Starting Transfixion | Light')
	elseif cmdParams[1] == 'Compression' then
		send_command('input /p Opening SC: Compression  MB: Dark; wait .1; input /ja "Immanence" <me>; wait 1.5; input /ma "Blizzard" <t>; wait 4.0;' .. 
		'input /ja "Immanence" <me>; wait 1.5; input /p Closing SC: Compression  MB: Dark; input /ma "Noctohelix" <t>')
		add_to_chat(158, 'Starting Compression | Dark')
	elseif cmdParams[1] == 'Fusion' then
		send_command('input /p Opening SC: Fusion  MB: Light / Fire; wait .1; input /ja "Immanence" <me>; wait 1.5; input /ma "Fire" <t>; wait 4.0;' .. 
		'input /ja "Immanence" <me>; wait 1.5; input /p Closing SC: Fusion  MB: Light / Fire; input /ma "Ionohelix" <t>')
		add_to_chat(158, 'Starting Fusion  | Fire/Light')
	elseif cmdParams[1] == 'Fragmentation' then
		send_command('input /p Opening SC: Fragmentation  MB: Lightning / Wind; wait .1; input /ja "Immanence" <me>; wait 1.5; input /ma "Blizzard" <t>; wait 4.0;' .. 
		'input /ja "Immanence" <me>; wait 1.5; input /p Closing SC: Fragmentation  MB: Wind / Lightning; input /ma "Hydrohelix" <t>')
		add_to_chat(158, 'Fragmentation | Thunder/Wind')
	elseif cmdParams[1] == 'Distortion' then
		send_command('input /p Opening SC: Distortion  MB: Water / Ice; wait .1; input /ja "Immanence" <me>; wait 1.5; input /ma "Luminohelix" <t>; wait 6.0;' .. 
		'input /ja "Immanence" <me>; wait 1.5; input /p Closing SC: Distortion  MB: Water / Ice; input /ma "Geohelix" <t>')
		add_to_chat(158, 'Starting Distortion | Water/Ice')
	elseif cmdParams[1] == 'Gravitation' then
		send_command('input /p Opening SC: Gravitation  MB: Dark / Stone; wait .1; input /ja "Immanence" <me>; wait 1.5; input /ma "Aero" <t>; wait 4.0;' .. 
		'input /ja "Immanence" <me>; wait 1.5; input /p Closing SC: Gravitation  MB: Dark / Stone; input /ma "Noctohelix" <t>')
		add_to_chat(158, 'Starting Gravitation | Dark/Stone')
	end

	
	
end


-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

-- Reset the state vars tracking strategems.
function update_active_strategems()
    state.Buff['Ebullience'] = buffactive['Ebullience'] or false
    state.Buff['Rapture'] = buffactive['Rapture'] or false
    state.Buff['Perpetuance'] = buffactive['Perpetuance'] or false
    state.Buff['Immanence'] = buffactive['Immanence'] or false
    state.Buff['Penury'] = buffactive['Penury'] or false
    state.Buff['Parsimony'] = buffactive['Parsimony'] or false
    state.Buff['Celerity'] = buffactive['Celerity'] or false
    state.Buff['Alacrity'] = buffactive['Alacrity'] or false

    state.Buff['Klimaform'] = buffactive['Klimaform'] or false
end

function update_sublimation()
    state.Buff['Sublimation: Activated'] = buffactive['Sublimation: Activated'] or false
end

-- Equip sets appropriate to the active buffs, relative to the spell being cast.
function apply_grimoire_bonuses(spell, action, spellMap)
    if state.Buff.Perpetuance and spell.type =='WhiteMagic' and spell.skill == 'Enhancing Magic' then
        equip(sets.buff['Perpetuance'])
    end
    if state.Buff.Rapture and (spellMap == 'Cure' or spellMap == 'Curaga') then
        equip(sets.buff['Rapture'])
    end
    if spell.skill == 'Elemental Magic' and spellMap ~= 'ElementalEnfeeble' then
        if state.Buff.Ebullience and spell.english ~= 'Impact' then
            equip(sets.buff['Ebullience'])
        end
        if state.Buff.Immanence then
            equip(sets.buff['Immanence'])
        end
        if state.Buff.Klimaform and (spell.element == world.weather_element or spell.element == world.day_element) then
            equip(sets.buff['Klimaform'])
        end
    end

    if state.Buff.Penury then equip(sets.buff['Penury']) end
    if state.Buff.Parsimony then equip(sets.buff['Parsimony']) end
    if state.Buff.Celerity then equip(sets.buff['Celerity']) end
    if state.Buff.Alacrity then equip(sets.buff['Alacrity']) end
end


-- General handling of strategems in an Arts-agnostic way.
-- Format: gs c scholar <strategem>
function handle_strategems(cmdParams)
    -- cmdParams[1] == 'scholar'
    -- cmdParams[2] == strategem to use

    if not cmdParams[2] then
        add_to_chat(123,'Error: No strategem command given.')
        return
    end
    local strategem = cmdParams[2]:lower()

    if strategem == 'light' then
        if buffactive['light arts'] then
            send_command('input /ja "Addendum: White" <me>')
        elseif buffactive['addendum: white'] then
            add_to_chat(122,'Error: Addendum: White is already active.')
        else
            send_command('input /ja "Light Arts" <me>')
        end
    elseif strategem == 'dark' then
        if buffactive['dark arts'] then
            send_command('input /ja "Addendum: Black" <me>')
        elseif buffactive['addendum: black'] then
            add_to_chat(122,'Error: Addendum: Black is already active.')
        else
            send_command('input /ja "Dark Arts" <me>')
        end
    elseif buffactive['light arts'] or buffactive['addendum: white'] then
        if strategem == 'cost' then
            send_command('input /ja Penury <me>')
        elseif strategem == 'speed' then
            send_command('input /ja Celerity <me>')
        elseif strategem == 'aoe' then
            send_command('input /ja Accession <me>')
        elseif strategem == 'power' then
            send_command('input /ja Rapture <me>')
        elseif strategem == 'duration' then
            send_command('input /ja Perpetuance <me>')
        elseif strategem == 'accuracy' then
            send_command('input /ja Altruism <me>')
        elseif strategem == 'enmity' then
            send_command('input /ja Tranquility <me>')
        elseif strategem == 'skillchain' then
            add_to_chat(122,'Error: Light Arts does not have a skillchain strategem.')
        elseif strategem == 'addendum' then
            send_command('input /ja "Addendum: White" <me>')
        else
            add_to_chat(123,'Error: Unknown strategem ['..strategem..']')
        end
    elseif buffactive['dark arts']  or buffactive['addendum: black'] then
        if strategem == 'cost' then
            send_command('input /ja Parsimony <me>')
        elseif strategem == 'speed' then
            send_command('input /ja Alacrity <me>')
        elseif strategem == 'aoe' then
            send_command('input /ja Manifestation <me>')
        elseif strategem == 'power' then
            send_command('input /ja Ebullience <me>')
        elseif strategem == 'duration' then
            add_to_chat(122,'Error: Dark Arts does not have a duration strategem.')
        elseif strategem == 'accuracy' then
            send_command('input /ja Focalization <me>')
        elseif strategem == 'enmity' then
            send_command('input /ja Equanimity <me>')
        elseif strategem == 'skillchain' then
            send_command('input /ja Immanence <me>')
        elseif strategem == 'addendum' then
            send_command('input /ja "Addendum: Black" <me>')
        else
            add_to_chat(123,'Error: Unknown strategem ['..strategem..']')
        end
    else
        add_to_chat(123,'No arts has been activated yet.')
    end
end


-- Gets the current number of available strategems based on the recast remaining
-- and the level of the sch.
function get_current_strategem_count()
    -- returns recast in seconds.
    local allRecasts = windower.ffxi.get_ability_recasts()
    local stratsRecast = allRecasts[231]

    local maxStrategems = (player.main_job_level + 10) / 20

    local fullRechargeTime = 4*60

    local currentCharges = math.floor(maxStrategems - maxStrategems * stratsRecast / fullRechargeTime)

    return currentCharges
end

function refine_various_spells(spell, action, spellMap, eventArgs)
    local newSpell = spell.english
    local spell_recasts = windower.ffxi.get_spell_recasts()
    local cancelling = 'All '..spell.english..' are on cooldown. Cancelling.'

    local spell_index

    if spell_recasts[spell.recast_id] > 0 then
        if spellMap == 'Aspir' then
            spell_index = table.find(degrade_array['Aspirs'],spell.name)
            if spell_index > 1 then
                newSpell = degrade_array['Aspirs'][spell_index - 1]
                send_command('@input /ma '..newSpell..' '..tostring(spell.target.raw))
                eventArgs.cancel = true
            end
        end
    end
end


-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    set_macro_page(1, 2)
end

function set_lockstyle()
    send_command('wait 2; input /lockstyleset ' .. lockstyleset)
end