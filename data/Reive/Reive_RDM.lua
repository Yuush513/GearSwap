-------------------------------------------------------------------------------------------------------------------
-- Setup functions for this job.  Generally should not be modified.
-------------------------------------------------------------------------------------------------------------------

--[[
ChangeNotes 4/13/22

Fixed RefreshOthers during Composure

Fixed Saboteur Gloves
Begun adding Haste Detection
Cleaned Up Weaponsets, Keybinds
Added NoResist
Optomized more sets

]]--

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
--              [ F8 ]           	Magic Burst Mode Toggle
--
--  Weapons:    [ CTRL+W ]          Toggles Weapon Lock
--				[ CTRL+INS]         Cycle Weaponset
--				[ CTRL+DEL]         Cycleback Weaponset
--
--	Toggles	    [ CTRL+HOME ]       Cycle Enspell
--				[ CTRL+END ]        Toggle EnspellMode
--				[ CTRL+PgUp ]       Cycle GainSpell
--				[ CTRL+PgDn ]       Cycleback GainSpell
--				[ ALT+HOME ]        Cycle BarElement
--				[ ALT+END ]         Cycleback BarElement
--				[ ALT+PgUp ]        Cycle BarStatus
--				[ ALT+PgDn ]        Cycleback BarStatus
--
--    			[ WIN+S ]   		Cycle SleepMode
--    			[ WIN+D ]			Toggle NM
--    			[ ALT+W ]			Toggle WeaponLock
--    			[ ALT+= ]			Toggle TreasureMode
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

    -- state.CP = M(false, "Capacity Points Mode")
    state.Buff.Composure = buffactive.Composure or false
    state.Buff.Saboteur = buffactive.Saboteur or false
    state.Buff.Stymie = buffactive.Stymie or false
	
	rdm_sub_weapons = S{"Tauret", "Ternion Dagger +1", "Blurred Knife +1", "Gleti's Knife", "Machaera +2", "Daybreak", "Bunzi's Rod", }

    enfeebling_magic_acc = S{'Bind', 'Break', 'Dispel', 'Distract', 'Distract II', 'Frazzle', 'Frazzle II', 'Silence'}
    enfeebling_magic_skill = S{'Distract III',  'Poison II', 'Frazzle III',}
    enfeebling_magic_effect = S{ 'Blind', 'Blind II', 'Gravity', 'Gravity II',}
    enfeebling_magic_sleep = S{'Sleep', 'Sleep II', 'Sleepga',}
	enfeebling_magic_noresist = S{'Dia', 'Dia II', 'Dia III', 'Diaga', 'Inundation'}
	
	elemental_ws = S{"Aeolian Edge", "Red Lotus Blade", "Seraph Blade", "Sanguine Blade"}

    skill_spells = S{
        'Temper', 'Temper II', 'Enfire', 'Enfire II', 'Enblizzard', 'Enblizzard II', 'Enaero', 'Enaero II',
        'Enstone', 'Enstone II', 'Enthunder', 'Enthunder II', 'Enwater', 'Enwater II'}

    include('Mote-TreasureHunter')

    -- For th_action_check():
    -- JA IDs for actions that always have TH: Provoke, Animated Flourish
    info.default_ja_ids = S{35, 204}
    -- Unblinkable JA IDs for actions that always have TH: Quick/Box/Stutter Step, Desperate/Violent Flourish
    info.default_u_ja_ids = S{201, 202, 203, 205, 207}

    lockstyleset = 20
	
end

-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
    state.OffenseMode:options('Normal', 'MidAcc', 'HighAcc')
    state.HybridMode:options('Normal', 'DT')
	state.WeaponskillMode:options('Normal', 'AtkCap')
    state.CastingMode:options('Normal', 'Resistant')
    state.IdleMode:options('Normal','DT')
    
	state.EnSpell = M{['description']='EnSpell', 'Enfire', 'Enblizzard', 'Enaero', 'Enstone', 'Enthunder', 'Enwater'}
    state.BarElement = M{['description']='BarElement', 'Barfire', 'Barblizzard', 'Baraero', 'Barstone', 'Barthunder', 'Barwater'}
    state.BarStatus = M{['description']='BarStatus', 'Baramnesia', 'Barvirus', 'Barparalyze', 'Barsilence', 'Barpetrify', 'Barpoison', 'Barblind', 'Barsleep'}
    state.GainSpell = M{['description']='GainSpell', 'Gain-STR', 'Gain-INT', 'Gain-AGI', 'Gain-VIT', 'Gain-DEX', 'Gain-MND', 'Gain-CHR'}

    state.WeaponLock = M(false, 'Weapon Lock')
    state.MagicBurst = M(false, 'Magic Burst')
    state.SleepMode = M{['description']='Sleep Mode', 'Normal', 'MaxDuration'}
    state.EnspellMode = M(false, 'Enspell Melee Mode')
    state.NM = M(false, 'NM?')
	state.MagicBurst = M(false, 'Magic Burst')
	--state.HasteMode = M{['description']='Haste Mode', 'Hi', 'Normal'}
	
	state.WeaponSet = M{['description']='Weapon Set', 'CroceaPhy', 'Naegling',  'Maxentius', 'TauretPhy',
										              'TauretMag', 'CroceaMag_R', 'CroceaMagS', } --'Sequence', 'NoTP', 'Fists', 
	
    send_command('bind f8 gs c toggle MagicBurst')	
	send_command('bind !f9 gs c cycle WeaponskillMode')
	
	send_command('bind ^insert gs c cycle WeaponSet')
    send_command('bind ^delete gs c cycleback WeaponSet')	
    send_command('bind ^home gs c cycle EnSpell')
    send_command('bind ^end gs c cycle EnspellMode')
    send_command('bind ^pageup gs c cycle GainSpell')
    send_command('bind ^pagedown gs c cycleback GainSpell')
	

	send_command('bind !home gs c cycle BarElement')
    send_command('bind !end gs c cycleback BarElement')
    send_command('bind !pageup gs c cycle BarStatus')
    send_command('bind !pagedown gs c cycleback BarStatus')
	
	
    send_command('bind @s gs c cycle SleepMode')
    send_command('bind @d gs c toggle NM')
    send_command('bind ^w gs c toggle WeaponLock')
	send_command('bind ^= gs c cycle treasuremode')

    select_default_macro_book()
    set_lockstyle()

    DW = false
    update_combat_form()
	

end


-- Define sets and vars used by this job file.
function init_gear_sets()

	Sucellos = {}
	Sucellos.STR_WSD = { name="Sucellos's Cape", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%','Phys. dmg. taken-10%',}}
	Sucellos.MND_WSD = { name="Sucellos's Cape", augments={'MND+20','Accuracy+20 Attack+20','MND+10','Weapon skill damage +10%',}}
	Sucellos.MND_WSD2 = { name="Sucellos's Cape", augments={'MND+20','Mag. Acc+20 /Mag. Dmg.+20','MND+10','Weapon skill damage +10%','Phys. dmg. taken-10%',}}
	Sucellos.INT_WSD = { name="Sucellos's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','INT+10','Weapon skill damage +10%','Phys. dmg. taken-10%',}}
	Sucellos.MAB = { name="Sucellos's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','INT+10','"Mag.Atk.Bns."+10',}}
	Sucellos.CRIT = { name="Sucellos's Cape", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','Crit.hit rate+10',}}
	Sucellos.STP = { name="Sucellos's Cape", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Store TP"+10','Phys. dmg. taken-10%',}}
	Sucellos.DW = { name="Sucellos's Cape", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dual Wield"+10','Phys. dmg. taken-10%',}}
	Sucellos.Tank = { name="Sucellos's Cape", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','Enmity+10','Chance of successful block +5',}}
	Sucellos.FC={ name="Sucellos's Cape", augments={'MND+20','Mag. Acc+20 /Mag. Dmg.+20','Mag. Acc.+10','"Fast Cast"+10',}}
	
	Chironic = {}
	Chironic_Hose_MND = { name="Chironic Hose", augments={'Mag. Acc.+16 "Mag.Atk.Bns."+16','"Resist Silence"+10','MND+15','Mag. Acc.+14','"Mag.Atk.Bns."+10',}}
	Chironic_Hose_INT = { name="Chironic Hose", augments={'Mag. Acc.+24 "Mag.Atk.Bns."+24','Spell interruption rate down -6%','INT+5','Mag. Acc.+15','"Mag.Atk.Bns."+8',}}
	
	Chironic_Hands_FC = { name="Chironic Gloves", augments={'"Mag.Atk.Bns."+14','"Fast Cast"+7','MND+5','Mag. Acc.+2',}}
	
    ------------------------------------------------------------------------------------------------
    ---------------------------------------- Precast Sets ------------------------------------------
    ------------------------------------------------------------------------------------------------
	
	-- JA sets
	
    sets.precast.JA['Chainspell'] = {body="Viti. Tabard +3"}
	
    -- Spell sets
    -- 38 FC
    sets.precast.FC = {
		ammo="Impatiens",
		head="Atrophy Chapeau +3",
		body="Ros. Jaseran +1",
		hands=Chironic_Hands_FC,
		legs="Bunzi's Pants",
		feet="Nyame Sollerets",
		neck="Loricate Torque +1",
		waist="Witful Belt",
		left_ear="Magnetic Earring",
		right_ear="Etiolation Earring",
		left_ring="Defending Ring",
		right_ring="Lebeche Ring",
		back="Fi Follet Cape +1",
		} 

    sets.precast.FC['Enhancing Magic'] = set_combine(sets.precast.FC, {})
    
	sets.precast.FC.Cure = set_combine(sets.precast.FC, {})
    
	sets.precast.FC.Curaga = sets.precast.FC.Cure
   
	sets.precast.FC['Healing Magic'] = sets.precast.FC.Cure
    
	sets.precast.FC['Elemental Magic'] = set_combine(sets.precast.FC, {})

    sets.precast.FC.Impact = set_combine(sets.precast.FC, {    
		main="Crocea Mors",
		sub="Sacro Bulwark",
		ammo="Impatiens",
		head=empty,
		body="Crepuscular Cloak",
		hands=Chironic_Hands_FC,
		legs="Aya. Cosciales +2",
		feet="Carmine Greaves +1",
		neck="Orunmila's Torque",
		waist="Witful Belt",
		left_ear="Malignance Earring",
		right_ear="Etiolation Earring",
		left_ring="Kishar Ring",
		right_ring="Lebeche Ring",
		back="Fi Follet Cape +1",
        })
		
    sets.precast.FC.Dispelga = set_combine(sets.precast.FC, {main="Daybreak"})
    sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, {})
  
    ------------------------------------------------------------------------------------------------
    -------------------------------------- Weaponskill Sets ----------------------------------------
    ------------------------------------------------------------------------------------------------ 
   
   sets.precast.WS = {
		ammo="Crepuscular pebble",
		head={ name="Nyame Helm", augments={'Path: B',}},
		body={ name="Nyame Mail", augments={'Path: B',}},
		hands={ name="Nyame Gauntlets", augments={'Path: B',}},
		legs={ name="Nyame Flanchard", augments={'Path: B',}},
		feet="Leth. Houseaux +3",
		neck="Rep. Plat. Medal",
		waist={ name="Sailfi Belt +1", augments={'Path: A',}},
		left_ear={ name="Moonshade Earring", augments={'"Mag.Atk.Bns."+4','TP Bonus +250',}},
		right_ear="Sherida Earring",
		left_ring="Cornelia's Ring",
		right_ring="Epaminondas's Ring",
		back=Sucellos.STR_WSD,
        }

	--sets.precast.WS.AtkCap = set_combine(sets.precast.WS, {ammo="Crepuscular Pebble",})

    sets.precast.WS['Savage Blade'] = set_combine(sets.precast.WS, {})	
    --sets.precast.WS['Savage Blade'].AtkCap  = set_combine(sets.precast.WS.AtkCap , {})
	
    sets.precast.WS['Chant du Cygne'] = {
		ammo="Coiste Bodhar",
		head="Blistering Sallet +1",
		body="Ayanmo Corazza +2",
		hands="Malignance Gloves",
		legs="Zoar Subligar +1",
		feet="Aya. Gambieras +2",
		neck="Fotia Gorget",
		waist="Fotia Belt",
		left_ear="Mache Earring +1",
		right_ear="Sherida Earring",
		left_ring="Ilabrat Ring",
		right_ring="Begrudging Ring",
		back=Sucellos.CRIT,
		}

    sets.precast.WS['Vorpal Blade'] = sets.precast.WS['Chant du Cygne']

    sets.precast.WS['Death Blossom'] = set_combine(sets.precast.WS, {back=Sucellos.MND_WSD})
    --sets.precast.WS['Death Blossom'].AtkCap = set_combine(sets.precast.WS.AtkCap, {left_ring="Metamor. Ring +1", back=Sucellos.MND_WSD})

    sets.precast.WS['Requiescat'] = set_combine(sets.precast.WS, {})
    --sets.precast.WS['Requiescat'].AtkCap = set_combine(sets.precast.WS.AtkCap, {})
	
	sets.precast.WS['Red Lotus Blade'] = {
		ammo="Sroda Tathlum",
		head="Leth. Chappel +3",
		body={ name="Nyame Mail", augments={'Path: B',}},
		hands="Jhakri Cuffs +2",
		legs="Leth. Fuseau +3",
		feet="Leth. Houseaux +3",
		neck="Sibyl Scarf",
		waist="Orpheus's Sash",
		left_ear={ name="Moonshade Earring", augments={'"Mag.Atk.Bns."+4','TP Bonus +250',}},
		right_ear="Malignance Earring",
		left_ring="Cornelia's Ring",
		right_ring="Epaminondas's Ring",
		back=Sucellos.INT_WSD,
		}
		
	sets.precast.WS['Burning Blade'] = sets.precast.WS['Red Lotus Blade']
	
    sets.precast.WS['Sanguine Blade'] = set_combine(sets.precast.WS['Red Lotus Blade'], {
		head="Pixie Hairpin +1",
		left_ear="Regal Earring",
		right_ring="Archon Ring",
		back=Sucellos.MND_WSD2,
        })

    sets.precast.WS['Seraph Blade'] = set_combine(sets.precast.WS['Red Lotus Blade'], {
		ammo="Pemphredo Tathlum",
		back=Sucellos.MND_WSD2,
		})
	
	sets.precast.WS['Shining Blade'] = sets.precast.WS['Seraph Blade']
    
	sets.precast.WS['Aeolian Edge'] = set_combine(sets.precast.WS['Red Lotus Blade'], {})

	sets.precast.WS['Evisceration'] = sets.precast.WS['Chant du Cygne']
	

		
    sets.precast.WS['Black Halo'] = set_combine(sets.precast.WS, {
		right_ear="Regal Earring",
		})
		
    --sets.precast.WS['Black Halo'].AtkCap = set_combine(sets.precast.WS.AtkCap, {back=Sucellos.MND_WSD})

	

    ------------------------------------------------------------------------------------------------
    ---------------------------------------- Midcast Sets ------------------------------------------
    ------------------------------------------------------------------------------------------------

    sets.midcast.FastRecast = sets.precast.FC

    sets.midcast.SpellInterrupt = sets.precast.FC

    sets.midcast.Cure = {
		main="Crocea Mors",
		sub="Sacro Bulwark",
		ammo="Regal Gem",
		head="Kaykaus Mitra +1",
		body="Kaykaus Bliaut",
		hands="Kaykaus Cuffs +1",
		legs="Atrophy Tights +3",
		feet="Kaykaus Boots +1",
		neck="Incanter's Torque",
		waist="Shinjutsu-no-Obi +1",
		left_ear="Magnetic Earring",
		right_ear="Meili Earring",
		left_ring="Menelaus's Ring",
		right_ring="Defending Ring",
		back="Fi Follet Cape +1",
	}

    sets.midcast.CureWeather = set_combine(sets.midcast.Cure, {
	    main="Chatoyant Staff",
		sub="Enki Strap",
		waist="Hachirin-no-Obi",
	})

    sets.midcast.CureSelf = set_combine(sets.midcast.Cure, {})

    sets.midcast.Curaga = set_combine(sets.midcast.Cure, {})

    sets.midcast.StatusRemoval = {}

    sets.midcast.Cursna = set_combine(sets.midcast.StatusRemoval, {
	    ammo="Homiliary",
		head={ name="Vanya Hood", augments={'Healing magic skill +20','"Cure" spellcasting time -7%','Magic dmg. taken -3',}},
		body="Viti. Tabard +3",
		--hands=,
		legs={ name="Vanya Slops", augments={'Healing magic skill +20','"Cure" spellcasting time -7%','Magic dmg. taken -3',}},
		feet={ name="Vanya Clogs", augments={'Healing magic skill +20','"Cure" spellcasting time -7%','Magic dmg. taken -3',}},
		neck="Debilis Medallion",
		waist="Witful Belt",
		left_ear="Beatific Earring",
		right_ear="Meili Earring",
		left_ring="Menelaus's Ring",
		right_ring="Haoma's Ring",
		back="Oretan. Cape +1",
	})

    sets.midcast['Enhancing Magic'] = {
		main={ name="Colada", augments={'Enh. Mag. eff. dur. +4','INT+6','Mag. Acc.+7','DMG:+1',}},
		sub="Ammurapi Shield",
		head={ name="Telchine Cap", augments={'Mag. Evasion+23','"Conserve MP"+5','Enh. Mag. eff. dur. +10',}},
		body="Viti. Tabard +3",
		hands="Atrophy Gloves +3",
		legs="Shedir Seraweels",
		feet="Leth. Houseaux +3",
		neck="Dls. Torque +2",
		waist="Embla Sash",
		left_ear="Mimir Earring",
		right_ear="Leth. Earring +1",
		left_ring={name="Stikini Ring +1", bag="wardrobe1"},
		right_ring={name="Stikini Ring +1", bag="wardrobe2"},
		back="Ghostfyre Cape",
        }

    sets.midcast.EnhancingDuration = set_combine(sets.midcast['Enhancing Magic'], {
		legs={ name="Telchine Braconi", augments={'Mag. Evasion+19','"Conserve MP"+5','Enh. Mag. eff. dur. +10',}},
		})

    sets.midcast.EnhancingSkill = {
		main="Pukulatmuj +1",
		sub="Forfend +1",
		range=empty,
		ammo="Crepuscular Pebble",
		head="Befouled Crown",
		body="Viti. Tabard +3",
		hands="Viti. Gloves +3",
		legs="Atrophy Tights +3",
		feet="Leth. Houseaux +3",
		neck="Incanter's Torque",
		waist="Olympus Sash",
		left_ear="Mimir Earring",
		right_ear="Andoaa Earring",
		left_ring={name="Stikini Ring +1", bag="wardrobe1"},
		right_ring={name="Stikini Ring +1", bag="wardrobe2"},
		back="Ghostfyre Cape",
		}

    sets.midcast.Regen = set_combine(sets.midcast.EnhancingDuration, {
		main="Bolelabunga",
		body={ name="Telchine Chas.", augments={'Mag. Evasion+23','"Conserve MP"+4','Enh. Mag. eff. dur. +10',}},
        })

    sets.midcast.Refresh = set_combine(sets.midcast.EnhancingDuration, {
		head="Amalric Coif +1",
		body="Atrophy Tabard +3",
		legs="Leth. Fuseau +3",
        })

    sets.midcast.RefreshSelf = {waist="Gishdubar Sash"}

    sets.midcast.Stoneskin = set_combine(sets.midcast.EnhancingDuration, {})

    sets.midcast['Phalanx'] = {
		main="Sakpata's Sword",
		sub="Ammurapi Shield",
		ammo="Homiliary",
		head={ name="Merlinic Hood", augments={'Rng.Acc.+25','INT+15','Phalanx +4','Accuracy+19 Attack+19','Mag. Acc.+6 "Mag.Atk.Bns."+6',}},
		body={ name="Taeon Tabard", augments={'Mag. Evasion+15','"Fast Cast"+5','Phalanx +3',}},
		hands={ name="Taeon Gloves", augments={'Mag. Evasion+19','Spell interruption rate down -10%','Phalanx +3',}},
		legs={ name="Merlinic Shalwar", augments={'Pet: "Mag.Atk.Bns."+1','AGI+3','Phalanx +5','Accuracy+5 Attack+5','Mag. Acc.+14 "Mag.Atk.Bns."+14',}},
		feet={ name="Merlinic Crackows", augments={'Accuracy+14 Attack+14','STR+9','Phalanx +5','Mag. Acc.+14 "Mag.Atk.Bns."+14',}},
		neck="Dls. Torque +2", 
		waist="Embla Sash",
		left_ear="Mimir Earring",
		right_ear="Leth. Earring +1",
		left_ring="Defending Ring",
		right_ring="Gelatinous Ring +1",
		back="Ghostfyre Cape",
		}

    sets.midcast.Aquaveil = set_combine(sets.midcast.EnhancingDuration, {
        head="Amalric Coif +1",
		waist="Emphatikos Rope",
        })

    sets.midcast.Storm = sets.midcast.EnhancingDuration
    sets.midcast.GainSpell = {hands="Viti. Gloves +3"}
    sets.midcast.SpikesSpell = {}

    sets.midcast.Protect = set_combine(sets.midcast.EnhancingDuration, {})
    sets.midcast.Protectra = sets.midcast.Protect
    sets.midcast.Shell = sets.midcast.Protect
    sets.midcast.Shellra = sets.midcast.Shell
--[[	
Magic Accuracy Skill +228: Magic Accuracy +115
Magic Accuracy Skill +242: Magic Accuracy +122
Magic Accuracy Skill +255: Magic Accuracy +128
Magic Accuracy Skill +269: Magic Accuracy +135
]]--

--Enfeebling(Effect y/n , dStat, notes)--

-- Y -+75 dMND
	sets.midcast['Slow II'] = {
		main="Bunzi's Rod",
		sub="Ammurapi Shield",
		range=empty,
		ammo="Regal Gem",
		head="Viti. Chapeau +3",
		body="Lethargy Sayon +3",
		hands="Leth. Ganth. +3",
		legs=Chironic_Hose_MND,
		feet="Vitiation Boots +3",
		neck="Dls. Torque +2",
		waist="Obstin. Sash",
		left_ear="Malignance Earring",
		right_ear="Snotra Earring",
		left_ring="Metamor. Ring +1",
		right_ring={name="Stikini Ring +1", bag="wardrobe2"},
		back=Sucellos.FC
		}
	sets.midcast['Slow'] = sets.midcast['Slow II']

-- Y -+40 dMND	
	sets.midcast['Paralyze II'] = sets.midcast['Slow II']
	sets.midcast['Paralyze'] = sets.midcast['Slow II']

-- Y -+100 dMND
	sets.midcast['Addle II'] = set_combine(sets.midcast['Slow II'], {main="Daybreak"})
	sets.midcast['Addle'] = set_combine(sets.midcast['Slow II'], {main="Daybreak"})

-- Y -+120 dINT	
	sets.midcast['Blind II'] = {
	    main="Bunzi's Rod",
		sub="Ammurapi Shield",
		range=empty,
		ammo="Regal Gem",
		head="Atrophy Chapeau +3",
		body="Lethargy Sayon +3",
		hands="Leth. Ganth. +3",
		legs=Chironic_Hose_INT,
		feet="Vitiation Boots +3",
		neck="Dls. Torque +2",
		waist="Acuity Belt +1",
		left_ear="Malignance Earring",
		right_ear="Regal Earring",
		left_ring="Metamor. Ring +1",
		right_ring={name="Stikini Ring +1", bag="wardrobe2"},
		back=Sucellos.INT_WSD,
		}
	sets.midcast['Blind'] = sets.midcast['Blind II']

-- Y no dStat
	sets.midcast['Gravity II'] = {
	    main="Crocea Mors",
		sub="Ammurapi Shield",
		range=empty,
		ammo="Regal Gem",
		head="Viti. Chapeau +3", 
		body="Lethargy Sayon +3",
		hands="Leth. Ganth. +3",
		legs=Chironic_Hose_INT,
		feet="Vitiation Boots +3",
		neck="Dls. Torque +2",
		waist="Obstin. Sash",
		left_ear="Malignance Earring",
		right_ear="Snotra Earring",
		left_ring="Kishar Ring",
		right_ring={name="Stikini Ring +1", bag="wardrobe2"},
		back=Sucellos.FC,
		}	
	sets.midcast['Gravity'] = sets.midcast['Gravity II']
	
-- N no dStat	
	sets.midcast['Bind'] = {
	    main="Crocea Mors",
		sub="Ammurapi Shield",
		range="Ullr",
		head="Viti. Chapeau +3",
		body="Atrophy Tabard +3",
		hands="Leth. Ganth. +3",
		legs=Chironic_Hose_INT,
		feet="Vitiation Boots +3",
		neck="Dls. Torque +2", 
		waist="Obstin. Sash",
		left_ear="Regal Earring",
		right_ear="Snotra Earring",
		left_ring="Kishar Ring",
		right_ring={name="Stikini Ring +1", bag="wardrobe2"},
		back="Aurist's Cape +1", 
	}
	
-- N no dStat	
	sets.midcast['Break'] = sets.midcast['Bind']
	
-- N no dStat	
	sets.midcast['Silence'] = sets.midcast['Bind']
	
-- N no dStat	
    sets.midcast.Sleep = sets.midcast['Bind']
	
    sets.midcast.SleepMaxDuration = set_combine(sets.midcast.Sleep, {
      --  head="Leth. Chappel +3",
		--body="Lethargy Sayon +3",
		--hands="Leth. Gantherots +3",
        --hands = "Regal Cuffs",
       -- legs="Leth. Fuseau +3",
       -- feet="Leth. Houseaux +3",
        })

-- Full MagicAcc
	sets.midcast['Dispel'] = {
	    main="Crocea Mors",
		sub="Ammurapi Shield",
		range="Ullr",
		head="Viti. Chapeau +3",
		body="Atrophy Tabard +3",
		hands="Leth. Ganth. +3",
		legs=Chironic_Hose_INT,
		feet="Vitiation Boots +3",
		neck="Dls. Torque +2", 
		waist="Obstin. Sash",
		left_ear="Regal Earring",
		right_ear="Snotra Earring",
		left_ring={name="Stikini Ring +1", bag="wardrobe1"},
		right_ring={name="Stikini Ring +1", bag="wardrobe2"},
		back="Aurist's Cape +1", 
		}
		
	sets.midcast['Dispelga'] = set_combine(sets.midcast['Dispel'], {main = "Daybreak"})
	sets.midcast['Distract'] = sets.midcast['Dispel']
	sets.midcast['Distract II'] = sets.midcast['Dispel']
	sets.midcast['Frazzle'] = sets.midcast['Dispel']
	sets.midcast['Frazzle II'] = sets.midcast['Dispel']

-- Y +50 dMND 610skill
	sets.midcast['Distract III'] = {
		main="Crocea Mors",
		sub="Ammurapi Shield",
		ammo="Regal Gem",
		head="Viti. Chapeau +3", 
		body="Lethargy Sayon +3",
		hands="Leth. Ganth. +3",
		legs=Chironic_Hose_MND,
		feet="Vitiation Boots +3",
		neck="Dls. Torque +2",
		waist="Obstin. Sash",
		left_ear="Malignance Earring",
		right_ear="Snotra Earring",
		left_ring={name="Stikini Ring +1", bag="wardrobe1"},
		right_ring={name="Stikini Ring +1", bag="wardrobe2"},
		back=Sucellos.FC,
		}
-- Y +50 dMND 625skill
	sets.midcast['Frazzle III'] = sets.midcast['Distract III']
-- Y no dStat?? No Known Cap
	sets.midcast['Poison II'] = sets.midcast['Distract III']
	sets.midcast['Poison'] = sets.midcast['Distract III']
	
--Dia and Inundation
	sets.midcast.NoResist = {
		main="Daybreak",
		sub="Ammurapi Shield",
		ammo="Regal Gem",
		head="Leth. Chappel +1",
		body="Lethargy Sayon +3",
		hands="Leth. Ganth. +3",
		legs="Leth. Fuseau +3",
		feet="Leth. Houseaux +3",
		neck="Dls. Torque +2",
		waist="Obstin. Sash",
		left_ear="Malignance Earring",
		right_ear="Snotra Earring",
		left_ring="Kishar Ring",
		right_ring="Metamor. Ring +1",
		back=Sucellos.MAB,
	}

	--Dark Magic Sets

    sets.midcast['Dark Magic'] = {
		main={ name="Rubicundity", augments={'Mag. Acc.+8','"Mag.Atk.Bns."+9','Dark magic skill +8','"Conserve MP"+6',}},
		sub="Ammurapi Shield",
		range="Ullr",
		head="Atrophy Chapeau +3",
		body="Atrophy Tabard +3",
		hands="Bunzi's Gloves",
		legs="Atrophy Tights +3",
		feet="Leth. Houseaux +3",
		neck="Erra Pendant",
		waist="Acuity Belt +1",
		left_ear="Malignance Earring",
		right_ear="Crep. Earring",
		left_ring={name="Stikini Ring +1", bag="wardrobe1"},
		right_ring="Evanescence Ring",
		back="Aurist's Cape +1",
        }
	
    sets.midcast.Drain = {
		main={ name="Rubicundity", augments={'Mag. Acc.+8','"Mag.Atk.Bns."+9','Dark magic skill +8','"Conserve MP"+6',}},
		sub="Ammurapi Shield",
		range="Ullr",
		head="Pixie Hairpin +1",
		body={ name="Merlinic Jubbah", augments={'Mag. Acc.+29','"Drain" and "Aspir" potency +10','MND+5',}},
		hands="Leth. Ganth. +3",
		legs="Leth. Fuseau +3",
		feet={ name="Merlinic Crackows", augments={'Mag. Acc.+21 "Mag.Atk.Bns."+21','"Drain" and "Aspir" potency +10','Mag. Acc.+13',}},
		neck="Erra Pendant",
		waist="Fucho-no-Obi",
		left_ear="Malignance Earring",
		right_ear="Crep. Earring",
		left_ring="Archon Ring",
		right_ring="Evanescence Ring",
		back={ name="Aurist's Cape +1", augments={'Path: A',}},
        }

    sets.midcast.Aspir = sets.midcast.Drain
	
	--38FC from traits
    sets.midcast.Stun = {
		main="Crocea Mors",
		sub="Ammurapi Shield",
		range="Ullr",
		head="Atrophy Chapeau +3",
		body="Viti. Tabard +3",
		hands="Malignance Gloves",
		legs="Malignance Tights",
		feet="Leth. Houseaux +3",
		neck="Erra Pendant",
		waist="Acuity Belt +1",
		left_ear="Malignance Earring",
		right_ear="Regal Earring",
		left_ring={name="Stikini Ring +1", bag="wardrobe1"},
		right_ring={name="Stikini Ring +1", bag="wardrobe2"},
		back={ name="Sucellos's Cape", augments={'MND+20','Mag. Acc+20 /Mag. Dmg.+20','Mag. Acc.+10','"Fast Cast"+10',}}
	}

	--Elemental Magic Sets

    sets.midcast['Elemental Magic'] = {
		main={ name="Bunzi's Rod", augments={'Path: A',}},
		sub="Ammurapi Shield",
		ammo={ name="Ghastly Tathlum +1", augments={'Path: A',}},
		head="Leth. Chappel +3",
		body = "Lethargy Sayon +3",
		hands="Leth. Ganth. +3",
		legs="Leth. Fuseau +3",
		feet="Leth. Houseaux +3",
		neck="Sibyl Scarf",
		waist={ name="Acuity Belt +1", augments={'Path: A',}},
		left_ear="Regal Earring",
		right_ear="Malignance Earring",
		left_ring={ name="Metamor. Ring +1", augments={'Path: A',}},
		right_ring="Freke Ring",
		back={ name="Sucellos's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','INT+10','"Mag.Atk.Bns."+10',}},
        }

    sets.midcast['Elemental Magic'].Resistant = set_combine(sets.midcast['Elemental Magic'], {})

    sets.midcast.Impact = {
		main="Crocea Mors",
		sub="Ammurapi Shield",
		range="Ullr",
		head=empty,
		body="Crepuscular Cloak",
		hands="Leth. Ganth. +3",
		legs="Leth. Fuseau +3",
		feet="Leth. Houseaux +3",
		neck={ name="Dls. Torque +2", augments={'Path: A',}},
		waist={ name="Sailfi Belt +1", augments={'Path: A',}},
		left_ear="Snotra Earring",
		right_ear="Malignance Earring",
		left_ring="Stikini Ring +1",
		right_ring={ name="Metamor. Ring +1", augments={'Path: A',}},
		back={ name="Aurist's Cape +1", augments={'Path: A',}},
		}
	
	sets.magic_burst = set_combine(sets.midcast['Elemental Magic'], {
		--head="Ea Hat +1",
		--body="Ea Houppe. +1",
		legs="Leth. Fuseau +3",
		neck="Mizu. Kubikazari",
		left_ring="Mujin Band",
		})
	
    sets.midcast.Utsusemi = sets.midcast.SpellInterrupt

    -- Initializes trusts at iLvl 119
    sets.midcast.Trust = sets.precast.FC

    -- Job-specific buff sets
    sets.buff.ComposureOther = {
        head = "Leth. Chappel +3",
        body = "Lethargy Sayon +3",
        legs = "Leth. Fuseau +3",
        feet = "Leth. Houseaux +3",
        }

    sets.buff.Saboteur = {hands="Leth. Ganth. +3",}

    -- Resting sets
    sets.resting = {}
    

    -- Idle sets
    sets.idle = {
		ammo="Homiliary",
		head={ name="Viti. Chapeau +3", augments={'Enfeebling Magic duration','Magic Accuracy',}},
		body="Lethargy Sayon +3",
		hands={ name="Nyame Gauntlets", augments={'Path: B',}},
		legs="Bunzi's Pants",
		feet={ name="Nyame Sollerets", augments={'Path: B',}},
		neck="Elite Royal Collar",
		waist="Carrier's Sash",
		left_ear="Eabani Earring",
		right_ear="Etiolation Earring",
		left_ring="Defending Ring",
		right_ring="Shneddick Ring +1",
		back={ name="Sucellos's Cape", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','Enmity+10','Occ. inc. resist. to stat. ailments+10',}},
		}
	
	sets.idle.DT = {
		}

    -- Defense sets
    sets.defense.PDT = sets.idle.DT

    sets.defense.MDT = sets.idle.DT

    -- Engaged sets


    ------------------------------------------------------------------------------------------------
    ---------------------------------------- Engaged Sets ------------------------------------------
    ------------------------------------------------------------------------------------------------

    sets.engaged = {
		ammo="Coiste Bodhar",
		head="Malignance Chapeau",
		body="Malignance Tabard",
		hands="Malignance Gloves",
		legs="Malignance Tights",
		feet="Malignance Boots",
		neck="Anu Torque",
		waist="Sailfi Belt +1",
		left_ear="Telos Earring",
		right_ear="Sherida Earring",
		left_ring="Chirich Ring +1",
		right_ring="Ilabrat Ring",
		back=Sucellos.STP
        }

	sets.engaged.Acc = set_combine(sets.engaged.MidAcc, {
		})
	
	sets.engaged.DW = set_combine(sets.engaged, {waist="Reiki Yotai", left_ear="Eabani Earring",})
	sets.engaged.Acc.DW = set_combine(sets.engaged.HighAcc, {waist="Reiki Yotai", left_ear="Eabani Earring",})

--[[
	
	sets.engaged.MaxHaste = set_combine(sets.engaged, {})
	sets.engaged.MidAcc.MaxHaste = {}
	sets.engaged.HighAcc.MaxHaste = {}
	
	sets.engaged.Haste_35 = sets.engaged.MaxHaste
	sets.engaged.MidAcc.Haste_35 = sets.engaged.MaxHaste
	sets.engaged.HighAcc.Haste_35 = sets.engaged.MaxHaste
	
	sets.engaged.Haste_30 = sets.engaged.MaxHaste
	sets.engaged.MidAcc.Haste_30 = sets.engaged.MaxHaste
	sets.engaged.HighAcc.Haste_30 = sets.engaged.MaxHaste
	
	sets.engaged.Haste_15 = sets.engaged.MaxHaste
	sets.engaged.MidAcc.Haste_15 = sets.engaged.MaxHaste
	sets.engaged.HighAcc.Haste_15 = sets.engaged.MaxHaste
]]--	

	sets.engaged.Enspell = {
		ammo="Sroda Tathlum",
		left_ear="Crep. Earring",
		hands="Aya. Manopolas +2",
		waist="Orpheus's Sash",
		back=Sucellos.DW,
		}
	
    ------------------------------------------------------------------------------------------------
    ---------------------------------------- Hybrid Sets -------------------------------------------
    ------------------------------------------------------------------------------------------------

    sets.engaged.Hybrid = {
		head="Malignance Chapeau",
		body="Malignance Tabard",
		hands="Malignance Gloves",
		legs="Malignance Tights",
		feet="Malignance Boots",
		left_ring="Defending Ring",
		}

    sets.engaged.DT = set_combine(sets.engaged, sets.engaged.Hybrid)
    sets.engaged.Acc.DT = set_combine(sets.engaged.Acc, sets.engaged.Hybrid)
	
	sets.engaged.DW.DT= set_combine(sets.engaged.DW, sets.engaged.Hybrid)
	sets.engaged.Acc.DW.DT = set_combine(sets.engaged.Acc.DW, sets.engaged.Hybrid, {})

    ------------------------------------------------------------------------------------------------
    ---------------------------------------- Special Sets ------------------------------------------
    ------------------------------------------------------------------------------------------------

    sets.buff.Doom = {
		neck="Nicander's Necklace", --20
		ring1="Purity Ring", --7
        ring2="Eshmun's Ring", --20
		waist="Gishdubar Sash", --10
    }

    sets.Obi = {waist="Hachirin-no-Obi"}

    sets.TreasureHunter = {
		head={ name="Merlinic Hood", augments={'Accuracy+7','INT+4','"Treasure Hunter"+2','Accuracy+15 Attack+15',}},
		head={ name="Merlinic Hood", augments={'Accuracy+7','INT+4','"Treasure Hunter"+2','Accuracy+15 Attack+15',}},
		legs={ name="Merlinic Shalwar", augments={'VIT+9','AGI+4','"Treasure Hunter"+2','Accuracy+17 Attack+17','Mag. Acc.+19 "Mag.Atk.Bns."+19',}}
	}

	-- Come up with something to improve the speed and user friendlieness of weapon swapping between magic/physical setups.
	-- Acc versions enabled during HighAcc offensive mode.
	--Phy--
	
    sets.Naegling = {main="Naegling", sub="Machaera +2",}
	
	sets.Maxentius = {main="Maxentius", sub="Machaera +2",}
	
	sets.CroceaPhy = {main="Crocea Mors", sub="Gleti's Knife",}
	
	sets.TauretPhy = {main="Tauret", sub="Gleti's Knife",}
    
	--Red Lotus
	sets.CroceaMag_R = {main="Crocea Mors", sub="Machaera +2",}
	
	--Sanguine/Seraph
	sets.CroceaMagS = {main="Crocea Mors", sub="Daybreak",}
	
	--AE
	sets.TauretMag = {main="Tauret", sub="Bunzi's Rod"}
	
	--Niche AF--
	--Turn on and off Manually--
	
	--sets.Sequence = {main="Sequence", sub="Gleti's Knife",}
    --sets.Fists = {main="Karambit"}

    sets.DefaultShield = {sub="Sacro Bulwark"}

end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------

function job_precast(spell, action, spellMap, eventArgs) 
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
    if spell.name == 'Impact' then
        equip(sets.precast.FC.Impact)
    end
	
    if spell.english == "Phalanx II" and spell.target.type == 'SELF' then
        cancel_spell()
        send_command('@input /ma "Phalanx" <me>')
    end
	
	if spell.type == 'WeaponSkill' then		
		if elemental_ws:contains(spell.name) then
			-- Matching double weather (w/o day conflict).
			if spell.element == world.weather_element and (world.weather_intensity == 2 and spell.element ~= elements.weak_to[world.day_element]) then
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

-- Run after the default midcast() is done.
-- eventArgs is the same one used in job_midcast, in case information needs to be persisted.
function job_post_midcast(spell, action, spellMap, eventArgs)
	if spell.skill == 'Enfeebling Magic' then
		if buffactive.Saboteur then
		equip(sets.buff.Saboteur)
		end
	end
    if spell.skill == 'Enhancing Magic' then
        if classes.NoSkillSpells:contains(spell.english) then
            equip(sets.midcast.EnhancingDuration)
            if spellMap == 'Refresh' then
                equip(sets.midcast.Refresh)
                if spell.target.type == 'SELF' then
                    equip (sets.midcast.RefreshSelf)
                end
            end
        elseif skill_spells:contains(spell.english) then
            equip(sets.midcast.EnhancingSkill)
        elseif spell.english:startswith('Gain') then
            equip(sets.midcast.GainSpell)
        elseif spell.english:contains('Spikes') then
            equip(sets.midcast.SpikesSpell)
        end
        if (spell.target.type == 'PLAYER' or spell.target.type == 'NPC') and buffactive.Composure then
            equip(sets.buff.ComposureOther)
			if spellMap == 'Refresh' then
                equip(sets.midcast.Refresh)
            end
        end
    end
    if spellMap == 'Cure' and spell.target.type == 'SELF' then
        equip(sets.midcast.CureSelf)
    end
    if spell.skill == 'Elemental Magic' then
        if state.MagicBurst.value and spell.english ~= 'Death' then
            equip(sets.magic_burst)
            if spell.english == "Impact" then
                equip(sets.midcast.Impact)
            end
        end
        if spell.skill == 'Elemental Magic' or spell.english == "Kaustra" then
            if spell.element == world.weather_element and (get_weather_intensity() == 2 and spell.element ~= elements.weak_to[world.day_element]) then
                equip(sets.Obi)
            -- Target distance under 1.7 yalms.
            elseif spell.target.distance < (1.7 + spell.target.model_size) then
                equip({waist="Orpheus's Sash"})
            -- Matching day and weather.
            elseif spell.element == world.day_element and spell.element == world.weather_element then
                equip(sets.Obi)
            -- Target distance under 8 yalms.
            elseif spell.target.distance < (8 + spell.target.model_size) then
                equip({waist="Orpheus's Sash"})
            -- Match day or weather.
            elseif spell.element == world.day_element or spell.element == world.weather_element then
                equip(sets.Obi)
            end
        end
    end
end

function job_aftercast(spell, action, spellMap, eventArgs)
   -- if spell.english:contains('Sleep') and not spell.interrupted then
   --    set_sleep_timer(spell)
   -- end
	if player.status ~= 'Engaged' and state.WeaponLock.value == false then
        check_weaponset()
    end
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for non-casting events.
-------------------------------------------------------------------------------------------------------------------

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
	
	    -- If we gain or lose any haste buffs, adjust which gear set we target.
--    if S{'haste', 'march', 'mighty guard', 'embrava', 'haste samba', 'geo-haste', 'indi-haste'}:contains(buff:lower()) then
 --       determine_haste_group()
 --       if not midaction() then
 --           handle_equipping_gear(player.status)
 --       end
 --   end
	
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

-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------

-- Called by the 'update' self-command, for common needs.
-- Set eventArgs.handled to true if we don't want automatic equipping of gear.
function job_handle_equipping_gear(playerStatus, eventArgs)
    update_combat_form()
end

function job_update(cmdParams, eventArgs)
    handle_equipping_gear(player.status)
end

function update_combat_form()
	if S{'NIN'}:contains(player.sub_job) and rdm_sub_weapons:contains(player.equipment.sub) then
        state.CombatForm:set("DW")
	elseif S{'DNC'}:contains(player.sub_job) and rdm_sub_weapons:contains(player.equipment.sub) then
        state.CombatForm:set("DW")
	else
        state.CombatForm:reset()
    end
end

-- Custom spell mapping.
function job_get_spell_map(spell, default_spell_map)
    if spell.action_type == 'Magic' then
        if default_spell_map == 'Cure' or default_spell_map == 'Curaga' then
            if world.weather_element == 'Light' or (world.day_element == 'Light' and world.weather_element ~= 'Dark') then
                return 'CureWeather'
            end
        end
        if spell.skill == 'Enfeebling Magic' then
            if enfeebling_magic_skill:contains(spell.english) then
                return "SkillEnfeebles"
            elseif spell.type == "WhiteMagic" then
				if enfeebling_magic_noresist:contains(spell.english) then
					return "NoResist"
              end
            elseif spell.type == "BlackMagic" then
                if enfeebling_magic_sleep:contains(spell.english) and ((buffactive.Stymie and buffactive.Composure) or state.SleepMode.value == 'MaxDuration') then
                    return "SleepMaxDuration"
                elseif enfeebling_magic_sleep:contains(spell.english) then
                    return "Sleep"
                end
            else
                return "MndEnfeebles"
            end
        end
    end
end
--[[
function get_custom_wsmode(spell, action, spellMap)
    local wsmode
    if state.OffenseMode.value == 'HighAcc' then
        wsmode = 'Acc'
    end

   return wsmode
end
]]--
-- Modify the default idle set after it was constructed.
function customize_idle_set(idleSet)

    return idleSet
end

function customize_melee_set(meleeSet)
    if state.EnspellMode.value == true then
        meleeSet = set_combine(meleeSet, sets.engaged.Enspell)
    end

	
	check_weaponset()
--Very Spamy, Fix Later
	--determine_haste_group()
    return meleeSet
end

function check_weaponset()
    if state.OffenseMode.value == 'HighAcc' then
        equip(sets[state.WeaponSet.current].Acc)
    else
        equip(sets[state.WeaponSet.current])
    end
    if player.sub_job ~= 'NIN' and player.sub_job ~= 'DNC' then
       equip(sets.DefaultShield)
    end
end

-- Set eventArgs.handled to true if we don't want the automatic display to be run.
function display_current_job_state(eventArgs)
    display_current_caster_state()
    eventArgs.handled = true
end
--[[
function determine_haste_group()

    classes.CustomMeleeGroups:clear()
    -- assuming +4 for marches (ghorn has +5)
    -- Haste (white magic) 15%
    -- Haste Samba (Sub) 5%
    -- Haste (Merited DNC) 10% (never account for this)
    -- Victory March +0/+3/+4/+5    9.4/14%/15.6%/17.1% +0
    -- Advancing March +0/+3/+4/+5  6.3/10.9%/12.5%/14%  +0
    -- Embrava 30% with 500 enhancing skill
    -- Mighty Guard - 15%
    -- buffactive[580] = geo haste
    -- buffactive[33] = regular haste
    -- buffactive[604] = mighty guard
    -- state.HasteMode = toggle for when you know Haste II is being cast on you
    -- Hi = Haste II is being cast. This is clunky to use when both haste II and haste I are being cast
    if state.CombatForm.value == 'DW' then
		if state.HasteMode.value == 'Hi' then
			if ( ( (buffactive[33] or buffactive[580] or buffactive.embrava) and (buffactive.march or buffactive[604]) ) or
				 ( buffactive[33] and (buffactive[580] or buffactive.embrava) ) or
				 ( buffactive.march == 2 and buffactive[604] ) ) then
				add_to_chat(8, '-------------Max-Haste Mode Enabled--------------')
				classes.CustomMeleeGroups:append('MaxHaste')
			elseif ( (buffactive[33] or buffactive.march == 2 or buffactive[580]) and buffactive['haste samba'] ) then
				add_to_chat(8, '-------------Haste 35%-------------')
				classes.CustomMeleeGroups:append('Haste_35')
			elseif ( ( buffactive[580] or buffactive[33] or buffactive.march == 2 ) or
					 ( buffactive.march == 1 and buffactive[604] ) ) then
				add_to_chat(8, '-------------Haste 30%-------------')
				classes.CustomMeleeGroups:append('Haste_30')
			elseif ( buffactive.march == 1 or buffactive[604] ) then
				add_to_chat(8, '-------------Haste 15%-------------')
				classes.CustomMeleeGroups:append('Haste_15')
			end
		else
			if ( buffactive[580] and ( buffactive.march or buffactive[33] or buffactive.embrava or buffactive[604]) ) or  -- geo haste + anything
			   ( buffactive.embrava and (buffactive.march or buffactive[33] or buffactive[604]) ) or  -- embrava + anything
			   ( buffactive.march == 2 and (buffactive[33] or buffactive[604]) ) or  -- two marches + anything
			   ( buffactive[33] and buffactive[604] and buffactive.march ) then -- haste + mighty guard + any marches
				add_to_chat(8, '-------------Max Haste Mode Enabled--------------')
				classes.CustomMeleeGroups:append('MaxHaste')
			elseif ( (buffactive[604] or buffactive[33]) and buffactive['haste samba'] and buffactive.march == 1) or -- MG or haste + samba with 1 march
				   ( buffactive.march == 2 and buffactive['haste samba'] ) or
				   ( buffactive[580] and buffactive['haste samba'] ) then 
				add_to_chat(8, '-------------Haste 35%-------------')
				classes.CustomMeleeGroups:append('Haste_35')
			elseif ( buffactive.march == 2 ) or -- two marches from ghorn
				   ( (buffactive[33] or buffactive[604]) and buffactive.march == 1 ) or  -- MG or haste + 1 march
				   ( buffactive[580] ) or  -- geo haste
				   ( buffactive[33] and buffactive[604] ) then  -- haste with MG
				add_to_chat(8, '-------------Haste 30%-------------')
				classes.CustomMeleeGroups:append('Haste_30')
			elseif buffactive[33] or buffactive[604] or buffactive.march == 1 then
				add_to_chat(8, '-------------Haste 15%-------------')
				classes.CustomMeleeGroups:append('Haste_15')
			end
		end
	end

end
]]--
-- Function to display the current relevant user state when doing an update.
-- Return true if display was handled, and you don't want the default info shown.
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
    if state.MagicBurst.value then
        msg = ' Burst: On |'
    end
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

function job_self_command(cmdParams, eventArgs)
    if cmdParams[1]:lower() == 'scholar' then
        handle_strategems(cmdParams)
        eventArgs.handled = true
    elseif cmdParams[1]:lower() == 'nuke' then
        handle_nuking(cmdParams)
        eventArgs.handled = true
    elseif cmdParams[1]:lower() == 'enspell' then
        send_command('@input /ma '..state.EnSpell.value..' <me>')
    elseif cmdParams[1]:lower() == 'barelement' then
        send_command('@input /ma '..state.BarElement.value..' <me>')
    elseif cmdParams[1]:lower() == 'barstatus' then
        send_command('@input /ma '..state.BarStatus.value..' <me>')
    elseif cmdParams[1]:lower() == 'gainspell' then
        send_command('@input /ma '..state.GainSpell.value..' <me>')
    end

end

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    -- Default macro set/book
    if player.sub_job == 'DNC' then
        set_macro_page(2, 4)
    elseif player.sub_job == 'NIN' then
        set_macro_page(2, 4)
    elseif player.sub_job == 'THF' then
        set_macro_page(4, 4)
    else
        set_macro_page(1, 4)
    end
end

function set_lockstyle()
    send_command('wait 2; input /lockstyleset ' .. lockstyleset)
end