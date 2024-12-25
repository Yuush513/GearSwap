-------------------------------------------------------------------------------------------------------------------
--  Keybinds
-------------------------------------------------------------------------------------------------------------------

--  Modes:      [ F9 ]              Cycle Offense Modes
--              [ CTRL+F9 ]         Cycle Hybrid Modes
--              [ WIN+F9 ]          Cycle Weapon Skill Modes
--              [ F10 ]             Emergency -PDT Mode
--              [ ALT+F10 ]         Toggle Kiting Mode
--              [ F11 ]             Emergency -MDT Mode
--              [ F12 ]             Update Current Gear / Report Current Status
--              [ CTRL+F12 ]        Cycle Idle Modes
--              [ ALT+F12 ]         Cancel Emergency -PDT/-MDT Mode
--              [ CTRL+` ]          Cycle Treasure Hunter Mode
--              [ WIN+C ]           Toggle Capacity Points Mode

-------------------------------------------------------------------------------------------------------------------
--  Custom Commands (preface with /console to use these in macros)
-------------------------------------------------------------------------------------------------------------------

--  gs c cycle treasuremode (set on ctrl-= by default): Cycles through the available treasure hunter modes.
--
--  TH Modes:  None                 Will never equip TH gear
--             Tag                  Will equip TH gear sufficient for initial contact with a mob (either melee,
--
--             SATA - Will equip TH gear sufficient for initial contact with a mob, and when using SATA
--             Fulltime - Will keep TH gear equipped fulltime


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
    state.Buff['Sneak Attack'] = buffactive['sneak attack'] or false
    state.Buff['Trick Attack'] = buffactive['trick attack'] or false
    state.Buff['Feint'] = buffactive['feint'] or false

    include('Mote-TreasureHunter')

    -- For th_action_check():
    -- JA IDs for actions that always have TH: Provoke, Animated Flourish
    info.default_ja_ids = S{35, 204}
    -- Unblinkable JA IDs for actions that always have TH: Quick/Box/Stutter Step, Desperate/Violent Flourish
    info.default_u_ja_ids = S{201, 202, 203, 205, 207}

    state.AttackMode = M{['description']='Attack', 'Capped', 'Uncapped'}
    state.CP = M(false, "Capacity Points Mode")

    lockstyleset = 3
end

-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
    state.OffenseMode:options('Normal', 'LowAcc', 'Acc', 'Eva')
    state.HybridMode:options('Normal', 'DT')
    state.RangedMode:options('Normal', 'Acc')
    state.WeaponskillMode:options('Normal')
	state.PhysicalDefenseMode:options('PDT')
	state.MagicalDefenseMode:options('MEVA', 'MDT')
    state.IdleMode:options('Normal', 'DT', 'Evasion')

--    send_command('lua l gearinfo')

    send_command('bind ^= gs c cycle treasuremode')

    send_command('bind ^- gs c cycle AttackMode')

    send_command('bind ^f11 gs c cycle MagicalDefenseMode')

    select_default_macro_book()
    set_lockstyle()

    update_combat_form()
end


-- Called when this job file is unloaded (eg: job change)S
function user_unload()
    send_command('unbind ^`')
    send_command('unbind @a')
    send_command('unbind @c')
end


-- Define sets and vars used by this job file.
function init_gear_sets()

    ------------------------------------------------------------------------------------------------
    ---------------------------------------- Precast Sets ------------------------------------------
    ------------------------------------------------------------------------------------------------

    sets.TreasureHunter = {
        hands = "Plun. Armlets +3", --4
        --waist = "Chaac Belt", --1
		feet = "Skulk. Poulaines +1", --2
        }

    sets.buff['Sneak Attack'] = {}
    sets.buff['Trick Attack'] = {}

    -- Actions we want to use to tag TH.
    sets.precast.Step = sets.TreasureHunter
    sets.precast.Flourish1 = sets.TreasureHunter
    sets.precast.JA.Provoke = sets.TreasureHunter


    ------------------------------------------------------------------------------------------------
    ---------------------------------------- Precast Sets ------------------------------------------
    ------------------------------------------------------------------------------------------------

    -- Precast sets to enhance JAs
    sets.precast.JA['Collaborator'] = {head = "Skulker's Bonnet +1"}
    sets.precast.JA['Accomplice'] = {head = "Skulker's Bonnet +1"}
    sets.precast.JA['Flee'] = {}
    sets.precast.JA['Hide'] = {body = "Pillager's Vest +3"}
    sets.precast.JA['Conspirator'] = {body = "Skulker's Vest +1"}

    sets.precast.JA['Steal'] = {}
	sets.precast.JA['Bully'] = sets.TreasureHunter

    sets.precast.JA['Despoil'] = {feet = "Skulk. Poulaines +1"}
    sets.precast.JA['Perfect Dodge'] = {hands = "Plun. Armlets +3"}
    sets.precast.JA['Feint'] = {legs = "Plun. Culottes +3"}
    --sets.precast.JA['Sneak Attack'] = sets.buff['Sneak Attack']
    --sets.precast.JA['Trick Attack'] = sets.buff['Trick Attack']

    sets.precast.Waltz = {
        }

    sets.precast.Waltz['Healing Waltz'] = {}

    sets.precast.FC = {
		ammo = "Sapience Orb", --2
		head = HerculeanHead.FC, --12
		neck = "Orunmila's Torque", --5
		ear1 = "Loquac. Earring", --2
		ear2 = "Etiolation Earring", --1
		body = "Taeon Tabard", --9
		hands = "Leyline Gloves", --8
		back = Toutatis.FC, --10
		legs = "Enif Cosciales", --8
		feet = HerculeanFeet.FC, --5
        } 

    sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, {
        })

    ------------------------------------------------------------------------------------------------
    ------------------------------------- Weapon Skill Sets ----------------------------------------
    ------------------------------------------------------------------------------------------------

    sets.precast.WS = {} -- default set

    sets.precast.WS.Uncapped = set_combine(sets.precast.WS, {})

    sets.precast.WS.Critical = {
		ammo = "Yetshila", 
		head = "Pill. Bonnet +3",
		}
		
	sets.precast.WS.Critical.Uncapped = {
		ammo = "Yetshila", 
		head = "Pill. Bonnet +3",
		body = "Pillager's Vest +3",
		legs="Plun. Culottes +3",
		feet={ name="Lustra. Leggings +1", augments={'HP+65','STR+15','DEX+15',}},
		}
	
    sets.precast.WS['Exenterator'] = {
        ammo = "C. Palug Stone",
		head = "Plun. Bonnet +3",
		neck = "Fotia Gorget",
		ear1 = "Sherida Earring",
		ear2 = "Brutal Earring",
		body = "Plunderer's Vest +3",
		hands = "Mummu Wrists +2",
		ring1 = "Ilabrat Ring",
		ring2 = "Regal Ring",
		back = "Sacro Mantle",
		waist = "Fotia Belt",
		legs = "Meg. Chausses +2",
		feet = "Plun. Poulaines +3",
		}

    sets.precast.WS['Exenterator'].Uncapped = set_combine(sets.precast.WS['Exenterator'], {
		ammo = "Seeth. Bomblet +1"
        })

    sets.precast.WS['Evisceration'] = {
		ammo="Yetshila",
		head={ name="Adhemar Bonnet +1", augments={'STR+12','DEX+12','Attack+20',}},
		body="Gleti's Cuirass",
		hands={ name="Adhemar Wrist. +1", augments={'STR+12','DEX+12','Attack+20',}},
		legs="Pill. Culottes +3",
		feet={ name="Adhe. Gamashes +1", augments={'STR+12','DEX+12','Attack+20',}},
		neck="Fotia Gorget",
		waist="Fotia Belt",
		left_ear={ name="Moonshade Earring", augments={'"Mag.Atk.Bns."+4','TP Bonus +250',}},
		right_ear="Odr Earring",
		left_ring="Ilabrat Ring",
		right_ring="Regal Ring",
		back={ name="Toutatis's Cape", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','Crit.hit rate+10',}},
        }

    sets.precast.WS['Evisceration'].Uncapped = set_combine(sets.precast.WS['Evisceration'], {body="Plunderer's Vest +3",})

    sets.precast.WS['Rudra\'s Storm'] = {
		ammo="C. Palug Stone",
		head="Gleti's Mask",
		body="Gleti's Cuirass",
		hands="Meg. Gloves +2",
		legs={ name="Lustr. Subligar +1", augments={'Accuracy+20','DEX+8','Crit. hit rate+3%',}},
		feet={ name="Lustra. Leggings +1", augments={'HP+65','STR+15','DEX+15',}},
		neck={ name="Asn. Gorget +2", augments={'Path: A',}},
		waist="Grunfeld Rope",
		left_ear={ name="Moonshade Earring", augments={'"Mag.Atk.Bns."+4','TP Bonus +250',}},
		right_ear="Odr Earring",
		left_ring="Regal Ring",
		right_ring="Ilabrat Ring",
		back={ name="Toutatis's Cape", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','Weapon skill damage +10%',}},
        }

    sets.precast.WS['Rudra\'s Storm'].Uncapped = set_combine(sets.precast.WS['Rudra\'s Storm'], {
		ammo="Seeth. Bomblet +1",
		head="Plun. Bonnet +3", 
		body="Plunderer's Vest +3",
		legs="Plun. Culottes +3",
		feet="Plun. Poulaines +3",
		waist="Grunfeld Rope",
		left_ring="Regal Ring",
		})
	
	
    sets.precast.WS['Mandalic Stab'] = sets.precast.WS['Rudra\'s Storm']
    sets.precast.WS['Mandalic Stab'].Uncapped = sets.precast.WS['Rudra\'s Storm'].Uncapped

    sets.precast.WS['Aeolian Edge'] = set_combine(sets.precast.WS, {
		ammo = "Seeth. Bomblet +1",
		head = HerculeanHead.WSD,
		neck = "Sibyl Scarf",
		ear2 = "Friomisi Earring",
		body = "Nyame Mail",
		hands = HerculeanHands.MAB_WSD,
		ring1 = "Dingir Ring",
		ring2 = "Metamor. Ring +1",
		waist = "Fotia Belt",
		back = Toutatis.WSD,
		legs = HerculeanLegs.MAB_WSD,
		feet = HerculeanFeet.MAB_WSD,
        })

    ------------------------------------------------------------------------------------------------
    ---------------------------------------- Midcast Sets ------------------------------------------
    ------------------------------------------------------------------------------------------------

    sets.midcast.FastRecast = sets.precast.FC

    sets.midcast.SpellInterrupt = {}

    sets.midcast.Utsusemi = sets.midcast.SpellInterrupt


    ------------------------------------------------------------------------------------------------
    ----------------------------------------- Idle Sets --------------------------------------------
    ------------------------------------------------------------------------------------------------

    sets.resting = {}

    sets.idle = {
		ammo="Staunch Tathlum +1",
		head="Turms Cap +1",
		body="Gleti's Cuirass",
		hands="Gleti's Gauntlets",
		legs="Gleti's Breeches",
		feet="Gleti's Boots",
		neck="Rep. Plat. Medal",
		waist="Carrier's Sash",
		left_ear="Eabani Earring",
		right_ear={ name="Odnowa Earring +1", augments={'Path: A',}},
		left_ring="Defending Ring",
		right_ring="Shneddick Ring +1",
		back="Moonlight Cape",
        }

    sets.idle.DT = {
	    ammo="Staunch Tathlum +1",
		head="Malignance Chapeau",
		body="Malignance Tabard",
		hands="Malignance Gloves",
		legs="Malignance Tights",
		feet="Nyame Sollerets",
		neck={ name="Bathy Choker +1", augments={'Path: A',}},
		waist="Carrier's Sash",
		left_ear="Eabani Earring",
		right_ear={ name="Odnowa Earring +1", augments={'Path: A',}},
		left_ring="Defending Ring",
		right_ring="Shneddick Ring +1",
		back={ name="Toutatis's Cape", augments={'AGI+20','Eva.+20 /Mag. Eva.+20','Evasion+10','"Store TP"+10','Evasion+12',}},
	}
	
	sets.idle.Evasion = {}
	

    ------------------------------------------------------------------------------------------------
    ---------------------------------------- Defense Sets ------------------------------------------
    ------------------------------------------------------------------------------------------------
	
	--Capped PDT/MDT dps
    sets.defense.PDT = {
		ammo = "Staunch Tathlum +1",
		head = AdhemarHead.D,
		neck = "Asn. Gorget +2",
		ear1 = "Sherida Earring",
		ear2 = "Odnowa Earring +1",
		body = "Malignance Tabard",
		hands = "Adhemar Wrist. +1",
		ring1 = "Gelatinous Ring +1",
		ring2 = "Defending Ring",
		back = Toutatis.STP,
		waist = "Reiki Yotai",
		legs = "Meg. Chausses +2",
		feet = "Plun. Poulaines +3",
		}
		
	sets.defense.Evasion = {}
	
	
	--Beefy Boi Set
	--Rename Later
    sets.defense.MDT = {
		ammo = "Yamarang",
		head = "Malignance Chapeau",
		neck = "Warder's Charm +1",
		ear1 = "Suppanomimi",
		ear2 = "Eabani Earring",
		body = "Malignance Tabard",
		hands = "Malignance Gloves",
		ring1 = "Moonlight Ring",
		ring2 = "Defending Ring",
		back = Toutatis.MEVA,
		waist = "Engraved Belt",
		legs = "Malignance Tights",
		feet = "Malignance Boots",
		}
		
	sets.defense.MEVA = {
		ammo = "Yamarang",
		head = "Malignance Chapeau",
		neck = "Asn. Gorget +2",
		ear1 = "Sherida Earring",
		ear2 = "Dedition Earring",
		body = "Malignance Tabard",
		hands = "Malignance Gloves",
		ring1 = "Moonlight Ring",
		ring2 = "Gere Ring",
		back = Toutatis.MEVA,
		waist = "Reiki Yotai",
		legs = "Malignance Tights",
		feet = "Malignance Boots",
		}
		
    sets.Kiting = {feet="Jute Boots +1"}


    ------------------------------------------------------------------------------------------------
    ---------------------------------------- Engaged Sets ------------------------------------------
    ------------------------------------------------------------------------------------------------

    -- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
    -- sets if more refined versions aren't defined.
    -- If you create a set with both offense and defense modes, the offense mode should be first.
    -- EG: sets.engaged.Dagger.Accuracy.Evasion

    sets.engaged = {
        ammo = "Coiste Bodhar",
		head = AdhemarHead.B,
		neck = "Asn. Gorget +2",
		ear1 = "Sherida Earring",
		ear2 = "Dedition Earring",
		body = "Pillager's Vest +3",
		hands = "Adhemar Wrist. +1",
		ring1 = "Hetairoi Ring",
		ring2 = "Gere Ring",
		back = Toutatis.STP,
		waist = "Reiki Yotai",
		legs = "Samnuha Tights",
		feet = "Plun. Poulaines +3",
		}

    sets.engaged.LowAcc = set_combine(sets.engaged, {
        ammo = "Yamarang",
		ear2 = "Telos Earring",
		})

    sets.engaged.Acc = set_combine(sets.engaged.LowAcc, {
		head = "Plun. Bonnet +3",
		ring1 = "Regal Ring",
		legs = "Pill. Culottes +3",
		})
	
	sets.engaged.Eva = {
		ammo="Yamarang",
		head="Malignance Chapeau",
		body="Malignance Tabard",
		hands="Malignance Gloves",
		legs="Malignance Tights",
		feet="Malignance Boots",
		neck={ name="Asn. Gorget +2", augments={'Path: A',}},
		waist="Reiki Yotai",
		left_ear="Sherida Earring",
		right_ear="Dedition Earring",
		left_ring="Gere Ring",
		right_ring="Ilabrat Ring",
		back={ name="Toutatis's Cape", augments={'AGI+20','Eva.+20 /Mag. Eva.+20','Evasion+10','"Store TP"+10','Evasion+12',}},
	}
	
	----------------------------------------------------------------
    ---------------------------------------- Hybrid Sets -------------------------------------------
    ------------------------------------------------------------------------------------------------

    sets.engaged.Hybrid = {
		ammo = "Staunch Tathlum +1",
        hands = "Malignance Gloves", 
        ring1 = "Moonlight Ring", 
        legs = "Malignance Tights",  
		}

    sets.engaged.DT = set_combine(sets.engaged, sets.engaged.Hybrid)
    sets.engaged.LowAcc.DT = set_combine(sets.engaged.LowAcc, sets.engaged.Hybrid)
    sets.engaged.Acc.DT = set_combine(sets.engaged.Acc, sets.engaged.Hybrid)
	sets.engaged.Eva.DT = sets.engaged.Eva


    ------------------------------------------------------------------------------------------------
    ---------------------------------------- Special Sets ------------------------------------------
    ------------------------------------------------------------------------------------------------

    sets.buff.Doom = {
        neck="Nicander's Necklace", --20
        ring1={name="Eshmun's Ring", bag="wardrobe1"}, --20
        ring2={name="Eshmun's Ring", bag="wardrobe2"}, --20
        waist="Gishdubar Sash", --10
        }
	
	sets.Ambush = {body = "Plunderer's Vest +3"}

end


-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------

-- Run after the general precast() is done.
function job_post_precast(spell, action, spellMap, eventArgs)
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
    if spell.english=='Sneak Attack' or spell.english=='Trick Attack' then
        if state.TreasureMode.value == 'SATA' or state.TreasureMode.value == 'Fulltime' then
            equip(sets.TreasureHunter)
        end
    end
    if spell.type == "WeaponSkill" then
        if state.Buff['Sneak Attack'] == true or state.Buff['Trick Attack'] == true then
			if state.AttackMode.value == 'Uncapped' then
				equip(sets.precast.WS.Critical.Uncapped)
			else
				equip(sets.precast.WS.Critical)
			end
        end
    end
    if spell.type == 'WeaponSkill' then
        if spell.english == 'Aeolian Edge' then
            -- Matching double weather (w/o day conflict).
            if spell.element == world.weather_element and (get_weather_intensity() == 2 and spell.element ~= elements.weak_to[world.day_element]) then
                equip({waist="Hachirin-no-Obi"})
            end
        end
    end
end

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_aftercast(spell, action, spellMap, eventArgs)
    -- Weaponskills wipe SATA/Feint.  Turn those state vars off before default gearing is attempted.
    if spell.type == 'WeaponSkill' and not spell.interrupted then
        state.Buff['Sneak Attack'] = false
        state.Buff['Trick Attack'] = false
        state.Buff['Feint'] = false
    end
end

-- Called after the default aftercast handling is complete.
function job_post_aftercast(spell, action, spellMap, eventArgs)
    -- If Feint is active, put that gear set on on top of regular gear.
    -- This includes overlaying SATA gear.
    check_buff('Feint', eventArgs)
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for non-casting events.
-------------------------------------------------------------------------------------------------------------------

-- Called when a player gains or loses a buff.
-- buff == buff gained or lost
-- gain == true if the buff was gained, false if it was lost.
function job_buff_change(buff,gain)

--    if buffactive['Reive Mark'] then
--        if gain then
--            equip(sets.Reive)
--            disable('neck')
--        else
--            enable('neck')
--        end
--    end

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

    if not midaction() then
        handle_equipping_gear(player.status)
    end
end


-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------

-- Called by the 'update' self-command, for common needs.
-- Set eventArgs.handled to true if we don't want automatic equipping of gear.
function job_handle_equipping_gear(playerStatus, eventArgs)
    update_combat_form()

    -- Check for SATA when equipping gear.  If either is active, equip
    -- that gear specifically, and block equipping default gear.
    check_buff('Sneak Attack', eventArgs)
    check_buff('Trick Attack', eventArgs)
end

function job_update(cmdParams, eventArgs)
    handle_equipping_gear(player.status)
    th_update(cmdParams, eventArgs)
end

function update_combat_form()
    if DW == true then
        state.CombatForm:set('DW')
    elseif DW == false then
        state.CombatForm:reset()
    end
end

function get_custom_wsmode(spell, action, spellMap)
    local wsmode

    if spell.type == 'WeaponSkill' and state.AttackMode.value == 'Uncapped' then
        wsmode = 'Uncapped'
    end
--    if state.Buff['Sneak Attack'] then
--        wsmode = 'Critical'
--    end
--    if state.Buff['Trick Attack'] then
 --       wsmode = 'Critical'
--    end

    return wsmode
end

function customize_idle_set(idleSet)
--    if state.CP.current == 'on' then
--        equip(sets.CP)
--        disable('back')
--    else
--        enable('back')
--    end
--    if state.Auto_Kite.value == true then
--       idleSet = set_combine(idleSet, sets.Kiting)
--    end

    return idleSet
end

function customize_melee_set(meleeSet)
    if state.TreasureMode.value == 'Fulltime' then
        meleeSet = set_combine(meleeSet, sets.TreasureHunter)
    end

    return meleeSet
end

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

    local d_msg = 'None'
    if state.DefenseMode.value ~= 'None' then
        d_msg = state.DefenseMode.value .. state[state.DefenseMode.value .. 'DefenseMode'].value
    end

    local i_msg = state.IdleMode.value

    local msg = ''
    if state.TreasureMode.value ~= 'None' then
        msg = msg .. ' TH: ' ..state.TreasureMode.value.. ' |'
    end
    if state.Kiting.value then
        msg = msg .. ' Kiting: On |'
    end

    add_to_chat(002, '| ' ..string.char(31,210).. 'Melee' ..cf_msg.. ': ' ..string.char(31,001)..m_msg.. string.char(31,002)..  ' |'
        ..string.char(31,207).. ' WS: ' ..string.char(31,001)..ws_msg.. string.char(31,002)..  ' |'
        ..string.char(31,004).. ' Defense: ' ..string.char(31,001)..d_msg.. string.char(31,002)..  ' |'
        ..string.char(31,008).. ' Idle: ' ..string.char(31,001)..i_msg.. string.char(31,002)..  ' |'
        ..string.char(31,002)..msg)

    eventArgs.handled = true
end


-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------


-- Automatically use Presto for steps when it's available and we have less than 3 finishing moves
function job_pretarget(spell, action, spellMap, eventArgs)
    if spell.type == 'Step' then
        local allRecasts = windower.ffxi.get_ability_recasts()
        local prestoCooldown = allRecasts[236]
        local under3FMs = not buffactive['Finishing Move 3'] and not buffactive['Finishing Move 4'] and not buffactive['Finishing Move 5']

        if player.main_job_level >= 77 and prestoCooldown < 1 and under3FMs then
            cast_delay(1.1)
            send_command('input /ja "Presto" <me>')
        end
    end
end

-- State buff checks that will equip buff gear and mark the event as handled.
function check_buff(buff_name, eventArgs)
    if state.Buff[buff_name] then
        equip(sets.buff[buff_name] or {})
        if state.TreasureMode.value == 'SATA' or state.TreasureMode.value == 'Fulltime' then
            equip(sets.TreasureHunter)
        end
        eventArgs.handled = true
    end
end


-- Check for various actions that we've specified in user code as being used with TH gear.
-- This will only ever be called if TreasureMode is not 'None'.
-- Category and Param are as specified in the action event packet.
function th_action_check(category, param)
    if category == 2 or -- any ranged attack
        --category == 4 or -- any magic action
        (category == 3 and param == 30) or -- Aeolian Edge
        (category == 6 and info.default_ja_ids:contains(param)) or -- Provoke, Animated Flourish
        (category == 14 and info.default_u_ja_ids:contains(param)) -- Quick/Box/Stutter Step, Desperate/Violent Flourish
        then return true
    end
end

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    -- Default macro set/book
    if player.sub_job == 'DRG' then
        set_macro_page(1, 1)
    elseif player.sub_job == 'DNC' then
        set_macro_page(2, 1)
    elseif player.sub_job == 'NIN' then
        set_macro_page(3, 1)
	elseif player.sub_job == 'RUN' then
        set_macro_page(4, 1)
	elseif player.sub_job == 'WAR' then
        set_macro_page(5, 1)
    else
        set_macro_page(1, 1)
    end
end

function set_lockstyle()
    send_command('wait 4; input /lockstyleset ' .. lockstyleset)
end

ranged_ws=S{'pewpewda boomm', 'Last Stand', 'etc' }

function job_precast(spell, action, spellMap, eventArgs)
	if spell.type:lower() == 'weaponskill' then
		if (spell.target.distance >8 and not ranged_ws[spell.name]) or (spell.target.distance >21) then
			cancel_spell()
			return
		end
	end
end

function job_precast(spell, action, spellMap, eventArgs)
	if spell.type:lower() == 'weaponskill' then
		if (spell.target.distance >8) then
			cancel_spell()
			return
		end
	end
end

function job_post_precast(spell, action, spellMap, eventArgs)
    if (spell.type == 'CorsairRoll' or spell.english == "Double-Up") then
        if player.status ~= 'Engaged' and state.WeaponLock.value == false then
            equip(sets.precast.CorsairRoll.Duration)
        end
    end
end