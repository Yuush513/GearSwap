-- Make Night/Daytime WS rule
-------------------------------------------------------------------------------------------------------------------
-- (Original: Motenten /  Modified: Yuush)
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

function job_setup()
    state.Buff.Sekkanoki = buffactive.Sekkanoki or false
    state.Buff.Sengikori = buffactive.Sengikori or false
	state.Buff.Hasso = buffactive.Hasso or false
	include('Mote-TreasureHunter')

end

-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

-- Setup vars that are user-dependent.
function user_setup()
    state.OffenseMode:options('Normal', 'Acc', 'SB')
    state.HybridMode:options('Normal', 'DT', 'Meva')
	state.WeaponskillMode:options('Normal', 'Acc')
    state.PhysicalDefenseMode:options('PDT')
	state.MagicalDefenseMode:options('MEVA')

	state.WeaponSet = M{['description']='Weapon Set', 'Masamune', 'Doji', 'ShiningOne'}
    state.WeaponLock = M(false, 'Weapon Lock')
--    update_combat_form()
    select_default_macro_book()
	
	--binds--
	send_command('bind ^f11 gs c cycle MagicalDefenseMode')
	send_command('bind ^= gs c cycle treasuremode')
	send_command('bind ^insert gs c cycle WeaponSet')
    send_command('bind ^delete gs c cycleback WeaponSet')
end


-- Called when this job file is unloaded (eg: job change)
function user_unload()
	send_command('unbind ^f11')
	send_command('unbind !f9')
end


-- Define sets and vars used by this job file.
function init_gear_sets()
	--WeaponSets--
	sets.Masamune = {main="Masamune", sub="Utu Grip"}
	sets.Doji = {main="Dojikiri Yasutsuna", sub="Utu Grip",}
	sets.ShiningOne = {main="Shining One", sub="Utu Grip",}
	
    -- Precast sets to enhance JAs
    sets.precast.JA.Meditate = {head="Wakido Kabuto +3", hands="Sakonji Kote +3", back="Smertrios's Mantle",}
    sets.precast.JA['Blade Bash'] = {hands="Sakonji Kote +3"}
	sets.precast.JA['Warding Circle'] = {head="Wakido Kabuto +3"}
	sets.precast.JA['Shikikoyo'] = {legs="Sakonji Haidate +3"}
	
	--/war
	sets.precast.JA['Provoke'] = sets.enmity 
	sets.precast.JA['Warcry'] = sets.enmity 
	
	--/run
	sets.precast.JA['Vallation'] = sets.enmity
    sets.precast.JA['Pflug'] = sets.enmity
    sets.precast.JA['Lunge'] = sets.enmity
    sets.precast.JA['Swordplay'] = sets.enmity

	--/drg **only use jump for pulls or HJump to drop agro... for now**
	sets.precast.JA['Jump'] = {
		ammo="Coiste Bodhar",
		head="Flam. Zucchetto +2",
		body="Tatena. Harama. +1", 
		hands="Tatena. Gote +1", 
		legs="Tatena. Haidate +1",
		feet="Tatena. Sune. +1",
		neck="Sam. Nodowa +2",
		waist="Ioskeha Belt +1",
		left_ear="Schere Earring",
		right_ear="Telos Earring",
		left_ring="Niqmaddu Ring",
		right_ring="Petrov Ring",
		back={ name="Smertrios's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}},
		}
		
	sets.precast.JA['High Jump'] = sets.precast.JA['Jump']
	
	
	-- Other JA sets
	sets.buff.Hasso = {hands="Wakido Kote +3"}
	
    sets.buff.Sekkanoki = {hands="Kasuga Kote +1"}
    sets.buff.Sengikori = {feet="Kas. Sune-Ate +1",}
	
    sets.buff['Meikyo Shisui'] = {fee ="Sak. Sune-Ate +3"}
	
	sets.enmity = {
		ammo="Sapience Orb",
		head=="Loess Barbuta +1",
		body="Emet Harness +1",
		hands="Kurys Gloves",
		legs={ name="Acro Breeches", augments={'DEF+15','Enmity+10','VIT+8',}},
		feet={ name="Acro Leggings", augments={'Mag. Evasion+15','Enmity+10','AGI+7',}},
		neck="Unmoving Collar +1",
		waist="Goading Belt",
		left_ear="Trux Earring",
		right_ear="Cryptic Earring",
		left_ring="Eihwaz Ring",
		right_ring="Supershear Ring",
		back={ name="Smertrios's Mantle", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','Enmity+10','Damage taken-5%',}},
	}
	
	sets.TreasureHunter = {
		ammo="Per. Lucky Egg",
		head={ name="Valorous Mask", augments={'Pet: STR+6','"Mag.Atk.Bns."+19','"Treasure Hunter"+2',}},
		waist="Chaac Belt",
		}
	
	sets.precast.FC = {
		ammo="Sapience Orb",
		body="Sacro Breastplate",
		neck="Baetyl Pendant",
		waist="Chaac Belt",
		left_ear="Loquac. Earring",
		right_ear="Etiolation Earring",
		left_ring="Weather. Ring",
		}
	
	--Flurry II 30 | Flurry 15 | Need 70
	sets.precast.RA = {
		ammo = "",
		head = "Sakonji Kabuto +3", --5 Snap
		--body = "Acro Surcoat", --5 Snap + 5 Rapid
		--hands = "Acro Gauntlets", --5 Snap + 5 Rapid
		--back = Smertrios.Snap, --10
		waist = "Yemaya Belt", --5 Rapid
		--legs = "Acro Breeches", --5 Snap (enmity but +1 inv.)
		--feet = "Acro Leggings", --5 Snap (enmity but +1 inv.)
		} 
 
-------------------------------------------------------------------------------------------------------------------
-- Weaponskill Sets : Normal(attack uncapped), Acc , Attack(Attack Capped)
-- head="Mpaca's Cap", right_ear="Moonshade Earring"
-------------------------------------------------------------------------------------------------------------------	

    sets.precast.WS = {
		ammo="Knobkierrie",
		head={ name="Valorous Mask", augments={'Enmity-3','"Fast Cast"+1','Weapon skill damage +8%',}},
		body="Sakonji Domaru +3", 
		hands={ name="Valorous Mitts", augments={'"Cure" potency +4%','Accuracy+1','Weapon skill damage +7%','Accuracy+13 Attack+13','Mag. Acc.+10 "Mag.Atk.Bns."+10',}},
		legs="Wakido Haidate +3",
		feet={ name="Valorous Greaves", augments={'Attack+25','Weapon skill damage +5%','STR+10','Accuracy+11',}},
		neck="Sam. Nodowa +2",
		waist="Fotia Belt",
		left_ear="Thrud Earring",
		right_ear="Lugra Earring +1",
		left_ring="Niqmaddu Ring",
		right_ring="Epaminondas's Ring",
		back={ name="Smertrios's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%',}},
		}
		
    sets.precast.WS.Acc = set_combine(sets.precast.WS, {
		head="Stinger Helm +1",
		hands="Sakonji Kote +3",
		feet="Flam. Gambieras +2",
		neck={ name="Sam. Nodowa +2", augments={'Path: A',}},
		left_ring="Regal Ring",
		})

	-- Great Katana
	sets.precast.WS['Tachi: Fudo'] = {
		ammo="Knobkierrie",
		head={ name="Valorous Mask", augments={'Enmity-3','"Fast Cast"+1','Weapon skill damage +8%',}},
		body="Sakonji Domaru +3", 
		hands={ name="Valorous Mitts", augments={'"Cure" potency +4%','Accuracy+1','Weapon skill damage +7%','Accuracy+13 Attack+13','Mag. Acc.+10 "Mag.Atk.Bns."+10',}},
		legs="Wakido Haidate +3",
		feet={ name="Valorous Greaves", augments={'Attack+25','Weapon skill damage +5%','STR+10','Accuracy+11',}},
		neck="Sam. Nodowa +2",
		waist="Sailfi Belt +1",
		left_ear="Thrud Earring",
		right_ear="Moonshade Earring",
		left_ring="Niqmaddu Ring",
		right_ring="Epaminondas's Ring",
		back={ name="Smertrios's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%',}},
		}
		
	sets.precast.WS['Tachi: Fudo'].Acc = set_combine(sets.precast.WS['Tachi: Fudo'], {
		head="Stinger Helm +1",
		hands="Sakonji Kote +3",
		left_ring="Regal Ring",
		})
		
    sets.precast.WS['Tachi: Shoha'] = {
		ammo="Knobkierrie",
		head="Stinger Helm +1",
		body="Sakonji Domaru +3",
		hands={ name="Valorous Mitts", augments={'"Cure" potency +4%','Accuracy+1','Weapon skill damage +7%','Accuracy+13 Attack+13','Mag. Acc.+10 "Mag.Atk.Bns."+10',}},
		legs="Wakido Haidate +3",
		feet="Flam. Gambieras +2",
		neck="Sam. Nodowa +2",
		waist="Sailfi Belt +1",
		left_ear="Thrud Earring",
		right_ear="Lugra Earring +1",
		left_ring="Niqmaddu Ring",
		right_ring="Epaminondas's Ring",
		back={ name="Smertrios's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%',}},
		}

	sets.precast.WS['Tachi: Shoha'].Acc = {
		hands="Sakonji Kote +3",
		left_ring="Regal Ring",
		}
	
    sets.precast.WS['Tachi: Rana'] = sets.precast.WS['Tachi: Fudo']
	sets.precast.WS['Tachi: Rana'].Acc = sets.precast.WS['Tachi: Fudo'].Acc

    sets.precast.WS['Tachi: Ageha'] = {
		ammo="Pemphredo Tathlum",
		head="Mpaca's Cap",
		body="Sakonji Domaru +3",
		hands="Mpaca's Gloves",
		legs="Mpaca's Hose",
		feet="Mpaca's Boots",
		neck="Fotia Gorget",
		waist="Fotia Belt",
		left_ear="Thrud Earring",
		right_ear="Lugra Earring +1",
		left_ring="Weather. Ring",
		right_ring="Regal Ring",
		back={ name="Smertrios's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%',}},
		}
	
    sets.precast.WS['Tachi: Jinpu'] = {
		ammo="Knobkierrie",
		head="Mpaca's Cap",
		body="Sakonji Domaru +3",
		hands={ name="Valorous Mitts", augments={'"Cure" potency +4%','Accuracy+1','Weapon skill damage +7%','Accuracy+13 Attack+13','Mag. Acc.+10 "Mag.Atk.Bns."+10',}},
		legs="Wakido Haidate +3",
		feet={ name="Valorous Greaves", augments={'Attack+25','Weapon skill damage +5%','STR+10','Accuracy+11',}},
		neck="Sam. Nodowa +2",
		waist="Eschan Stone",
		left_ear="Friomisi Earring",
		right_ear="Crematio Earring",
		left_ring="Beithir Ring",
		right_ring="Epaminondas's Ring",
		back={ name="Smertrios's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%',}},
		}

	--Polearm--
	
	sets.precast.WS['Impulse Drive'] = set_combine(sets.precast.WS['Tachi: Fudo'], {hands = "Ryuo Tekko +1",})
		
	sets.precast.WS['Impulse Drive'].Acc = set_combine(sets.precast.WS['Tachi: Fudo'].Acc, {hands = "Ryuo Tekko +1",})
		
	sets.precast.WS['Stardiver'] = {
		ammo="Knobkierrie",
		head="Stinger Helm +1",
		body="Tatena. Harama. +1",
		hands="Ryuo Tekko +1",
		legs="Ken. Hakama +1",
		feet="Ken. Sune-Ate +1",
		neck="Fotia Gorget",
		waist="Fotia Belt",
		left_ear="Lugra Earring +1",
		right_ear="Schere Earring",
		left_ring="Niqmaddu Ring",
		right_ring="Regal Ring",
		back={ name="Smertrios's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}},
		}
		
	sets.precast.WS['Legsweep'] = sets.precast.WS['Tachi: Ageha']

	------------------
    -- Midcast Sets --
	------------------
	
    sets.midcast.FastRecast = sets.precast.FC
	sets.midcast['Flash'] = sets.enmity

	sets.midcast.RA = {}

-------------------------------------------------------------------------------------------------------------------
-- Engaged Sets
-- If Hasso is up Wakido kote +3 will be equipped.
-------------------------------------------------------------------------------------------------------------------	
	-- Base Engaged
    sets.engaged = {
		ammo="Coiste Bodhar",
		head="Flam. Zucchetto +2",
		body="Tatena. Harama. +1",
		hands="Wakido Kote +3",
		legs="Tatena. Haidate +1",
		feet="Ryuo Sune-Ate +1",
		neck="Sam. Nodowa +2",
		waist="Sailfi Belt +1",
		left_ear="Dedition Earring",
		right_ear="Telos Earring",
		left_ring="Niqmaddu Ring",
		right_ring="Chirich Ring +1",
		back={ name="Smertrios's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Store TP"+10','Phys. dmg. taken-10%',}},
		}
	
	sets.engaged.Acc = set_combine(sets.engaged, {
		feet="Tatena. Sune. +1",
		waist="Ioskeha Belt +1",
		left_ear="Cessance Earring",
		})
	
	-- Assumes Auspice
	sets.engaged.SB = set_combine(sets.engaged, {
		--head = "Ken. Jinpachi +1",
		body = "Ken. Samue +1",
		legs = "Mpaca's Hose",
		})
	
	--Hybrid Sets--
	--Assumption is you need midigation regardless of mode
	sets.Hybrid = {} -- Don't fill
	
	sets.engaged.DT = {
		ammo="Staunch Tathlum +1",
		head="Mpaca's Cap",
		body="Wakido Domaru +3",
		hands="Wakido Kote +3",
		legs="Ken. Hakama +1",
		feet="Ken. Sune-Ate +1",
		neck="Sam. Nodowa +2",
		waist="Sailfi Belt +1",
		left_ear="Dedition Earring",
		right_ear="Telos Earring",
		left_ring="Niqmaddu Ring",
		right_ring="Defending Ring",
		back={ name="Smertrios's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Store TP"+10','Phys. dmg. taken-10%',}},
		}
	sets.engaged.Acc.DT = set_combine(sets.engaged.DT, {
		waist="Ioskeha Belt +1",
		left_ear="Cessance Earring",
		left_ring="Regal Ring",
		})
		
	sets.engaged.SB.DT = set_combine(sets.engaged.DT, {    
		head="Ken. Jinpachi +1",
		legs="Mpaca's Hose",
		waist="Ioskeha Belt +1",
		left_ear="Schere Earring",
		right_ear="Telos Earring",
		right_ring="Chirich Ring +1",
		})

	sets.engaged.Meva = {    
		ammo="Staunch Tathlum +1",
		head="Ken. Jinpachi +1",
		body="Ken. Samue +1",
		hands="Wakido Kote +3",
		legs="Ken. Hakama +1",
		feet="Ken. Sune-Ate +1",
		neck={ name="Sam. Nodowa +2", augments={'Path: A',}},
		waist="Ioskeha Belt +1",
		left_ear="Dedition Earring",
		right_ear="Telos Earring",
		left_ring={ name="Gelatinous Ring +1", augments={'Path: A',}},
		right_ring="Defending Ring",
		back={ name="Smertrios's Mantle", augments={'DEX+20','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','"Store TP"+10','Phys. dmg. taken-10%',}},
		}
		
	sets.engaged.Acc.Meva = set_combine(sets.engaged.Meva,{
		left_ear="Cessance Earring",
		left_ring="Regal Ring",
		})
	
	sets.engaged.SB.Meva = set_combine(sets.engaged.Meva,{
		left_ear="Odnowa Earring +1",
		left_ring="Niqmaddu Ring",
		})

    -- Defense Sets
	
	-- Engaged Tanking
    sets.defense.PDT = {
		ammo="Staunch Tathlum +1",
		head="Ken. Jinpachi +1",
		body="Wakido Domaru +3",
		hands="Wakido Kote +3",
		legs="Mpaca's Hose",
		feet="Ken. Sune-Ate +1",
		neck="Sam. Nodowa +2",
		waist="Sailfi Belt +1",
		left_ear="Odnowa Earring +1",
		right_ear="Telos Earring",
		left_ring="Gelatinous Ring +1",
		right_ring="Defending Ring",
		back={ name="Smertrios's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Store TP"+10','Phys. dmg. taken-10%',}},
		} 

    sets.defense.MEVA= {
		ammo="Staunch Tathlum +1",
		head="Ken. Jinpachi +1",
		body="Ken. Samue +1",
		hands="Wakido Kote +3",
		legs="Ken. Hakama +1",
		feet="Ken. Sune-Ate +1",
		neck=="Sam. Nodowa +2",
		waist="Sailfi Belt +1",
		left_ear="Odnowa Earring +1",
		right_ear="Telos Earring",
		left_ring="Gelatinous Ring +1",
		right_ring="Defending Ring",
		back={ name="Smertrios's Mantle", augments={'DEX+20','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','"Store TP"+10','Phys. dmg. taken-10%',}},
		} 

    -- Idle Sets 
 
	sets.idle= {
		ammo="Staunch Tathlum +1",
		head="Wakido Kabuto +3",
		body="Sacro Breastplate",
		hands="Mpaca's Gloves",
		legs="Mpaca's Hose",
		feet="Mpaca's Boots",
		neck="Loricate Torque +1",
		waist="Carrier's Sash",
		left_ear="Odnowa Earring +1",
		right_ear="Eabani Earring",
		left_ring="Sheltered Ring",
		right_ring="Defending Ring",
		back={ name="Smertrios's Mantle", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','Enmity+10','Damage taken-5%',}},
		}
	
	--With Nikilo you only need +50%.. but this will be used for inferior WHMs as well.
	sets.buff.Doom = {
		neck="Nicander's Necklace", --20	
		waist="Gishdubar Sash", --10
		left_ring="Saida Ring", --15
		right_ring="Eshmun's Ring", --20
		}
		
	sets.buff.Sleep = {neck="Vim Torque +1"}
	
end


-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------

function job_pretarget(spell, action, spellMap, eventArgs)
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

--------
function job_pretarget(spell)
    if spell.type == 'WeaponSkill' and player.tp < 1000 then
		cancel_spell()
		send_command('gs c update')
		add_to_chat(3,'Canceled Spell:'..spell.name..' - Waiting on TP')
		return
	end
	if spell.type == 'WeaponSkill' and buffactive.Amnesia then
		cancel_spell()
		send_command('gs c update')
		add_to_chat(3,'Canceling Ability - Currently have Amnesia')
		return	  
	end
end

function job_post_precast(spell, action, spellMap, eventArgs)
    if spell.type:lower() == 'weaponskill' then
        if player.tp < 2700 then  
          equip({head="Mpaca's Cap", right_ear="Moonshade Earring"})
		elseif player.tp < 2950 then
			equip({right_ear="Moonshade Earring"})
        end
		
		if state.Buff.Sekkanoki then
            equip(sets.buff.Sekkanoki)
        end
		
        if state.Buff.Sengikori then
            equip(sets.buff.Sengikori)
        end
--	elseif  spell.action_type == 'Ability' then
--            equip(sets.Enmity)
--			equip(sets.precast.JA[spell])
    end
end

function job_post_midcast(spell)

    if spell.name == 'Utsusemi: Ichi' then
	  send_command('cancel Copy Image|Copy Image (2)')
	end

end 

function job_aftercast(spell)
	if spell.type == "WeaponSkill" then
		send_command('wait 0.2;gs c returntp')
	end
	if player.status ~= 'Engaged' and state.WeaponLock.value == false then
        check_weaponset()
    end
end
--[[
function update_combat_form()
     --Check Weapontype
    if  Masa_weapons:contains(player.equipment.main) then
        state.CombatForm:set('Masamune')
    elseif Doji_weapons:contains(player.equipment.main) then
		state.CombatForm:set('Dojikiri Yasutsuna')
    else
        state.CombatForm:reset()
    end

end
]]--

function job_buff_change(buff,gain)
    if buff == "terror" or buff=="petrification" or buff=="stun" then
        if gain then
            equip(sets.defense.AwwShitDawg)
        end
    end

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
	
	if buff == "Meikyo Shisui" then
		if gain then
			equip(sets.buff['Meikyo Shisui'])
			send_command('@input /echo Locking Feet')
			disable('feet')
		else
			enable('feet')
			handle_equipping_gear(player.status)
		end
	end

	if buff == "sleep" then
		if gain then
		   equip(sets.buff.Sleep)
	    end
	end

end

function job_state_change(stateField, newValue, oldValue)
    if state.WeaponLock.value == true then
        disable('main')
		disable('sub')
		disable('ranged')
    else
	    enable('main')
		enable('sub')
		enable('ranged')
    end

    check_weaponset()
end

function job_update(cmdParams, eventArgs)
    --update_combat_form()
	th_update(cmdParams, eventArgs)
end

-- Modify the default melee set after it was constructed.
function customize_melee_set(meleeSet)
--[[ this fucks with WSmode for some reason??
	if buffactive['Hasso'] and state.DefenseMode.value == 'None' then
        meleeSet = set_combine(meleeSet, sets.buff.Hasso)
    end
]]--
check_weaponset()
    return meleeSet
end

function get_custom_wsmode(spell, action, spellMap)
    local wsmode
    
	if state.OffenseMode.value == 'Acc' then
        wsmode = 'Acc'
    end

    return wsmode
end

function job_self_command(cmdParams, eventArgs)

---  THIS IS WHERE BUFF COMANDS GO  ---
	
	if cmdParams[1] == 'returntp' then
        add_to_chat(158, 'TP Return = '..tostring(player.tp))
    end

end

function display_current_job_state(eventArgs)
    
	local msg = '[ Melee'
     
     if state.CombatForm.has_value then
          msg = msg .. ' (' .. state.CombatForm.value .. ')'
     end
     
     msg = msg .. ': '
     
     msg = msg .. state.OffenseMode.value
     if state.HybridMode.value ~= 'Normal' then
          msg = msg .. '/' .. state.HybridMode.value 
     end
     msg = msg .. ' ][ WS: ' .. state.WeaponskillMode.value .. ' ]'
     
     if state.DefenseMode.value ~= 'None' then
          msg = msg .. '[ Defense: ' .. state.DefenseMode.value .. state[state.DefenseMode.value .. 'DefenseMode'].value .. ' ]'
     end
	 if state.TreasureMode.value ~= 'None' then
        msg = msg .. ' TH: ' ..state.TreasureMode.value.. ' |'
     end
     add_to_chat(060, msg)

     eventArgs.handled = true
end
------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------
function check_weaponset()
    equip(sets[state.WeaponSet.current])
end



-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    -- Default macro set/book
    if player.sub_job == 'WAR' then
        set_macro_page(1, 11)
    elseif player.sub_job == 'DRG' then
        set_macro_page(2, 11)
    else
        set_macro_page(1, 11)
    end
end