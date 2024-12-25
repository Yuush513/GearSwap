
  -------------------------------------------------------------------------------------------------------------------
--  Keybinds
-------------------------------------------------------------------------------------------------------------------
--  Modes:      [ F9 ]              Cycle Offense Modes
--              [ CTRL+F9 ]         Cycle Hybrid Modes
--				[ ALT+F9 ]          Cycle Weapon Skill Modes
--              [ F10 ]             Emergency -PDT Mode
--              [ F11 ]             Emergency -MDT Mode
--				[ CTRL+F10 ]        Cycle PDT Mode
--				[ CTRL+F11 ]        Cycle MDT Mode
--              [ ALT+F10 ]         Toggle Kiting Mode
--              [ F12 ]             Update Current Gear / Report Current Status
--              [ ALT+F12 ]         Cancel Emergency -PDT/-MDT Mod
--              [ CTRL+F12 ]        Cycle Idle Modes
-- 
--				[ CTRL+DEL ]        Cycleback Weapons
--				[ CTRL+INS ]        Cycle Weapons
--				[ CTRL+HOME ]       Weapon Lock
--
--  Abilities:  [ CTRL+- ]          Rune element cycle forward.
--              [ CTRL+= ]          Rune element cycle backward.
--				
-------------------------------------------------------------------------------------------------------------------
-- Setup functions for this job.  Generally should not be modified.
-------------------------------------------------------------------------------------------------------------------

-- Initialization function for this job file.
function get_sets()
    mote_include_version = 2

    -- Load and initialize the include file.
    include('Mote-Include.lua')
	include('organizer-lib')
    res = require 'resources'
end

-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------
function job_setup()

    -- /BLU Spell Maps
    blue_magic_maps = {}

    blue_magic_maps.Enmity = S{'Blank Gaze', 'Geist Wall', 'Jettatura', 'Soporific',
        'Poison Breath', 'Blitzstrahl', 'Sheep Song', 'Chaotic Eye'}
    blue_magic_maps.Cure = S{'Wild Carrot'}
    blue_magic_maps.Buffs = S{'Cocoon', 'Refueling'}

    rayke_duration = 35
    gambit_duration = 96
   

   state.mainweapon = M{['description'] = 'Main Weapon'}
    state.mainweapon:options('Lionheart','Epeolatry','Aettir','Lycurgos')
end

function user_setup()
    state.OffenseMode:options('Normal', 'LowAcc', 'Acc')
    state.WeaponskillMode:options('Normal', 'Attack', 'Safe')
    state.HybridMode:options('Normal', 'DT')
    state.IdleMode:options('Normal', 'DT', 'Turtle')
    state.PhysicalDefenseMode:options('PDT', 'Offense')
    state.MagicalDefenseMode:options('MEVA', 'Status', 'MEVAoffense')

    state.WeaponLock = M(false, 'Weapon Lock')
    state.Runes = M{['description']='Runes', 'Ignis', 'Gelus', 'Flabra', 'Tellus', 'Sulpor', 'Unda', 'Lux', 'Tenebrae'}

    Lionheart_weapons = S{'Lionheart'}
    Epeolatry_weapons = S{'Epeolatry'}
    Aettir_weapons = S{'Aettir'}
	GreatAxe_weapons = S{'Lycurgos'}

    -- Additional local binds
	send_command('bind ^- gs c cycleback Runes')
    send_command('bind ^= gs c cycle Runes')
	send_command('bind !f9 gs c cycle WeaponskillMode')
    send_command('bind ^f11 gs c cycle MagicalDefenseMode')
    send_command('bind ^insert gs c mainweapon')
	send_command('bind ^delete gs c mainweapon2')
    send_command('bind ^home gs c toggle WeaponLock')

	update_combat_form()
    select_default_macro_book()
    set_lockstyle()
end

function user_unload()
    send_command('unbind ^-')
	send_command('unbind ^=')
    send_command('unbind !f9')
    send_command('unbind ^f11')
    send_command('unbind ^insert')
    send_command('unbind ^delete')
	send_command('unbind ^home')
end
sets.mainweapon = {}
    sets.mainweapon.Lionheart = {
        main = "Lionheart",
        sub = "Utu Grip"
    }
    sets.mainweapon.Epeolatry = {
		main = "Epeolatry",
		sub = "Utu grip",
    }
	sets.mainweapon.Aettir = {
		main = "Aettir",
		sub = "Utu grip"
	}
	sets.mainweapon.Lycurgos = {
		main = "Lycurgos",
		sub = "Utu Grip"
	}


-- Define sets and vars used by this job file.
function init_gear_sets()
	
	
	------------------------------------------------------------------------------------------------
    ---------------------------------------- Precast Sets ------------------------------------------
    ------------------------------------------------------------------------------------------------
	
    sets.Enmity = {
		head="Rabid Visor",
        neck="Moonbeam Necklace", --10
        ear1="Cryptic Earring", --4
        ear2="Friomisi Earring", --2
        body="Emet Harness +1", --10
        hands="Kurys Gloves", --9
        ring1="Supershear Ring", --5
        ring2="Eihwaz Ring", --5
        back="Ogma's Cape", --10
		waist="Flume Belt +1",
        legs="Eri. Leg Guards +1", --7
        feet="Erilaz Greaves +1",--6
        }

	
    -- Precast sets to enhance JAs
	
    sets.precast.JA['Vallation'] = {body="Runeist's Coat +1", legs="Futhark Trousers", back="Ogma's Cape",}
    sets.precast.JA['Valiance'] = sets.precast.JA['Vallation']
    sets.precast.JA['Pflug'] = {feet="Runeist's Boots"}
    sets.precast.JA['Battuta'] = {head="Fu. Bandeau +1"}
    sets.precast.JA['Liement'] = {body="Futhark Coat"}

    sets.precast.JA['Lunge'] = {}

    sets.precast.JA['Swipe'] = sets.precast.JA['Lunge']
    sets.precast.JA['Gambit'] = {hands="Runeist's Mitons"}
    sets.precast.JA['Rayke'] = {feet="Futhark Boots"}
    sets.precast.JA['Elemental Sforzo'] = {body="Futhark Coat"}
    sets.precast.JA['Swordplay'] = {hands="Futhark Mitons"}
    sets.precast.JA['Vivacious Pulse'] = {head="Erilaz Galea +1"}

    
	sets.precast.JA['Provoke'] = sets.Enmity
    sets.precast.JA['Warcry'] = sets.Enmity
    sets.precast.JA['Berserk'] = sets.Enmity
    sets.precast.JA['Defender'] = sets.Enmity
    sets.precast.JA['Aggressor'] = sets.Enmity

    sets.precast.JA['Last Resort'] = sets.Enmity
    sets.precast.JA['Weapon Bash'] = sets.Enmity
    sets.precast.JA['Souleater'] = sets.Enmity
	 

    -- Fast cast sets for spells
	-- 51 + 4/5 Inspiration (48)
    sets.precast.FC = {
		ammo="Staunch Tathlum +1",
		head="Carmine Mask +1",
		neck="Voltsurge Torque",
		left_ear="Odnowa Earring +1",
		right_ear="Etiolation Earring",
		body={ name="Taeon Tabard", augments={'"Fast Cast"+5','Phalanx +3',}},
		hands="Leyline Gloves",
		left_ring={name="Moonbeam Ring", bag="wardrobe1"},
		right_ring="Kishar Ring",
		back="Moonbeam Cape",
		waist="Ninurta's Sash",
		legs="Aya. Cosciales +2",
		feet="Carmine Greaves +1", 
        }

    sets.precast.FC.HP = set_combine(sets.precast.FC, {})

    sets.precast.FC['Enhancing Magic'] = set_combine(sets.precast.FC, {waist = "Siegel Sash"})

    sets.precast.FC.Cure = set_combine(sets.precast.FC, {})

    sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, {})


	
    ------------------------------------------------------------------------------------------------
    ---------------------------------------- Midcast Sets ------------------------------------------
	------------------------------------------------------------------------------------------------
    sets.midcast['Enhancing Magic'] = {
        head="Carmine Mask",
        hands="Runeist's Mitons",
        legs="Carmine Cuisses +1",
        neck="Incanter's Torque",
        }

    sets.midcast.EnhancingDuration = {
        head="Erilaz Galea +1",
        legs="Futhark Trousers",
        }

    sets.midcast['Phalanx'] = set_combine(sets.midcast.SpellInterrupt, {
		ammo="Staunch Tathlum +1",
		head={ name="Fu. Bandeau +1", augments={'Enhances "Battuta" effect',}},
		body={ name="Taeon Tabard", augments={'"Fast Cast"+5','Phalanx +3',}},
		hands={ name="Taeon Gloves", augments={'Pet: Accuracy+5 Pet: Rng. Acc.+5','Phalanx +3',}},
		legs={ name="Taeon Tights", augments={'Phalanx +3',}},
		feet={ name="Herculean Boots", augments={'Pet: STR+3','MND+9','Phalanx +5','Accuracy+4 Attack+4',}},
		neck="Incanter's Torque",
		waist="Flume Belt +1",
		left_ear="Genmei Earring",
		right_ear="Etiolation Earring",
		left_ring={name="Moonbeam Ring", bag="wardrobe1"},
		right_ring={name="Moonbeam Ring", bag="wardrobe2"},
		back="Moonbeam Cape",
        })

    sets.midcast['Aquaveil'] = set_combine(sets.midcast['Enhancing Magic'], sets.midcast.SpellInterrupt, {})

    sets.midcast['Regen'] = set_combine(sets.midcast['Enhancing Magic'], {})
    sets.midcast.Refresh = set_combine(sets.midcast.EnhancingDuration, {})
    sets.midcast.Stoneskin = set_combine(sets.midcast['Enhancing Magic'], {})
    sets.midcast.Protect = set_combine(sets.midcast['Enhancing Magic'], {})
    sets.midcast.Shell = sets.midcast.Protect

    sets.midcast['Divine Magic'] = {}

    sets.midcast.Flash = sets.Enmity
    sets.midcast.Foil = sets.Enmity
    sets.midcast.Utsusemi = sets.midcast.SpellInterrupt

    sets.midcast['Blue Magic'] = {}
    sets.midcast['Blue Magic'].Enmity = sets.Enmity
    sets.midcast['Blue Magic'].Cure = sets.midcast.Cure
    sets.midcast['Blue Magic'].Buff = sets.midcast['Enhancing Magic']

    ------------------------------------------------------------------------------------------------
    ------------------------------------- Weapon Skill Sets ----------------------------------------
    ------------------------------------------------------------------------------------------------

	sets.precast.WS = {
		    ammo="Yamarang",
    head={ name="Carmine Mask +1", augments={'Accuracy+20','Mag. Acc.+12','"Fast Cast"+4',}},
    body="Ayanmo Corazza +2",
    hands="Aya. Manopolas +2",
    legs="Aya. Cosciales +2",
    feet="Aya. Gambieras +2",
    neck="Fotia Gorget",
    waist="Fotia Belt",
    left_ear="Telos Earring",
    right_ear="Sherida Earring",
    left_ring="Ilabrat Ring",
    right_ring="Ayanmo Ring",
    back={ name="Ogma's cape", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Enmity+10','Phys. dmg. taken-10%',}},
	}
		
	sets.precast.WS.AtkCap = set_combine(sets.precast.WS, {})
     
	
	------------------------------------------------------------------------------------------------
    ---------------------------------------- Engaged Sets ------------------------------------------
    ------------------------------------------------------------------------------------------------
	sets.engaged = {	
    ammo="Staunch Tathlum +1",
    head="Meghanada Visor +2",
    body="Erilaz Surcoat +1",
    hands="Turms Mittens",
    legs="Eri. Leg Guards +1",
    feet="Turms Leggings",
    neck="Loricate Torque +1",
    waist="Flume Belt +1",
    left_ear="Genmei Earring",
    right_ear="Etiolation Earring",
    left_ring="Defending Ring",
    right_ring="Moonbeam Ring",
    back={ name="Ogma's cape", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Enmity+10','Phys. dmg. taken-10%',}},
	}

    sets.engaged.LowAcc = set_combine(sets.engaged, {})

    sets.engaged.Acc = set_combine(sets.engaged.LowAcc, {})
	


    sets.engaged.Lionheart = {}

    sets.engaged.Lionheart.LowAcc = set_combine(sets.engaged.Lionheart, {})

    sets.engaged.Lionheart.Acc = set_combine(sets.engaged.Lionheart.LowAcc, {})
	
	
	sets.engaged.Epeolatry = {}

    sets.engaged.Epeolatry.LowAcc = set_combine(sets.engaged.Epeolatry, {})

    sets.engaged.Epeolatry.Acc = set_combine(sets.engaged.Epeolatry.LowAcc, {})
	
	sets.engaged.Epeolatry.Aftermath = {}
	
	
	sets.engaged.Aettir = set_combine(sets.engaged.Lionheart , {})

    sets.engaged.Aettir.LowAcc = set_combine(sets.engaged.Aettir, {})

    sets.engaged.Aettir.Acc = set_combine(sets.engaged.Aettir.LowAcc, {})
	
	
	sets.engaged.Lycurgos = sets.engaged.Lionheart

    sets.engaged.Lycurgos.LowAcc = sets.engaged.Lionheart.LowAcc

    sets.engaged.Lycurgos.Acc = sets.engaged.Lionheart.Acc

	

    ------------------------------------------------------------------------------------------------
    ---------------------------------------- Hybrid Sets -------------------------------------------
    ------------------------------------------------------------------------------------------------

    sets.Hybrid = {}
	
	sets.engaged.DT = set_combine(sets.engaged, sets.Hybrid)
    sets.engaged.LowAcc.DT = set_combine(sets.engaged.LowAcc, sets.Hybrid)
    sets.engaged.Acc.DT = set_combine(sets.engaged.Acc, sets.Hybrid)
	
	sets.engaged.Lionheart.DT = set_combine(sets.engaged.Lionheart, sets.Hybrid)
    sets.engaged.Lionheart.LowAcc.DT = set_combine(sets.engaged.Lionheart.LowAcc, sets.Hybrid)
    sets.engaged.Lionheart.Acc.DT = set_combine(sets.engaged.Lionheart.Acc, sets.Hybrid)
	
	sets.engaged.Epeolatry.DT = set_combine(sets.engaged.Epeolatry, sets.Hybrid)
    sets.engaged.Epeolatry.LowAcc.DT = set_combine(sets.engaged.Epeolatry.LowAcc, sets.Hybrid)
    sets.engaged.Epeolatry.Acc.DT = set_combine(sets.engaged.Epeolatry.Acc, sets.Hybrid)	
	
	sets.engaged.Epeolatry.Aftermath.DT = set_combine(sets.engaged.Epeolatry.Aftermath, sets.Hybrid)
	
	sets.engaged.Aettir.DT = set_combine(sets.engaged.Aettir, sets.Hybrid)
    sets.engaged.Aettir.LowAcc.DT = set_combine(sets.engaged.Aettir.LowAcc, sets.Hybrid)
    sets.engaged.Aettir.Acc.DT = set_combine(sets.engaged.Aettir.Acc, sets.Hybrid)
	
	sets.engaged.Lycurgos.DT = set_combine(sets.engaged.Lycurgos, sets.Hybrid)
    sets.engaged.Lycurgos.LowAcc.DT = set_combine(sets.engaged.Lycurgos.LowAcc, sets.Hybrid)
    sets.engaged.Lycurgos.Acc.DT = set_combine(sets.engaged.Lycurgos.Acc, sets.Hybrid)

	
    ------------------------------------------------------------------------------------------------
    ---------------------------------------- Defense Sets ------------------------------------------
    ------------------------------------------------------------------------------------------------
    sets.defense.PDT = {
		main={ name="Aettir", augments={'Accuracy+70','Mag. Evasion+50','Weapon skill damage +10%',}},
		sub="Utu Grip",
		ammo="Staunch Tathlum +1",
		head="Meghanada Visor +2",
		body="Erilaz Surcoat +1",
		hands="Turms Mittens",
		legs="Eri. Leg Guards +1",
		feet="Erilaz Greaves +1",
		neck="Loricate Torque +1",
		waist="Flume Belt +1",
		left_ear="Genmei Earring",
		right_ear="Etiolation Earring",
		left_ring="Defending Ring",
		right_ring={name="Moonbeam Ring", bag="wardrobe2"},
		back="Moonbeam Cape",
	}
		
	sets.defense.Offense = {}

	sets.defense.MEVA = {}
		
	 -- Gotta Avoid it!! --
    sets.defense.Status = { }
	
	sets.defense.MEVAoffense = {}
	
	------------------------------------------------------------------------------------------------
    ---------------------------------------- Idle Sets ------------------------------------------
    ------------------------------------------------------------------------------------------------
	
	sets.idle = {		

		ammo="Staunch Tathlum +1",
		head="Meghanada Visor +2",
		body="Meg. Cuirie +2",
		hands="Turms Mittens",
		legs = "Carmine Cuisses +1",
		feet="Turms Leggings",
		neck="Loricate Torque +1",
		waist="Flume Belt +1",
		left_ear="Genmei Earring",
		right_ear="Etiolation Earring",
		left_ring="Defending Ring",
		right_ring={name="Moonbeam Ring", bag="wardrobe2"},
		back="Moonbeam Cape", 
		}

    sets.idle.DT = { }
	
	sets.idle.Turtle = {}
	
	sets.idle.Refresh = set_combine(sets.idle, {})
	
	sets.idle.Town = set_combine(sets.idle, {ammo = "Staunch Tathlum +1", body = "Ashera Harness"})

	
    ------------------------------------------------------------------------------------------------
    ---------------------------------------- Special Sets ------------------------------------------
    ------------------------------------------------------------------------------------------------

    sets.buff.Doom = {
		neck = "Nicander's Necklace", --20
		ring1={name="Eshmun's Ring", bag="wardrobe1"},  --20
        ring2={name="Eshmun's Ring", bag="wardrobe2"}, --20
        --waist="Gishdubar Sash", --10
        }
	sets.buff.Sleep = {}
	
	sets.buff.Phalanx = {}
	sets.buff.ProShell = {}
	sets.buff.Enhancing = {}
	
	sets.MaxHP = {}
	
    sets.Embolden = set_combine(sets.midcast.EnhancingDuration, {back="Evasionist's Cape"})
    sets.Obi = {waist="Hachirin-no-Obi"}
    --sets.Reive = {neck="Ygnas's Resolve +1"}


end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------

function job_precast(spell, action, spellMap, eventArgs)

    if buffactive['terror'] or buffactive['petrification'] or buffactive['stun'] or buffactive['sleep'] then
        add_to_chat(167, 'Stopped due to status.')
        eventArgs.cancel = true
        return
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

-- Run after the default midcast() is done.
-- eventArgs is the same one used in job_midcast, in case information needs to be persisted.
function job_post_midcast(spell, action, spellMap, eventArgs)
    if spell.english == 'Lunge' or spell.english == 'Swipe' then
        if (spell.element == world.day_element or spell.element == world.weather_element) then
            equip(sets.Obi)
        end
    end
    if spell.skill == 'Enhancing Magic' and classes.NoSkillSpells:contains(spell.english) then
        equip(sets.midcast.EnhancingDuration)
        if spellMap == 'Refresh' then
            equip(sets.midcast.Refresh)
        end
    end
    if spell.english == 'Phalanx' and buffactive['Embolden'] then
        equip(sets.midcast.EnhancingDuration)
    end
    -- If DefenseMode is active, apply that gear over midcast
    -- choices.  Precast is allowed through for fast cast on
    -- spells, but we want to return to def gear before there's
    -- time for anything to hit us.
    -- Exclude Job Abilities from this restriction, as we probably want
    -- the enhanced effect of whatever item of gear applies to them,
    -- and only one item should be swapped out.
    --if state.DefenseMode.value ~= 'None' and spell.type ~= 'JobAbility' then
    --    handle_equipping_gear(player.status)
    --    eventArgs.handled = true
    --end
end

function job_aftercast(spell, action, spellMap, eventArgs)
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

function update_combat_form()
     --Check Weapontype
    if Lionheart_weapons:contains(player.equipment.main) then
        state.CombatForm:set('Lionheart')
    elseif Epeolatry_weapons:contains(player.equipment.main) then
        state.CombatForm:set('Epeolatry')
    elseif Aettir_weapons:contains(player.equipment.main) then
        state.CombatForm:set('Aettir')
    elseif GreatAxe_weapons:contains(player.equipment.main) then
        state.CombatForm:set('Lycurgos')
    else
        state.CombatForm:reset()
    end
end

function job_buff_change(buff,gain)
    -- If we gain or lose any haste buffs, adjust which gear set we target.
--    if buffactive['Reive Mark'] then
--        if gain then
--            equip(sets.Reive)
--            disable('neck')
--        else
--            enable('neck')
--        end
--    end

    if buff == "terror" or buff=="petrification" or buff=="stun" then
        if gain then
            equip(sets.defense.PDT)
        end
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
	
	if buff == "sleep" then
		if gain then
			equip(sets.buff.Sleep)
	    end
	end
	
    if buff == 'Embolden' then
        if gain then
            equip(sets.Embolden)
            disable('head','legs','back')
        else
            enable('head','legs','back')
            status_change(player.status)
        end
    end

    if buff:startswith('Aftermath') then
        state.Buff.Aftermath = gain
        customize_melee_set()
        handle_equipping_gear(player.status)
    end

    if buff == 'Battuta' and not gain then
        status_change(player.status)
    end

end

-- Handle notifications of general user state change.
function job_state_change(stateField, newValue, oldValue)
    if state.WeaponLock.value == true then
        disable('main','sub')
    else
        enable('main','sub')
    end
	
	update_combat_form()
end

-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------

function job_update(cmdParams, eventArgs)
	update_combat_form()
end

-- Modify the default idle set after it was constructed.
function customize_idle_set(idleSet)
    if mainswap then
		enable('main','sub')
        equip(sets.mainweapon[state.mainweapon.value])
		mainswap=false
	end
	if player.mpp < 31 then
        idleSet = set_combine(idleSet, sets.idle.Refresh)
    end

    return idleSet
end

-- Modify the default melee set after it was constructed.
function customize_melee_set(meleeSet)
    if mainswap then
		enable('main','sub')
        equip(sets.mainweapon[state.mainweapon.value])
		mainswap=false
	end
	
	if buffactive['Aftermath: Lv.3'] and player.equipment.main == "Epeolatry"
        and state.DefenseMode.value == 'None' then
        if state.HybridMode.value == "DT" then
            meleeSet = set_combine(meleeSet, sets.engaged.Epeolatry.Aftermath.DT)
        else
            meleeSet = set_combine(meleeSet, sets.engaged.Epeolatry.Aftermath)
        end
    end

    return meleeSet
end

function customize_defense_set(defenseSet)
    if buffactive['Battuta'] then
        defenseSet = set_combine(defenseSet, sets.defense.Parry)
    end

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
    if state.HybridMode.value ~= 'Normal' then
        m_msg = m_msg .. '/' ..state.HybridMode.value
    end

    local ws_msg = state.WeaponskillMode.value

    local d_msg = 'None'
    if state.DefenseMode.value ~= 'None' then
        d_msg = state.DefenseMode.value .. state[state.DefenseMode.value .. 'DefenseMode'].value
    end

    local i_msg = state.IdleMode.value

    local msg = ''

    add_to_chat(r_color, string.char(129,121).. '  ' ..string.upper(r_msg).. '  ' ..string.char(129,122)
        ..string.char(31,210).. ' Melee' ..cf_msg.. ': ' ..string.char(31,001)..m_msg.. string.char(31,002).. ' |'
        ..string.char(31,207).. ' WS: ' ..string.char(31,001)..ws_msg.. string.char(31,002).. ' |'
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

function job_self_command(cmdParams, eventArgs)
    if cmdParams[1]:lower() == 'rune' then
        send_command('@input /ja '..state.Runes.value..' <me>')
    end
	
    if cmdParams[1]:lower()=='mainweapon' then
        mainswap=1
        send_command('gs c cycle mainweapon')
	end
	if cmdParams[1]:lower()=='mainweapon2' then
        mainswap=1
        send_command('gs c cycleback mainweapon')
	
	end
	if cmdParams[1] == 'TH' then
		equip(sets.TH)
		disable('body', 'legs', 'waist')
		add_to_chat(158, 'Treasure Hunter Equipped')
	elseif cmdParams[1] == 'THoff' then
		enable('body', 'legs', 'waist')
		add_to_chat(158, 'Treasure Hunter Unequipped')
		send_command('gs c update')
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

	if cmdParams[1] == 'pictures' then
		send_command('input /equipset 100; wait 1; input //gs disable ammo; wait 1; input //gs disable ranged; wait 5; input //sat alltarget; wait 10;'..
		'input /item "Soultrapper 2000" <t>; wait 35; input /item "Soultrapper 2000" <t>; wait 35;'..
		'input /item "Soultrapper 2000" <t>; wait 35; input /item "Soultrapper 2000" <t>; wait 35;'..
		'input /item "Soultrapper 2000" <t>; wait 35; input /item "Soultrapper 2000" <t>; wait 35;'..
		'input /item "Soultrapper 2000" <t>; wait 35; input /item "Soultrapper 2000" <t>; wait 35;'..
		'input /item "Soultrapper 2000" <t>; wait 35; input /item "Soultrapper 2000" <t>; wait 35;'..
		'input /item "Soultrapper 2000" <t>; wait 35; input /item "Soultrapper 2000" <t>; wait 35;')
		add_to_chat(158,'Equipping Camera and Taking 12 pictures')
	end
	if cmdParams[1] == 'temps' then
		send_command('input //temps buy;')
		add_to_chat(158, 'buying temps')
	end
	if cmdParams[1] == 'neak' then
		send_command('input //sat alltarget; wait 1; input //tradenpc 1 "Tolba\'s Shell"')
		add_to_chat(158, 'trading shell')
	end
	if cmdParams[1] == 'zitah' then
		send_command('input //sat alltarget; wait 1; input //tradenpc 5 "Pluton"; wait 5; input //tradenpc 5 "Riftborn Boulder"')
		add_to_chat(158, 'trading pop items')
	end

end

-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

-- Select default macro book on initial load or subjob change.
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
     send_command('wait 2; input /lockstyleset 3')
end