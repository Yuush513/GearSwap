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
-------------------------------------------------------------------------------------------------------------------
-- Setup functions for this job.  Generally should not be modified.
-------------------------------------------------
-- Initialization function for this job file.
function get_sets()
    mote_include_version = 2
    
    -- Load and initialize the include file.
    include('Mote-Include.lua')
	include('organizer-lib.lua')
end


-- Setup vars that are user-independent.  state.Buff vars initialized here will automatically be tracked.
function job_setup()
    state.Buff.Footwork = buffactive.Footwork or false
    state.Buff.Impetus = buffactive.Impetus or false
	state.Buff['Hundred Fists'] = buffactive['Hundred Fists'] or false
	
	state.Buff['Boost'] = buffactive['Boost'] or false
	

    state.FootworkWS = M(false, 'Footwork on WS')
end


-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
    state.OffenseMode:options('Normal', 'Acc', 'Max')
    state.WeaponskillMode:options('Normal', 'Attack', 'Acc')
    state.HybridMode:options('Normal', 'DT')
    state.PhysicalDefenseMode:options('PDT', 'Counterstance')
	state.MagicalDefenseMode:options('MEVA')
	state.IdleMode:options('Normal')
	
	state.WeaponSet = M{['description']='Weapon Set', 'Kaja', 'Godhands', 'Staff'}
	
    update_combat_form()
    update_melee_groups()

    select_default_macro_book()
	
	send_command('bind !f9 gs c cycle WeaponskillMode')
    send_command('bind ^insert gs c cycle WeaponSet')
    send_command('bind ^delete gs c cycleback WeaponSet')

end


-- Define sets and vars used by this job file.
function init_gear_sets()
    --------------------------------------
    -- Start defining the sets
    --------------------------------------
    sets.Kaja = {main="Karambit"}
	sets.Godhands = {main="Godhands"}
	sets.Staff = {main="Xoanon", sub="Pole Grip"}
    -- Precast Sets
    
    -- Precast sets to enhance JAs on use
    sets.precast.JA['Hundred Fists'] = {legs = "Hes. Hose +1"}
    sets.precast.JA['Boost'] = {hands = "Anchor. Gloves +1", waist = "Ask Sash"}
    sets.precast.JA['Dodge'] = {feet = "Anch. Gaiters +1"}
    sets.precast.JA['Focus'] = {head = "Anchorite's Crown +1"}
    sets.precast.JA['Counterstance'] = {feet = "Hes. Gaiters +1"}
    sets.precast.JA['Footwork'] = {feet = "Shukuyu Sune-Ate"}
    sets.precast.JA['Formless Strikes'] = {body = "Hesychast's Cyclas +1"}
    sets.precast.JA['Mantra'] = {feet = "Hes. Gaiters +1"}

    sets.precast.JA['Chi Blast'] = {head = "Hes. Crown +1",}

    sets.precast.JA['Chakra'] = {
		ammo="Crepuscular Pebble",
		head="Mpaca's Cap",
		body="Anch. Cyclas +1",
		hands={ name="Hes. Gloves +1", augments={'Enhances "Invigorate" effect',}},
		legs="Mpaca's Hose",
		feet="Mpaca's Boots",
		neck={ name="Loricate Torque +1", augments={'Path: A',}},
		waist="Moonbow Belt +1",
		left_ear="Eabani Earring",
		right_ear="Etiolation Earring",
		left_ring="Niqmaddu Ring",
		right_ring="Defending Ring",
		back={ name="Segomo's Mantle", augments={'VIT+20','Accuracy+20 Attack+20','Weapon skill damage +10%',}},
		}

    -- Fast cast sets for spells
    
    sets.precast.FC = {}

    sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, {})

    -- Weaponskill sets
    -- Default set for any weaponskill that isn't any more specifically defined
	--486 for TPbonus Junk

    sets.precast.WS = {
		ammo="Knobkierrie",
		head="Mpaca's Cap",
		body="Mpaca's Doublet",
		hands="Mpaca's Gloves",
		legs="Mpaca's Hose",
		feet="Mpaca's Boots",
		neck="Fotia Gorget",
		waist="Moonbow Belt +1",
		right_ear={ name="Moonshade Earring", augments={'"Mag.Atk.Bns."+4','TP Bonus +250',}},
		left_ear="Sherida Earring",
		right_ring="Niqmaddu Ring",
		left_ring="Gere Ring",
		back={ name="Segomo's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','"Dbl.Atk."+10',}},
	}
		
	sets.precast.WS.Acc = {}
	
	sets.precast.WS.Attack = {}

	-- VS and AF when impetus up	
    sets.precast.impWS = {
		ammo="Knobkierrie",
		head={ name="Adhemar Bonnet +1", augments={'STR+12','DEX+12','Attack+20',}},
		body="Bhikku Cyclas +1",
		hands={ name="Ryuo Tekko +1", augments={'STR+12','DEX+12','Accuracy+20',}},
		legs="Mpaca's Hose",
		feet={ name="Herculean Boots", augments={'Accuracy+15','Crit. hit damage +5%','STR+10',}},
		neck="Fotia Gorget",
		waist="Moonbow Belt +1",
		left_ear="Sherida Earring",
		right_ear={ name="Schere Earring", augments={'Path: A',}},
		left_ring="Gere Ring",
		right_ring="Niqmaddu Ring",
		back={ name="Segomo's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','"Dbl.Atk."+10',}},
		}
	
	sets.precast.impWS.Acc = set_combine(sets.precast.impWS, {})
	
	sets.precast.impWS.Attack = set_combine(sets.precast.impWS, {})
	
	
    -- Specific weaponskill sets.
	--impetus down
	sets.precast.WS['Victory Smite'] = {
		ammo="Knobkierrie",
		head={ name="Adhemar Bonnet +1", augments={'STR+12','DEX+12','Attack+20',}},
		body="Bhikku Cyclas +1",
		hands={ name="Ryuo Tekko +1", augments={'STR+12','DEX+12','Accuracy+20',}},
		legs="Mpaca's Hose",
		feet={ name="Herculean Boots", augments={'Accuracy+15','Crit. hit damage +5%','STR+10',}},
		neck="Fotia Gorget",
		waist="Moonbow Belt +1",
		left_ear="Sherida Earring",
		right_ear="Odr Earring",
		left_ring="Gere Ring",
		right_ring="Niqmaddu Ring",
		back={ name="Segomo's Mantle", augments={'STR+20','Accuracy+20 Attack+20','Crit.hit rate+10',}},
		}
	sets.precast.WS['Victory Smite'].Acc = set_combine(sets.precast.WS['Victory Smite'], {})
    
    sets.precast.WS['Raging Fists'] = {
		ammo="Knobkierrie",
		head="Ken. Jinpachi +1",
		body="Mpaca's Doublet",
		hands={ name="Adhemar Wrist. +1", augments={'STR+12','DEX+12','Attack+20',}},
		legs="Mpaca's Hose",
		feet={ name="Herculean Boots", augments={'"Triple Atk."+4','STR+5','Accuracy+6','Attack+3',}},
		neck="Fotia Gorget",
		waist="Moonbow Belt +1",
		left_ear="Sherida Earring",
		right_ear={ name="Moonshade Earring", augments={'"Mag.Atk.Bns."+4','TP Bonus +250',}},
		left_ring="Gere Ring",
		right_ring="Niqmaddu Ring",
		back={ name="Segomo's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','"Dbl.Atk."+10',}},
	}
    sets.precast.WS['Raging Fists'].Acc = set_combine(sets.precast.WS['Raging Fists'], {})
	
	sets.precast.WS['Howling Fist'] = {
		ammo="Knobkierrie",
		head="Ken. Jinpachi +1",
		body="Mpaca's Doublet",
		hands={ name="Adhemar Wrist. +1", augments={'STR+12','DEX+12','Attack+20',}},
		legs={ name="Tatena. Haidate +1", augments={'Path: A',}},
		feet={ name="Herculean Boots", augments={'"Triple Atk."+4','STR+5','Accuracy+6','Attack+3',}},
		neck="Fotia Gorget",
		waist="Moonbow Belt +1",
		left_ear="Sherida Earring",
		right_ear={ name="Moonshade Earring", augments={'"Mag.Atk.Bns."+4','TP Bonus +250',}},
		left_ring="Gere Ring",
		right_ring="Niqmaddu Ring",
		back={ name="Segomo's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','"Dbl.Atk."+10',}},
	}

	sets.precast.WS['Howling Fist'].Acc = set_combine(sets.precast.WS['Howling Fist'], {ammo = "Amar Cluster"})

	sets.precast.WS['Shijin Spiral'] = {}
		
    sets.precast.WS['Shijin Spiral'].Acc = set_combine(sets.precast.WS['Shijin Spiral'], {})
	
	sets.precast.WS['Tornado Kick'] = {
	    ammo="Knobkierrie",
		head="Mpaca's Cap",
		body="Mpaca's Doublet",
		hands="Mpaca's Gloves",
		legs={ name="Tatena. Haidate +1", augments={'Path: A',}},
		feet="Anch. Gaiters +2",
		neck={ name="Mnk. Nodowa +2", augments={'Path: A',}},
		waist="Moonbow Belt +1",
		left_ear="Sherida Earring",
		right_ear={ name="Moonshade Earring", augments={'"Mag.Atk.Bns."+4','TP Bonus +250',}},
		left_ring="Gere Ring",
		right_ring="Niqmaddu Ring",
		back={ name="Segomo's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','"Dbl.Atk."+10',}},
	}
	
	sets.precast.WS['Tornado Kick'].Acc = set_combine(sets.precast.WS['Tornado Kick'], {})
	
	sets.precast.WS['Dragon Kick'] = sets.precast.WS['Tornado Kick']
	sets.precast.WS['Dragon Kick'].Acc = sets.precast.WS['Tornado Kick'].Acc
	
	sets.precast.WS["Ascetic's Fury"] = sets.precast.WS["Victory Smite"]
	sets.precast.WS["Ascetic's Fury"].Acc = sets.precast.WS["Victory Smite"].Acc

	sets.precast.WS['Asuran Fists'] = {}
	
	sets.precast.WS['Asuran Fists'].Acc = set_combine(sets.precast.WS['Asuran Fists'], {})
	
	sets.precast.WS['Spinning Attack'] = {
    ammo="Knobkierrie",
    head={ name="Adhemar Bonnet +1", augments={'STR+12','DEX+12','Attack+20',}},
    body="Mpaca's Doublet",
    hands={ name="Adhemar Wrist. +1", augments={'STR+12','DEX+12','Attack+20',}},
    legs="Hiza. Hizayoroi +2",
    feet="Mpaca's Boots",
    neck="Fotia Gorget",
    waist="Moonbow Belt +1",
    left_ear="Sherida Earring",
    right_ear={ name="Moonshade Earring", augments={'"Mag.Atk.Bns."+4','TP Bonus +250',}},
    left_ring="Niqmaddu Ring",
    right_ring="Gere Ring",
    back={ name="Segomo's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','"Dbl.Atk."+10',}},
	}
	
	
	--Special Staff Weaponskill
	sets.precast.WS['Earth Crusher'] = {
	    ammo="Ghastly Tathlum +1",
		head="Nyame Helm",
		body="Nyame Mail",
		hands="Nyame Gauntlets",
		legs="Nyame Flanchard",
		feet="Nyame Sollerets",
		neck="Fotia Gorget",
		waist="Orpheus's Sash",
		left_ear="Friomisi Earring",
		right_ear={ name="Moonshade Earring", augments={'"Mag.Atk.Bns."+4','TP Bonus +250',}},
		left_ring="Karieyh Ring +1",
		right_ring={ name="Metamor. Ring +1", augments={'Path: A',}},
		back={ name="Segomo's Mantle", augments={'VIT+20','Accuracy+20 Attack+20','Weapon skill damage +10%',}},
	}
	
    sets.precast.WS['Cataclysm'] = {
		ammo="Ghastly Tathlum +1",
		head="Pixie Hairpin +1",
		body="Nyame Mail",
		hands="Nyame Gauntlets",
		legs="Nyame Flanchard",
		feet="Nyame Sollerets",
		neck="Sibyl Scarf",
		waist="Orpheus's Sash",
		right_ear={ name="Moonshade Earring", augments={'"Mag.Atk.Bns."+4','TP Bonus +250',}},
		left_ear="Friomisi Earring",
		left_ring="Epaminondas's Ring",
		right_ring="Archon Ring",
		back={ name="Segomo's Mantle", augments={'VIT+20','Accuracy+20 Attack+20','Weapon skill damage +10%',}},
	}
	
	sets.precast.WS['Cataclysm'].Acc = set_combine(sets.precast.WS['Cataclysm'], {})
	
	sets.precast.WS['Shell Crusher'] = {
	    ammo="Pemphredo Tathlum",
		head="Malignance Chapeau",
		body="Malignance Tabard",
		hands="Malignance Gloves",
		legs="Malignance Tights",
		feet="Malignance Boots",
		neck="Fotia Gorget",
		waist="Fotia Belt",
		left_ear="Crep. Earring",
		right_ear="Telos Earring",
		left_ring="Stikini Ring +1",
		right_ring={ name="Metamor. Ring +1", augments={'Path: A',}},
		back={ name="Segomo's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','"Dbl.Atk."+10',}},
	}
	
	sets.precast.WS['Shell Crusher'].Acc = set_combine(sets.precast.WS['Shell Crusher'], {})

    -- Midcast Sets
    sets.midcast.FastRecast = {}

    sets.midcast.Utsusemi = set_combine(sets.midcast.FastRecast, {}) 

    -- Idle sets
    sets.idle = {
		ammo="Crepuscular Pebble",
		head="Malignance Chapeau",
		body="Hiza. Haramaki +2",
		hands="Malignance Gloves",
		legs="Malignance Tights",
		feet="Hermes' Sandals",
		neck="Bathy Choker +1",
		waist="Moonbow Belt +1",
		left_ear="Eabani Earring",
		right_ear="Etiolation Earring",
		left_ring="Defending Ring",
		right_ring={ name="Gelatinous Ring +1", augments={'Path: A',}},
		back={ name="Segomo's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','"Dbl.Atk."+10','Phys. dmg. taken-10%',}},
	}

    -- Defense sets
	
	-- Full DT
	-- DEEEEEPS
	sets.defense.PDT = {
	    ammo="Staunch Tathlum +1",
		head="Malignance Chapeau",
		body="Mpaca's Doublet",
		hands="Malignance Gloves",
		legs="Malignance Tights",
		feet="Malignance Boots",
		neck={ name="Mnk. Nodowa +2", augments={'Path: A',}},
		waist="Moonbow Belt +1",
		left_ear="Sherida Earring",
		right_ear={ name="Schere Earring", augments={'Path: A',}},
		left_ring="Niqmaddu Ring",
		right_ring="Gere Ring",
		back={ name="Segomo's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','"Dbl.Atk."+10','Phys. dmg. taken-10%',}},
	}
	
	--Merits+Trait 27. Need 53 to cap
	--Counterstance 45 --Pants+3 +21%
	--[[
	sets.defense.Counter = {}
	
	sets.defense.Counterstance = sets.defense.PDT
	]]--
	
	-- DPS MEVA set... Bhikku Body will overwrite
    sets.defense.MEVA = {}

    -- Engaged sets

    -- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
    -- sets if more refined versions aren't defined.
    -- If you create a set with both offense and defense modes, the offense mode should be first.
    -- EG: sets.engaged.Dagger.Accuracy.Evasion
	
    sets.engaged = {
		ammo={ name="Coiste Bodhar", augments={'Path: A',}},
		head="Mpaca's Cap",
		body="Mpaca's Doublet",
		hands={ name="Adhemar Wrist. +1", augments={'STR+12','DEX+12','Attack+20',}},
		legs="Mpaca's Hose",
		feet="Mpaca's Boots",
		neck={ name="Mnk. Nodowa +2", augments={'Path: A',}},
		waist="Moonbow Belt +1",
		left_ear="Sherida Earring",
		right_ear={ name="Schere Earring", augments={'Path: A',}},
		left_ring="Niqmaddu Ring",
		right_ring="Gere Ring",
		back={ name="Segomo's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','"Dbl.Atk."+10','Phys. dmg. taken-10%',}},
	}
	
	sets.engaged.Acc = set_combine(sets.engaged, {
		hands="Malignance Gloves",
		feet="Malignance Boots",
		})
	
	sets.engaged.Max = set_combine(sets.engaged, {
		head={ name="Adhemar Bonnet +1", augments={'STR+12','DEX+12','Attack+20',}},
		feet={ name="Herculean Boots", augments={'"Triple Atk."+4','STR+5','Accuracy+6','Attack+3',}},
	})
	
	sets.engaged.Impetus = set_combine(sets.engaged, {body="Bhikku Cyclas +1"})	
	sets.engaged.Impetus.Acc = set_combine(sets.engaged.Acc, {body="Bhikku Cyclas +1"})
	sets.engaged.Impetus.Max = set_combine(sets.engaged.Max, {body="Bhikku Cyclas +1"})
	
	sets.engaged.Footwork =  set_combine(sets.engaged, {
	--legs="Hes. Hose +3"
	})	
	sets.engaged.Footwork.Acc = set_combine(sets.engaged.Acc, {
	--legs="Hes. Hose +3"
	})
	sets.engaged.Footwork.Max = set_combine(sets.engaged.Max, {
	--legs="Hes. Hose +3", feet="Anch. Gaiters +3",
	})

	sets.engaged.ImpKicks = set_combine(sets.engaged, {
	--body="Bhikku Cyclas +1", legs="Hes. Hose +3"
	})
	sets.engaged.ImpKicks.Acc = set_combine(sets.engaged.Acc, {
	--body="Bhikku Cyclas +1", legs="Hes. Hose +3"
	})
	sets.engaged.ImpKicks.Max = set_combine(sets.engaged.Max, {
	--body="Bhikku Cyclas +1", legs="Hes. Hose +3", feet="Anch. Gaiters +3"
	})
	
	sets.engaged.HF = set_combine(sets.engaged, {})
	sets.engaged.HF.Acc = set_combine(sets.engaged.Acc, {})
	sets.engaged.HF.Max = set_combine(sets.engaged.Max, {})
	
	sets.engaged.HFimp = set_combine(sets.engaged, {body="Bhikku Cyclas +1",})
	sets.engaged.HFimp.Acc = set_combine(sets.engaged.Acc, {body="Bhikku Cyclas +1",})
	sets.engaged.HFimp.Max = set_combine(sets.engaged.Max, {body="Bhikku Cyclas +1",})
	
	
	--Hybrid Engaged--
	
	sets.Hybrid = {} 
	
	--Hybrid DT
	
	sets.engaged.DT = set_combine(sets.engaged, {
		head="Malignance Chapeau",
		hands="Malignance Gloves",
		feet="Malignance Boots",
		})
	sets.engaged.Acc.DT = set_combine(sets.engaged.DT, {})
	sets.engaged.Max.DT = set_combine(sets.engaged.DT, {
	    head="Mpaca's Cap",
		hands="Mpaca's Gloves",
		legs="Mpaca's Hose",
		feet="Mpaca's Boots",
		left_ring="Defending Ring",
		})
	
	sets.engaged.Impetus.DT = set_combine(sets.engaged.DT, {body="Bhikku Cyclas +1",})
	sets.engaged.Impetus.Acc.DT = set_combine(sets.engaged.Acc.DT, {body="Bhikku Cyclas +1",})
	sets.engaged.Impetus.Max.DT = set_combine(sets.engaged.Max.DT, {body="Bhikku Cyclas +1",})
	
	sets.engaged.Footwork.DT = set_combine(sets.engaged.DT, {})
	sets.engaged.Footwork.Acc.DT = set_combine(sets.engaged.Acc.DT, {})
	sets.engaged.Footwork.Max.DT = set_combine(sets.engaged.Max.DT, {})

	sets.engaged.ImpKicks.DT = set_combine(sets.engaged.DT, {body="Bhikku Cyclas +1",})
	sets.engaged.ImpKicks.Acc.DT = set_combine(sets.engaged.Acc.DT, {body="Bhikku Cyclas +1",})
	sets.engaged.ImpKicks.Max.DT = set_combine(sets.engaged.Max.DT, {body="Bhikku Cyclas +1",})
	
	sets.engaged.HF.DT = set_combine(sets.engaged.DT, {})
	sets.engaged.HF.Acc.DT = set_combine(sets.engaged.Acc.DT, {})
	sets.engaged.HF.Max.DT = set_combine(sets.engaged.Max.DT, {})

	sets.engaged.HFimp.DT = set_combine(sets.engaged.DT, {body="Bhikku Cyclas +1",})
	sets.engaged.HFimp.Acc.DT = set_combine(sets.engaged.Acc.DT, {body="Bhikku Cyclas +1",})
	sets.engaged.HFimp.Max.DT = set_combine(sets.engaged.Max.DT, {body="Bhikku Cyclas +1",})

	
	-- Utility Sets
	sets.buff.Doom = {
		neck = "Nicander's Necklace", --20
		ring1 = "Purity Ring", --10
        ring2 = "Eshmun's Ring", --20
		waist = "Gishdubar Sash" --10
		}
	sets.buff.Boost = {waist="Ask Sash"}
	
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------
moonshade_WS = S{"Raging Fists", "Howling Fist", "Tornado Kick", "Dragon Kick"}
-- Run after the general precast() is done.
function job_post_precast(spell, action, spellMap, eventArgs)
    equip(sets[state.WeaponSet.current])
	if spell.type == 'WeaponSkill' then
        if buffactive.impetus and (spell.english == "Victory Smite" or spell.english == "Ascetic's Fury") then
			if state.OffenseMode.value == 'Acc' or state.WeaponskillMode.value =='Acc' then
				equip(sets.precast.impWS.Acc)
			elseif state.WeaponskillMode.value == 'Attack' then
				equip(sets.precast.impWS.Attack)
			else
				equip(sets.precast.impWS)
			end
		end
		if player.equipment.main == 'Godhands' then
			if moonshade_WS:contains(spell.english) and player.tp < 2200 then  
				equip({head="Mpaca's Cap", right_ear="Moonshade Earring"})
			elseif player.tp < 2450 then
				equip({right_ear="Moonshade Earring"})
			end
		else
			if moonshade_WS:contains(spell.english) and player.tp < 2700 then  
				equip({head="Mpaca's Cap", right_ear="Moonshade Earring"})
			elseif player.tp < 2950 then
				equip({right_ear="Moonshade Earring"})
			end
        end
    end
end

function job_aftercast(spell, action, spellMap, eventArgs)
   equip(sets[state.WeaponSet.current])
   if player.status ~= 'Engaged' then
        check_weaponset()
    end
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for non-casting events.
-------------------------------------------------------------------------------------------------------------------

-- Called when a player gains or loses a buff.
-- buff == buff gained or lost
-- gain == true if the buff was gained, false if it was lost.
function job_buff_change(buff, gain)

    -- Hundred Fists and Impetus modify the custom melee groups
    if buff == "Hundred Fists" or buff == "Footwork" or buff == "Impetus" then
        classes.CustomMeleeGroups:clear()
		
		if buff == "Footwork" and buff == "Impetus" then
			classes.CustomMeleeGroups:append('ImpKicks')
		end
		
		if buff == "Hundred Fists" and buff == "Impetus" then
			classes.CustomMeleeGroups:append('HFimp')
		end
		
        if (buff == "Hundred Fists" and gain) or buffactive['hundred fists'] then
            classes.CustomMeleeGroups:append('HF')
        end
        
        if (buff == "Impetus" and gain) or buffactive.impetus then
			classes.CustomMeleeGroups:append('Impetus')
        end
		
		if (buff == "Footwork" and gain) or buffactive.footwork then
			classes.CustomMeleeGroups:append('Impetus')
		end
		
    end


    -- Update gear if any of the above changed
    if buff == "Hundred Fists" or buff == "Impetus" or buff == "Footwork" or "Boost" then
        handle_equipping_gear(player.status)
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
	
	update_melee_groups()
	
	check_weaponset()
	
end


-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------

function customize_idle_set(idleSet)
    check_weaponset()
	if state.Buff['Boost'] and sets.buff.Boost then
        idleSet = set_combine(idleSet, sets.buff.Boost)
    end
	
    return idleSet
	
end

function customize_melee_set(meleeSet)
check_weaponset()
--[[
 if buffactive.impetus and buffactive.footwork then
	meleeSet = set_combine(meleeSet, sets.ImpKicks)
 end
 
 if state.DefenseMode.value == 'MEVA' or  state.HybridMode.value == 'DT' then
	if buffactive.impetus then
		meleeSet = set_combine(meleeSet, {body="Bhikku Cyclas +1"})
	end
 end
   ]]-- 
	return meleeSet
	
 end
function job_handle_equipping_gear(playerStatus, eventArgs)
    update_combat_form()
    update_melee_groups()
	check_weaponset()
end

function job_update(cmdParams, eventArgs)
    handle_equipping_gear(player.status)
end

function job_self_command(cmdParams, eventArgs)
end

function check_weaponset()
    if state.OffenseMode.value == 'Acc' then
        equip(sets[state.WeaponSet.current].Acc)
    else
        equip(sets[state.WeaponSet.current])
    end
end
-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

function update_combat_form()
	if buffactive['Hundred Fists'] and buffactive.impetus then
		state.CombatForm:set('HFimp')
	elseif buffactive['Hundred Fists'] then
		state.CombatForm:set('HF')
	elseif buffactive.impetus and buffactive.footwork then
		state.CombatForm:set('ImpKicks')
	elseif (buff == "Impetus" and gain) or buffactive.impetus then
		state.CombatForm:set('Impetus')
    elseif (buff == "Footwork" and gain) or buffactive.footwork then
		state.CombatForm:set('Footwork')
    else
        state.CombatForm:reset()
    end
	
end

function update_melee_groups()
    classes.CustomMeleeGroups:clear() 
	
	if buffactive.footwork and not buffactive['hundred fists'] then
        classes.CustomMeleeGroups:append('Footwork')
    end
	
	if buffactive.impetus and buffactive.footwork then
		classes.CustomMeleeGroups:append('ImpKicks')
	end
	
	if buffactive['Hundred Fists'] and buffactive.impetus then
		classes.CustomMeleeGroups:append('HFimp')
	end
	
    if buffactive['hundred fists'] then
        classes.CustomMeleeGroups:append('HF')
    end
	
    if buffactive.impetus then
        classes.CustomMeleeGroups:append('Impetus')
    end

end

-- Function to display the current relevant user state when doing an update.
-- Set eventArgs.handled to true if display was handled, and you don't want the default info shown.
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

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    -- Default macro set/book
    if player.sub_job == 'WAR' then
        set_macro_page(1, 5)
    elseif player.sub_job == 'RUN' then
        set_macro_page(2, 5)
    elseif player.sub_job == 'NIN' then
        set_macro_page(3, 5)
    elseif player.sub_job == 'DNC' then
        set_macro_page(4, 5)
    else
        set_macro_page(5, 5)
    end
end
