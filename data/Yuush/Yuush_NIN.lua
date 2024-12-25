-- Original: Motenten / Modified: Arislan
-- Haste/DW Detection Requires Gearinfo Addon

-------------------------------------------------------------------------------------------------------------------
--  Keybinds
-------------------------------------------------------------------------------------------------------------------

--  Modes:      [ F9 ]              Cycle Offense Modes
--              [ CTRL+F9 ]         Cycle Hybrid Modes
--              [ WIN+F9 ]          Cycle Weapon Skill Modes
--              [ F10 ]             Emergency -PDT Mode
--              [ ALT+F10 ]         Toggle Kiting Mode
--              [ F11 ]             Emergency -MDT Mode
--              [ CTRL+F11 ]        Cycle Casting Modes
--              [ F12 ]             Update Current Gear / Report Current Status
--              [ CTRL+F12 ]        Cycle Idle Modes
--              [ ALT+F12 ]         Cancel Emergency -PDT/-MDT Mode
--              [ ALT+` ]           Toggle Magic Burst Mode
--              [ WIN+C ]           Toggle Capacity Points Mode
--
--
--              (Global-Binds.lua contains additional non-job-related keybinds)


-------------------------------------------------------------------------------------------------------------------
-- Setup functions for this job.  Generally should not be modified.
-------------------------------------------------------------------------------------------------------------------

-- Initialization function for this job file.
function get_sets()
    mote_include_version = 2

    -- Load and initialize the include file.
    include('Mote-Include.lua')
end


-- Setup vars that are user-independent.  state.Buff vars initialized here will automatically be tracked.
function job_setup()
    state.Buff.Migawari = buffactive.migawari or false
    state.Buff.Doom = buffactive.doom or false
    state.Buff.Yonin = buffactive.Yonin or false
    state.Buff.Innin = buffactive.Innin or false
    state.Buff.Futae = buffactive.Futae or false

    include('Mote-TreasureHunter')

    -- For th_action_check():
    -- JA IDs for actions that always have TH: Provoke, Animated Flourish
    info.default_ja_ids = S{35, 204}
    -- Unblinkable JA IDs for actions that always have TH: Quick/Box/Stutter Step, Desperate/Violent Flourish
    info.default_u_ja_ids = S{201, 202, 203, 205, 207}

    lugra_ws = S{'Blade: Kamu', 'Blade: Shun', 'Blade: Ten'}

    lockstyleset = 1
end

-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
    state.OffenseMode:options('Normal', 'Acc', 'DW')
    state.HybridMode:options('Normal', 'DT')
    state.WeaponskillMode:options('Normal', 'Acc')
    state.CastingMode:options('Normal', 'Resistant')
    state.IdleMode:options('Normal', 'DT')
    state.PhysicalDefenseMode:options('PDT', 'Evasion')

    state.MagicBurst = M(false, 'Magic Burst')
    state.CP = M(false, "Capacity Points Mode")

    state.Night = M(false, "Dusk to Dawn")
    options.ninja_tool_warning_limit = 10

    -- Additional local binds
    send_command('bind !` gs c toggle MagicBurst')
	
	--

    -- Whether a warning has been given for low ninja tools
    state.warned = M(false)

    select_movement_feet()
    select_default_macro_book()
    set_lockstyle()

    DW = false
    moving = false
    update_combat_form()
end

function user_unload()
    send_command('unbind ^`')
    send_command('unbind !`')
    send_command('unbind ^-')
    send_command('unbind ^=')
end

-- Define sets and vars used by this job file.
function init_gear_sets()
    --------------------------------------
    -- Precast sets
    --------------------------------------

    -- Enmity set
    sets.Enmity = {
		ammo="Sapience Orb",
		head={ name="Herculean Helm", augments={'"Mag.Atk.Bns."+13','"Fast Cast"+6','DEX+6','Mag. Acc.+2',}},
		body="Emet Harness +1",
		hands="Kurys Gloves",
		legs="Zoar Subligar +1",
		feet={ name="Mochi. Kyahan +1", augments={'Enh. Ninj. Mag. Acc/Cast Time Red.',}},
		neck="Moonlight Necklace",
		waist="Trance Belt",
		left_ear="Trux Earring",
		right_ear="Cryptic Earring",
		left_ring="Eihwaz Ring",
		right_ring="Supershear Ring",
		back={ name="Andartia's Mantle", augments={'AGI+20','Eva.+20 /Mag. Eva.+20','Enmity+10',}},
		}

    sets.precast.JA['Provoke'] = sets.Enmity
    sets.precast.JA['Mijin Gakure'] = {legs="Mochi. Hakama +1"}
    sets.precast.JA['Futae'] = {legs="Hattori Tekko +1"}
    sets.precast.JA['Sange'] = {body="Mochi. Chainmail +1"}


    -- Fast cast sets for spells

    sets.precast.FC = {		
		ammo="Sapience Orb",
		head={ name="Herculean Helm", augments={'"Mag.Atk.Bns."+13','"Fast Cast"+6','DEX+6','Mag. Acc.+2',}},
		body={ name="Adhemar Jacket +1", augments={'HP+105','"Fast Cast"+10','Magic dmg. taken -4',}},
		hands={ name="Leyline Gloves", augments={'Accuracy+15','Mag. Acc.+15','"Mag.Atk.Bns."+15','"Fast Cast"+3',}},
		legs={ name="Herculean Trousers", augments={'Mag. Acc.+16 "Mag.Atk.Bns."+16','"Fast Cast"+5','Mag. Acc.+4',}},
		feet={ name="Herculean Boots", augments={'Mag. Acc.+17','"Fast Cast"+6','MND+2',}},
		neck="Orunmila's Torque",
		waist="Audumbla Sash",
		left_ear="Loquac. Earring",
		right_ear="Etiolation Earring",
		left_ring="Kishar Ring",
		right_ring="Defending Ring",
		back={ name="Andartia's Mantle", augments={'AGI+20','Eva.+20 /Mag. Eva.+20','"Fast Cast"+10',}},
		}

    sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, {neck="Magoraga Beads"})

    sets.precast.RA = {}

    -- Weaponskill sets
    -- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS = {} -- default set


    sets.precast.WS['Blade: Hi'] =  {        
		ammo = "Yetshila", 
        head = "Hachiya Hatsuburi +3", 
        neck = "Rancor Collar",
        ear1 = "Odr Earring",
        ear2 = "Ishvara Earring", 
        body = "Ken. Samue +1",
        hands = "Mummu Wrists +2",
        ring1 = "Regal Ring", 
        ring2 = "Begrudging Ring",
        back = Andartia.AGI_WSD,
        waist = "Sailfi Belt +1",
        legs = "Mummu Kecks +2", --Relic +3
        feet = "Mummu Gamash. +2",
		}
		
    sets.precast.WS['Blade: Ten'] =  {
		ammo = "Seething Bomblet +1", --r15 until then use w/e has most STR
		head = "Hachiya Hatsu. +3",
		neck = "Caro Necklace",
        ear1 = "Lugra Earring +1", 
        ear2 = "Moonshade Earring",
		body = HerculeanBody.STR_WSD,
		hands = HerculeanHands.STR_WSD,
		ring1 = "Epaminondas's Ring",
		ring2 = "Regal Ring",
		back = Andartia.AGI_WSD, --STR WS
		waist = "Sailfi Belt +1",
		legs = "Hiza. Hizayoroi +2",
		feet = HerculeanFeet.STR_WSD
		}
		
    sets.precast.WS['Blade: Shun'] =  {
		ammo = "C. Palug Stone", 
        head = "Ken. Jinpachi +1", 
        neck = "Fotia Gorget",
        ear1 = "Odr Earring",
        ear2 = "Lugra Earring +1", 
        body = "Adhemar Jacket +1",
        hands = "Ken. Tekko +1",
        ring1 = "Regal Ring", 
        ring2 = "Gere Ring",
        back = Andartia.DEX_DA, --DEX + WSD
        waist = "Fotia Belt",
        legs = "Jokushu Haidate",
        feet = "Ken. Sune-Ate +1",
		}
		
	sets.precast.WS['Blade: Metsu'] = {}
	
    sets.precast.WS['Blade: Kamu'] = {}
		
	sets.precast.WS['Blade: Ku'] = {}
		
	sets.precast.WS['Blade: Jin'] = {}
	
	sets.precast.WS['Blade: Yu'] = {}

    --------------------------------------
    -- Midcast sets
    --------------------------------------

    sets.midcast.FastRecast = sets.precast.FC

    sets.midcast.SpellInterrupt = {}

    -- Specific spells
    sets.midcast.Utsusemi = {
		ammo="Sapience Orb",
		head={ name="Herculean Helm", augments={'"Mag.Atk.Bns."+13','"Fast Cast"+6','DEX+6','Mag. Acc.+2',}},
		body="Emet Harness +1",
		hands="Kurys Gloves",
		legs="Zoar Subligar +1",
		feet="Hattori Kyahan +1",
		neck="Moonlight Necklace",
		waist="Trance Belt",
		left_ear="Trux Earring",
		right_ear="Cryptic Earring",
		left_ring="Eihwaz Ring",
		right_ring="Supershear Ring",
		back={ name="Andartia's Mantle", augments={'AGI+20','Eva.+20 /Mag. Eva.+20','Enmity+10',}},
		}

    sets.midcast.ElementalNinjutsu = {}

--    sets.midcast.ElementalNinjutsu.Resistant = set_combine(sets.midcast.Ninjutsu, {})

    sets.midcast.EnfeeblingNinjutsu = {}

    sets.midcast.EnhancingNinjutsu = {}

    sets.midcast.RA = {}

    --------------------------------------
    -- Idle/resting/defense/etc sets
    --------------------------------------

    -- Resting sets
--    sets.resting = {}

    -- Idle sets
    sets.idle = {
		ammo = "Staunch Tathlum +1",
		head = "Malignance Chapeau",
		neck = "Bathy Choker +1",
		ear1 = "Eabani Earring",
		ear2 = "Odnowa Earring +1",
		body = "Hiza. Haramaki +2",
		hands = "Malignance Gloves",
		ring1 = "Defending Ring",
		ring2 = "Gelatinous Ring +1",
		back = "Moonbeam Cape",
		waist = "Flume Belt +1",
		legs = "Malignance Tights",
		feet = "Malignance Boots"
		}

    sets.idle.DT = set_combine(sets.idle, {})

    -- Tanking Sets
	sets.defense.PDT = {}
	
    sets.defense.MDT = {}

    sets.Kiting = {}

    sets.DayMovement = {}
    sets.NightMovement = {}


    --------------------------------------
    -- Engaged sets
    --------------------------------------

    -- Engaged sets

    -- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
    -- sets if more refined versions aren't defined.
    -- If you create a set with both offense and defense modes, the offense mode should be first.
    -- EG: sets.engaged.Dagger.Accuracy.Evasion

    -- * NIN Native DW Trait: 35% DW

    sets.engaged = {
		ammo = "Date Shuriken",
		head = "Adhemar Bonnet +1",
		neck = "Iskur Gorget",
		--neck = Dyna Neck +1 or +2
		ear1 = "Telos Earring",
		ear2 = "Dedition Earring",
		body = "Kendatsuba Samue +1",
		hands = AdhemarHands.A,
		ring1 = "Epona's Ring",
		ring2 = "Gere Ring",
		back = Andartia.DEX_DA,
		waist = "Windbuffet Belt +1",
		--legs = "Samnuha Tights",
		legs = "Ken. Hakama +1",
		feet = HerculeanFeet.STR_TA
		} 

    sets.engaged.LowAcc = set_combine(sets.engaged, {
		head = "Ken. Jinpachi +1",
		feet = "Ken. Sune-Ate +1",
		})

	--The Issue at this point seems to be Racc--
    sets.engaged.Acc = set_combine(sets.engaged.LowAcc, {
		hands = "Ken. Tekko +1",
		})
	
    sets.engaged.DW = set_combine(sets.engaged, {})

	sets.Hybrid = {
		head = "Malignance Chapeau",
		hands = "Malignance Gloves",
		ring1 = "Defending Ring",
		feet = "Malignance Boots",
		}

    sets.engaged.DT = set_combine(sets.engaged, sets.engaged.Hybrid)
    sets.engaged.LowAcc.DT = set_combine(sets.engaged.LowAcc, sets.engaged.Hybrid)
    sets.engaged.Acc.DT = set_combine(sets.engaged.MidAcc, sets.engaged.Hybrid)
    sets.engaged.DW.DT = set_combine(sets.engaged.STP, sets.engaged.Hybrid)

    --------------------------------------
    -- Custom buff sets
    --------------------------------------

    sets.magic_burst = {}

--    sets.buff.Migawari = {body="Iga Ningi +2"}

    sets.buff.Doom = {}
        
--    sets.buff.Yonin = {}
--    sets.buff.Innin = {}

    sets.CP = {}
    sets.TreasureHunter = {}

end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------

function job_precast(spell, action, spellMap, eventArgs)
    if spell.skill == "Ninjutsu" then
        do_ninja_tool_checks(spell, spellMap, eventArgs)
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
        if lugra_ws:contains(spell.english) and state.Night.value == true then
                equip(sets.LugraRight)
            if spell.english == 'Blade: Kamu' then
                equip(sets.LugraLeft)
            end
        end
        if spell.english == 'Blade: Yu' and (world.weather_element == 'Water' or world.day_element == 'Water') then
            equip(sets.Obi)
        end
    end
end

-- Run after the general midcast() is done.
-- eventArgs is the same one used in job_midcast, in case information needs to be persisted.
function job_post_midcast(spell, action, spellMap, eventArgs)
    if default_spell_map == 'ElementalNinjutsu' then
        if state.MagicBurst.value then
            equip(sets.magic_burst)
        end
        if (spell.element == world.day_element or spell.element == world.weather_element) then
            equip(sets.Obi)
        end
        if state.Buff.Futae then
            equip(sets.precast.JA['Futae'])
        end
    end
    if state.Buff.Doom then
        equip(sets.buff.Doom)
    end
end


-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_aftercast(spell, action, spellMap, eventArgs)
    if not spell.interrupted and spell.english == "Migawari: Ichi" then
        state.Buff.Migawari = true
    end
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for non-casting events.
-------------------------------------------------------------------------------------------------------------------

-- Called when a player gains or loses a buff.
-- buff == buff gained or lost
-- gain == true if the buff was gained, false if it was lost.
function job_buff_change(buff, gain)
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

end

function job_status_change(new_status, old_status)
    if new_status == 'Idle' then
        select_movement_feet()
    end
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
    th_update(cmdParams, eventArgs)
end

function update_combat_form()
    if DW == true then
        state.CombatForm:set('DW')
    elseif DW == false then
        state.CombatForm:reset()
    end
end

-- Modify the default idle set after it was constructed.
function customize_idle_set(idleSet)
    if state.Buff.Migawari then
       idleSet = set_combine(idleSet, sets.buff.Migawari)
    end
    if state.CP.current == 'on' then
        equip(sets.CP)
        disable('back')
    else
        enable('back')
    end

    idleSet = set_combine(idleSet, select_movement_feet())

    return idleSet
end


-- Modify the default melee set after it was constructed.
function customize_melee_set(meleeSet)
    if state.Buff.Migawari then
        meleeSet = set_combine(meleeSet, sets.buff.Migawari)
    end
    if state.TreasureMode.value == 'Fulltime' then
        meleeSet = set_combine(meleeSet, sets.TreasureHunter)
    end

    return meleeSet
end

function job_self_command(cmdParams, eventArgs)

---  THIS IS WHERE BUFF COMANDS GO  ---
	
	if cmdParams[1] == 'returntp' then
        add_to_chat(158, 'TP Return = '..tostring(player.tp))
    end
	
	if cmdParams[1] == 'ambu' then
       send_command('input /ja "Hasso" <me>; wait 1; input /ja "Meditate" <me>; wait 1; input /ja "Berserk" <me>; wait 1; input /ja "Agressor" <me>; wait 1; input /ja "Sekkanoki" <me>')
    end
	
	if cmdParams[1] == 'warp' then
		send_command('input /equip ring1 "Warp ring"; wait 12; input /item "Warp ring" <me>')
        add_to_chat(158,'warp ring')
	elseif cmdParams[1] == 'dem' then
		send_command('input /equip ring2 "Dimensional ring (Dem)"; wait 12; input /item "Dimensional ring (Dem)" <me>')
        add_to_chat(158,'dem ring')
	end
	
	if cmdParams:get(1) == 'unfollow' then 
		send_command('setkey numpad7 down;wait 0.1;setkey numpad7 up') 
		add_to_chat(158,'unfollow') 
	end
	
end

-- Function to display the current relevant user state when doing an update.
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
    if state.TreasureMode.value == 'Tag' then
        msg = msg .. ' TH: Tag |'
    end
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

function select_movement_feet()
    if world.time >= (17*60) or world.time <= (7*60) then
        state.Night:set()
        return sets.NightMovement
    else
        state.Night:reset()
        return sets.DayMovement
    end
end

-- Determine whether we have sufficient tools for the spell being attempted.
function do_ninja_tool_checks(spell, spellMap, eventArgs)
    local ninja_tool_name
    local ninja_tool_min_count = 1

    -- Only checks for universal tools and shihei
    if spell.skill == "Ninjutsu" then
        if spellMap == 'Utsusemi' then
            ninja_tool_name = "Shihei"
        elseif spellMap == 'ElementalNinjutsu' then
            ninja_tool_name = "Inoshishinofuda"
        elseif spellMap == 'EnfeeblingNinjutsu' then
            ninja_tool_name = "Chonofuda"
--        elseif spellMap == 'EnhancingNinjutsu' then
--            ninja_tool_name = "Shikanofuda"
        else
            return
        end
    end

    local available_ninja_tools = player.inventory[ninja_tool_name] or player.wardrobe[ninja_tool_name]

    -- If no tools are available, end.
    if not available_ninja_tools then
        if spell.skill == "Ninjutsu" then
            return
        end
    end

    -- Low ninja tools warning.
    if spell.skill == "Ninjutsu" and state.warned.value == false
        and available_ninja_tools.count > 1 and available_ninja_tools.count <= options.ninja_tool_warning_limit then
        local msg = '*****  LOW TOOLS WARNING: '..ninja_tool_name..' *****'
        --local border = string.repeat("*", #msg)
        local border = ""
        for i = 1, #msg do
            border = border .. "*"
        end

        add_to_chat(104, border)
        add_to_chat(104, msg)
        add_to_chat(104, border)

        state.warned:set()
    elseif available_ninja_tools.count > options.ninja_tool_warning_limit and state.warned then
        state.warned:reset()
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

windower.register_event('zone change', 
    function()
        send_command('gi ugs true')
    end
)

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    -- Default macro set/book
    if player.sub_job == 'DNC' then
        set_macro_page(2, 11)
    elseif player.sub_job == 'THF' then
        set_macro_page(3, 11)
    else
        set_macro_page(1, 11)
    end
end

function set_lockstyle()
    send_command('wait 2; input /lockstyleset ' .. lockstyleset)
end