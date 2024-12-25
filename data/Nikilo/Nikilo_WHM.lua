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
	
	lockstyleset = 20
	
	whm_sub_weapons = S{'Makhila +2'}
	
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
		main={ name="Grioavolr", augments={'"Fast Cast"+6','MP+106','Mag. Acc.+2','"Mag.Atk.Bns."+16',}},
		sub="Enki Strap",
		ammo="Impatiens",
		head="Ebers Cap +3",
		body="Inyanga Jubbah +2",
		hands={ name="Fanatic Gloves", augments={'MP+50','Healing magic skill +10','"Conserve MP"+7','"Fast Cast"+7',}},
		legs={ name="Kaykaus Tights +1", augments={'INT+12','"Mag.Atk.Bns."+20','Enmity-6',}},
		feet="Volte Gaiters",
		neck={ name="Clr. Torque +2", augments={'Path: A',}},
		waist="Witful Belt",
		left_ear="Loquac. Earring",
		right_ear="Malignance Earring",
		left_ring="Lebeche Ring",
		right_ring="Kishar Ring",
		back="Perimede Cape",
		} --80/10
		
	sets.precast.FC['Healing Magic'] = set_combine(sets.precast.FC,{
		legs = "Ebers Pant. +3", --15
		})
		
	sets.precast.FC.Raise = set_combine(sets.precast.FC['Healing Magic'], {}) 
		
	sets.precast.FC.Reraise = sets.precast.FC.Raise
   
    sets.precast.FC.StatusRemoval = set_combine(sets.precast.FC['Healing Magic'], {main = "Yagrush", sub="Ammurapi Shield"})
   
    sets.precast.FC.Cure = set_combine(sets.precast.FC['Healing Magic'], {})
    sets.precast.FC.Curaga = sets.precast.FC.Cure
    sets.precast.FC.CureSolace = sets.precast.FC.Cure
	
    sets.precast.FC['Enhancing Magic'] = set_combine(sets.precast.FC, {})

    sets.precast.FC['Dispelga'] = set_combine(sets.precast.FC, {main="Daybreak", sub="Ammurapi Shield"})  
   
   sets.precast.FC.Impact = set_combine(sets.precast.FC, {})
	
    -- Precast sets to enhance JAs
    sets.precast.JA['Benediction'] = {body="Piety Bliaut +3"}
    sets.precast.JA['Devotion'] = {head="Piety Cap +3"}
	sets.precast.JA['Martyr'] = {hands="Piety Mitts +3"}

	-- Midcast Sets
    sets.midcast.FC = set_combine(sets.precast.FC,{
		legs="Aya. Cosciales +2",
		})
		
	-- Define these sets into an array later:
	sets.midcast['Warp'] = sets.midcast.FC
	sets.midcast['Warp II'] = sets.midcast.FC
	sets.midcast['Escape'] = sets.midcast.FC
	sets.midcast['Teleport'] = sets.midcast.FC
		
    -- Cure sets

    sets.midcast.CureSolace = {
		main="Daybreak",
		sub="Genmei Shield",
		ammo="Staunch Tathlum +1",
		head={ name="Kaykaus Mitra +1", augments={'MP+80','"Cure" spellcasting time -7%','Enmity-6',}},
		body="Ebers Bliaut +3",
		hands="Theophany Mitts +3",
		legs="Ebers Pant. +3",
		feet={ name="Kaykaus Boots +1", augments={'Mag. Acc.+20','"Cure" potency +6%','"Fast Cast"+4',}},
		neck={ name="Clr. Torque +2", augments={'Path: A',}},
		waist="Carrier's Sash",
		left_ear="Glorious Earring",
		right_ear="Ebers Earring +1",
		left_ring="Defending Ring",
		right_ring="Gurebu's Ring",
		back={ name="Alaunus's Cape", augments={'MND+20','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','Haste+10','Damage taken-5%',}},
        } 
	
	sets.midcast.CureSolace.MEVA = set_combine(sets.midcast.CureSolace, {
		head="Ebers Cap +3",
		body="Bunzi's Robe",
		hands="Bunzi's Gloves",
		feet="Ebers Duckbills +3",
		left_ear="Eabani Earring",
		left_ring="Inyanga Ring",
		}) 
	
    sets.midcast.CureSolaceWeather = set_combine(sets.midcast.CureSolace, {
		main="Chatoyant Staff", --10
		sub="Enki Strap",
		waist="Hachirin-no-obi",
		}) 
	
	sets.midcast.CureSolaceWeather.MEVA = set_combine(sets.midcast.CureSolace.MEVA , {
		main="Chatoyant Staff", --10
		sub="Enki Strap",
		waist="Hachirin-no-obi",
		})
	
    sets.midcast.CureNormal = set_combine(sets.midcast.CureSolace, {body="Theo. Bliaut +3"})
		
	sets.midcast.CureNormal.MEVA = sets.midcast.CureSolace.MEVA
	
    sets.midcast.CureWeather = set_combine(sets.midcast.CureSolaceWeather, {body="Theo. Bliaut +3"})
	
	sets.midcast.CureWeather.MEVA = set_combine(sets.midcast.CureSolaceWeather.MEVA, {})
		
    sets.midcast.CuragaNormal = set_combine(sets.midcast.CureNormal, {})

	sets.midcast.CuragaNormal.MEVA = set_combine(sets.midcast.CureNormal.MEVA, {})
	
    sets.midcast.CuragaWeather = set_combine(sets.midcast.CureWeather, {})
	
	sets.midcast.CuragaWeather.MEVA = set_combine(sets.midcast.CureWeather.MEVA, {})

    sets.midcast.CureMelee = {
		ammo="Staunch Tathlum +1",
		head={ name="Kaykaus Mitra +1", augments={'MP+80','"Cure" spellcasting time -7%','Enmity-6',}},
		body="Bunzi's Robe",
		hands="Theophany Mitts +3",
		legs="Ebers Pant. +3",
		feet={ name="Kaykaus Boots +1", augments={'Mag. Acc.+20','"Cure" potency +6%','"Fast Cast"+4',}},
		neck={ name="Clr. Torque +2", augments={'Path: A',}},
		waist="Carrier's Sash",
		left_ear="Glorious Earring",
		right_ear={ name="Ebers Earring +1", augments={'System: 1 ID: 1676 Val: 0','Accuracy+12','Mag. Acc.+12','Damage taken-4%',}},
		left_ring="Defending Ring",
		right_ring="Gurebu's Ring",
		back={ name="Alaunus's Cape", augments={'MND+20','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','Haste+10','Damage taken-5%',}},
		} 
	
	sets.midcast.CureMelee.MEVA = {
		ammo="Staunch Tathlum +1",
		head="Ebers Cap +3",
		body="Bunzi's Robe",
		hands="Bunzi's Gloves",
		legs="Ebers Pant. +3",
		feet="Ebers Duckbills +3",
		neck={ name="Clr. Torque +2", augments={'Path: A',}},
		waist="Carrier's Sash",
		left_ear="Glorious Earring",
		right_ear={ name="Ebers Earring +1", augments={'System: 1 ID: 1676 Val: 0','Accuracy+12','Mag. Acc.+12','Damage taken-4%',}},
		left_ring="Inyanga Ring",
		right_ring="Gurebu's Ring",
		back={ name="Alaunus's Cape", augments={'MND+20','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','Haste+10','Damage taken-5%',}},
		}

    sets.midcast.StatusRemoval = {
		main={ name="Yagrush", augments={'Path: A',}},
		sub="Ammurapi Shield",
		ammo="Impatiens",
		head="Ebers Cap +3",
		body="Bunzi's Robe",
		hands="Ebers Mitts +3",
		legs="Ebers Pant. +3",
		feet="Ebers Duckbills +3",
		neck={ name="Clr. Torque +2", augments={'Path: A',}},
		waist="Witful Belt",
		left_ear="Etiolation Earring",
		right_ear="Malignance Earring",
		left_ring="Lebeche Ring",
		right_ring="Gurebu's Ring",
		back={ name="Alaunus's Cape", augments={'MND+20','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','Haste+10','Damage taken-5%',}},
		} --Yagrush +20FC, Ebers+25??FC

    sets.midcast.Cursna = { 
		main={ name="Yagrush", augments={'Path: A',}},
		sub="Genmei Shield",
		ammo="Staunch Tathlum +1",
		head={ name="Vanya Hood", augments={'Healing magic skill +20','"Cure" spellcasting time -7%','Magic dmg. taken -3',}},
		body="Ebers Bliaut +3",
		hands={ name="Fanatic Gloves", augments={'MP+50','Healing magic skill +10','"Conserve MP"+7','"Fast Cast"+7',}},
		legs="Th. Pant. +3",
		feet={ name="Vanya Clogs", augments={'Healing magic skill +20','"Cure" spellcasting time -7%','Magic dmg. taken -3',}},
		neck="Debilis Medallion",
		waist="Bishop's Sash",
		left_ear="Meili Earring",
		right_ear="Ebers Earring +1",
		left_ring="Menelaus's Ring",
		right_ring="Haoma's Ring",
		back={ name="Alaunus's Cape", augments={'MND+20','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','Haste+10','Mag. Evasion+15',}},
		}
	
	--500 skill + Duration
    sets.midcast['Enhancing Magic'] = { 
		main={ name="Gada", augments={'Enh. Mag. eff. dur. +6','Mag. Acc.+3','"Mag.Atk.Bns."+20',}},
		sub="Ammurapi Shield",
		ammo="Staunch Tathlum +1",
		head={ name="Telchine Cap", augments={'Mag. Evasion+21','"Conserve MP"+5','Enh. Mag. eff. dur. +10',}},
		body={ name="Telchine Chas.", augments={'Mag. Evasion+25','"Conserve MP"+5','Enh. Mag. eff. dur. +10',}},
		hands={ name="Telchine Gloves", augments={'Mag. Evasion+23','"Conserve MP"+4','Enh. Mag. eff. dur. +10',}},
		legs={ name="Telchine Braconi", augments={'Mag. Evasion+5','"Conserve MP"+5','Enh. Mag. eff. dur. +10',}},
		feet="Theo. Duckbills +3",
		neck="Incanter's Torque",
		waist="Embla Sash",
		left_ear="Mimir Earring",
		right_ear="Andoaa Earring",
		left_ring="Stikini Ring +1",
		right_ring="Gurebu's Ring",
		back={ name="Fi Follet Cape +1", augments={'Path: A',}},
        }

    sets.midcast.EnhancingDuration = set_combine(sets.midcast['Enhancing Magic'], {})
		
    sets.midcast.BarElement = {
		main="Beneficus",
		sub="Ammurapi Shield",
		ammo="Staunch Tathlum +1",
		head="Ebers Cap +3",
		body="Ebers Bliaut +3",
		hands="Ebers Mitts +3",
		legs={ name="Piety Pantaln. +3", augments={'Enhances "Afflatus Misery" effect',}},
		feet="Ebers Duckbills +3",
		neck="Elite Royal Collar",
		waist="Embla Sash",
		left_ear="Etiolation Earring",
		right_ear={ name="Ebers Earring +1", augments={'System: 1 ID: 1676 Val: 0','Accuracy+12','Mag. Acc.+12','Damage taken-4%',}},
		left_ring="Defending Ring",
		right_ring="Gurebu's Ring",
		back={ name="Alaunus's Cape", augments={'MND+20','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','Haste+10','Mag. Evasion+15',}},
        }
		
	sets.midcast.BarStatus = set_combine(sets.midcast.EnhancingDuration, {neck="Sroda Necklace",})
	
    sets.midcast.Regen = {
		main="Bolelabunga",
		sub="Ammurapi Shield",
		head="Inyanga Tiara +2",
		body={ name="Piety Bliaut +3", augments={'Enhances "Benediction" effect',}},
		hands="Ebers Mitts +3",
		legs="Th. Pant. +3",
		feet="Theo. Duckbills +3",
		waist="Embla Sash",
		left_ring="Defending Ring",
        }

    sets.midcast['Aquaveil'] = set_combine(sets.midcast['Enhancing Magic'], {
		--main = "Vadose Rod",
		--head = ChironicHead.WSD,
		--waist = "Emphatikos Rope",
        })
    
	sets.midcast['Auspice'] = set_combine(sets.midcast.EnhancingDuration, {feet="Ebers Duckbills +3"})
		
    sets.midcast['Stoneskin'] = set_combine(sets.midcast.EnhancingDuration, {waist="Siegel Sash"})

    sets.midcast.Proshell = set_combine(sets.midcast.EnhancingDuration, {left_ring="Sheltered Ring"})

	--Repose--
	sets.midcast['Divine Magic'] = {
		main={ name="Yagrush", augments={'Path: A',}},
		sub="Ammurapi Shield",
		ammo="Pemphredo Tathlum",
		head="Ebers Cap +3",
		body="Ebers Bliaut +3",
		hands={ name="Piety Mitts +3", augments={'Enhances "Martyr" effect',}},
		legs="Th. Pant. +3",
		feet="Ebers Duckbills +3",
		neck="Jokushu Chain",
		waist="Luminary Sash",
		left_ear="Malignance Earring",
		right_ear="Regal Earring",
		left_ring="Stikini Ring +1",
		right_ring={ name="Metamor. Ring +1", augments={'Path: A',}},
		back={ name="Aurist's Cape +1", augments={'Path: A',}},
	}

    sets.midcast.Banish = {
		main="Daybreak",
		sub="Ammurapi Shield",
		ammo="Pemphredo Tathlum",
		body={ name="Cohort Cloak +1", augments={'Path: A',}},
		hands="Bunzi's Gloves",
		legs={ name="Kaykaus Tights +1", augments={'INT+12','"Mag.Atk.Bns."+20','Enmity-6',}},
		feet="Bunzi's Sabots",
		neck="Mizu. Kubikazari",
		waist="Sacro Cord",
		left_ear="Malignance Earring",
		right_ear="Regal Earring",
		left_ring="Freke Ring",
		right_ring={ name="Metamor. Ring +1", augments={'Path: A',}},
		back={ name="Alaunus's Cape", augments={'MND+20','Mag. Acc+20 /Mag. Dmg.+20','MND+10','"Mag.Atk.Bns."+10',}},
	}

    sets.midcast.Holy = set_combine(sets.midcast.Banish, {feet="Piety duckbills +3"})

    sets.midcast['Dark Magic'] = {}

    sets.midcast.MndEnfeebles = {		
		main="Yagrush",
		sub="Ammurapi Shield",
		ammo="Pemphredo Tathlum",
		head="Ebers Cap +3",
		body="Theo. Bliaut +3",
		hands={ name="Kaykaus Cuffs +1", augments={'MP+80','MND+12','Mag. Acc.+20',}},
		legs={ name="Chironic Hose", augments={'Mag. Acc.+25 "Mag.Atk.Bns."+25','MND+12','Mag. Acc.+10',}},
		feet="Theo. Duckbills +3",
		neck="Erra Pendant",
		waist="Luminary Sash",
		left_ear="Malignance Earring",
		right_ear="Regal Earring",
		left_ring="Stikini Ring +1",
		right_ring={ name="Metamor. Ring +1", augments={'Path: A',}},
		back={ name="Aurist's Cape +1", augments={'Path: A',}},
		}

    sets.midcast.IntEnfeebles = set_combine(sets.midcast.MndEnfeebles, {main = "Yagrush"})
	sets.midcast['Dispelga'] = set_combine(sets.midcast.IntEnfeebles, {main = "Daybreak"})
	
	sets.midcast.Impact = {}
	
	-- Sets to return to when not performing an action.
    
    -- Resting sets

    sets.idle = {
		main="Daybreak",
		sub="Genmei Shield",
		ammo="Staunch Tathlum +1",
		head="Bunzi's Hat",
		body="Ebers Bliaut +3",
		hands="Bunzi's Gloves",
		legs="Ebers Pant. +3",
		feet="Ebers Duckbills +3",
		neck="Elite Royal Collar",
		waist="Carrier's Sash",
		left_ear="Etiolation Earring",
		right_ear={ name="Ebers Earring +1", augments={'System: 1 ID: 1676 Val: 0','Accuracy+12','Mag. Acc.+12','Damage taken-4%',}},
		left_ring="Shneddick Ring",
		right_ring="Gurebu's Ring",
		back={ name="Alaunus's Cape", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','Enmity-10','Mag. Evasion+15',}},
		}
	
	sets.idle.Refresh = {
		main="Mpaca's Staff",
		sub="Enki Strap",
		ammo="Homiliary",
		head="Volte Beret",
		body="Ebers Bliaut +3",
		hands={ name="Chironic Gloves", augments={'Spell interruption rate down -4%','Pet: "Store TP"+7','"Refresh"+2','Mag. Acc.+10 "Mag.Atk.Bns."+10',}},
		legs="Assid. Pants +1",
		feet="Volte Gaiters",
		neck="Elite Royal Collar",
		waist="Carrier's Sash",
		left_ear="Etiolation Earring",
		right_ear={ name="Ebers Earring +1", augments={'System: 1 ID: 1676 Val: 0','Accuracy+12','Mag. Acc.+12','Damage taken-4%',}},
		left_ring="Stikini Ring +1",
		right_ring="Gurebu's Ring",
		back={ name="Alaunus's Cape", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','Enmity-10','Mag. Evasion+15',}},
		}
	
    -- Defense sets

    sets.defense.PDT = set_combine(sets.idle, {})

    sets.defense.MDT = set_combine(sets.idle, {})
   
   -- Buff sets: Gear that needs to be worn to actively enhance a current player buff.
   
    sets.buff['Divine Caress'] = {hands="Ebers Mitts +3", back="Mending Cape"}
	
	sets.Obi = {waist="Hachirin-no-obi"}
   
    sets.magic_burst = {
		head="Bunzi's Hat",
		body="Bunzi's Robe", 
		legs="Bunzi's Pants", 
		feet="Bunzi's Sabots" ,
		neck="Mizu. Kubikazari", 
		}
    
	
	------------------
	-- Engaged Sets --
	------------------    

	sets.YagrushDW = {main = "Yagrush", sub = "Makhila +2"} 
	sets.YagrushAccDW = {main = "Yagrush", sub = "Makhila +2"}
	sets.MaxentiusDW = {main = "Maxentius", sub = "Makhila +2"}
	
	sets.Yagrush = {main = "Yagrush", sub = "Genmei Shield"}   
	sets.YagrushAcc = {main = "Yagrush", sub = "Genmei Shield"}
	sets.Maxentius = {main = "Maxentius", sub = "Genmei Shield"}
    
	sets.engaged = {
		ammo="Oshasha's Treatise",
		head="Bunzi's Hat",
		body="Ebers Bliaut +3",
		hands="Bunzi's Gloves",
		legs="Ebers Pant. +3",
		feet="Ebers Duckbills +3",
		neck="Lissome Necklace",
		waist="Cornelia's Belt",
		left_ear="Telos Earring",
		right_ear="Cessance Earring",
		left_ring="Petrov Ring",
		right_ring="Ilabrat Ring",
		back={ name="Alaunus's Cape", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}},
		}
	
	sets.engaged.DW = set_combine(sets.engaged, {
		waist = "Shetal Stone", 
		ear2 = "Suppanomimi"
		})
	
	sets.engaged.AM = set_combine(sets.engaged,{
		ear1 = "Telos Earring",
		back = Alaunus.STP,
		})
		
	sets.engaged.AM_DW = set_combine(sets.engaged.AM, {
		waist = "Shetal Stone", 
		ear2 = "Suppanomimi"
		})
	
	
	-- Weaponskill sets

    -- Default set for any weaponskill that isn't any more specifically defined
	sets.precast.WS = {
		ammo="Oshasha's Treatise",
		head="Nyame Helm",
		body="Nyame Mail",
		hands="Nyame Gauntlets",
		legs="Nyame Flanchard",
		feet="Nyame Sollerets",
		neck="Fotia Gorget",
		waist="Fotia Belt",
		left_ear={ name="Moonshade Earring", augments={'"Mag.Atk.Bns."+4','TP Bonus +250',}},
		right_ear="Ishvara Earring",
		left_ring="Shukuyu Ring",
		right_ring={ name="Metamor. Ring +1", augments={'Path: A',}},
		back={ name="Alaunus's Cape", augments={'MND+20','Accuracy+20 Attack+20','MND+10','Weapon skill damage +10%',}},
		}
	
	--1 hit | 70% MND / 30% STR | Scales
	sets.precast.WS['Mystic Boon'] = set_combine(sets.precast.WS, {
		neck = "Clr. Torque +2",
		waist = "Luminary Sash",
		ring1 = "Rufescent Ring",
		})
	
	--2 hit | 70% MND / 30% STR | Scales
	--Assuming Main Hand Maxentius
    sets.precast.WS['Black Halo'] = set_combine(sets.precast.WS, {
		neck = "Clr. Torque +2",
		waist = "Luminary Sash",
		ring1 = "Rufescent Ring",
		})
		
	--7 hit |  73~85% MND | No Scale
	sets.precast.WS['Realmrazer'] = set_combine(sets.precast.WS, {
		neck = "Clr. Torque +2",
		ear1 = "Digni. Earring",
		ear2 = "Malignance Earring",
		ring1 = "Rufescent Ring",
		waist = "Luminary Sash",
		})
	
	--1 hit | 40% STR / 40% MND | No Scale
	sets.precast.WS['Randgrith'] = set_combine(sets.precast.WS, {
		neck = "Clr. Torque +2",
		ear2 = "Malignance Earring",
		})
	
	--6 hit | Crit | 30% STR / 30% MND
	sets.precast.WS['Hexa Strike'] = set_combine(sets.precast.WS, {
		head = "Blistering Sallet +1",
		ear2 = "Brutal Earring",
		ring2 = "Begrudging Ring",
		back = Alaunus.Crit,
		feet = "Aya. Gambieras +2",
		})

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
		if spellMap == 'BarStatus' then
			equip(sets.midcast.BarStatus)
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
