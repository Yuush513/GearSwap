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
    state.Buff['Afflatus Solace'] = buffactive['Afflatus Solace'] or false
    state.Buff['Afflatus Misery'] = buffactive['Afflatus Misery'] or false
	
    no_swap_gear = S{"Warp Ring", "Dim. Ring (Dem)", "Dim. Ring (Holla)", "Dim. Ring (Mea)",
       "Trizek Ring", "Echad Ring", "Facility Ring", "Capacity Ring"}
	
	lockstyleset = 19
	
	--whm_sub_weapons = S{'Makhila +2'}
	
	enhancing_teleportation = S{'Warp','Warp II', 'Escape', 'Recall-Jugner', 'Recall-Pashh', 'Recall-Meriph',
	'Teleport-Holla','Teleport-Dem','Teleport-Mea','Teleport-Yhoat','Teleport-Altepa','Teleport-Vahzl'}
end

-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
    state.OffenseMode:options('None', 'Yagrush', 'YagrushAcc', 'Maxentius')
    state.CastingMode:options('Normal','MEVA')
    state.IdleMode:options('Normal', 'Refresh')
	state.PhysicalDefenseMode:options('PDT')
    state.MagicalDefenseMode:options('MDT', 'Silence')
   
	state.WeaponLock = M(false, 'Weapon Lock')
    state.MagicBurst = M(false, 'Magic Burst')
	
	state.BarElement = M{['description']='BarElement', 'Barfira', 'Barblizzara', 'Baraera', 'Barstonra', 'Barthundra', 'Barwatera'}
    state.BarStatus = M{['description']='BarStatus', 'Baramnesra', 'Barvira', 'Barparalyzra', 'Barsilencera', 'Barpetra', 'Barpoisonra', 'Barblindra', 'Barsleepra'}
    state.BoostSpell = M{['description']='BoostSpell', 'Boost-STR', 'Boost-INT', 'Boost-AGI', 'Boost-VIT', 'Boost-DEX', 'Boost-MND', 'Boost-CHR'}
	
--	state.CombatForm  = M{['description']='Combat Form', ['string']='DW'}
	
    select_default_macro_book()
	
	update_combat_form()
	set_lockstyle()
	
	--
	
	send_command('bind f8 gs c toggle MagicBurst')
	
    send_command('bind ^insert gs c cycleback BoostSpell')
    send_command('bind ^delete gs c cycle BoostSpell')
    send_command('bind ^home gs c cycleback BarElement')
    send_command('bind ^end gs c cycle BarElement')
    send_command('bind ^pageup gs c cycleback BarStatus')
    send_command('bind ^pagedown gs c cycle BarStatus')
	send_command('bind ^f10 gs c cycle MagicalDefenseMode')
end

function user_unload()

    send_command('unbind ^insert')
    send_command('unbind ^delete')
    send_command('unbind ^home')
    send_command('unbind ^end')
    send_command('unbind ^pageup')
    send_command('unbind ^pagedown')
	send_command('unbind ^f10')

end

-- Define sets and vars used by this job file.
function init_gear_sets()
    --------------------------------------
    -- Start defining the sets
    --------------------------------------
    -- Precast Sets

    -- Fast cast sets for spells
    sets.precast.FC = {    
		main="Chatoyant Staff",
		sub="Irenic Strap +1",
		ammo="Staunch Tathlum",
		head="Nahtirah Hat",
		body="Inyanga Jubbah +2",
		hands={ name="Fanatic Gloves", augments={'MP+50','Healing magic skill +10','"Conserve MP"+7','"Fast Cast"+7',}},
		legs="Aya. Cosciales +2",
		feet="Volte Gaiters",
		neck="Baetyl Pendant",
		waist="Witful Belt",
		left_ear="Mendi. Earring",
		right_ear="Malignance Earring",
		left_ring="Lebeche Ring",
		right_ring="Kishar Ring",
		back={ name="Alaunus's Cape", augments={'MND+20','Mag. Acc+20 /Mag. Dmg.+20','"Fast Cast"+10',}},
	}
		
	sets.precast.FC['Healing Magic'] = set_combine(sets.precast.FC,{legs="Ebers Pant. +1",})
		
	sets.precast.FC.Raise = set_combine(sets.precast.FC['Healing Magic'], {}) 
		
	sets.precast.FC.Reraise = sets.precast.FC.Raise
   
    sets.precast.FC.StatusRemoval = set_combine(sets.precast.FC['Healing Magic'], {})
   
    sets.precast.FC.Cure = set_combine(sets.precast.FC['Healing Magic'], {})
    sets.precast.FC.Curaga = sets.precast.FC.Cure
    sets.precast.FC.CureSolace = sets.precast.FC.Cure
	
    sets.precast.FC['Enhancing Magic'] = set_combine(sets.precast.FC, {})

    sets.precast.FC['Dispelga'] = set_combine(sets.precast.FC, {main="Daybreak", sub="Ammurapi Shield"})  
   
   sets.precast.FC.Impact = set_combine(sets.precast.FC, {})
	
    -- Precast sets to enhance JAs
    sets.precast.JA['Benediction'] = {body="Piety Briault +1"}
    sets.precast.JA['Devotion'] = {head = "Piety Cap +1"}
	sets.precast.JA['Martyr'] = {hands = "Piety Mitts +1"}

	-- Midcast Sets
    sets.midcast.FC = set_combine(sets.precast.FC,{})
		
	-- Define these sets into an array later:
	sets.midcast['Warp'] = sets.midcast.FC
	sets.midcast['Warp II'] = sets.midcast.FC
	sets.midcast['Escape'] = sets.midcast.FC
	sets.midcast['Teleport'] = sets.midcast.FC
		
    -- Cure sets

    sets.midcast.CureSolace = {
	    main="Chatoyant Staff",
		sub="Irenic Strap +1",
		ammo="Staunch Tathlum",
		head={ name="Kaykaus Mitra", augments={'MP+60','"Cure" spellcasting time -5%','Enmity-5',}},
		body="Ebers Bliaud +1",
		hands="Theophany Mitts +2",
		legs="Ebers Pant. +1",
		feet={ name="Kaykaus Boots", augments={'MP+60','"Cure" spellcasting time -5%','Enmity-5',}},
		neck="Clr. Torque +1",
		waist="Luminary Sash",
		left_ear="Mendi. Earring",
		right_ear="Nourish. Earring +1",
		left_ring="Lebeche Ring",
		right_ring="Defending Ring",
		back={ name="Alaunus's Cape", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','Enmity-10','Phys. dmg. taken-10%',}},
	} 
	
	sets.midcast.CureSolace.MEVA = {} 
	
    sets.midcast.CureSolaceWeather = set_combine(sets.midcast.CureSolace, {}) 
	
	sets.midcast.CureSolaceWeather.MEVA = set_combine(sets.midcast.CureSolace.MEVA , {})
	
    sets.midcast.CureNormal = set_combine(sets.midcast.CureSolace, {})
		
	sets.midcast.CureNormal.MEVA = sets.midcast.CureSolace.MEVA
	
    sets.midcast.CureWeather = set_combine(sets.midcast.CureSolaceWeather, {})
	
	sets.midcast.CureWeather.MEVA = set_combine(sets.midcast.CureSolaceWeather.MEVA, {})
		
    sets.midcast.CuragaNormal = set_combine(sets.midcast.CureNormal, {})

	sets.midcast.CuragaNormal.MEVA = set_combine(sets.midcast.CureNormal.MEVA, {})
	
    sets.midcast.CuragaWeather = set_combine(sets.midcast.CureWeather, {})
	
	sets.midcast.CuragaWeather.MEVA = set_combine(sets.midcast.CureWeather.MEVA, {})

    sets.midcast.CureMelee = {} 
	
	sets.midcast.CureMelee.MEVA = {}

    sets.midcast.StatusRemoval = {
	    main="Chatoyant Staff",
		sub="Irenic Strap +1",
		ammo="Staunch Tathlum",
		head="Ebers Cap +1",
		body="Inyanga Jubbah +2",
		hands={ name="Fanatic Gloves", augments={'MP+50','Healing magic skill +10','"Conserve MP"+7','"Fast Cast"+7',}},
		legs="Aya. Cosciales +2",
		feet="Volte Gaiters",
		neck="Clr. Torque +1",
		waist="Witful Belt",
		left_ear="Etiolation Earring",
		right_ear="Malignance Earring",
		left_ring="Lebeche Ring",
		right_ring="Kishar Ring",
		back={ name="Alaunus's Cape", augments={'MND+20','Mag. Acc+20 /Mag. Dmg.+20','"Fast Cast"+10',}},
	} 

    sets.midcast.Cursna = {}
	
	--500 skill + Duration
    sets.midcast['Enhancing Magic'] = {
	    head="Ebers Cap +1",
		body="Ebers Bliaud +1",
		hands="Ebers Mitts +1",
		legs={ name="Piety Pantaln. +1", augments={'Enhances "Afflatus Misery" effect',}},
		feet="Ebers Duckbills +1",
		neck="Melic Torque",
		left_ear="Andoaa Earring",
		}

    sets.midcast.EnhancingDuration = set_combine(sets.midcast['Enhancing Magic'], { 
        head="Ebers Cap +1",
		body="Ebers Bliaud +1",
		hands="Ebers Mitts +1",
		legs={ name="Piety Pantaln. +1", augments={'Enhances "Afflatus Misery" effect',}},
		feet="Ebers Duckbills +1",
		neck="Melic Torque",
		left_ear="Andoaa Earring",
	})
		
    sets.midcast.BarElement = set_combine(sets.midcast['Enhancing Magic'], {})
	
    sets.midcast.Regen = {
	    head="Inyanga Tiara +2",
		body={ name="Piety Briault +1", augments={'Enhances "Benediction" effect',}},
		hands="Ebers Mitts +1",
		legs="Th. Pantaloons +2",
		feet="Theo. Duckbills +2",
	}

    sets.midcast['Aquaveil'] = set_combine(sets.midcast['Enhancing Magic'], {})
    
	sets.midcast['Auspice'] = set_combine(sets.midcast.EnhancingDuration, {feet = "Ebers Duckbills +1"})
		
    sets.midcast['Stoneskin'] = set_combine(sets.midcast.EnhancingDuration, {})

    sets.midcast.Proshell = set_combine(sets.midcast.EnhancingDuration, {})

	--Repose--
	sets.midcast['Divine Magic'] = {}

    sets.midcast.Banish = {}

    sets.midcast.Holy = sets.midcast.Banish

    sets.midcast['Dark Magic'] = {}

    sets.midcast.MndEnfeebles = {}

    sets.midcast.IntEnfeebles = set_combine(sets.midcast.MndEnfeebles, {})
	sets.midcast['Dispelga'] = set_combine(sets.midcast.IntEnfeebles, {main = "Daybreak"})
	
	sets.midcast.Impact = {}
	
	-- Sets to return to when not performing an action.
    
    -- Resting sets

    sets.idle = {
	    main="Chatoyant Staff",
		sub="Irenic Strap +1",
		ammo="Staunch Tathlum",
		head="Inyanga Tiara +2",
		body="Inyanga Jubbah +2",
		hands="Inyan. Dastanas +2",
		legs="Inyanga Shalwar +2",
		feet="Volte Gaiters",
		neck={ name="Loricate Torque +1", augments={'Path: A',}},
		waist="Carrier's Sash",
		left_ear="Etiolation Earring",
		right_ear="Eabani Earring",
		left_ring="Inyanga Ring",
		right_ring="Defending Ring",
		back={ name="Alaunus's Cape", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','Enmity-10','Phys. dmg. taken-10%',}},
	}
	
	sets.idle.Refresh = {}
	
    -- Defense sets

    sets.defense.PDT = set_combine(sets.idle, {})

    sets.defense.MDT = set_combine(sets.idle, {})
   
   -- Buff sets: Gear that needs to be worn to actively enhance a current player buff.
   
    sets.buff['Divine Caress'] = {hands="Ebers Mitts +1",}
	
	sets.Obi = {}
   
    sets.magic_burst = {}
    
	
	------------------
	-- Engaged Sets --
	------------------    

	sets.engaged = {}
	
	sets.engaged.DW = set_combine(sets.engaged, {})
	
	sets.engaged.AM = set_combine(sets.engaged,{})
		
	sets.engaged.AM_DW = set_combine(sets.engaged.AM, {})
	
	
	-- Weaponskill sets

    -- Default set for any weaponskill that isn't any more specifically defined
	sets.precast.WS = {}
	
	--1 hit | 70% MND / 30% STR | Scales
	sets.precast.WS['Mystic Boon'] = set_combine(sets.precast.WS, {})
	
	--2 hit | 70% MND / 30% STR | Scales
	--Assuming Main Hand Maxentius
    sets.precast.WS['Black Halo'] = set_combine(sets.precast.WS, {})
		
	--7 hit |  73~85% MND | No Scale
	sets.precast.WS['Realmrazer'] = set_combine(sets.precast.WS, {})
	
	--1 hit | 40% STR / 40% MND | No Scale
	sets.precast.WS['Randgrith'] = set_combine(sets.precast.WS, {})
	
	--6 hit | Crit | 30% STR / 30% MND
	sets.precast.WS['Hexa Strike'] = set_combine(sets.precast.WS, {})

	--Magical | 50% STR / 50% MND | No Scale
	sets.precast.WS['Flash Nova'] = sets.midcast.Banish

end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
-- Set eventArgs.useMidcastGear to true if we want midcast gear equipped on precast.
function job_precast(spell, action, spellMap, eventArgs)
    if spell.english == "Paralyna" and buffactive.Paralyzed then
        -- no gear swaps if we're paralyzed, to avoid blinking while trying to remove it.
        eventArgs.handled = true
    end
end

function job_post_precast(spell, action, spellMap, eventArgs)
    if spell.name == 'Impact' then
        equip(sets.precast.FC.Impact)
    end
end

function job_post_midcast(spell, action, spellMap, eventArgs)
    -- Apply Divine Caress boosting items as highest priority over other gear, if applicable.
    if spellMap == 'StatusRemoval' and buffactive['Divine Caress'] then
        equip(sets.buff['Divine Caress'])
    end
    if spellMap == 'Banish' or spellMap == "Holy" then
	    if state.MagicBurst.value then
            equip(sets.magic_burst)
        end
        if (world.weather_element == 'Light' or world.day_element == 'Light') then
            equip(sets.Obi)
        end
    end
--	if spellMap == 'BarElement' and buffactive['Light Arts'] then
--		equip(sets.midcast.BarElement.LA)
--	end
    if spell.skill == 'Enhancing Magic' then 
	
        if classes.NoSkillSpells:contains(spell.english) then
			equip(sets.midcast.EnhancingDuration)
            if spellMap == 'Refresh' then
                equip(sets.midcast.Refresh)
			end
		end
		if spellMap == 'BarElement' then
			equip(sets.midcast.BarElement)
		end
		if spellMap == 'Shellra' or spellMap == 'Protectra' or spellMap == 'Protect' or spellMap == 'Shell' then
			equip(sets.midcast.Proshell)
		end
		--fixed this--
		if spell.name == 'Erase' then
			equip(sets.midcast.StatusRemoval)
		end
		if spellMap == "Regen" then
            equip(sets.midcast.Regen)
        end
		
    end
end

function job_buff_change(buff,gain)
    if buff:startswith('Aftermath') then
        state.Buff.Aftermath = gain
        customize_melee_set()
        handle_equipping_gear(player.status)
    end
end
-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for non-casting events.
-------------------------------------------------------------------------------------------------------------------
--[[
-- Handle notifications of general user state change.
function job_state_change(stateField, newValue, oldValue)
    if stateField == 'Offense Mode' then
        if newValue == 'Yagrush' then
			if S{'NIN', 'DNC'}:contains(player.sub_job) then
				equip(sets.YagrushDW)
				disable('main','sub')
			else
				equip(sets.Yagrush)
				disable('main','sub')
			end
		elseif newValue == 'YagrushAcc' then
			enable('main','sub','range')
			if S{'NIN', 'DNC'}:contains(player.sub_job) then
				equip(sets.YagrushAccDW)
				disable('main','sub')
			else
				equip(sets.YagrushAcc)
				disable('main','sub','range')
			end
		elseif newValue == 'Maxentius' then
			enable('main','sub','range')
			if S{'NIN', 'DNC'}:contains(player.sub_job) then
				equip(sets.MaxentiusDW)
				disable('main','sub')
			else
				equip(sets.Maxentius)
				disable('main','sub','range')
			end
		else
            enable('main','sub')
        end
    end
end
]]--


function job_handle_equipping_gear(playerStatus, eventArgs)
    update_combat_form()
end

function update_combat_form()
	if S{'NIN', 'DNC'}:contains(player.sub_job) and whm_sub_weapons:contains(player.equipment.sub) then
        state.CombatForm:set("DW")
	else
        state.CombatForm:reset()
    end
end

function customize_melee_set(meleeSet)

	if buffactive['Aftermath: Lv.3'] and player.equipment.main == "Yagrush" then
		if S{'NIN', 'DNC'}:contains(player.sub_job) then
			meleeSet = set_combine(meleeSet, sets.engaged.AM_DW)
		else
			meleeSet = set_combine(meleeSet, sets.engaged.AM)
		end
    end

    return meleeSet
end
-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------
function job_self_command(cmdParams, eventArgs)
	if cmdParams[1]:lower() == 'barelement' then
        send_command('@input /ma '..state.BarElement.value..' <me>')
    elseif cmdParams[1]:lower() == 'barstatus' then
        send_command('@input /ma '..state.BarStatus.value..' <me>')
    elseif cmdParams[1]:lower() == 'boostspell' then
        send_command('@input /ma '..state.BoostSpell.value..' <me>')
    end
	if cmdParams[1] == 'ambu' then
		send_command('input /ja "Afflatus Solace" <me>; wait 1; input /ja "Light Arts" <me>; wait 1; input /ma "Haste" <me>; wait 5; input /ma "Protectra V" <me>;' ..
		 'wait 4; input /ma "Shellra V" <me>; wait 4; input //gs c BarElement; wait 4; input //gs c BarStatus; wait 5; input //gs c BoostSpell" <me>;' ..
         'wait 5; input /ma "Auspice" <me>; wait 4; input /ma "Reraise IV" <me>; wait 5; input /ja "Accession" <me>; wait 1; input /ma "Regen IV" <me>;' ..
         'wait 4; input /ma "Aurorastorm" <me>; wait 1; input //hb on;')     
        add_to_chat(158, 'casting buffs')	
	end

	if cmdParams[1] == 'warp' then
		send_command('input /equip ring1 "Warp ring"; wait 12; input /item "Warp ring" <me>')
        add_to_chat(158,'warp ring')
	end
	if cmdParams[1] == 'dem' then
		send_command('input /equip ring2 "Dimensional ring (Dem)"; wait 12; input /item "Dimensional ring (Dem)" <me>')
        add_to_chat(158,'dem ring')
	end

end

-- Custom spell mapping.
function job_get_spell_map(spell, default_spell_map)
    if spell.action_type == 'Magic' then
        if (default_spell_map == 'Cure' or default_spell_map == 'Curaga') and player.status == 'Engaged' then
            return "CureMelee"
		elseif default_spell_map == 'Cure' then
            if buffactive['Afflatus Solace'] then
                if (world.weather_element == 'Light' or world.day_element == 'Light') then
                    return "CureSolaceWeather"
                else
                    return "CureSolace"
                end
            else
                if (world.weather_element == 'Light' or world.day_element == 'Light') then
                    return "CureWeather"
                else
                    return "CureNormal"
                end
            end
        elseif default_spell_map == 'Curaga' then
            if (world.weather_element == 'Light' or world.day_element == 'Light') then
                return "CuragaWeather"
            else
                return "CuragaNormal"
            end
        elseif spell.skill == "Enfeebling Magic" then
            if spell.type == "WhiteMagic" then
                return "MndEnfeebles"
            else
                return "IntEnfeebles"
            end
        end
    end
end


function customize_idle_set(idleSet)
--    if state.Buff['Sublimation: Activated'] then
--        idleSet = set_combine(idleSet, sets.buff.Sublimation)
--    end
    if player.mpp < 51 then
        idleSet = set_combine(idleSet, sets.more_refresh)
    end
    return idleSet
end

-- Called by the 'update' self-command.
function job_update(cmdParams, eventArgs)
    if cmdParams[1] == 'user' and not areas.Cities:contains(world.area) then
        local needsArts = 
            player.sub_job:lower() == 'sch' and
            not buffactive['Light Arts'] and
            not buffactive['Addendum: White'] and
            not buffactive['Dark Arts'] and
            not buffactive['Addendum: Black']
            
        if not buffactive['Afflatus Solace'] and not buffactive['Afflatus Misery'] then
            if needsArts then
                send_command('@input /ja "Afflatus Solace" <me>;wait 1.2;input /ja "Light Arts" <me>')
            else
                send_command('@input /ja "Afflatus Solace" <me>')
            end
        end
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

    add_to_chat(060, '| Magic: ' ..string.char(31,001)..c_msg.. string.char(31,002)..  ' |'
        ..string.char(31,004).. ' Defense: ' ..string.char(31,001)..d_msg.. string.char(31,002)..  ' |'
        ..string.char(31,008).. ' Idle: ' ..string.char(31,001)..i_msg.. string.char(31,002)..  ' |'
        ..string.char(31,002)..msg)

    eventArgs.handled = true
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

-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    -- Default macro set/book
    set_macro_page(1, 1)
end

function set_lockstyle()
    send_command('wait 2; input /lockstyleset ' .. lockstyleset)
end
