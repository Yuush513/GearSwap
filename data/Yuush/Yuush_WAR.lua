----------------------------------------------------------------------------------------------------------
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
	
	state.Buff['Mighty Strikes'] = buffactive['Mighty Strikes'] or false
	state.Buff['Brazen Rush'] = buffactive['Brazen Rush'] or false
	state.Buff['Samurai Roll'] = buffactive['Samurai Roll'] or false
	state.Buff['Fighter\'s Roll'] = buffactive['Fighter\'s Roll'] or false
	state.Buff.SAMroll = buffactive['Samurai Roll'] or false
	state.Buff.WARroll = buffactive['Fighter\'s Roll'] or false
	
end
 
function user_setup()
    -- Options: Override default values
	state.OffenseMode:options('Normal')
	state.HybridMode:options('Normal', 'DT')
	state.WeaponskillMode:options('Normal', 'Attack')
    state.IdleMode:options('Normal', 'DT')
    state.PhysicalDefenseMode:options('PDT','Shield')
    state.MagicalDefenseMode:options('MDT')
	
	state.WeaponSet = M{['description']='Weapon Set', 'Chango', 'Conqueror', 'Montante', 'ShiningOne', 'KajaScythe', 
	'NaeglingDW', 'NaeglingFencer', 'DolichenusDW' ,'DolichenusFencer', 'LoxoticDW', 'LoxoticFencer', 'Karambit'}
	    
	state.WeaponLock = M(false, 'Weapon Lock')
                 
    update_combat_form()
    select_default_macro_book()  
	
	lockstyleset = 20
	set_lockstyle()
	
	send_command('bind @w gs c toggle WeaponLock')
	send_command('bind !f9 gs c cycle WeaponskillMode')
    send_command('bind ^f11 gs c cycle MagicalDefenseMode')
	send_command('bind ^insert gs c cycle WeaponSet')
    send_command('bind ^delete gs c cycleback WeaponSet')
	
end
 
-- Called when this job file is unloaded (eg: job change)
function file_unload()
    send_command('unbind !f9')
    send_command('unbind ^f11')
    send_command('unbind ^insert')
    send_command('unbind ^delete')
	send_command('unbind ^home')
	send_command('unbind ^end')
end


function init_gear_sets()
	--Weapons
	sets.Chango = {main="Chango", sub="Utu Grip"}
	sets.Conqueror = {main="Helheim", sub="Utu Grip"}
	sets.Montante = {main="Montante +1", sub="Utu grip"}	
	sets.ShiningOne = {main="Shining One", sub="Utu Grip"}
	sets.KajaScythe = {main="Drepanum", sub="Utu Grip",}
	sets.NaeglingDW = {main="Naegling", sub="Sangarius +1"}
	sets.NaeglingFencer = {main="Naegling", sub="Blurred Shield +1"}
	sets.DolichenusDW = {main="Dolichenus", sub="Sangarius +1"}	
	sets.DolichenusFencer = {main="Dolichenus", sub="Blurred Shield +1"}
	sets.LoxoticDW = {main="Loxotic Mace +1", sub="Sangarius +1"}
	sets.LoxoticFencer = {main="Loxotic Mace +1", sub="Blurred Shield +1"}
	sets.Karambit = {main="Karambit"}
	
	
	-- Enmity Sets
	sets.Enmity = {
		ammo = "Sapience Orb", --2
		head = "Pummeler's Mask +3", --9(12)
		neck = "Unmoving Collar +1", --10
		ear1 = "Trux Earring", --5
		ear2 = "Cryptic Earring", --4
		body = "Souv. Cuirass +1", --20
		hands = "Pumm. Mufflers +3", --15
		ring1 = "Supershear Ring", --5
		ring2 = "Eihwaz Ring", --5
		back = Cichol.Enmity, --10
		waist = "Trance Belt", --4
		legs = "Souv. Diechlings +1", --9
		feet = "Eschite Greaves", --15
		}
	
	-- Precast sets for JA
    sets.precast.JA['Berserk'] = {feet="Agoge Calligae +3", body="Pummeler's Lorica +3", back="Cichol's Mantle"}
	sets.precast.JA['Defender'] = {hands = "Agoge Mufflers +3"}
    sets.precast.JA['Warcry'] = set_combine(sets. Enmity, {head="Agoge Mask +3"})
    sets.precast.JA['Aggressor'] = {body="Agoge Lorica +1", head="Pummeler's Mask +3", body = "Agoge Lorica +3"}
    sets.precast.JA['Blood Rage'] = set_combine(sets. Enmity, {body="Boii Lorica +3"})
    sets.precast.JA['Retaliation'] = {hands = "Pumm. Mufflers +3", feet="Boii Calligae +3"}
    sets.precast.JA['Restraint'] = {}
    sets.precast.JA['Mighty Strikes'] = {hands="Agoge Mufflers +3"}
    sets.precast.JA["Warrior's Charge"] = {legs = "Agoge Cuisses +3"}
    sets.precast.JA['Provoke'] = sets.Enmity
	sets.precast.JA['Tomahawk'] = {ammo="Thr. Tomahawk", feet="Agoge calligae +3"}
 
	sets.precast.FC = {
		ammo="Sapience Orb",
		head="Sakpata's Helm",
		body="Sacro Breastplate",
		hands="Leyline Gloves", 
		legs="Eschite Cuisses",
		feet="Odyssean Greaves",
		neck="Orunmila's Torque",
		left_ear="Loquac. Earring",
		right_ear="Etiolation Earring",
		}

	sets.midcast['Flash'] = sets.Enmity
        
    ------------------------------------------------------------------------------------------------
    ------------------------------------- Weapon Skill Sets ----------------------------------------
    ------------------------------------------------------------------------------------------------

    sets.precast.WS = {}
    
	sets.precast.WS.Attack = {}
	
	sets.precast.WS.MS = {}
	
	sets.precast.WS.BRMS = {}
	
	--Moonshade Slot 2
	--Great Axe--
	
	sets.precast.WS['Upheaval']= {
		ammo="Knobkierrie",
		head="Sakpata's Helm",
		body="Sakpata's Plate",
		hands="Sakpata's Gauntlets",
		legs="Boii Cuisses +3",
		feet={ name="Nyame Sollerets", augments={'Path: B',}},
		neck={ name="War. Beads +2", augments={'Path: A',}},
		waist={ name="Sailfi Belt +1", augments={'Path: A',}},
		left_ear={ name="Lugra Earring +1", augments={'Path: A',}},
		right_ear="Thrud Earring",
		left_ring="Cornelia's Ring",
		right_ring="Niqmaddu Ring",
		back={ name="Cichol's Mantle", augments={'VIT+20','Accuracy+20 Attack+20','VIT+10','Weapon skill damage +10%','Phys. dmg. taken-10%',}},
		}

    sets.precast.WS['Upheaval'].Attack = set_combine(sets.precast.WS['Upheaval'],{
		head={ name="Agoge Mask +3", augments={'Enhances "Savagery" effect',}},
		body={ name="Nyame Mail", augments={'Path: B',}},
		hands="Boii Mufflers +3",
	})
	
	sets.precast.WS['Upheaval'].MS = set_combine(sets.precast.WS['Upheaval'], {
		ammo = "Yetshila",
		feet = "Boii Calligae +3"
		})
	
	sets.precast.WS['Upheaval'].BRMS = set_combine(sets.precast.WS['Upheaval'], {
		ammo = "Yetshila",
		neck = "Unmoving Collar +1",
		feet = "Boii Calligae +3"
		})
	
	sets.precast.WS['Raging Rush'] = {
		ammo="Yetshila",
		head="Boii Mask +3",
		body="Sakpata's Plate",
		hands="Sakpata's Gauntlets",
		legs="Boii Cuisses +3",
		feet="Boii Calligae +3",
		neck={ name="War. Beads +2", augments={'Path: A',}},
		waist={ name="Sailfi Belt +1", augments={'Path: A',}},
		left_ear="Schere Earring",
		right_ear={ name="Boii Earring +1", augments={'System: 1 ID: 1676 Val: 0','Accuracy+15','Mag. Acc.+15','Crit.hit rate+5',}},
		left_ring="Sroda Ring",
		right_ring="Niqmaddu Ring",
		back={ name="Cichol's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Crit.hit rate+10',}},
	}
	
	sets.precast.WS['Raging Rush'].Attack = set_combine(sets.precast.WS['Raging Rush'], {
		hands="Boii Mufflers +3",
		left_ring="Sroda Ring",
	})
	
	sets.precast.WS['Raging Rush'].MS = set_combine(sets.precast.WS['Raging Rush'], {})
	
	sets.precast.WS['Raging Rush'].BRMS = sets.precast.WS['Raging Rush'].MS
	
	sets.precast.WS['King\'s Justice'] = {
		ammo="Knobkierrie",
		head={ name="Agoge Mask +3", augments={'Enhances "Savagery" effect',}},
		body="Sakpata's Plate",
		hands="Sakpata's Gauntlets",
		legs="Boii Cuisses +3",
		feet={ name="Nyame Sollerets", augments={'Path: B',}},
		neck={ name="War. Beads +2", augments={'Path: A',}},
		waist={ name="Sailfi Belt +1", augments={'Path: A',}},
		left_ear={ name="Lugra Earring +1", augments={'Path: A',}},
		right_ear="Thrud Earring",
		left_ring="Sroda Ring",
		right_ring="Cornelia's Ring",
		back={ name="Cichol's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%','Phys. dmg. taken-10%',}},
	}
	sets.precast.WS['King\'s Justice'].Attack = set_combine(sets.precast.WS['King\'s Justice'], {
		body={ name="Nyame Mail", augments={'Path: B',}},
		hands="Boii Mufflers +3",
		left_ring="Cornelia's Ring",
		right_ring="Niqmaddu Ring",
	})
	sets.precast.WS['King\'s Justice'].MS = set_combine(sets.precast.WS['King\'s Justice'], {
		ammo = "Yetshila",
		feet = "Boii Calligae +3"
	})
		
	sets.precast.WS['King\'s Justice'].BRMS = sets.precast.WS['King\'s Justice'].MS
	
	sets.precast.WS['Ukko\'s fury'] = sets.precast.WS['Raging Rush']
	sets.precast.WS['Ukko\'s fury'].Attack = sets.precast.WS['Raging Rush'].Attack
	sets.precast.WS['Ukko\'s fury'].MS = sets.precast.WS['Raging Rush'].MS
	sets.precast.WS['Ukko\'s fury'].BRMS = sets.precast.WS['Raging Rush'].BRMS
	
	sets.precast.WS['Full Break'] = {
		ammo="Knobkierrie",
		head="Boii Mask +3",
		body="Boii Lorica +3",
		hands="Boii Mufflers +3",
		legs="Boii Cuisses +3",
		feet="Boii Calligae +3",
		neck="Fotia Gorget",
		waist="Fotia Belt",
		left_ear="Digni. Earring",
		right_ear={ name="Boii Earring +1", augments={'System: 1 ID: 1676 Val: 0','Accuracy+15','Mag. Acc.+15','Crit.hit rate+5',}},
		left_ring="Cornelia's Ring",
		right_ring="Flamma Ring",
		back={ name="Cichol's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%','Phys. dmg. taken-10%',}},
		}
	sets.precast.WS['Shield Break'] = set_combine(sets.precast.WS['Full Break'],{})
	sets.precast.WS['Armor Break'] = set_combine(sets.precast.WS['Full Break'],{})
	sets.precast.WS['Weapon Break'] = set_combine(sets.precast.WS['Full Break'],{})
	
	--Great Sword--
	
    sets.precast.WS['Resolution'] = {	
		ammo="Seeth. Bomblet +1",
		head="Boii Mask +3",
		body="Sakpata's Plate",
		hands="Sakpata's Gauntlets",
		legs="Sakpata's Cuisses",
		feet="Sakpata's Leggings",
		neck="Fotia Gorget",
		waist="Fotia Belt",
		left_ear="Lugra Earring +1",
		right_ear="Schere Earring",
		left_ring="Sroda Ring",
		right_ring="Niqmaddu Ring",
		back=Cichol.STR_DA,	
		}
	
    sets.precast.WS['Resolution'].Attack = set_combine(sets.precast.WS['Resolution'], {
		body="Agoge Lorica +3",
		left_ring="Regal Ring",
		})


	sets.precast.WS['Resolution'].MS = set_combine(sets.precast.WS['Resolution'], {
		ammo = "Yetshila",
		feet = "Boii Calligae +3"
		})
	
	sets.precast.WS['Resolution'].BRMS = set_combine(sets.precast.WS['Resolution'], {
		ammo = "Yetshila",
		feet = "Boii Calligae +3"
		})
	
	--Polearm--
	sets.precast.WS['Impulse Drive'] = {
		ammo="Yetshila",
		head={ name="Blistering Sallet +1", augments={'Path: A',}},
		body="Sakpata's Plate",
		hands="Boii Mufflers +3",
		legs="Boii Cuisses +3",
		feet="Boii Calligae +3",
		neck={ name="War. Beads +2", augments={'Path: A',}},
		waist={ name="Sailfi Belt +1", augments={'Path: A',}},
		left_ear="Thrud Earring",
		right_ear={ name="Boii Earring +1", augments={'System: 1 ID: 1676 Val: 0','Accuracy+15','Mag. Acc.+15','Crit.hit rate+5',}},
		left_ring="Sroda Ring",
		right_ring="Cornelia's Ring",
		back={ name="Cichol's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%','Phys. dmg. taken-10%',}},
		}	
	sets.precast.WS['Impulse Drive'].Attack = set_combine(sets.precast.WS['Impulse Drive'], {
		head="Boii Mask +3",
		body="Hjarrandi Breast.",
		left_ring="Cornelia's Ring",
		right_ring="Niqmaddu Ring",
		back={ name="Cichol's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Crit.hit rate+10',}},
		})	
	sets.precast.WS['Impulse Drive'].MS = set_combine(sets.precast.WS['Impulse Drive'], {})	
	sets.precast.WS['Impulse Drive'].BRMS = sets.precast.WS['Impulse Drive'].MS
	
	sets.precast.WS['Stardiver'] = {
	    ammo="Yetshila",
		head={ name="Blistering Sallet +1", augments={'Path: A',}},
		body="Sakpata's Plate",
		hands="Sakpata's Gauntlets",
		legs="Boii Cuisses +3",
		feet="Boii Calligae +3",
		neck="Fotia Gorget",
		waist="Fotia Belt",
		left_ear="Schere Earring",
		right_ear={ name="Boii Earring +1", augments={'System: 1 ID: 1676 Val: 0','Accuracy+15','Mag. Acc.+15','Crit.hit rate+5',}},
		left_ring="Sroda Ring",
		right_ring="Niqmaddu Ring",
		back={ name="Cichol's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Crit.hit rate+10',}},
		}
	sets.precast.WS['Stardiver'].Attack = set_combine(sets.precast.WS['Stardiver'],{
		head="Boii Mask +3",
		body="Hjarrandi Breast.",
		hands="Flam. Manopolas +2",
		left_ring="Regal Ring",
		})
	sets.precast.WS['Stardiver'].MS = set_combine(sets.precast.WS['Stardiver'], {})
	sets.precast.WS['Stardiver'].BRMS = set_combine(sets.precast.WS['Stardiver'], {})
	
	sets.precast.WS['Sonic Thrust'] = {
		ammo="Knobkierrie",
		head="Sakpata's Helm",
		body="Sakpata's Plate",
		hands="Sakpata's Gauntlets",
		legs="Sakpata's Cuisses",
		feet="Sakpata's Leggings",
		neck="War. Beads +2",
		waist="Fotia Belt",
		left_ear="Lugra Earring +1",
		right_ear="Thrud Earring",
		left_ring="Regal Ring",
		right_ring="Niqmaddu Ring",
		back=Cichol.STR_WSD,
		} 
		
	sets.precast.WS['Sonic Thrust'].Attack = set_combine(sets.precast.WS['Sonic Thrust'], {
		head="Agoge Mask +3",
		body="Pumm. Lorica +3",
		hands=OdysseanHands.WSD,
		legs=ValorousLegs.WSD,
		feet="Sulev. Leggings +2",
		})
		
	sets.precast.WS['Sonic Thrust'].MS = set_combine(sets.precast.WS['Sonic Thrust'], {})
	sets.precast.WS['Sonic Thrust'].BRMS = set_combine(sets.precast.WS['Sonic Thrust'], {})
	
	sets.precast.WS['Leg Sweep'] = sets.precast.WS['Full Break']

	--Axe
    sets.precast.WS['Decimation'] = {
		ammo={ name="Coiste Bodhar", augments={'Path: A',}},
		head="Sakpata's Helm",
		body="Sakpata's Plate",
		hands="Sakpata's Gauntlets",
		legs="Sakpata's Cuisses",
		feet="Sakpata's Leggings",
		neck="Fotia Gorget",
		waist="Fotia Belt",
		left_ear="Schere Earring",
		right_ear={ name="Boii Earring +1", augments={'System: 1 ID: 1676 Val: 0','Accuracy+15','Mag. Acc.+15','Crit.hit rate+5',}},
		left_ring="Sroda Ring",
		right_ring="Niqmaddu Ring",
		back={ name="Cichol's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}},
		}
	
	sets.precast.WS['Decimation'].Attack = set_combine(sets.precast.WS['Decimation'], {
		head="Boii Mask +3",
		body={ name="Agoge Lorica +3", augments={'Enhances "Aggressive Aim" effect',}},
		hands="Boii Mufflers +3",
		legs="Boii Cuisses +3",
		feet="Pumm. Calligae +3",
		neck={ name="War. Beads +2", augments={'Path: A',}},
		waist={ name="Sailfi Belt +1", augments={'Path: A',}},
		left_ring="Regal Ring",
	})
	
	sets.precast.WS['Decimation'].MS = set_combine(sets.precast.WS['Decimation'], {
		ammo = "Yetshila",
		feet = "Boii Calligae +3"
	})
	
	sets.precast.WS['Decimation'].BRMS = set_combine(sets.precast.WS['Decimation'], {
		ammo = "Yetshila",
		feet = "Boii Calligae +3"
	})
	
	sets.precast.WS['Ruinator'] = sets.precast.WS['Resolution']
	
	sets.precast.WS['Cloudsplitter'] = {
		ammo={ name="Seeth. Bomblet +1", augments={'Path: A',}},
		head="Nyame Helm",
		body={ name="Nyame Mail", augments={'Path: B',}},
		hands={ name="Nyame Gauntlets", augments={'Path: B',}},
		legs={ name="Nyame Flanchard", augments={'Path: B',}},
		feet={ name="Nyame Sollerets", augments={'Path: B',}},
		neck="Sibyl Scarf",
		waist="Eschan Stone",
		left_ear="Thrud Earring",
		right_ear="Friomisi Earring",
		left_ring="Regal Ring",
		right_ring="Cornelia's Ring",
		back={ name="Cichol's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%','Phys. dmg. taken-10%',}},
	}
	
	--Sword--
    sets.precast.WS['Savage Blade'] = {
		ammo="Knobkierrie",
		head={ name="Agoge Mask +3", augments={'Enhances "Savagery" effect',}},
		body="Sakpata's Plate",
		hands="Boii Mufflers +3",
		legs="Boii Cuisses +3",
		feet={ name="Nyame Sollerets", augments={'Path: B',}},
		neck={ name="War. Beads +2", augments={'Path: A',}},
		waist={ name="Sailfi Belt +1", augments={'Path: A',}},
		left_ear={ name="Lugra Earring +1", augments={'Path: A',}},
		right_ear="Thrud Earring",
		left_ring="Cornelia's Ring",
		right_ring="Sroda Ring",
		back={ name="Cichol's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%','Phys. dmg. taken-10%',}},
		}
	
	sets.precast.WS['Savage Blade'].Attack = set_combine(sets.precast.WS['Savage Blade'], {
		body={ name="Nyame Mail", augments={'Path: B',}},
		legs={ name="Nyame Flanchard", augments={'Path: B',}},
		right_ring="Regal Ring",
	})
	
	sets.precast.WS['Savage Blade'].MS = set_combine(sets.precast.WS['Savage Blade'], {
		ammo = "Yetshila",
		feet = "Boii Calligae +3"
	})
		
	sets.precast.WS['Savage Blade'].BRMS = sets.precast.WS['Savage Blade'].MS
	
	--Club--
	sets.precast.WS['Judgement'] = sets.precast.WS['Savage Blade']
	sets.precast.WS['Judgement'].Attack = sets.precast.WS['Savage Blade'].Attack
	sets.precast.WS['Judgement'].MS = sets.precast.WS['Savage Blade'].MS
	sets.precast.WS['Judgement'].BRMS = sets.precast.WS['Savage Blade'].BRMS
		
	sets.precast.WS['Black Halo'] = set_combine(sets.precast.WS['Judgement'], {})
	
	--H2H--
	
	sets.precast.WS['Raging Fists'] = {
		ammo="Coiste Bodhar",
		head="Sakpata's Helm",
		body="Sakpata's Plate",
		hands="Sakpata's Gauntlets",
		legs="Sakpata's Cuisses",
		feet="Sakpata's Leggings",
		neck="Fotia Gorget",
		waist="Fotia Belt",
		left_ear="Brutal Earring",
		right_ear="Schere Earring",
		left_ring="Regal Ring",
		right_ring="Niqmaddu Ring",
		back=Cichol.STR_DA,
		}
		
	sets.precast.WS['Raging Fists'].Attack = set_combine(sets.precast.WS['Raging Fists'], {
	    head="Flam. Zucchetto +2",
		body="Tatena. Harama. +1",
		hands="Tatena. Gote +1",
		legs="Pumm. Cuisses +3",
		feet="Pumm. Calligae +3",
		})
	
	sets.precast.WS['Raging Fists'].MS = set_combine(sets.precast.WS['Raging Fists'], {feet = "Boii Calligae +3"})
	sets.precast.WS['Raging Fists'].BRMS = set_combine(sets.precast.WS['Raging Fists'], {feet = "Boii Calligae +3"})
	
	------------------------------------------------------------------------------------------------
    ---------------------------------------- Midcast Sets ------------------------------------------
    ------------------------------------------------------------------------------------------------

	sets.midcast.FastRecast = set_combine(sets.precast.FC, {
		})

	------------------------------------------------------------------------------------------------
    ---------------------------------------- Engaged Sets ------------------------------------------
    ------------------------------------------------------------------------------------------------
	
	--2Handed
	sets.engaged = {
		ammo={ name="Coiste Bodhar", augments={'Path: A',}},
		head="Boii Mask +3",
		body="Boii Lorica +3",
		hands="Sakpata's Gauntlets",
		legs="Pumm. Cuisses +3",
		feet="Pumm. Calligae +3",
		neck={ name="War. Beads +2", augments={'Path: A',}},
		waist={ name="Sailfi Belt +1", augments={'Path: A',}},
		left_ear="Schere Earring",
		right_ear="Boii Earring +1",
		left_ring="Moonlight Ring",
		right_ring="Niqmaddu Ring",
		back={ name="Cichol's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}},
		}
	sets.engaged.SAM = set_combine(sets.engaged, {})	
	sets.engaged.FR = set_combine(sets.engaged, {})	
	sets.engaged.SAMFR = set_combine(sets.engaged,{})
	
	--DualWield
	sets.engaged.DW = {
		ammo="Coiste Bodhar",
		head="Hjarrandi Helm",
		body="Emicho Haubert +1",
		hands="Emi. Gauntlets +1",
		legs="Pumm. Cuisses +3",
		feet="Pumm. Calligae +3",
		neck="War. Beads +2",
		waist="Sailfi Belt +1",
		left_ear="Schere Earring",
		right_ear="Suppanomimi",
		left_ring="Petrov Ring",
		right_ring="Niqmaddu Ring",
		back=Cichol.DEX_DA,
		}
	sets.engaged.DW.SAM = set_combine(sets.engaged.DW, {})
	sets.engaged.DW.FR = set_combine(sets.engaged.DW, {
	    head="Flam. Zucchetto +2",
		body="Tatena. Harama. +1",
		})
	sets.engaged.DW.SAMFR = set_combine(sets.engaged.DW, {
		head="Flam. Zucchetto +2",
		body="Tatena. Harama. +1",
		})
	
	--SingleWield
	sets.engaged.Fencer = {}
	sets.engaged.Fencer.SAM = {}
	sets.engaged.Fencer.FR = {}
	sets.engaged.Fencer.SAMFR = {}
	
	--GreatAxe--
	sets.engaged.Chango = set_combine(sets.engaged,{})
	sets.engaged.Chango.SAM = set_combine(sets.engaged.SAM,{})
	sets.engaged.Chango.FR = set_combine(sets.engaged.FR, {})
	sets.engaged.Chango.SAMFR = set_combine(sets.engaged.SAMFR,{})
	
	sets.engaged.Conqueror = set_combine(sets.engaged,{})
	sets.engaged.Conqueror.SAM = set_combine(sets.engaged.SAM,{})
	sets.engaged.Conqueror.FR = set_combine(sets.engaged.FR, {})
	sets.engaged.Conqueror.SAMFR = set_combine(sets.engaged.SAMFR,{})
	
	--GreatSword--
	sets.engaged.Montante = set_combine(sets.engaged, {})	
	sets.engaged.Montante.SAM = set_combine(sets.engaged.SAM,{})
	sets.engaged.Montante.FR = set_combine(sets.engaged.FR, {})	
	sets.engaged.Montante.SAMFR = set_combine(sets.engaged.SAMFR, {})

	--PokeyStick--
	sets.engaged.ShiningOne = set_combine(sets.engaged, {})	
	sets.engaged.ShiningOne.SAM = set_combine(sets.engaged.SAM,{})
	sets.engaged.ShiningOne.FR = set_combine(sets.engaged.FR, {})
	sets.engaged.ShiningOne.SAMFR = set_combine(sets.engaged.SAMFR, {})

	--Scythe--
	sets.engaged.KajaScythe = set_combine(sets.engaged,{})
	sets.engaged.KajaScythe.SAM = set_combine(sets.engaged.SAM,{})
	sets.engaged.KajaScythe.FR = set_combine(sets.engaged,{})
	sets.engaged.KajaScythe.SAMFR = set_combine(sets.engaged,{})
	
	--Axe--
	sets.engaged.DolichenusDW = set_combine(sets.engaged.DW, {})
	sets.engaged.DolichenusDW.SAM = set_combine(sets.engaged.SAM,{})
	sets.engaged.DolichenusDW.FR = set_combine(sets.engaged.FR, {})
	sets.engaged.DolichenusDW.SAMFR = set_combine(sets.engaged.SAMFR, {})
	
	sets.engaged.DolichenusFencer = set_combine(sets.engaged.Fencer, {})
	sets.engaged.DolichenusFencer.SAM = set_combine(sets.engaged.SAM,{})
	sets.engaged.DolichenusFencer.FR = set_combine(sets.engaged.Fencer.FR, {})
	sets.engaged.DolichenusFencer.SAMFR = set_combine(sets.engaged.Fencer.SAMFR, {})
	
	--Sword--
	sets.engaged.NaeglingDW = set_combine(sets.engaged.DW, {})
	sets.engaged.NaeglingDW.SAM = set_combine(sets.engaged.SAM,{})
	sets.engaged.NaeglingDW.FR = set_combine(sets.engaged.FR, {})
	sets.engaged.NaeglingDW.SAMFR = set_combine(sets.engaged.SAMFR, {})
	
	sets.engaged.NaeglingFencer = set_combine(sets.engaged.Fencer, {})
	sets.engaged.NaeglingFencer.SAM = set_combine(sets.engaged.SAM,{})
	sets.engaged.NaeglingFencer.FR = set_combine(sets.engaged.Fencer.FR, {})
	sets.engaged.NaeglingFencer.SAMFR = set_combine(sets.engaged.Fencer.SAMFR, {})
	
	--Club--
	sets.engaged.LoxoticDW = set_combine(sets.engaged.DW, {})
	sets.engaged.LoxoticDW.SAM = set_combine(sets.engaged.SAM,{})
	sets.engaged.LoxoticDW.FR = set_combine(sets.engaged.FR, {})
	sets.engaged.LoxoticDW.SAMFR = set_combine(sets.engaged.SAMFR, {})
	
	sets.engaged.LoxoticFencer = set_combine(sets.engaged.Fencer, {})
	sets.engaged.LoxoticFencer.SAM = set_combine(sets.engaged.SAM,{})
	sets.engaged.LoxoticFencer.FR = set_combine(sets.engaged.Fencer.FR, {})
	sets.engaged.LoxoticFencer.SAMFR = set_combine(sets.engaged.Fencer.SAMFR, {})
	
	
	--Hand2Hand--
	sets.engaged.Karambit = set_combine(sets.engaged, {})
	sets.engaged.Karambit.SAM = set_combine(sets.engaged.SAM, {})
	sets.engaged.Karambit.FR = set_combine(sets.engaged.FR, {})
	sets.engaged.Karambit.SAMFR = set_combine(sets.engaged.SAMFR, {})
	
	
	sets.Hybrid = {
		head="Sakpata's Helm",
		body="Sakpata's Plate",
		hands="Sakpata's Gauntlets",
		legs="Sakpata's Cuisses",
		feet="Sakpata's Leggings",
		waist="Sailfi Belt +1",
		neck="War. Beads +2",
		}

	sets.engaged.DT = set_combine(sets.engaged, sets.Hybrid)		
    sets.engaged.SAM.DT = set_combine(sets.engaged.SAM, sets.Hybrid)
	sets.engaged.FR.DT = set_combine(sets.engaged.DT, sets.Hybrid)		
    sets.engaged.SAMFR.DT = set_combine(sets.engaged.SAMFR, sets.Hybrid)
	
	sets.engaged.DW.DT = set_combine(sets.engaged.DW, sets.Hybrid)
	sets.engaged.DW.SAM.DT = set_combine(sets.engaged.DW.SAM, sets.Hybrid)
	sets.engaged.DW.FR.DT = set_combine(sets.engaged.DW.FR, sets.Hybrid)		
    sets.engaged.DW.SAMFR.DT = set_combine(sets.engaged.DW.SAMFR, sets.Hybrid)
	
	sets.engaged.Fencer.DT = set_combine(sets.engaged.Fencer, sets.Hybrid)
    sets.engaged.Fencer.SAM.DT = set_combine(sets.engaged.Fencer.SAM, sets.Hybrid)	
	sets.engaged.Fencer.FR.DT = set_combine(sets.engaged.Fencer.FR, sets.Hybrid)		
    sets.engaged.Fencer.SAMFR.DT = set_combine(sets.engaged.Fencer.SAMFR, sets.Hybrid)
	
	sets.engaged.Chango.DT = set_combine(sets.engaged.DT, {})
    sets.engaged.Chango.SAM.DT = set_combine(sets.engaged.SAM, sets.Hybrid)
	sets.engaged.Chango.FR.DT = set_combine(sets.engaged.FR.DT, {})
	sets.engaged.Chango.SAMFR.DT = set_combine(sets.engaged.SAMFR.DT, {})
	
	sets.engaged.Conqueror.DT = set_combine(sets.engaged.DT, {})
    sets.engaged.Conqueror.SAM.DT = set_combine(sets.engaged.SAM, sets.Hybrid)
	sets.engaged.Conqueror.FR.DT = set_combine(sets.engaged.FR.DT, {})
	sets.engaged.Conqueror.SAMFR.DT = set_combine(sets.engaged.SAMFR.DT, {})
	
	sets.engaged.Montante.DT = set_combine(sets.engaged.DT, {})
    sets.engaged.Montante.SAM.DT = set_combine(sets.engaged.SAM, sets.Hybrid)
	sets.engaged.Montante.FR.DT = set_combine(sets.engaged.FR.DT, {})
	sets.engaged.Montante.SAMFR.DT = set_combine(sets.engaged.SAMFR.DT, {})
	
	sets.engaged.ShiningOne.DT = set_combine(sets.engaged.DT, {})
    sets.engaged.ShiningOne.SAM.DT = set_combine(sets.engaged.SAM, sets.Hybrid)
	sets.engaged.ShiningOne.FR.DT = set_combine(sets.engaged.FR.DT, {})
	sets.engaged.ShiningOne.SAMFR.DT = set_combine(sets.engaged.SAMFR.DT, {})
		
	sets.engaged.KajaScythe.DT = set_combine(sets.engaged.DT,{})
    sets.engaged.KajaScythe.SAM.DT = set_combine(sets.engaged.SAM, sets.Hybrid)
	sets.engaged.KajaScythe.FR.DT = set_combine(sets.engaged.FR.DT,{})
	sets.engaged.KajaScythe.SAMFR.DT = set_combine(sets.engaged.SAMFR.DT,{})	
		
	sets.engaged.DolichenusDW.DT = set_combine(sets.engaged.DW.DT, {})
    sets.engaged.DolichenusDW.SAM.DT = set_combine(sets.engaged.DW.SAM.DT, sets.Hybrid)
	sets.engaged.DolichenusDW.FR.DT = set_combine(sets.engaged.DW.FR.DT, {})
	sets.engaged.DolichenusDW.SAMFR.DT = set_combine(sets.engaged.DW.SAMFR.DT, {})
	
	sets.engaged.DolichenusFencer.DT = set_combine(sets.engaged.Fencer.DT, {})
    sets.engaged.DolichenusFencer.SAM.DT = set_combine(sets.engaged.Fencer.SAM.DT, sets.Hybrid)
	sets.engaged.DolichenusFencer.FR = set_combine(sets.engaged.Fencer.FR.DT, {})
	sets.engaged.DolichenusFencer.SAMFR = set_combine(sets.engaged.Fencer.SAMFR.DT, {})
		
	sets.engaged.NaeglingDW.DT = set_combine(sets.engaged.DW.DT, {})
    sets.engaged.NaeglingDW.SAM.DT = set_combine(sets.engaged.DW.SAM.DT, sets.Hybrid)
	sets.engaged.NaeglingDW.FR = set_combine(sets.engaged.DW.FR.DT, {})
	sets.engaged.NaeglingDW.SAMFR = set_combine(sets.engaged.DW.SAMFR.DT, {})
	
	sets.engaged.NaeglingFencer.DT = set_combine(sets.engaged.Fencer.DT, {})
    sets.engaged.NaeglingFencer.SAM.DT = set_combine(sets.engaged.Fencer.SAM.DT, {})
	sets.engaged.NaeglingFencer.FR = set_combine(sets.engaged.Fencer.FR.DT, {})
	sets.engaged.NaeglingFencer.SAMFR = set_combine(sets.engaged.Fencer.SAMFR.DT, {})
		
	sets.engaged.LoxoticDW.DT = set_combine(sets.engaged.DW.DT, {})
    sets.engaged.LoxoticDW.SAM.DT = set_combine(sets.engaged.DW.SAM.DT, sets.Hybrid)
	sets.engaged.LoxoticDW.FR = set_combine(sets.engaged.DW.FR.DT, {})
	sets.engaged.LoxoticDW.SAMFR = set_combine(sets.engaged.DW.SAMFR.DT, {})
	
	sets.engaged.LoxoticFencer.DT = set_combine(sets.engaged.Fencer.DT, {})
    sets.engaged.LoxoticFencer.SAM.DT = set_combine(sets.engaged.Fencer.SAM.DT, sets.Hybrid)
	sets.engaged.LoxoticFencer.FR = set_combine(sets.engaged.Fencer.FR.DT, {})
	sets.engaged.LoxoticFencer.SAMFR = set_combine(sets.engaged.Fencer.SAMFR.DT, {})
		
	sets.engaged.Karambit.DT = set_combine(sets.engaged.DT, {})
	sets.engaged.Karambit.SAM.DT = set_combine(sets.engaged.SAM.DT, sets.Hybrid)
	sets.engaged.Karambit.FR.DT = set_combine(sets.engaged.FR.DT, {})
	sets.engaged.Karambit.SAMFR.DT = set_combine(sets.engaged.SAMFR.DT, {})

	------------------------------------------------------------------------------------------------
    ---------------------------------------- Defense Sets ------------------------------------------
    ------------------------------------------------------------------------------------------------
	 
    sets.defense.PDT = {
		ammo="Seeth. Bomblet +1",
		head="Sakpata's Helm",
		body="Sakpata's Plate",
		hands="Sakpata's Gauntlets",
		legs="Sakpata's Cuisses",
		feet="Sakpata's Leggings",
		neck="Warder's Charm +1",
		waist="Engraved Belt",
		left_ear="Odnowa Earring +1",
		right_ear="Sanare Earring",
		left_ring="Defending Ring",
		right_ring="Shadow Ring",
		back=Cichol.MEVA,
		}    
	
	sets.defense.MDT = sets.defense.PDT
	
	------------------------------------------------------------------------------------------------
    ---------------------------------------- Idle Sets ------------------------------------------
    ------------------------------------------------------------------------------------------------
	
	sets.idle = {
		ammo="Staunch Tathlum +1",
		head="Sakpata's Helm",
		body="Sacro Breastplate",
		hands="Sakpata's Gauntlets",
		legs="Sakpata's Cuisses",
		feet="Sakpata's Leggings",
		neck="Elite Royal Collar",
		waist="Engraved Belt",
		left_ear="Eabani Earring",
		right_ear="Sanare Earring",
		left_ring="Defending Ring",
		right_ring="Shneddick Ring +1",
		back={ name="Cichol's Mantle", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','Enmity+10','Damage taken-5%',}},
		}

	sets.idle.DT = set_combine(sets.idle, {})
	
	sets.Phalanx = {    
		ammo="Staunch Tathlum +1",
		head={ name="Valorous Mask", augments={'DEX+11','Pet: Accuracy+29 Pet: Rng. Acc.+29','Phalanx +4','Mag. Acc.+6 "Mag.Atk.Bns."+6',}},
		body={ name="Valorous Mail", augments={'Pet: DEX+9','DEX+10','Phalanx +4',}},
		hands={ name="Souv. Handsch. +1", augments={'HP+65','Shield skill +15','Phys. dmg. taken -4',}},
		legs="Sakpata's Cuisses",
		feet={ name="Souveran Schuhs +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
		neck={ name="Loricate Torque +1", augments={'Path: A',}},
		waist="Engraved Belt",
		left_ear={ name="Odnowa Earring +1", augments={'Path: A',}},
		right_ear="Etiolation Earring",
		left_ring="Defending Ring",
		right_ring="Shneddick Ring +1",
		back={ name="Cichol's Mantle", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','Enmity+10','Damage taken-5%',}},
	}

    sets.Doom = {
		neck = "Nicander's Necklace", --20
		ring1 = "Eshmun's Ring", --20
        ring2 = "Purity Ring", --7
        waist = "Gishdubar Sash", --10
		legs = "Shabti Cuisses +1", --15
	}
	
	sets.Phalanx={
	    head={ name="Valorous Mask", augments={'DEX+11','Pet: Accuracy+29 Pet: Rng. Acc.+29','Phalanx +4','Mag. Acc.+6 "Mag.Atk.Bns."+6',}},
		body={ name="Valorous Mail", augments={'Pet: DEX+9','DEX+10','Phalanx +4',}},
		hands={ name="Souv. Handsch. +1", augments={'HP+65','Shield skill +15','Phys. dmg. taken -4',}},
		legs="Sakpata's Cuisses",
		feet={ name="Souveran Schuhs +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
	}
	
end
 
-- Job-specific hooks for standard casting events.
moonshade_WS = S{"Resolution", "Upheaval", "Savage Blade", "Impulse Drive", "Stardiver", 'Judgement',}
 
function job_post_precast(spell, action, spellMap, eventArgs)
	equip(sets[state.WeaponSet.current])
	--equip(sets[state.ShieldSet.current])
	
    if spell.type == 'WeaponSkill' then
--        if world.time >= (17*60) or world.time <= (7*60) then
--            equip({ear1="Lugra Earring +1",})
--        end
        if moonshade_WS:contains(spell.english) and player.tp<2950 then  
            equip({left_ear="Moonshade Earring"})
        end
    end
end

function job_midcast(spell, action, spellMap, eventArgs)
  
end
 

function job_post_midcast(spell, action, spellMap, eventArgs)
    if spellMap == 'Cure' and spell.target.type == 'SELF' then
        equip(sets.midcast.CureSelf)
    end
end

function job_aftercast(spell, action, spellMap, eventArgs)
	equip(sets[state.WeaponSet.current])
	--equip(sets[state.ShieldSet.current])
	handle_equipping_gear(player.status)
end

function job_update(cmdParams, eventArgs)
    equip(sets[state.WeaponSet.current])
	--equip(sets[state.ShieldSet.current])
    handle_equipping_gear(player.status)
	update_combat_form()
end

function update_combat_form()

end

function check_weaponset()
end
 
 function job_buff_change(buff,gain)
    
	if buff == "doom" then
        if gain then
            equip(sets.buff.Doom)
            send_command('@input /p Doomed.')
            disable('ring1','ring2','waist','neck','legs')
        else
            enable('ring1','ring2','waist','neck','legs')
            handle_equipping_gear(player.status)
        end
    end
	
	if buff == "samurai roll" then
		state.Buff.SAMroll = gain
		customize_melee_set()
		handle_equipping_gear(player.status)
	end
	
	if buff == "fighter\'s roll" then
		state.Buff.WARroll = gain
		customize_melee_set()
		handle_equipping_gear(player.status)
	end
 
    if buff:startswith('Aftermath') then
        state.Buff.Aftermath = gain
        customize_melee_set()
        handle_equipping_gear(player.status)
    end

end

function job_handle_equipping_gear(playerStatus, eventArgs)
	update_combat_form()
end

-- Handle notifications of general user state change.
function job_state_change(stateField, newValue, oldValue)
    if state.WeaponLock.value == true then
        disable('main','sub')
    else
        enable('main','sub')
    end

	equip(sets[state.WeaponSet.current])
	--equip(sets[state.ShieldSet.current])
	update_combat_form()
end

function job_self_command(cmdParams, eventArgs)

end

-- Return a customized weaponskill mode to use for weaponskill sets.
-- Don't return anything if you're not overriding the default value.
function get_custom_wsmode(spell, spellMap, default_wsmode)
    
	local wsmode = ''
	
    if state.Buff['Mighty Strikes'] then
		if state.Buff['Brazen Rush'] then
			wsmode = wsmode .. 'BRMS'
		else
			wsmode = wsmode .. 'MS'
		end
    end

    if wsmode ~= '' then
        return wsmode
    end
	
end

-- Modify the default melee set after it was constructed.
function customize_melee_set(meleeSet)
	check_weaponset()
	--meleeSet = meleeSet[state.WeaponSet.current]
	if state.HybridMode.value ~= "DT" then
		if buffactive['Samurai Roll'] then
			if buffactive['Fighter\'s Roll'] then
				meleeSet = sets.engaged[state.WeaponSet.current].SAMFR
			else
				meleeSet = sets.engaged[state.WeaponSet.current].SAM
			end
		end
		if buffactive['Fighter\'s Roll'] then
			if buffactive['Samurai Roll'] then
				meleeSet = sets.engaged[state.WeaponSet.current].SAMFR
			else
				meleeSet = sets.engaged[state.WeaponSet.current].FR
			end
		end
	end
	
	if buffactive['Aftermath: Lv.3'] and player.equipment.main == "Conq" then
        if state.HybridMode.value == "DT" then
            meleeSet = set_combine(meleeSet, sets.engaged.Aftermath.DT)
        else
            meleeSet = set_combine(meleeSet, sets.engaged.Aftermath)
        end
    end

    return meleeSet
end


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
        msg = msg .. ', Defense: ' .. state.DefenseMode.value .. ' (' .. state[state.DefenseMode.value .. 'DefenseMode'].value .. ')'
    end
     
    msg = msg .. ', Casting: ' .. state.CastingMode.value
     
    if state.Kiting.value == true then
        msg = msg .. ', Kiting'
    end
 
    if state.PCTargetMode.value ~= 'default' then
        msg = msg .. ', Target PC: '..state.PCTargetMode.value
    end
 
    if state.SelectNPCTargets.value == true then
        msg = msg .. ', Target NPCs'
    end
 
    add_to_chat(122, msg)
 
    eventArgs.handled = true
end
 
-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    -- Default macro set/book
    if player.sub_job == 'NIN' then
        set_macro_page(1, 8)
    elseif player.sub_job == 'SAM' then
        set_macro_page(2, 8)
    elseif player.sub_job == 'DRG' then
        set_macro_page(3, 8)
    else
        set_macro_page(1, 8)
    end
end
function set_lockstyle()
    send_command('wait 2; input /lockstyleset ' .. lockstyleset)
end