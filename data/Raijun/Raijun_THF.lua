include('organizer-lib')

-------------------------------------------------------------------------------------------------------------------
-- Setup functions for this job.  Generally should not be modified.
-------------------------------------------------------------------------------------------------------------------
 
--[[
    Custom commands:
    gs c cycle treasuremode (set on ctrl-= by default): Cycles through the available treasure hunter modes.
   
    Treasure hunter modes:
        None - Will never equip TH gear
        Tag - Will equip TH gear sufficient for initial contact with a mob (either melee, ranged hit, or Aeolian Edge AOE)
        SATA - Will equip TH gear sufficient for initial contact with a mob, and when using SATA
        Fulltime - Will keep TH gear equipped fulltime
--]]
 
-- Initialization function for this job file.
function get_sets()
    mote_include_version = 2
	include('organizer-lib')
	
    -- Load and initialize the include file.
    include('Mote-Include.lua')
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
end
 
-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------
 
-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
    state.OffenseMode:options('DANormal', 'DAMidAcc', 'DAAcc', 'DASuperAcc','Solo')
    state.HybridMode:options()
    state.RangedMode:options('Normal', 'Acc')
    state.WeaponskillMode:options('Normal', 'Acc', 'Mod')
    state.PhysicalDefenseMode:options('PDT', 'MDT')
    state.IdleMode:options('Normal', 'Regen', 'DT')
 
    -- Additional local binds
    send_command('bind ^` input /ja "Flee" <me>')
    send_command('bind ^= gs c cycle treasuremode')
    send_command('bind !- gs c cycle targetmode')
end
 
-- Called when this job file is unloaded (eg: job change)
function user_unload()
    send_command('unbind ^`')
    send_command('unbind !-')
end
 
-- Define sets and vars used by this job file.
function init_gear_sets()
send_command('input /macro book 1;wait .1;input /macro set 3')
send_command('wait 2; input /lockstyleset 3')
    --------------------------------------
    -- Special sets (required by rules)
    --------------------------------------
    sets.TreasureHunter = {
    head={ name="Herculean Helm", augments={'Pet: Attack+21 Pet: Rng.Atk.+21','STR+10','"Treasure Hunter"+2','Mag. Acc.+14 "Mag.Atk.Bns."+14',}},
    hands="Plunderer's Armlets +1",
	waist="Chaac Belt"
	}
    sets.ExtraRegen = {neck="Bathy Choker +1",ring1="Sheltered Ring"}
    sets.Kiting = {feet="Jute Boots +1"}
 
    sets.buff['Sneak Attack'] = {}
 
    sets.buff['Trick Attack'] = {}
 
    -- Actions we want to use to tag TH.
    sets.precast.Step = sets.TreasureHunter
    sets.precast.Flourish1 = sets.TreasureHunter
    sets.precast.JA.Provoke = sets.TreasureHunter
 
 
    --------------------------------------
    -- Precast sets
    --------------------------------------
 
    -- Precast sets to enhance JAs
    sets.precast.JA['Collaborator'] = {head="Skulker's Bonnet +1"}
    sets.precast.JA['Accomplice'] = {head="Skulker's Bonnet +1"}
    sets.precast.JA['Flee'] = {feet="Pillager's Poulaines +1"}
    sets.precast.JA['Hide'] = {}
    sets.precast.JA['Conspirator'] = {}
    sets.precast.JA['Steal'] = {feet="Pillager's Poulaines +1"}
    sets.precast.JA['Despoil'] = {feet="Skulker's Poulaines"}
    sets.precast.JA['Perfect Dodge'] = {hands="Plunderer's Armlets +1"}
    sets.precast.JA['Feint'] = {}
    sets.precast.JA['Mug'] = {}
    sets.precast.JA['Lunge'] = {}
    sets.precast.JA['Swipe'] = {sets.precast.JA['Lunge']}
   
    sets.precast.JA['Sneak Attack'] = sets.buff['Sneak Attack']
    sets.precast.JA['Trick Attack'] = sets.buff['Trick Attack']
   
    sets.precast.Item = {HolyWater}
   
    sets.precast.Item['Holy Water'] = {}
 
 
    -- Waltz set (chr and vit)
    sets.precast.Waltz = {}
 
    -- Don't need any special gear for Healing Waltz.
    sets.precast.Waltz['Healing Waltz'] = {}
 
 
    -- Fast cast sets for spells
    sets.precast.FC = {}
 
    sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, {})
   
    sets.precast.FC['Enhancing Magic'] = set_combine(sets.precast.FC)
 
 
    -- Ranged snapshot gear
    sets.precast.RA = {}
 
 
    -- Weaponskill sets
 
    -- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS = {}
    sets.precast.WS.Acc = set_combine(sets.precast.WS, {})
 
    -- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
    sets.precast.WS['Exenterator'] = {
		ammo="Seething Bomblet +1",
        head="Adhemar Bonnet +1",
		neck="Fotia Gorget",
		ear1="Brutal Earring",
		ear2="Cessance Earring",
        body="Meghanada Cuirie +2",
		hands={ name="Adhemar Wrist. +1", augments={'STR+12','DEX+12','Attack+20',}},
		left_ring="Epona's Ring",
    right_ring="Ilabrat Ring",
        back={ name="Toutatis's Cape", augments={'DEX+20','Accuracy+20 Attack+20','Weapon skill damage +10%',}},
		waist="Fotia Belt",
		legs="Meg. Chausses +2",
		feet={ name="Herculean Boots", augments={'Accuracy+27','"Triple Atk."+3','DEX+4','Attack+6',}},
		}
    sets.precast.WS['Exenterator'].Acc = set_combine(sets.precast.WS['Exenterator'], {})
 
 ---------------------------Highlight how to accomplish that --------------------------------
 
    sets.precast.WS['Dancing Edge'] = 	{		
	ammo="Jukukik Feather",
    head="Adhemar Bonnet +1",
    body="Meghanada Cuirie +2",
    hands={ name="Adhemar Wrist. +1", augments={'STR+12','DEX+12','Attack+20',}},
    legs="Lustratio Subligar +1",
    feet={ name="Herculean Boots", augments={'Accuracy+27','"Triple Atk."+3','DEX+4','Attack+6',}},
    neck="Fotia Gorget",
    waist="Fotia Belt",
    left_ear="Ishvara Earring",
    right_ear={ name="Moonshade Earring", augments={'Attack+4','TP Bonus +250',}},
    left_ring="Epona's Ring",
    right_ring="Ilabrat Ring",
    back={ name="Toutatis's Cape", augments={'DEX+20','Accuracy+20 Attack+20','Weapon skill damage +10%',}},
	}
	sets.precast.WS['Dancing Edge'].Acc = set_combine(sets.precast.WS['Dancing Edge'], {})
	
	
	--sets.precast.WS['Dancing Edge'] = sets.precast.WS
	--sets.precast.WS['Dancing Edge'].Acc = sets.precast.WS.Acc
	
	--This is also what default WS set does.. I just made a set for every WS cause im anal--
 -----------------------------------------------------------------------------------------------
    sets.precast.WS['Evisceration'] = {
		ammo="Jukukik Feather",
		head="Adhemar Bonnet +1",
		body="Meghanada Cuirie +2",
		hands={ name="Adhemar Wrist. +1", augments={'STR+12','DEX+12','Attack+20',}},
		legs={ name="Herculean Trousers", augments={'Accuracy+14','Crit. hit damage +2%','DEX+12','Attack+15',}},
		feet={ name="Herculean Boots", augments={'Accuracy+27','"Triple Atk."+3','DEX+4','Attack+6',}},
		neck="Fotia Gorget",
		waist="Fotia Belt",
		left_ear="Brutal Earring",
		right_ear={ name="Moonshade Earring", augments={'Attack+4','TP Bonus +250',}},
		left_ring="Epona's Ring",
		right_ring="Ilabrat Ring",
		back={ name="Toutatis's Cape", augments={'DEX+20','Accuracy+20 Attack+20','Weapon skill damage +10%',}},
    }
    sets.precast.WS['Evisceration'].Acc = set_combine(sets.precast.WS['Evisceration'], {})
   
    sets.precast.WS['Mercy Stroke'] = {}
    sets.precast.WS['Mercy Stroke'].Mod = set_combine(sets.precast.WS['Mercy Stroke'], {})
    sets.precast.WS['Mercy Stroke'].SA = set_combine(sets.precast.WS['Mercy Stroke'].Mod, {})
    sets.precast.WS['Mercy Stroke'].TA = set_combine(sets.precast.WS['Mercy Stroke'].Mod, {})
    sets.precast.WS['Mercy Stroke'].SATA = set_combine(sets.precast.WS['Mercy Stroke'].Mod, {})
 
    sets.precast.WS['Rudra\'s Storm'] = {
		ammo="Falcon Eye",
		head={ name="Herculean Helm", augments={'Attack+20','Weapon skill damage +4%','STR+9','Accuracy+1',}},
		body="Meg. Cuirie +2",
		hands="Meg. Gloves +2",
		legs={ name="Lustr. Subligar +1", augments={'Accuracy+20','DEX+8','Crit. hit rate+3%',}},
		feet={ name="Herculean Boots", augments={'Accuracy+29','Weapon skill damage +4%','STR+12','Attack+1',}},
		neck="Caro Necklace",
		waist="Grunfeld Rope",
		left_ear="Ishvara Earring",
		right_ear={ name="Moonshade Earring", augments={'"Mag.Atk.Bns."+4','TP Bonus +250',}},
		left_ring="Epaminondas's Ring",
		right_ring="Karieyh Ring",
		back={ name="Toutatis's Cape", augments={'DEX+20','Accuracy+20 Attack+20','Weapon skill damage +10%',}},
    }	    
	sets.precast.WS['Rudra\'s Storm'].Mod =  {
		ammo="Falcon Eye",
		head={ name="Adhemar Bonnet +1", augments={'STR+12','DEX+12','Attack+20',}},
		body="Meg. Cuirie +2",
		hands="Meg. Gloves +2",
		legs={ name="Lustr. Subligar +1", augments={'Accuracy+20','DEX+8','Crit. hit rate+3%',}},
		feet={ name="Herculean Boots", augments={'Accuracy+29','Weapon skill damage +4%','STR+12','Attack+1',}},
		neck="Caro Necklace",
		waist="Grunfeld Rope",
		left_ear="Ishvara Earring",
		right_ear={ name="Moonshade Earring", augments={'"Mag.Atk.Bns."+4','TP Bonus +250',}},
		left_ring="Epaminondas's Ring",
		right_ring="Karieyh Ring",
		back={ name="Toutatis's Cape", augments={'DEX+20','Accuracy+20 Attack+20','Weapon skill damage +10%',}},
    }
    sets.precast.WS['Rudra\'s Storm'].SA = set_combine(sets.precast.WS['Rudra\'s Storm'].Mod, {})
    sets.precast.WS['Rudra\'s Storm'].TA = set_combine(sets.precast.WS['Rudra\'s Storm'].Mod, {})
    sets.precast.WS['Rudra\'s Storm'].SATA = set_combine(sets.precast.WS['Rudra\'s Storm'].Mod, {})
 
    sets.precast.WS['Shark Bite'] = {
		ammo="Jukukik Feather",
    head={ name="Herculean Helm", augments={'Attack+20','Weapon skill damage +4%','STR+9','Accuracy+1',}},
    body="Meghanada Cuirie +2",
    hands="Meg. Gloves +2",
    legs="Lustratio Subligar +1",
    feet={ name="Herculean Boots", augments={'Accuracy+29','Weapon skill damage +4%','STR+12','Attack+1',}},
    neck="Fotia Gorget",
    waist="Fotia Belt",
    left_ear="Ishvara Earring",
    right_ear={ name="Moonshade Earring", augments={'Attack+4','TP Bonus +250',}},
    left_ring="Ramuh Ring",
    right_ring="Ilabrat Ring",
    back={ name="Toutatis's Cape", augments={'DEX+20','Accuracy+20 Attack+20','Weapon skill damage +10%',}},
	}
	
    sets.precast.WS['Shark Bite'].Mod = set_combine(sets.precast.WS['Shark Bite'], {
		ammo="Yetshila",
        head="Adhemar Bonnet +1",
		body="Meghanada cuirie +2"})
    sets.precast.WS['Shark Bite'].SA = set_combine(sets.precast.WS['Shark Bite'].Mod, {})
    sets.precast.WS['Shark Bite'].TA = set_combine(sets.precast.WS['Shark Bite'].Mod, {})
    sets.precast.WS['Shark Bite'].SATA = set_combine(sets.precast.WS['Shark Bite'].Mod, {})
 
    sets.precast.WS['Mandalic Stab'] = {
		ammo="Jukukik Feather",
    head={ name="Herculean Helm", augments={'Attack+20','Weapon skill damage +4%','STR+9','Accuracy+1',}},
    body="Meghanada Cuirie +2",
    hands="Meg. Gloves +2",
    legs="Lustratio Subligar +1",
    feet={ name="Herculean Boots", augments={'Accuracy+29','Weapon skill damage +4%','STR+12','Attack+1',}},
    neck="Fotia Gorget",
    waist="Fotia Belt",
    left_ear="Ishvara Earring",
    right_ear={ name="Moonshade Earring", augments={'Attack+4','TP Bonus +250',}},
    left_ring="Ramuh Ring",
    right_ring="Ilabrat Ring",
    back={ name="Toutatis's Cape", augments={'DEX+20','Accuracy+20 Attack+20','Weapon skill damage +10%',}},
	}
	
    sets.precast.WS['Mandalic Stab'].Mod = {		
		ammo="Jukukik Feather",
    head={ name="Herculean Helm", augments={'Attack+20','Weapon skill damage +4%','STR+9','Accuracy+1',}},
    body="Meghanada Cuirie +2",
    hands="Meg. Gloves +2",
    legs="Lustratio Subligar +1",
    feet={ name="Herculean Boots", augments={'Accuracy+29','Weapon skill damage +4%','STR+12','Attack+1',}},
    neck="Fotia Gorget",
    waist="Fotia Belt",
    left_ear="Ishvara Earring",
    right_ear={ name="Moonshade Earring", augments={'Attack+4','TP Bonus +250',}},
    left_ring="Ramuh Ring",
    right_ring="Ilabrat Ring",
    back={ name="Toutatis's Cape", augments={'DEX+20','Accuracy+20 Attack+20','Weapon skill damage +10%',}},
	}
	
    sets.precast.WS['Mandalic Stab'].SA = set_combine(sets.precast.WS['Mandalic Stab'].Mod, {})
    sets.precast.WS['Mandalic Stab'].TA = set_combine(sets.precast.WS['Mandalic Stab'].Mod, {})
    sets.precast.WS['Mandalic Stab'].SATA = set_combine(sets.precast.WS['Mandalic Stab'].Mod, {})
 
    sets.precast.WS['Aeolian Edge'] = {
		ammo="Seething Bomblet +1",
        head="",
		neck="Fotia Gorget",
		ear1="Moonshade Earring",
		ear2="Friomisi Earring",
        body="Samnuha Coat",
		hands="Leyline Gloves",
		ring1="Regal Ring",
		ring2="Ilabrat Ring",
        back="",
		waist="Fotia Belt",
		legs="",
		feet=""}
       
    sets.precast.WS['Last Stand'] = {}
       
    sets.precast.WS['Vorpal Blade'] = set_combine(sets.precast.WS['Evisceration'], {})
 
 
 
    --------------------------------------
    -- Midcast sets
    --------------------------------------
 
    sets.midcast.FastRecast = sets.precast.FC
 
    -- Specific spells
    sets.midcast.Utsusemi = sets.midcast.FastRecast
       
    sets.midcast['Enhancing Magic'] = {neck="Incanter's Torque",ear1="Andoaa Earring",ring1="Stikini Ring",waist="Olympus Sash"}
   
 
    -- Ranged gear
    sets.midcast.RA = {}
 
    sets.midcast.RA.Acc = {}
 
 
    --------------------------------------
    -- Idle/resting/defense sets
    --------------------------------------
 
    -- Resting sets
    sets.resting = {neck="Bathy Choker +1", ring1="Sheltered Ring"}
 
 
    -- Idle sets (default idle set not needed since the other three are defined, but leaving for testing purposes)
 
    sets.idle = {
    ammo="Staunch Tathlum +1",
    head="Meghanada Visor +2",
    body="Malignance Tabard",
    hands="Malignance Gloves",
    legs="Malignance Tights",
    feet="Jute Boots +1",
    neck="Loricate Torque +1",
    waist="Flume Belt +1",
    left_ear="Genmei Earring",
    right_ear="Odnowa Earring +1",
    left_ring="Moonbeam Ring",
    right_ring="Defending Ring",
    back="Moonbeam Cape",
}
       
    sets.idle.Regen = {}
       
    sets.idle.DT =  { }
       
 
    sets.idle.Town = sets.idle
 
 
    -- Defense sets
 
    sets.defense.PDT = {
		ammo="Staunch tathlum",
        head="Meghanada Visor +2",
		neck="Loricate Torque +1",
		ear1="Suppanomimi",
		ear2="Cessance Earring",
        body="Meghanada Cuirie +2",
		hands="Meg. Gloves +2",
		ring1="Moonbeam Ring",
		ring2="Defending Ring",
        back="Moonbeam Cape",
		waist="Flume Belt +1",
		legs="Meg. Chausses +2",
		feet=""}
 
    sets.defense.MDT = {
		ammo="Staunch Tathlum",
        head="",
		neck="Warder's Charm",
		ear1="Odnowa Earring +1",
		ear2="Etiolation Earring",
        body="Adhemar Jacket",
		hands="Meg. Gloves +2",
		ring1="Shadow Ring",
		ring2="Defending Ring",
        back="Moonbeam Cape",
		waist="Carrier's Sash",
		legs="Mummu Kecks +1",
		feet=""}
 
 
    --------------------------------------
    -- Melee sets
    --------------------------------------
 
    -- Normal melee group
       
    sets.engaged.DANormal = {--1060~--
    main={ name="Taming Sari", augments={'STR+10','DEX+10','DMG:+15','"Treasure Hunter"+1',}},
    sub={ name="Taming Sari", augments={'STR+10','DEX+10','DMG:+15','"Treasure Hunter"+1',}},
    ammo="Yamarang",
    head="Malignance Chapeau",
    body="Malignance Tabard",
    hands="Malignance Gloves",
    legs="Malignance Tights",
    feet="Malignance Boots",
    neck="Iskur Gorget",
    waist="Windbuffet Belt +1",
    left_ear="Sherida Earring",
    right_ear="Suppanomimi",
    left_ring="Gere Ring",
    right_ring="Defending Ring",
    back={ name="Toutatis's Cape", augments={'DEX+20','Accuracy+20 Attack+20','"Store TP"+10',}},
		}
       
    sets.engaged.DAMidAcc = {
		ammo="Mantoptera Eye",
		head="Adhemar Bonnet +1",
		body={ name="Adhemar Jacket", augments={'DEX+10','AGI+10','Accuracy+15',}}, 
		hands={ name="Adhemar Wrist. +1", augments={'STR+12','DEX+12','Attack+20',}},
        legs="Samnuha Tights",
        feet={ name="Herculean Boots", augments={'Accuracy+27','"Triple Atk."+3','DEX+4','Attack+6',}},
		neck="Subtlety Spec.",
		waist="Kentarch Belt +1",
		left_ear="Brutal Earring",
		right_ear="Sherida Earring",
		left_ring="Epona's Ring",
		right_ring="Petrov Ring",
		back={ name="Toutatis's Cape", augments={'DEX+20','Accuracy+20 Attack+20','"Store TP"+10',}},
		}
       
    sets.engaged.DAAcc = {
	    ammo="Mantoptera Eye",
        head={ name="Dampening Tam", augments={'DEX+10','Accuracy+15','Mag. Acc.+15','Quadruple Attack +3',}},
        body={ name="Adhemar Jacket", augments={'DEX+10','AGI+10','Accuracy+15',}},
        hands={ name="Adhemar Wrist. +1", augments={'STR+12','DEX+12','Attack+20',}},
        legs="Samnuha Tights",
        feet={ name="Herculean Boots", augments={'Accuracy+27','"Triple Atk."+3','DEX+4','Attack+6',}},
        neck="Subtlety Spec.",
        waist="Kentarch Belt +1",
        left_ear="Brutal Earring",
		right_ear="Sherida Earring",
        left_ring="Ramuh Ring",
        right_ring="Ramuh Ring",
        back={ name="Toutatis's Cape", augments={'DEX+20','Accuracy+20 Attack+20','"Store TP"+10',}},
		}
       
    --sets.engaged.DASuperAcc = {}
       
   -- sets.engaged.Solo = {}
       
 

 
 
end
 
 
-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------
 
-- Run after the general precast() is done.
function job_post_precast(spell, action, spellMap, eventArgs)
    if spell.english == 'Aeolian Edge' and state.TreasureMode.value ~= 'None' then
        equip(sets.TreasureHunter)
    elseif spell.english=='Sneak Attack' or spell.english=='Trick Attack' or spell.type == 'WeaponSkill' then
        if state.TreasureMode.value == 'SATA' or state.TreasureMode.value == 'Fulltime' then
            equip(sets.TreasureHunter)
        end
    end
end
 
-- Run after the general midcast() set is constructed.
function job_post_midcast(spell, action, spellMap, eventArgs)
    if state.TreasureMode.value ~= 'None' and spell.action_type == 'Ranged Attack' then
        equip(sets.TreasureHunter)
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
function job_buff_change(buff, gain)
    if state.Buff[buff] ~= nil then
        if not midaction() then
            handle_equipping_gear(player.status)
        end
    end
end
 
 
-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------
 
function get_custom_wsmode(spell, spellMap, defaut_wsmode)
    local wsmode
 
    if state.Buff['Sneak Attack'] then
        wsmode = 'SA'
    end
    if state.Buff['Trick Attack'] then
        wsmode = (wsmode or '') .. 'TA'
    end
 
    return wsmode
end
 
 
-- Called any time we attempt to handle automatic gear equips (ie: engaged or idle gear).
function job_handle_equipping_gear(playerStatus, eventArgs)
    -- Check that ranged slot is locked, if necessary
    check_range_lock()
 
    -- Check for SATA when equipping gear.  If either is active, equip
    -- that gear specifically, and block equipping default gear.
    check_buff('Sneak Attack', eventArgs)
    check_buff('Trick Attack', eventArgs)
end
 
 
function customize_idle_set(idleSet)
    if player.hpp < 80 then
        idleSet = set_combine(idleSet, sets.ExtraRegen)
    end
 
    return idleSet
end
 
 
function customize_melee_set(meleeSet)
    if state.TreasureMode.value == 'Fulltime' then
        meleeSet = set_combine(meleeSet, sets.TreasureHunter)
    end
 
    return meleeSet
end
 
 
-- Called by the 'update' self-command.
function job_update(cmdParams, eventArgs)
    th_update(cmdParams, eventArgs)
end
 
-- Function to display the current relevant user state when doing an update.
-- Return true if display was handled, and you don't want the default info shown.
function display_current_job_state(eventArgs)
    local msg = 'Melee'
   
    if state.CombatForm.has_value then
        msg = msg .. ' (' .. state.CombatForm.value .. ')'
    end
   
    msg = msg .. ': '
   
    msg = msg .. state.OffenseMode.value
    if state.HybridMode.value ~= 'Normal' then
        msg = msg .. '/' .. state.HybridMode.value
    end
    msg = msg .. ', WS: ' .. state.WeaponskillMode.value
   
    if state.DefenseMode.value ~= 'None' then
        msg = msg .. ', ' .. 'Defense: ' .. state.DefenseMode.value .. ' (' .. state[state.DefenseMode.value .. 'DefenseMode'].value .. ')'
    end
   
    if state.Kiting.value == true then
        msg = msg .. ', Kiting'
    end
 
    if state.PCTargetMode.value ~= 'default' then
        msg = msg .. ', Target PC: '..state.PCTargetMode.value
    end
 
    if state.SelectNPCTargets.value == true then
        msg = msg .. ', Target NPCs'
    end
   
    msg = msg .. ', TH: ' .. state.TreasureMode.value
 
    add_to_chat(122, msg)
 
    eventArgs.handled = true
end
 
-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------
 
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
 
 
-- Function to lock the ranged slot if we have a ranged weapon equipped.
function check_range_lock()
    if player.equipment.range ~= 'empty' then
        disable('range', 'ammo')
    else
        enable('range', 'ammo')
    end
end
 
 
-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    -- Default macro set/book
    if player.sub_job == 'DNC' then
        set_macro_page(3, 1)
    elseif player.sub_job == 'WAR' then
        set_macro_page(1, 1)
    elseif player.sub_job == 'NIN' then
        set_macro_page(2, 1)
    else
        set_macro_page(1, 1)
    end
end