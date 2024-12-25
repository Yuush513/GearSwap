-- Original: Motenten / Modified: Arislan
-- Haste/DW Detection Requires Gearinfo Addon

-------------------------------------------------------------------------------------------------------------------
--  Keybinds
-------------------------------------------------------------------------------------------------------------------

--  Modes:      [ F9 ]              Cycle Offense Modes
--              [ CTRL+F9 ]         Cycle Hybrid Modes
--              [ ALT+F9 ]          Cycle Ranged Modes
--              [ WIN+F9 ]          Cycle Weapon Skill Modes
--              [ F10 ]             Emergency -PDT Mode
--              [ ALT+F10 ]         Toggle Kiting Mode
--              [ F11 ]             Emergency -MDT Mode
--              [ F12 ]             Update Current Gear / Report Current Status
--              [ CTRL+F12 ]        Cycle Idle Modes
--              [ ALT+F12 ]         Cancel Emergency -PDT/-MDT Mode
--              [ WIN+C ]           Toggle Capacity Points Mode
--
--  Weapons:    [ CTRL+INS/DEL ]    Cycles between available Weapon Sets
--
--  RA:         [ Numpad0 ]         Ranged Attack
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
	require('rnghelper')
end


-- Setup vars that are user-independent.  state.Buff vars initialized here will automatically be tracked.
function job_setup()
    state.Buff.Barrage = buffactive.Barrage or false
    state.Buff.Camouflage = buffactive.Camouflage or false
    state.Buff['Unlimited Shot'] = buffactive['Unlimited Shot'] or false
    state.Buff['Velocity Shot'] = buffactive['Velocity Shot'] or false
    state.Buff['Double Shot'] = buffactive['Double Shot'] or false

    -- Whether a warning has been given for low ammo
    state.warned = M(false)

    elemental_ws = S{'Aeolian Edge', 'Trueflight', 'Wildfire'}
    no_swap_gear = S{"Warp Ring", "Dim. Ring (Dem)", "Dim. Ring (Holla)", "Dim. Ring (Mea)",
              "Trizek Ring", "Echad Ring", "Facility Ring", "Capacity Ring",
              "Era. Bul. Pouch", "Dev. Bul. Pouch", "Chr. Bul. Pouch", "Quelling B. Quiver",
              "Yoichi's Quiver", "Artemis's Quiver", "Chrono Quiver"}

    lockstyleset = 20
end

-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
    state.OffenseMode:options('Normal', 'LowAcc', 'Acc')
    state.HybridMode:options('Normal', 'DT')
    state.RangedMode:options('Normal', 'Acc','Critical')
    state.WeaponskillMode:options('Normal', 'Acc', 'Enmity')
    state.IdleMode:options('Normal', 'DT')

    state.WeaponSet = M{['description']='Weapon Set', 'Gastraphetes','Annihilator', 'Armageddon', 'Fomalhaut', 'Sparrowhawk'}
    -- state.CP = M(false, "Capacity Points Mode")
	state.WeaponLock = M(false, 'Weapon Lock')
	
	--add Sparrowhawk to shooting

    DefaultAmmo = {['Yoichinoyumi'] = "Chrono Arrow",
                   ['Gandiva'] = "Chrono Arrow",
                   ['Fail-Not'] = "Chrono Arrow",
                   ['Annihilator'] = "Chrono Bullet",
                   ['Armageddon'] = "Chrono Bullet",
				    ['Gastraphetes'] = "Bronze Bolt",
                  -- ['Gastraphetes'] = "Quelling Bolt",
                   ['Fomalhaut'] = "Chrono Bullet",
				   ['Sparrowhawk'] = "Hauksbok Arrow",
                   }

    AccAmmo = {    ['Yoichinoyumi'] = "Yoichi's Arrow",
                   ['Gandiva'] = "Yoichi's Arrow",
                   ['Fail-Not'] = "Yoichi's Arrow",
                   ['Annihilator'] = "Eradicating Bullet",
                   ['Armageddon'] = "Eradicating Bullet",
				   ['Gastraphetes'] = "Bronze Bolt",
                   --['Gastraphetes'] = "Quelling Bolt",
                   ['Fomalhaut'] = "Devastating Bullet",
				   ['Sparrowhawk'] = "Hauksbok Arrow",
                   }

    WSAmmo = {     ['Yoichinoyumi'] = "Chrono Arrow",
                   ['Gandiva'] = "Chrono Arrow",
                   ['Fail-Not'] = "Chrono Arrow",
                   ['Annihilator'] = "Chrono Bullet",
                   ['Armageddon'] = "Chrono Bullet",
				   ['Gastraphetes'] = "Bronze Bolt",
                   --['Gastraphetes'] = "Quelling Bolt",
                   ['Fomalhaut'] = "Chrono Bullet",
				   ['Sparrowhawk'] = "Hauksbok Arrow",
                   }

    MagicAmmo = {  ['Yoichinoyumi'] = "Chrono Arrow",
                   ['Gandiva'] = "Chrono Arrow",
                   ['Fail-Not'] = "Chrono Arrow",
                   ['Annihilator'] = "Devastating Bullet",
                   ['Armageddon'] = "Devastating Bullet",
				   ['Gastraphetes'] = "Bronze Bolt",
                   --['Gastraphetes'] = "Quelling Bolt",
                   ['Fomalhaut'] = "Devastating Bullet",
				   ['Sparrowhawk'] = "Hauksbok Arrow",
                   }

    -- Additional local binds

    -- send_command('bind @c gs c toggle CP')
    send_command('bind ^insert gs c cycle WeaponSet')
    send_command('bind ^delete gs c cycleback WeaponSet')
	send_command('bind @w gs c toggle WeaponLock')


    select_default_macro_book()
    set_lockstyle()

    --state.Auto_Kite = M(false, 'Auto_Kite')
    --Haste = 0
    --DW_needed = 0
    DW = false
    --moving = false
    update_combat_form()
    --determine_haste_group()
end


-- Called when this job file is unloaded (eg: job change)
function user_unload()
    send_command('unbind @c')
    send_command('unbind ^insert')
    send_command('unbind ^delete')
end


-- Set up all gear sets.
function init_gear_sets()

organizer_items = {
	Eradicating = "Eradicating Bullet",	
	Devastating = "Devastating Bullet",
	Chrono = "Chrono Bullet",
	--Quelling = "Quelling Bolt",
	--Yoichi = "Yoichi's Arrow",
	--Chrono = "Chrono Arrow",
	EraPouch = "Era. Bul. Pouch", 
	DevPouch = "Dev. Bul. Pouch", 
	ChrPouch = "Chr. Bul. Pouch", 
	--waist = "Quelling B. Quiver",
    --waist = "Yoichi's Quiver", 
	--waist = "Artemis's Quiver", 
	--waist = "Chrono Quiver"
	}
	

    ------------------------------------------------------------------------------------------------
    ---------------------------------------- Precast Sets ------------------------------------------
    ------------------------------------------------------------------------------------------------

    -- Precast sets to enhance JAs
    sets.precast.JA['Eagle Eye Shot'] = {legs = "Arc. Braccae +3"}
    sets.precast.JA['Bounty Shot'] = {hands = "Amini Glove. +1"}
    sets.precast.JA['Camouflage'] = {body = "Orion Jerkin +3"}
    sets.precast.JA['Scavenge'] = {feet = "Orion Socks +1"}
    sets.precast.JA['Shadowbind'] = {hands = "Orion Bracers +3"}
    sets.precast.JA['Sharpshot'] = {legs = "Orion Braccae +3"}


    -- Fast cast sets for spells
--[[
    sets.precast.Waltz = {
        body = "Passion Jacket",
        ring1 = "Asklepian Ring",
        waist = "Gishdubar Sash",
        }

    sets.precast.Waltz['Healing Waltz'] = {}
]]--
    sets.precast.FC = {
        head = "Carmine Mask +1", --14
        neck = "Baetyl Pendant", --4
        ear1 = "Loquacious Earring", --2
        ear2 = "Etiolation earring", --1
        body = "Taeon Tabard", --9
        hands = "Leyline Gloves", --7
		legs = "Gyve Trousers", --4
        feet = "Carmine Greaves +1", --8
        }

    sets.precast.Utsusemi = set_combine(sets.precast.FC, {neck = "Magoraga Beads"})


    -- (10% Snapshot, 5% Rapid from Merits)
    sets.precast.RA = {
        head = TaeonHead.SNAP, --10/0
		neck = "Scout's Gorget +2", --4/0
        body = "Amini Caban +1", 
        hands = "Carmine Fin. Ga. +1", --8/11
        back = Belenus.SNAP, --10/0
        waist = "Impulse belt", --3/0
		legs = "Orion Braccae +3", --15/0
        feet = "Meg. Jam. +2", --10/0
        } --66/11

    sets.precast.RA.Flurry1 = set_combine(sets.precast.RA, {
        head = "Orion Beret +3", --0/18
        legs = "Adhemar kecks +1", --10/13
        }) --51/42

    sets.precast.RA.Flurry2 = set_combine(sets.precast.RA.Flurry1, {
        feet = "Arcadian Socks +3", --0/10
        waist = "Yemaya Belt", --0/5
        }) --38/57


    sets.precast.RA.Gastra = {
        head="Orion Beret +3", --15/0
        }
    sets.precast.RA.Gastra.Flurry1 = set_combine(sets.precast.RA.Gastra, {
        feet="Arcadian Socks +3", --0/10
        })
    sets.precast.RA.Gastra.Flurry2 = set_combine(sets.precast.RA.Gastra.Flurry1, {
        legs="Pursuer's Pants", --0/19
        })



    ------------------------------------------------------------------------------------------------
    ------------------------------------- Weapon Skill Sets ----------------------------------------
    ------------------------------------------------------------------------------------------------

    sets.precast.WS = {
		head="Orion Beret +3",
		body="Ikenga's Vest",
		hands="Meg. Gloves +2",
		legs={ name="Arc. Braccae +3", augments={'Enhances "Eagle Eye Shot" effect',}},
		feet="Ikenga's Clogs",
		neck={ name="Scout's Gorget +2", augments={'Path: A',}},
		waist="Fotia Belt",
		left_ear={ name="Moonshade Earring", augments={'"Mag.Atk.Bns."+4','TP Bonus +250',}},
		right_ear="Ishvara Earring",
		left_ring="Regal Ring",
		right_ring="Epaminondas's Ring",
		back={ name="Belenus's Cape", augments={'AGI+20','Mag. Acc+20 /Mag. Dmg.+20','AGI+10','Weapon skill damage +10%',}},
        }

    sets.precast.WS.Acc = set_combine(sets.precast.WS, {})

    -------------------------------
    -------- Marksmanship ---------
    -------------------------------
	
    sets.precast.WS['Last Stand'] = {
		head="Orion Beret +3",
		body="Ikenga's Vest",
		hands="Meg. Gloves +2",
		legs="Arc. Braccae +3",
		feet="Ikenga's Clogs",
		neck="Scout's Gorget +2",
		waist="Fotia Belt",
		left_ear="Moonshade Earring",
		right_ear="Ishvara Earring",
		left_ring="Regal Ring",
		right_ring="Epaminondas's Ring",
		back=Belenus.AGI_WSD,
		}

    sets.precast.WS['Last Stand'].Acc = set_combine(sets.precast.WS['Last Stand'], {})

    sets.precast.WS["Coronach"] = set_combine(sets.precast.WS['Last Stand'], {left_ear="Sherida Earring",})
	
    sets.precast.WS['Coronach'].Acc = set_combine(sets.precast.WS['Coronach'], {})

    sets.precast.WS['Trueflight'] = {
		head=empty,
		body="Cohort Cloak +1",
		hands="Carmine Fin. Ga. +1",
		legs="Arc. Braccae +3",
		feet={ name="Herculean Boots", augments={'Mag. Acc.+19 "Mag.Atk.Bns."+19','Weapon skill damage +3%','MND+8','"Mag.Atk.Bns."+13',}},
		neck="Scout's Gorget +2",
		waist="Eschan Stone",
		left_ear="Friomisi Earring",
		right_ear="Moonshade Earring",
		left_ring="Weather. Ring",
		right_ring="Epaminondas's Ring",
		back=Belenus.MAB_WSD,
        }

    sets.precast.WS['Wildfire'] = set_combine(sets.precast.WS["Trueflight"], {left_ring="Dingir Ring", right_ear="Crematio Earring",})

    -------------------------------
    ----------- Archery -----------
    -------------------------------

    sets.precast.WS['Apex Arrow'] = sets.precast.WS
    sets.precast.WS['Apex Arrow'].Acc = set_combine(sets.precast.WS['Apex Arrow'], {})

    sets.precast.WS['Jishnu\'s Radiance'] = set_combine(sets.precast.WS, {})
    sets.precast.WS['Jishnu\'s Radiance'].Acc = set_combine(sets.precast.WS['Jishnu\'s Radiance'], {})

    -------------------------------
    ------ Sword/Axe/Dagger -------
    -------------------------------
		
    sets.precast.WS['Evisceration'] = {}

	sets.precast.WS['Savage Blade'] = {    
		ammo="Hauksbok Arrow",
		head="Orion Beret +3",
		body={ name="Herculean Vest", augments={'Accuracy+10','Weapon skill damage +4%','STR+8','Attack+14',}},
		hands="Meg. Gloves +2",
		legs="Arc. Braccae +3",
		feet={ name="Herculean Boots", augments={'Accuracy+29','Weapon skill damage +4%','STR+12','Attack+1',}},
		neck="Scout's Gorget +2",
		waist="Sailfi Belt +1",
		left_ear="Moonshade Earring",
		right_ear="Ishvara Earring",
		left_ring="Regal Ring",
		right_ring="Epaminondas's Ring",
		back=Belenus.STR,
	}
	
    ------------------------------------------------------------------------------------------------
    ---------------------------------------- Midcast Sets ------------------------------------------
    ------------------------------------------------------------------------------------------------

    -- Fast recast for spells

    sets.midcast.FastRecast = sets.precast.FC

    sets.midcast.SpellInterrupt = {}

    sets.midcast.Utsusemi = set_combine(sets.midcast.SpellInterrupt, sets.precast.Utsusemi)

    -- Ranged sets

    sets.midcast.RA = {
		head="Arcadian Beret +3",
		body="Ikenga's Vest",
		hands="Malignance Gloves",
		legs="Ikenga's Trousers",
		feet="Ikenga's Clogs",
		neck="Scout's Gorget +2",
		waist="Yemaya Belt",
		left_ear="Dedition Earring",
		right_ear="Telos Earring",
		left_ring="Dingir Ring",
		right_ring="Ilabrat Ring",
		back={ name="Belenus's Cape", augments={'AGI+20','Rng.Acc.+20 Rng.Atk.+20','AGI+10','"Store TP"+10',}},
        }

    sets.midcast.RA.Acc = set_combine(sets.midcast.RA, {})

    sets.midcast.RA.Critical = set_combine(sets.midcast.RA, {})

    sets.DoubleShot = {
	    head = "Arcadian Beret +3",
        body = "Arc. Jerkin +3",
        hands = "Oshosi Gloves", 
        legs = "Oshosi Trousers",
        feet = "Oshosi Leggings",
        }

    sets.DoubleShot.Critical = {
        head = "Meghanada Visor +2",
        waist = "K. Kachina Belt +1",
        }


    ------------------------------------------------------------------------------------------------
    ----------------------------------------- Idle Sets --------------------------------------------
    ------------------------------------------------------------------------------------------------

    sets.resting = {}

    -- Idle sets
    sets.idle = {
		head="Malignance Chapeau",
		body="Malignance Tabard",
		hands="Malignance Gloves",
		legs="Malignance Tights",
		feet={ name="Jute Boots +1", augments={'Path: A',}},
		neck={ name="Bathy Choker +1", augments={'Path: A',}},
		waist="Carrier's Sash",
		left_ear="Eabani Earring",
		right_ear={ name="Odnowa Earring +1", augments={'Path: A',}},
		left_ring="Defending Ring",
		right_ring="Sheltered Ring",
		back={ name="Belenus's Cape", augments={'AGI+20','Eva.+20 /Mag. Eva.+20','"Snapshot"+10','Phys. dmg. taken-10%',}},
        }

    sets.idle.DT = set_combine(sets.idle, {})

    ------------------------------------------------------------------------------------------------
    ---------------------------------------- Defense Sets ------------------------------------------
    ------------------------------------------------------------------------------------------------

    sets.defense.PDT = sets.idle.DT
    sets.defense.MDT = sets.idle.DT

    ------------------------------------------------------------------------------------------------
    ---------------------------------------- Engaged Sets ------------------------------------------
    ------------------------------------------------------------------------------------------------

    -- Engaged sets

    -- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
    -- sets if more refined versions aren't defined.
    -- If you create a set with both offense and defense modes, the offense mode should be first.
    -- EG: sets.engaged.Dagger.Accuracy.Evasion

    sets.engaged = {
		head = "Malignance Chapeau",
		neck = "Iskur Gorget",
		ear1 = "Sherida Earring",
		ear2 = "Telos Earring",
		body = "Malignance Tabard",
		hands = "Malignance Gloves",
		ring1 = "Ilabrat Ring",
		ring2 = "Chirich Ring +1",
		back = Belenus.DW,
		waist = "Goading Belt",
		legs = "Malignance Tights",
		feet = "Malignance Boots",
		}

    sets.engaged.Acc = set_combine(sets.engaged.LowAcc, {})

    sets.engaged.DW = {
		head = "Malignance Chapeau",
		neck = "Iskur Gorget",
		ear1 = "Sherida Earring",
		ear2 = "Telos Earring",
		body = "Malignance Tabard",
		hands = "Malignance Gloves",
		ring1 = "Ilabrat Ring",
		ring2 = "Chirich Ring +1",
		back = Belenus.DW,
		waist = "Goading Belt",
		legs = "Malignance Tights",
		feet = "Malignance Boots",
		} 

    sets.engaged.DW.Acc = set_combine(sets.engaged.DW, {})


    ------------------------------------------------------------------------------------------------
    ---------------------------------------- Hybrid Sets -------------------------------------------
    ------------------------------------------------------------------------------------------------

    sets.engaged.Hybrid = {
        neck = "Loricate Torque +1", --6/6
        ring2 = "Defending Ring", --10/10
        }

    sets.engaged.DT = set_combine(sets.engaged, sets.engaged.Hybrid)
    sets.engaged.Acc.DT = set_combine(sets.engaged.LowAcc, sets.engaged.Hybrid)

    sets.engaged.DW.DT = set_combine(sets.engaged.DW, sets.engaged.Hybrid)
    sets.engaged.DW.Acc.DT = set_combine(sets.engaged.DW.LowAcc, sets.engaged.Hybrid)

    ------------------------------------------------------------------------------------------------
    ---------------------------------------- Special Sets ------------------------------------------
    ------------------------------------------------------------------------------------------------

    sets.buff.Barrage = {hands = "Orion Bracers +3"}
    sets.buff['Velocity Shot'] = set_combine(sets.midcast.RA, {body = "Amini Caban +1", back = gear.RNG_TP_Cape})
    sets.buff.Camouflage = {body = "Orion Jerkin +3"}

    sets.buff.Doom = {
        neck = "Nicander's Necklace", --20
        ring1 = {name="Eshmun's Ring", bag="wardrobe3"}, --20
        ring2 = {name="Eshmun's Ring", bag="wardrobe4"}, --20
        waist = "Gishdubar Sash", --10
        }

    sets.FullTP = {ear2="novio Earring"}
    sets.Obi = {waist="Hachirin-no-Obi"}
    --sets.Reive = {neck="Ygnas's Resolve +1"}
    -- sets.CP = {back="Mecisto. Mantle"}

    sets.Annihilator = {main="Perun +1", sub="Ternion Dagger +1", ranged="Annihilator"}
    sets.Armageddon = {main="Malevolence", sub="Malevolence", ranged="Armageddon"}
    sets.Fomalhaut = {main="Perun +1", sub="Ternion Dagger +1", ranged="Fomalhaut"}
	sets.Gastraphetes = {main="Malevolence", sub="Malevolence", ranged="Gastraphetes"}
	sets.Sparrowhawk= {main="Naegling", sub="Kraken Club", ranged="Sparrowhawk +2"}

	--sets.Gastraphetes = {main="Malevolence", sub="Malevolence", ranged="Gastraphetes"}

    sets.DefaultShield = {sub="Nusku Shield"}

end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
-- Set eventArgs.useMidcastGear to true if we want midcast gear equipped on precast.
function job_precast(spell, action, spellMap, eventArgs)
    if spell.action_type == 'Ranged Attack' then
        state.CombatWeapon:set(player.equipment.range)
    end
    -- Check that proper ammo is available if we're using ranged attacks or similar.
    if spell.action_type == 'Ranged Attack' or (spell.type == 'WeaponSkill' and (spell.skill == 'Marksmanship' or spell.skill == 'Archery')) then
        check_ammo(spell, action, spellMap, eventArgs)
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
    if spell.action_type == 'Ranged Attack' then
        if spell.action_type == 'Ranged Attack' then
            if player.equipment.ranged == "Gastraphetes" then
                if flurry == 2 then
                    equip(sets.precast.RA.Gastra.Flurry2)
                elseif flurry == 1 then
                    equip(sets.precast.RA.Gastra.Flurry1)
                else
                    equip(sets.precast.RA.Gastra)
                end
            else
                if flurry == 2 then
                    equip(sets.precast.RA.Flurry2)
                elseif flurry == 1 then
                    equip(sets.precast.RA.Flurry1)
                else
                    equip(sets.precast.RA)
                end
            end
            if player.equipment.main == "Perun +1" then
                equip({waist="Yemaya Belt"})
            end
        end
        -- Replace TP-bonus gear if not needed.
        if spell.english == 'Trueflight' or spell.english == 'Aeolian Edge' and player.tp > 2900 then
            equip(sets.FullTP)
        end
        -- Equip obi if weather/day matches for WS.
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
function job_post_midcast(spell, action, spellMap, eventArgs)
    if spell.action_type == 'Ranged Attack' then
        if buffactive['Double Shot'] then
            equip(sets.DoubleShot)
            if buffactive['Aftermath: Lv.3'] and player.equipment.ranged == "Armageddon" then
                equip(sets.DoubleShotCritical)
            end
        elseif buffactive['Aftermath: Lv.3'] and player.equipment.ranged == "Armageddon" then
            equip(sets.midcast.RA.Critical)
        end
        if state.Buff.Barrage then
            equip(sets.buff.Barrage)
        end
--        if state.Buff['Velocity Shot'] and state.RangedMode.value == 'STP' then
--            equip(sets.buff['Velocity Shot'])
--        end
    end
end


function job_aftercast(spell, action, spellMap, eventArgs)
    if spell.english == "Shadowbind" then
        send_command('@timers c "Shadowbind ['..spell.target.name..']" 42 down abilities/00122.png')
    end
    if player.status ~= 'Engaged' and state.WeaponLock.value == false then
        check_weaponset()
    end
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for non-casting events.
-------------------------------------------------------------------------------------------------------------------

-- Called when a player gains or loses a buff.
-- buff == buff gained or lost
-- gain == true if the buff was gained, false if it was lost.
function job_buff_change(buff,gain)
-- If we gain or lose any flurry buffs, adjust gear.
    if S{'flurry'}:contains(buff:lower()) then
        if not gain then
            flurry = nil
            add_to_chat(122, "Flurry status cleared.")
        end
        if not midaction() then
            handle_equipping_gear(player.status)
        end
    end

    if buff == "Camouflage" then
        if gain then
            equip(sets.buff.Camouflage)
            disable('body')
        else
            enable('body')
        end
    end

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

function job_state_change(stateField, newValue, oldValue)
    if state.WeaponLock.value == true then
	   disable('main')
	   disable('sub')
	   disable('ranged')
    else
	   disable('main')
	   disable('sub')
       enable('ranged')
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
    --determine_haste_group()
    --check_moving()
end

function job_update(cmdParams, eventArgs)
    handle_equipping_gear(player.status)
end

function update_combat_form()
    if DW == true then
        state.CombatForm:set('DW')
    elseif DW == false then
        state.CombatForm:reset()
    end
end

-- Modify the default melee set after it was constructed.
function customize_melee_set(meleeSet)
    check_weaponset()

    return meleeSet
end

function get_custom_wsmode(spell, action, spellMap)
    local wsmode
    if (spell.skill == 'Marksmanship' or spell.skill == 'Archery') then
        if state.RangedMode.value == 'Acc' or state.RangedMode.value == 'HighAcc' then
            wsmode = 'Acc'
            add_to_chat(1, 'WS Mode Auto Acc')
        end
    elseif (spell.skill ~= 'Marksmanship' and spell.skill ~= 'Archery') then
        if state.OffenseMode.value == 'Acc' or state.OffenseMode.value == 'HighAcc' then
            wsmode = 'Acc'
        end
    end

    return wsmode
end

function customize_idle_set(idleSet)
    -- if state.CP.current == 'on' then
    --     equip(sets.CP)
    --     disable('back')
    -- else
    --     enable('back')
    -- end
--    if state.Auto_Kite.value == true then
--       idleSet = set_combine(idleSet, sets.Kiting)
--    end

    return idleSet
end

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

--Read incoming packet to differentiate between Haste/Flurry I and II
windower.register_event('action',
    function(act)
        --check if you are a target of spell
        local actionTargets = act.targets
        playerId = windower.ffxi.get_player().id
        isTarget = false
        for _, target in ipairs(actionTargets) do
            if playerId == target.id then
                isTarget = true
            end
        end
        if isTarget == true then
            if act.category == 4 then
                local param = act.param
                if param == 845 and flurry ~= 2 then
                    --add_to_chat(122, 'Flurry Status: Flurry I')
                    flurry = 1
                elseif param == 846 then
                    --add_to_chat(122, 'Flurry Status: Flurry II')
                    flurry = 2
              end
            end
        end
    end)
--[[
function determine_haste_group()
    classes.CustomMeleeGroups:clear()
    if DW == true then
        if DW_needed <= 11 then
            classes.CustomMeleeGroups:append('MaxHaste')
        elseif DW_needed > 11 and DW_needed <= 21 then
            classes.CustomMeleeGroups:append('MaxHastePlus')
        elseif DW_needed > 21 and DW_needed <= 27 then
            classes.CustomMeleeGroups:append('HighHaste')
        elseif DW_needed > 27 and DW_needed <= 31 then
            classes.CustomMeleeGroups:append('MidHaste')
        elseif DW_needed > 31 and DW_needed <= 42 then
            classes.CustomMeleeGroups:append('LowHaste')
        elseif DW_needed > 42 then
            classes.CustomMeleeGroups:append('')
        end
    end
end
]]--
function job_self_command(cmdParams, eventArgs)
    --gearinfo(cmdParams, eventArgs)
end
--[[
function gearinfo(cmdParams, eventArgs)
    if cmdParams[1] == 'gearinfo' then
        if type(tonumber(cmdParams[2])) == 'number' then
            if tonumber(cmdParams[2]) ~= DW_needed then
            DW_needed = tonumber(cmdParams[2])
            DW = true
            end
        elseif type(cmdParams[2]) == 'string' then
            if cmdParams[2] == 'false' then
                DW_needed = 0
                DW = false
            end
        end
        if type(tonumber(cmdParams[3])) == 'number' then
            if tonumber(cmdParams[3]) ~= Haste then
                Haste = tonumber(cmdParams[3])
            end
        end
        if type(cmdParams[4]) == 'string' then
            if cmdParams[4] == 'true' then
                moving = true
            elseif cmdParams[4] == 'false' then
                moving = false
            end
        end
        if not midaction() then
            job_update()
        end
    end
end
]]--
-- Check for proper ammo when shooting or weaponskilling
function check_ammo(spell, action, spellMap, eventArgs)
    if spell.action_type == 'Ranged Attack' then
        if player.equipment.ammo == 'empty' or player.equipment.ammo ~= DefaultAmmo[player.equipment.range] then
            if DefaultAmmo[player.equipment.range] then
                if player.inventory[DefaultAmmo[player.equipment.range]] then
                    --add_to_chat(3,"Using Default Ammo")
                    equip({ammo=DefaultAmmo[player.equipment.range]})
                else
                    add_to_chat(3,"Default ammo unavailable.  Leaving empty.")
                end
            else
                add_to_chat(3,"Unable to determine default ammo for current weapon.  Leaving empty.")
            end
        end
    elseif spell.type == 'WeaponSkill' then
        -- magical weaponskills
        if elemental_ws:contains(spell.english) then
            if player.inventory[MagicAmmo[player.equipment.range]] then
                equip({ammo=MagicAmmo[player.equipment.range]})
            else
                add_to_chat(3,"Magic ammo unavailable.  Using default ammo.")
                equip({ammo=DefaultAmmo[player.equipment.range]})
            end
        --physical weaponskills
        else
            if state.RangedMode.value == 'Acc' then
                if player.inventory[AccAmmo[player.equipment.range]] then
                    equip({ammo=AccAmmo[player.equipment.range]})
                else
                    add_to_chat(3,"Acc ammo unavailable.  Using default ammo.")
                    equip({ammo=DefaultAmmo[player.equipment.range]})
                end
            else
                if player.inventory[WSAmmo[player.equipment.range]] then
                    equip({ammo=WSAmmo[player.equipment.range]})
                else
                    add_to_chat(3,"WS ammo unavailable.  Using default ammo.")
                    equip({ammo=DefaultAmmo[player.equipment.range]})
                end
            end
        end
    end
    if player.equipment.ammo ~= 'empty' and player.inventory[player.equipment.ammo].count < 15 then
        add_to_chat(39,"*** Ammo '"..player.inventory[player.equipment.ammo].shortname.."' running low! *** ("..player.inventory[player.equipment.ammo].count..")")
    end
end

function update_offense_mode()
    if player.sub_job == 'NIN' or player.sub_job == 'DNC' then
        state.CombatForm:set('DW')
    else
        state.CombatForm:reset()
    end
end
--[[
function check_moving()
    if state.DefenseMode.value == 'None'  and state.Kiting.value == false then
        if state.Auto_Kite.value == false and moving then
            state.Auto_Kite:set(true)
        elseif state.Auto_Kite.value == true and moving == false then
            state.Auto_Kite:set(false)
        end
    end
end
]]--
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
    if no_swap_gear:contains(player.equipment.waist) then
        disable("waist")
    else
        enable("waist")
    end
end

function check_weaponset()
    if state.OffenseMode.value == 'LowAcc' or state.OffenseMode.value == 'MidAcc' or state.OffenseMode.value == 'HighAcc' then
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
        if no_swap_gear:contains(player.equipment.waist) then
            enable("waist")
            equip(sets.idle)
        end
    end
)

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    set_macro_page(1, 6)
end

function set_lockstyle()
    send_command('wait 2; input /lockstyleset ' .. lockstyleset)
end