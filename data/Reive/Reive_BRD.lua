-- Original: Motenten / Modified: Arislan

-------------------------------------------------------------------------------------------------------------------
--  Keybinds
-------------------------------------------------------------------------------------------------------------------

--  Modes:      [ F9 ]              Cycle Offense Mode
--              [ CTRL+F9 ]         Cycle Hybrid Modes
--              [ WIN+F9 ]          Cycle Weapon Skill Modes
--              [ F10 ]             Emergency -PDT Mode
--              [ ALT+F10 ]         Toggle Kiting Mode
--              [ F11 ]             Emergency -MDT Mode
--              [ CTRL+F11 ]        Cycle Casting Modes
--              [ F12 ]             Update Current Gear / Report Current Status
--              [ CTRL+F12 ]        Cycle Idle Modes
--              [ ALT+F12 ]         Cancel Emergency -PDT/-MDT Mode
--              [ WIN+C ]           Toggle Capacity Points Mode
--
--  Abilities:  [ CTRL+` ]          Cycle SongMode
--
--  Songs:      [ ALT+` ]           Chocobo Mazurka
--              [ WIN+, ]           Utsusemi: Ichi
--              [ WIN+. ]           Utsusemi: Ni
--
--  Weapons:    [ CTRL+W ]          Toggles Weapon Lock
--
--  WS:         [ CTRL+Numpad7 ]    Mordant Rime
--              [ CTRL+Numpad4 ]    Evisceration
--              [ CTRL+Numpad5 ]    Rudra's Storm
--              [ CTRL+Numpad1 ]    Aeolian Edge
--
--
--              (Global-Binds.lua contains additional non-job-related keybinds)


-------------------------------------------------------------------------------------------------------------------
-- Setup functions for this job.  Generally should not be modified.
-------------------------------------------------------------------------------------------------------------------

--[[
    Custom commands:
    SongMode may take one of three values: None, Placeholder, FullLength
    You can set these via the standard 'set' and 'cycle' self-commands.  EG:
    gs c cycle SongMode
    gs c set SongMode Placeholder
    The Placeholder state will equip the bonus song instrument and ensure non-duration gear is equipped.
    The FullLength state will simply equip the bonus song instrument on top of standard gear.
    Simple macro to cast a placeholder Daurdabla song:
    /console gs c set SongMode Placeholder
    /ma "Shining Fantasia" <me>
    To use a Terpander rather than Daurdabla, set the info.ExtraSongInstrument variable to
    'Terpander', and info.ExtraSongs to 1.
--]]

-- Initialization function for this job file.
function get_sets()
    mote_include_version = 2

    -- Load and initialize the include file.
	include('organizer-lib')
    include('Mote-Include.lua')
	res = require 'resources'
end


-- Setup vars that are user-independent.  state.Buff vars initialized here will automatically be tracked.
function job_setup()
    state.SongMode = M{['description']='Song Mode', 'None', 'Placeholder'}

    state.Buff['Pianissimo'] = buffactive['pianissimo'] or false

    no_swap_gear = S{"Warp Ring", "Dim. Ring (Dem)", "Dim. Ring (Holla)", "Dim. Ring (Mea)",
              "Trizek Ring", "Echad Ring", "Facility Ring", "Capacity Ring"}
    elemental_ws = S{"Aeolian Edge"}

	brd_sub_weapons=S{"Ternion Dagger +1", "Tauret", "Gleti's Knife", "Levante Dagger", "Malevolence", "Fusetto +2", "Legato Dagger", "Kali"}
	
    lockstyleset = 20
end

-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
    state.OffenseMode:options('Normal','Acc')
    state.HybridMode:options('Normal', 'DT')
    state.WeaponskillMode:options('Normal', 'Uncapped')
    state.CastingMode:options('Normal', 'Resistant')
    state.IdleMode:options('Normal', 'Regain')

    state.LullabyMode = M{['description']='Lullaby Instrument', 'Harp', 'Horn'}

    state.Carol = M{['description']='Carol',
        'Fire Carol', 'Fire Carol II', 'Ice Carol', 'Ice Carol II', 'Wind Carol', 'Wind Carol II',
        'Earth Carol', 'Earth Carol II', 'Lightning Carol', 'Lightning Carol II', 'Water Carol', 'Water Carol II',
        'Light Carol', 'Light Carol II', 'Dark Carol', 'Dark Carol II',
        }

    state.Threnody = M{['description']='Threnody',
        'Fire Threnody II', 'Ice Threnody II', 'Wind Threnody II', 'Earth Threnody II',
        'Ltng. Threnody II', 'Water Threnody II', 'Light Threnody II', 'Dark Threnody II',
        }

    state.Etude = M{['description']='Etude', 'Sinewy Etude', 'Herculean Etude', 'Learned Etude', 'Sage Etude',
        'Quick Etude', 'Swift Etude', 'Vivacious Etude', 'Vital Etude', 'Dextrous Etude', 'Uncanny Etude',
        'Spirited Etude', 'Logical Etude', 'Enchanting Etude', 'Bewitching Etude'}

    state.WeaponSet = M{['description']='Weapon Set', 'Naegling', 'Aeneas', 'MAB',}
    state.WeaponLock = M(false, 'Weapon Lock')


    -- Adjust this if using the Terpander (new +song instrument)
    info.ExtraSongInstrument = 'Daurdabla'
    -- How many extra songs we can keep from Daurdabla/Terpander
    info.ExtraSongs = 2

    send_command('bind ^` gs c cycle SongMode')

	send_command('bind !f9 gs c cycle WeaponskillMode')
	
    send_command('bind ^insert gs c cycle WeaponSet')
    send_command('bind ^delete gs c cycleback WeaponSet')
    send_command('bind ^home gs c cycleback Carol')
    send_command('bind ^end gs c cycle Carol')
    send_command('bind ^pageup gs c cycleback Threnody')
    send_command('bind ^pagedown gs c cycleback Etude')

    send_command('bind @` gs c cycle LullabyMode')
    send_command('bind @w gs c toggle WeaponLock')

--	

    select_default_macro_book()
    set_lockstyle()

    DW = false
    update_combat_form()
end


-- Called when this job file is unloaded (eg: job change)
function user_unload()
    send_command('unbind ^`')
    send_command('unbind !insert')
    send_command('unbind !delete')
    send_command('unbind ^insert')
    send_command('unbind ^delete')
    send_command('unbind ^home')
    send_command('unbind ^end')
    send_command('unbind ^pageup')
    send_command('unbind ^pagedown')
    send_command('unbind @`')
    send_command('unbind @w')
end


-- Define sets and vars used by this job file.
function init_gear_sets()
	
	Linos={}
	Linos.TP = { name="Linos", augments={'Accuracy+14 Attack+14','"Store TP"+4','Quadruple Attack +3',}}
	Linos.Idle = { name="Linos", augments={'Mag. Evasion+15','"Regen"+2','INT+6 MND+6',}}
	Linos.WS = 	{ name="Linos", augments={'Accuracy+14 Attack+14','Weapon skill damage +3%','STR+6 DEX+6',}}
	Linos.MAB = { name="Linos", augments={'Mag. Acc.+12 "Mag.Atk.Bns."+12','Weapon skill damage +3%','INT+8',}}
	Linos.FC =  { name="Linos", augments={'"Fast Cast"+4',}}
	
    ------------------------------------------------------------------------------------------------
    ---------------------------------------- Precast Sets ------------------------------------------
    ------------------------------------------------------------------------------------------------

    -- Fast cast sets for spells
    sets.precast.FC = {
		range=Linos.FC,
		head={ name="Bunzi's Hat", augments={'Path: A',}},
		body="Inyanga Jubbah +2",
		hands={ name="Leyline Gloves", augments={'Accuracy+15','Mag. Acc.+15','"Mag.Atk.Bns."+15','"Fast Cast"+3',}},
		legs="Aya. Cosciales +2",
		feet="Fili Cothurnes +2",
		neck={ name="Loricate Torque +1", augments={'Path: A',}},
		waist={ name="Shinjutsu-no-Obi +1", augments={'Path: A',}},
		left_ear="Loquac. Earring",
		right_ear="Etiolation Earring",
		left_ring="Defending Ring",
		right_ring="Kishar Ring",
		back={ name="Intarabus's Cape", augments={'CHR+20','Mag. Acc+20 /Mag. Dmg.+20','Mag. Acc.+10','"Fast Cast"+10','Damage taken-5%',}},
        }

    sets.precast.FC['Enhancing Magic'] = set_combine(sets.precast.FC, {})

    sets.precast.FC.Cure = set_combine(sets.precast.FC, {})

    sets.precast.FC.BardSong = {
		main={ name="Carnwenhan", augments={'Path: A',}},
		head="Fili Calot +2",
		body="Inyanga Jubbah +2",
		hands={ name="Gende. Gages +1", augments={'Phys. dmg. taken -4%','Magic dmg. taken -4%','Song spellcasting time -5%',}},
		legs="Aya. Cosciales +2",
		feet="Fili Cothurnes +2",
		neck={ name="Loricate Torque +1", augments={'Path: A',}},
		waist={ name="Shinjutsu-no-Obi +1", augments={'Path: A',}},
		left_ear="Eabani Earring",
		right_ear="Etiolation Earring",
		left_ring="Defending Ring",
		right_ring="Kishar Ring",
		back={ name="Intarabus's Cape", augments={'CHR+20','Mag. Acc+20 /Mag. Dmg.+20','Mag. Acc.+10','"Fast Cast"+10','Damage taken-5%',}},
	}
	
    sets.precast.FC.SongPlaceholder = set_combine(sets.precast.FC.BardSong, {range="Daurdabla"})--{range=info.ExtraSongInstrument})

    sets.precast.FC.Dispelga = set_combine(sets.precast.FC, {main="Daybreak", sub="Ammurapi Shield"})

    -- Precast sets to enhance JAs

    sets.precast.JA['Nightingale'] = {feet="Bihu Slippers +3"}
    sets.precast.JA['Troubadour'] = {body="Bihu Jstcorps. +3"}
    sets.precast.JA['Soul Voice'] = {legs="Bihu Cannions +3"}

    -- Waltz set (chr and vit)
    sets.precast.Waltz = {}


    ------------------------------------------------------------------------------------------------
    ------------------------------------- Weapon Skill Sets ----------------------------------------
    ------------------------------------------------------------------------------------------------

    -- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS = {
		range=Linos.WS,
		head="Nyame Helm",
		body="Bihu Jstcorps. +3",
		hands="Nyame Gauntlets",
		legs="Nyame Flanchard", 
		feet="Nyame Sollerets",
		neck="Bard's Charm +2",
		waist="Grunfeld Rope",
		left_ear="Moonshade Earring",
		right_ear="Mache Earring +1",
		left_ring="Cornelia's Ring",
		right_ring="Ilabrat Ring",
		back={ name="Intarabus's Cape", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','Weapon skill damage +10%',}},
		}
	
	sets.precast.WS.Uncapped = set_combine(sets.precast.WS, {})

    -- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
    sets.precast.WS['Mordant Rime'] = set_combine(sets.precast.WS, {
		waist="Sailfi Belt +1",
		left_ear="Regal Earring",
		right_ear="Ishvara Earring",
		right_ring="Metamor. Ring +1",
		})

    sets.precast.WS['Rudra\'s Storm'] = {
	}
	
	sets.precast.WS['Rudra\'s Storm'].Uncapped = set_combine(sets.precast.WS['Rudra\'s Storm'], {})
	
	sets.precast.WS['Evisceration'] = {
		range=Linos.TP,
		head="Blistering Sallet +1",
		body="Ayanmo Corazza +2",
		hands="Bunzi's gloves",
		legs="Zoar subligar +1",
		feet="Aya. Gambieras +2",
		neck="Fotia Gorget",
		waist="Fotia Belt",
		left_ear="Moonshade Earring",
		right_ear="Mache Earring +1",
		left_ring="Begrudging Ring",
		right_ring="Ilabrat Ring",
		back={ name="Intarabus's Cape", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}},
	}
	
	sets.precast.WS['Evisceration'].Uncapped = set_combine(sets.precast.WS['Evisceration'], {})

    sets.precast.WS['Exenterator'] = set_combine(sets.precast.WS, {})

    sets.precast.WS['Aeolian Edge'] = set_combine(sets.precast.WS, {
		range={ name="Linos", augments={'Mag. Acc.+12 "Mag.Atk.Bns."+12','Weapon skill damage +3%','INT+8',}},
		head={ name="Nyame Helm", augments={'Path: B',}},
		body={ name="Nyame Mail", augments={'Path: B',}},
		hands={ name="Nyame Gauntlets", augments={'Path: B',}},
		legs={ name="Nyame Flanchard", augments={'Path: B',}},
		feet={ name="Nyame Sollerets", augments={'Path: B',}},
		neck="Sibyl Scarf",
		waist="Orpheus's Sash",
		left_ear={ name="Moonshade Earring", augments={'"Mag.Atk.Bns."+4','TP Bonus +250',}},
		right_ear="Regal Earring",
		left_ring="Cornelia's Ring",
		right_ring="Epaminondas's Ring",
		back={ name="Intarabus's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','Weapon skill damage +10%',}},
	})

    sets.precast.WS['Savage Blade'] = set_combine(sets.precast.WS, {
		neck="Rep. Plat. Medal",
		waist="Sailfi Belt +1",
		right_ear="Ishvara Earring",
		right_ring="Epaminondas's Ring",
		back={ name="Intarabus's Cape", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%',}},
	})
	
	sets.precast.WS['Savage Blade'].Uncapped = set_combine(sets.precast.WS['Savage Blade'], {})


    ------------------------------------------------------------------------------------------------
    ---------------------------------------- Midcast Sets ------------------------------------------
    ------------------------------------------------------------------------------------------------

    -- General set for recast times.
    sets.midcast.FastRecast = sets.precast.FC

    sets.midcast.SpellInterrupt = {}

    sets.midcast.Utsusemi = sets.midcast.SpellInterrupt

    -- Gear to enhance certain classes of songs.
    sets.midcast.Ballad = {}
    sets.midcast.Carol = {hands="Mousai Gages +1"}
    sets.midcast.Etude = {head="Mousai Turban +1"}
    sets.midcast.HonorMarch = {range="Marsyas", hands="Fili Manchettes +2"}
    sets.midcast.Madrigal = {head="Fili Calot +2"}
    sets.midcast.Mambo = {feet="Mousai Crackows +1"}
    sets.midcast.March = {hands="Fili Manchettes +2"}
    sets.midcast.Minne = {legs="Mou. Seraweels +1"}
    sets.midcast.Minuet = {body="Fili Hongreline +2"}
    sets.midcast.Paeon = {head="Brioso Roundlet +3"}
    sets.midcast["Sentinel's Scherzo"] = {feet="Fili Cothurnes +2"}
	-- Debuffs
    sets.midcast.Threnody = {body="Mou. Manteel +1",}
    sets.midcast['Magic Finale'] = {}
	
	sets.midcast['Horde Lullaby'] = {
	    main="Carnwenhan",
		sub="Ammurapi Shield",
		range="Daurdabla",
		head="Brioso Roundlet +3",
		body="Brioso Justau. +3",
		hands="Brioso Cuffs +3",
		legs="Inyanga Shalwar +2",
		feet="Brioso Slippers +3", 
		neck="Mnbw. Whistle +1",
		waist="Acuity Belt +1", 
		left_ear="Crep. Earring",
		right_ear="Regal Earring",
		left_ring="Metamor. Ring +1", 
		right_ring={name="Stikini Ring +1", bag="wardrobe2"},
		back={ name="Intarabus's Cape", augments={'CHR+20','Mag. Acc+20 /Mag. Dmg.+20','Mag. Acc.+10','"Fast Cast"+10','Damage taken-5%',}},
	}
	
	sets.midcast['Horde Lullaby II'] = set_combine(sets.midcast['Horde Lullaby'], {
		range="Daurdabla",
		hands="Inyan. Dastanas +2",
		feet="Bihu Slippers +3",
		waist="Harfner's Sash",
		left_ear="Gersemi Earring",
		left_ring={name="Stikini Ring +1", bag="wardrobe2"},
	})
	
	sets.midcast['Foe Lullaby'] = set_combine(sets.midcast['Horde Lullaby'], {range="Gjallarhorn"})
	sets.midcast['Foe Lullaby II'] = set_combine(sets.midcast['Horde Lullaby'], {range="Gjallarhorn"})
	

    -- For song defbuffs (duration primary, accuracy secondary)
    sets.midcast.SongEnfeeble = {
        main="Carnwenhan",
		sub="Ammurapi Shield",
		range="Gjallarhorn",
		head="Brioso Roundlet +3",
		body="Brioso Justau. +3",
		hands="Fili Manchettes +2",
		legs="Brioso Cannions +3",
		feet="Brioso Slippers +3",
		neck="Mnbw. Whistle +1",
		waist="Acuity Belt +1",
		left_ear="Crep. Earring",
		right_ear="Regal Earring",
		left_ring={name="Stikini Ring +1", bag="wardrobe1"},
		right_ring={name="Stikini Ring +1", bag="wardrobe2"},
		back={ name="Intarabus's Cape", augments={'CHR+20','Mag. Acc+20 /Mag. Dmg.+20','"Fast Cast"+10'}},
        }
	
    -- For song defbuffs (accuracy primary, duration secondary)
    sets.midcast.SongEnfeebleAcc = set_combine(sets.midcast.SongEnfeeble, {legs="Brioso Cannions +3"})
	
    -- For song buffs (duration and AF3 set bonus)
    sets.midcast.SongEnhancing = {
        main="Carnwenhan",
		sub="Genmei Shield",
		range="Gjallarhorn",
		head="Fili Calot +2",
		body="Fili Hongreline +2",
		hands="Fili Manchettes +2",
		legs="Inyanga Shalwar +2",
		feet="Brioso Slippers +3",
		neck="Mnbw. Whistle +1",
		waist="Carrier's Sash",
		left_ear="Odnowa Earring +1",
		right_ear="Etiolation Earring",
		left_ring="Defending Ring",
		right_ring={name="Moonlight Ring", bag="wardrobe1"},
		back={ name="Intarabus's Cape", augments={'CHR+20','Mag. Acc+20 /Mag. Dmg.+20','"Fast Cast"+10'}},
        }
		
    -- Placeholder song; minimize duration to make it easy to overwrite.
	sets.midcast.Dummy= set_combine(sets.precast.FC.BardSong, {
		range="Daurdabla"
		})
	
	-- Dummy Songs --
	sets.midcast['Gold Capriccio']=sets.midcast.Dummy
	sets.midcast['Fowl Aubade']=sets.midcast.Dummy
	sets.midcast['Valor Minuet']=sets.midcast.Dummy
	sets.midcast['Valor Minuet II']=sets.midcast.Dummy
	sets.midcast['Knight\'s Minne']=sets.midcast.Dummy
	sets.midcast['Knight\'s Minne II']=sets.midcast.Dummy
	sets.midcast['Army\'s Paeon']=sets.midcast.Dummy
	sets.midcast['Army\'s Paeon II']=sets.midcast.Dummy
	
	
    -- Other general spells and classes.
    sets.midcast.Cure = {
		main="Chatoyant Staff",
		sub="Enki Strap",
		range={ name="Linos", augments={'Mag. Evasion+15','"Regen"+2','INT+6 MND+6',}},
		head={ name="Kaykaus Mitra +1", augments={'MP+80','"Cure" spellcasting time -7%','Enmity-6',}},
		body={ name="Kaykaus Bliaut", augments={'MP+60','"Cure" spellcasting time -5%','Enmity-5',}},
		hands={ name="Kaykaus Cuffs +1", augments={'MP+80','MND+12','Mag. Acc.+20',}},
		legs={ name="Vanya Slops", augments={'Healing magic skill +20','"Cure" spellcasting time -7%','Magic dmg. taken -3',}},
		feet={ name="Kaykaus Boots +1", augments={'MP+80','"Cure" spellcasting time -7%','Enmity-6',}},
		neck="Incanter's Torque",
		waist={ name="Shinjutsu-no-Obi +1", augments={'Path: A',}},
		left_ear="Meili Earring",
		right_ear="Mendi. Earring",
		left_ring={name="Stikini Ring +1", bag="wardrobe1"},
		right_ring="Menelaus's Ring",
		back={ name="Aurist's Cape +1", augments={'Path: A',}},
	}

    sets.midcast.Curaga = set_combine(sets.midcast.Cure, {})

    sets.midcast.StatusRemoval = {}

    sets.midcast.Cursna = set_combine(sets.midcast.StatusRemoval, {})

    sets.midcast['Enhancing Magic'] = {
		main="Pukulatmuj +1",
		sub="Ammurapi Shield",
		head={ name="Telchine Cap", augments={'Mag. Evasion+23','"Conserve MP"+5','Enh. Mag. eff. dur. +10',}},
		body={ name="Telchine Chas.", augments={'Mag. Evasion+23','"Conserve MP"+4','Enh. Mag. eff. dur. +10',}},
		hands="Inyan. Dastanas +2",
		legs="Shedir Seraweels",
		feet={ name="Telchine Pigaches", augments={'Mag. Evasion+25','Song spellcasting time -7%','Enh. Mag. eff. dur. +10',}},
		neck="Incanter's Torque",
		waist="Embla Sash",
		left_ear="Mimir Earring",
		right_ear="Andoaa Earring", 
		left_ring={name="Stikini Ring +1", bag="wardrobe1"},
		right_ring={name="Stikini Ring +1", bag="wardrobe2"},
		back={ name="Intarabus's Cape", augments={'CHR+20','Mag. Acc+20 /Mag. Dmg.+20','"Fast Cast"+10',}},
	}

    sets.midcast.Haste = set_combine(sets.midcast['Enhancing Magic'], {
		hands={ name="Telchine Gloves", augments={'Mag. Evasion+23','"Conserve MP"+5','Enh. Mag. eff. dur. +10',}},
		legs={ name="Telchine Braconi", augments={'Mag. Evasion+19','"Conserve MP"+5','Enh. Mag. eff. dur. +10',}},
		})
    sets.midcast.Regen = set_combine(sets.midcast['Enhancing Magic'], sets.midcast.Haste, {})
    sets.midcast.Refresh = set_combine(sets.midcast['Enhancing Magic'], sets.midcast.Haste, {})
    sets.midcast.Stoneskin = set_combine(sets.midcast['Enhancing Magic'], sets.midcast.Haste, {})
    sets.midcast.Aquaveil = set_combine(sets.midcast['Enhancing Magic'], sets.midcast.Haste, {})
    sets.midcast.Protect = set_combine(sets.midcast['Enhancing Magic'], sets.midcast.Haste, {})
    sets.midcast.Protectra = set_combine(sets.midcast['Enhancing Magic'], sets.midcast.Haste, {})
    sets.midcast.Shell = set_combine(sets.midcast['Enhancing Magic'], sets.midcast.Haste, {})
    sets.midcast.Shellra = set_combine(sets.midcast['Enhancing Magic'], sets.midcast.Haste, {})

    sets.midcast['Enfeebling Magic'] = {}

    sets.midcast.Dispelga = set_combine(sets.midcast['Enfeebling Magic'], {main="Daybreak"})

    ------------------------------------------------------------------------------------------------
    ----------------------------------------- Idle Sets --------------------------------------------
    ------------------------------------------------------------------------------------------------

    sets.idle = {
		range={ name="Linos", augments={'Mag. Evasion+15','"Regen"+2','INT+6 MND+6',}},
		head="Fili Calot +2",
		body="Fili Hongreline +2",
		hands={ name="Bunzi's Gloves", augments={'Path: A',}},
		legs="Fili Rhingrave +2",
		feet={ name="Nyame Sollerets", augments={'Path: B',}},
		neck={ name="Loricate Torque +1", augments={'Path: A',}},
		waist="Carrier's Sash",
		left_ear="Eabani Earring",
		right_ear="Etiolation Earring",
		left_ring="Defending Ring",
		right_ring="Shneddick Ring +1",
		back={ name="Intarabus's Cape", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','Occ. inc. resist. to stat. ailments+10',}},
        }
		
	sets.idle.Regain = set_combine(sets.idle, {
		neck="Rep. Plat. Medal",
	})

	
    ------------------------------------------------------------------------------------------------
    ---------------------------------------- Defense Sets ------------------------------------------
    ------------------------------------------------------------------------------------------------

    sets.defense.PDT = sets.idle.DT
    sets.defense.MDT = sets.idle.DT

    sets.Kiting = {}
    sets.latent_refresh = {}

    ------------------------------------------------------------------------------------------------
    ---------------------------------------- Engaged Sets ------------------------------------------
    ------------------------------------------------------------------------------------------------

    -- Engaged sets

    -- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
    -- sets if more refined versions aren't defined.
    -- If you create a set with both offense and defense modes, the offense mode should be first.
    -- EG: sets.engaged.Dagger.Accuracy.Evasion

	sets.engaged = {    
		range=Linos.TP,
		head="Aya. Zucchetto +2",
		body="Ayanmo Corazza +2",
		hands="Bunzi's Gloves",
		legs="Nyame Flanchard",
		feet="Nyame Sollerets",
		neck="Bard's Charm +2",
		waist="Sailfi Belt +1",
		left_ear="Brutal Earring",
		right_ear="Telos Earring",
		left_ring={name="Moonlight Ring", bag="wardrobe1"},
		right_ring={name="Moonlight Ring", bag="wardrobe2"},
		back={ name="Intarabus's Cape", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}},
        }
		
	sets.engaged.Acc = set_combine(sets.engaged, {
		})
	
	--sets.engaged.DNC = set_combine(sets.engaged,{})
	
	
    -- * DNC Subjob DW Trait: +15%
    -- * NIN Subjob DW Trait: +25%

    -- No Magic Haste (74% DW to cap)
    sets.engaged.DW = set_combine(sets.engaged, {	
		waist="Reiki Yotai", 
		right_ear="Telos Earring",
        })
		
	sets.engaged.DW.Acc = set_combine(sets.engaged.DW, {
		})


--Fix later this will really fug up Carn brd/dnc 	
    sets.engaged.Aftermath = {}



    ------------------------------------------------------------------------------------------------
    ---------------------------------------- Hybrid Sets -------------------------------------------
    ------------------------------------------------------------------------------------------------

    sets.engaged.Hybrid = {
		head="Nyame Helm",
		body="Ayanmo Corazza +2",
		hands="Bunzi's Gloves",
		legs="Nyame Flanchard", 
		feet="Nyame Sollerets",
		}

    sets.engaged.DT = set_combine(sets.engaged, sets.engaged.Hybrid)

    sets.engaged.DW.DT = set_combine(sets.engaged.DW, sets.engaged.Hybrid)

    ------------------------------------------------------------------------------------------------
    ---------------------------------------- Special Sets ------------------------------------------
    ------------------------------------------------------------------------------------------------

    sets.SongDWDuration = {main="Carnwenhan", sub="Kali"}

    sets.buff.Doom = {
        neck="Nicander's Necklace", --20
        --ring1="Saida Ring",  --15
        ring2="Eshmun's Ring",  --20
        waist="Gishdubar Sash", --10
        }

    sets.Obi = {}

    sets.Aeneas = {main="Aeneas", sub="Ternion Dagger +1"}
	--sets.Aeneas.Acc = {main="Aeneas", sub="Ternion Dagger +1"}
    --sets.Tauret = {main="Tauret", sub="Gleti's Knife"}
	--sets.Tauret.Acc = {main="Tauret", sub="Gleti's Knife"}
    sets.Naegling = {main="Naegling", sub="Fusetto +2"}
	sets.Naegling.Acc = sets.Naegling
	sets.MAB = {main="Tauret", sub="Malevolence"}
	--sets.MAB.Acc = {main="Tauret", sub="Ternion Dagger +1"}
	--sets.Staff = {main="Mpaca's Staff", sub="Enki Strap",}
	--sets.Staff.Acc = {main="Mpaca's Staff", sub="Enki Strap",}
	


    sets.DefaultShield = {sub="Genmei Shield"}

end


-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
-- Set eventArgs.useMidcastGear to true if we want midcast gear equipped on precast.
function job_precast(spell, action, spellMap, eventArgs)
    if spell.type == 'BardSong' then
        if spell.name == 'Honor March' then
            equip({range="Marsyas"})
        end
		--[[
        if string.find(spell.name,'Lullaby') then
            if buffactive.Troubadour then
                equip({range="Marsyas"})
            elseif state.LullabyMode.value == 'Harp' and spell.english:contains('Horde') then
				equip({range="Daurdabla"})
            else
                equip({range="Gjallarhorn"})
            end
        end]]--
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
    if spell.type == 'WeaponSkill' then
        if elemental_ws:contains(spell.name) then
            -- Matching double weather (w/o day conflict).
            if spell.element == world.weather_element and (get_weather_intensity() == 2 and spell.element ~= elements.weak_to[world.day_element]) then
                equip({waist="Hachirin-no-Obi"})
            -- Target distance under 1.7 yalms.
            elseif spell.target.distance < (1.7 + spell.target.model_size) then
                equip({waist="Orpheus's Sash"})
            -- Matching day and weather.
            elseif spell.element == world.day_element and spell.element == world.weather_element then
                equip({waist="Hachirin-no-Obi"})
            -- Target distance under 8 yalms.
            elseif spell.target.distance < (8 + spell.target.model_size) then
                equip({waist="Orpheus's Sash"})
            -- Match day or weather.
            elseif spell.element == world.day_element or spell.element == world.weather_element then
                equip({waist="Hachirin-no-Obi"})
            end
        end
    end
end

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_midcast(spell, action, spellMap, eventArgs)
    if spell.type == 'BardSong' then
        -- layer general gear on first, then let default handler add song-specific gear.
        local generalClass = get_song_class(spell)
        if generalClass and sets.midcast[generalClass] then
            equip(sets.midcast[generalClass])
        end
        if spell.name == 'Honor March' then
            equip({range="Marsyas"})
        end
        if string.find(spell.name,'Lullaby') then
            if buffactive.Troubadour then
                equip({range="Marsyas"})
            elseif state.LullabyMode.value == 'Harp' and spell.english:contains('Horde') then
                equip({range="Daurdabla"})
                equip(sets.midcast.SongStringSkill)
            else
                equip({range="Gjallarhorn"})
            end
        end
    end
end

function job_post_midcast(spell, action, spellMap, eventArgs)
    if spell.type == 'BardSong' then
        if player.status ~= 'Engaged' and state.WeaponLock.value == false and (player.sub_job == 'DNC' or player.sub_job == 'NIN') then
            equip(sets.SongDWDuration)
        end
    end
end

function job_aftercast(spell, action, spellMap, eventArgs)
    if spell.english:contains('Lullaby') and not spell.interrupted then
        get_lullaby_duration(spell)
    end
    if player.status ~= 'Engaged' and state.WeaponLock.value == false then
        check_weaponset()
    end
end

function job_buff_change(buff,gain)

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
        disable('main','sub')
    else
        enable('main','sub')
    end

    check_weaponset()
end

-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------

-- Called by the 'update' self-command, for common needs.
-- Set eventArgs.handled to true if we don't want automatic equipping of gear.
function job_handle_equipping_gear(playerStatus, eventArgs)
    check_gear()
    update_combat_form()
end

function job_update(cmdParams, eventArgs)
    handle_equipping_gear(player.status)
end

function update_combat_form()
	if S{'NIN'}:contains(player.sub_job) and brd_sub_weapons:contains(player.equipment.sub) then
        state.CombatForm:set("DW")
	elseif S{'DNC'}:contains(player.sub_job) and brd_sub_weapons:contains(player.equipment.sub) then
        state.CombatForm:set("DW")
	else
        state.CombatForm:reset()
    end
end

-- Called for direct player commands.
function job_self_command(cmdParams, eventArgs)
    if cmdParams[1]:lower() == 'etude' then
        send_command('@input /ma '..state.Etude.value..' <stpc>')
    elseif cmdParams[1]:lower() == 'carol' then
        send_command('@input /ma '..state.Carol.value..' <stpc>')
    elseif cmdParams[1]:lower() == 'threnody' then
        send_command('@input /ma '..state.Threnody.value..' <stnpc>')
    end

end

-- Modify the default melee set after it was constructed.
function customize_melee_set(meleeSet)
    if buffactive['Aftermath: Lv.3'] and player.equipment.main == "Carnwenhan" then
        meleeSet = set_combine(meleeSet, sets.engaged.Aftermath)
    end

    check_weaponset()

    return meleeSet
end

function get_custom_wsmode(spell, action, spellMap)
    local wsmode
    if state.OffenseMode.value == 'MidAcc' or state.OffenseMode.value == 'HighAcc' then
        wsmode = 'Acc'
    end

    return wsmode
end

-- Modify the default idle set after it was constructed.
function customize_idle_set(idleSet)

    if player.mpp < 51 then
        idleSet = set_combine(idleSet, sets.latent_refresh)
    end

    return idleSet
end

-- Set eventArgs.handled to true if we don't want the automatic display to be run.
function display_current_job_state(eventArgs)
    local cf_msg = ''
    if state.CombatForm.has_value then
        cf_msg = ' (' ..state.CombatForm.value.. ')'
    end

    local m_msg = state.OffenseMode.value
    if state.HybridMode.value ~= 'Normal' then
        m_msg = m_msg .. '/' ..state.HybridMode.value
    end

    local ws_msg = state.WeaponskillMode.value

    local c_msg = state.CastingMode.value

    local d_msg = 'None'
    if state.DefenseMode.value ~= 'None' then
        d_msg = state.DefenseMode.value .. state[state.DefenseMode.value .. 'DefenseMode'].value
    end

    local i_msg = state.IdleMode.value

    local msg = ''
    if state.Kiting.value then
        msg = msg .. ' Kiting: On |'
    end

    add_to_chat(002, '| ' ..string.char(31,210).. 'Melee' ..cf_msg.. ': ' ..string.char(31,001)..m_msg.. string.char(31,002)..  ' |'
        ..string.char(31,207).. ' WS: ' ..string.char(31,001)..ws_msg.. string.char(31,002)..  ' |'
        ..string.char(31,060).. ' Magic: ' ..string.char(31,001)..c_msg.. string.char(31,002)..  ' |'
        ..string.char(31,004).. ' Defense: ' ..string.char(31,001)..d_msg.. string.char(31,002)..  ' |'
        ..string.char(31,008).. ' Idle: ' ..string.char(31,001)..i_msg.. string.char(31,002)..  ' |'
        ..string.char(31,002)..msg)

    eventArgs.handled = true
end

-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

-- Determine the custom class to use for the given song.
function get_song_class(spell)
    -- Can't use spell.targets:contains() because this is being pulled from resources
    if set.contains(spell.targets, 'Enemy') then
        if state.CastingMode.value == 'Resistant' then
            return 'SongEnfeebleAcc'
        else
            return 'SongEnfeeble'
        end
    elseif state.SongMode.value == 'Placeholder' then
        return 'SongPlaceholder'
    else
        return 'SongEnhancing'
    end
end

function get_lullaby_duration(spell)
    local self = windower.ffxi.get_player()

    local troubadour = false
    local clarioncall = false
    local soulvoice = false
    local marcato = false

    for i,v in pairs(self.buffs) do
        if v == 348 then troubadour = true end
        if v == 499 then clarioncall = true end
        if v == 52 then soulvoice = true end
        if v == 231 then marcato = true end
    end

    local mult = 1

    if player.equipment.range == 'Daurdabla' then mult = mult + 0.3 end -- change to 0.25 with 90 Daur
    if player.equipment.range == "Gjallarhorn" then mult = mult + 0.4 end -- change to 0.3 with 95 Gjall
    if player.equipment.range == "Marsyas" then mult = mult + 0.5 end

    if player.equipment.main == "Carnwenhan" then mult = mult + 0.5 end -- 0.1 for 75, 0.4 for 95, 0.5 for 99/119
    if player.equipment.main == "Legato Dagger" then mult = mult + 0.05 end
    if player.equipment.main == "Kali" then mult = mult + 0.05 end
    if player.equipment.sub == "Kali" then mult = mult + 0.05 end
    if player.equipment.sub == "Legato Dagger" then mult = mult + 0.05 end
    if player.equipment.neck == "Aoidos' Matinee" then mult = mult + 0.1 end
    if player.equipment.neck == "Mnbw. Whistle" then mult = mult + 0.2 end
    if player.equipment.neck == "Mnbw. Whistle +1" then mult = mult + 0.3 end
    if player.equipment.body == "Fili Hongreline +2" then mult = mult + 0.13 end
    if player.equipment.legs == "Inyanga Shalwar +1" then mult = mult + 0.15 end
    if player.equipment.legs == "Inyanga Shalwar +2" then mult = mult + 0.17 end
    if player.equipment.feet == "Brioso Slippers" then mult = mult + 0.1 end
    if player.equipment.feet == "Brioso Slippers +1" then mult = mult + 0.11 end
    if player.equipment.feet == "Brioso Slippers +3" then mult = mult + 0.13 end
    if player.equipment.feet == "Brioso Slippers +3" then mult = mult + 0.15 end
    if player.equipment.hands == 'Brioso Cuffs +1' then mult = mult + 0.1 end
    if player.equipment.hands == 'Brioso Cuffs +2' then mult = mult + 0.1 end
    if player.equipment.hands == 'Brioso Cuffs +3' then mult = mult + 0.2 end

    --JP Duration Gift
    if self.job_points.brd.jp_spent >= 1200 then
        mult = mult + 0.05
    end

    if troubadour then
        mult = mult * 2
    end

    if spell.en == "Foe Lullaby II" or spell.en == "Horde Lullaby II" then
        base = 60
    elseif spell.en == "Foe Lullaby" or spell.en == "Horde Lullaby" then
        base = 30
    end

    totalDuration = math.floor(mult * base)

    -- Job Points Buff
    totalDuration = totalDuration + self.job_points.brd.lullaby_duration
    if troubadour then
        totalDuration = totalDuration + self.job_points.brd.lullaby_duration
        -- adding it a second time if Troubadour up
    end

    if clarioncall then
        if troubadour then
            totalDuration = totalDuration + (self.job_points.brd.clarion_call_effect * 2 * 2)
            -- Clarion Call gives 2 seconds per Job Point upgrade.  * 2 again for Troubadour
        else
            totalDuration = totalDuration + (self.job_points.brd.clarion_call_effect * 2)
            -- Clarion Call gives 2 seconds per Job Point upgrade.
        end
    end

    if marcato and not soulvoice then
        totalDuration = totalDuration + self.job_points.brd.marcato_effect
    end

    -- Create the custom timer
    if spell.english == "Foe Lullaby II" or spell.english == "Horde Lullaby II" then
        send_command('@timers c "Lullaby II ['..spell.target.name..']" ' ..totalDuration.. ' down spells/00377.png')
    elseif spell.english == "Foe Lullaby" or spell.english == "Horde Lullaby" then
        send_command('@timers c "Lullaby ['..spell.target.name..']" ' ..totalDuration.. ' down spells/00376.png')
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


function check_weaponset()
    if state.OffenseMode.value == 'Acc' then
        equip(sets[state.WeaponSet.current].Acc)
    else
        equip(sets[state.WeaponSet.current])
    end
    if player.sub_job ~= 'NIN' and player.sub_job ~= 'DNC' then
        equip(sets.DefaultShield)
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
    set_macro_page(1, 3)
end

function set_lockstyle()
    send_command('wait 2; input /lockstyleset ' .. lockstyleset)
end