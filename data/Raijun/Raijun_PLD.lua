-- lock weapon , no weapon swaps
-- phalanx
-- SIRD sets default.
-- Doesn't Care About HP sets
-- Melee: Normal, Acc
-- Hybrid: DT, MEVA     50% PDT   -- max emnity
-- Tank : DT, Block and MDT
-- Cure Cheats
-- Idle: DT-Movement, Refresh|Regen|Regain
-- TP bullshit
-------------------------------------------------------------------------------------------------------------------
-- Setup functions for this job.  Generally should not be modified.
-------------------------------------------------------------------------------------------------------------------
--  Modes:      
--				[ F9 ]              Cycle Offense Modes
--              [ CTRL+F9 ]         Cycle Hybrid Modes
--				[ ALT+F9 ]			Cycle WeaponSkill Modes
--
--              [ F10 ]             PDT Mode
--				[ CTRL+F10 ]        Cycle PDT Modes
--
--              [ F11 ]             MDT Mode
--				[ CTRL+F11 ]        Cycle MDT Modes
--				[ ALT+F11 ]  		Cycle Casting Mode 
--
--              [ F12 ]             Update Current Gear / Report Current Status
--              [ CTRL+F12 ]        Cycle Idle Mode
--              [ ALT+F12 ]         Cancel PDT / MDT Mode
--
--				[ CTRL+INS ]		Cycle Weapons
--  			[ CTRL+HOME ]       Cycleback Weapons 
--
-----------------------------------------------------------------------------------------------------------------

-- Initialization function for this job file.
function get_sets()
    mote_include_version = 2

    -- Load and initialize the include file.
    include('Mote-Include.lua')
	include('organizer-lib')
	res = require 'resources'
end

-- Setup vars that are user-independent.  state.Buff vars initialized here will automatically be tracked.
function job_setup()
    -- /BLU Spell Maps
    blue_magic_maps = {}

    blue_magic_maps.Enmity = S{'Blank Gaze', 'Jettatura', 'Soporific', 'Poison Breath', 'Blitzstrahl', 'Chaotic Eye',
	'Sheep Song', 'Geist Wall', 'Stinking Gas'}
    blue_magic_maps.Cure = S{'Wild Carrot'}
    blue_magic_maps.Buffs = S{'Cocoon', 'Refueling'}

    state.Buff.Sentinel = buffactive.sentinel or false
    state.Buff.Cover = buffactive.cover or false

end

-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
    state.OffenseMode:options('Normal', 'Acc')
    state.HybridMode:options('Normal', 'DT')
    state.WeaponskillMode:options('Normal', 'DT')
	state.CastingMode:options('Normal', 'HP')
    state.PhysicalDefenseMode:options('PDT', 'Block', 'Offense')
    state.MagicalDefenseMode:options('MDT')
	state.IdleMode:options('Normal', 'DT')
	
	state.WeaponSet = M{['description']='Weapon Set', 'Burtgang', 'Excalibur', 'Naegling', 'Almace'}
	state.ShieldSet = M{['description']='Shield Set', 'Ochain', 'Priwen', 'Aegis'}
    
	state.WeaponLock = M(false, 'Weapon Lock')

    select_default_macro_book()
	set_lockstyle()
	
    target_distance = 5.5 -- Set Default Distance Here --
 
    update_defense_mode()
	send_command('bind !f9 gs c cycle WeaponskillMode')
	send_command('bind ^f11 gs c cycle MagicalDefenseMode')
	send_command('bind !f11 gs c cycle CastingMode')
	
	send_command('bind ^insert gs c cycle WeaponSet')
    send_command('bind ^delete gs c cycleback WeaponSet')
	send_command('bind ^home gs c cycle ShieldSet')
    send_command('bind ^end gs c cycleback ShieldSet')
	
    send_command('pld')
	
    select_default_macro_book()
	--
	
	
end

function user_unload()
    send_command('unbind ^insert')
	send_command('unbind ^home')
	send_command('gs enable all')
end

-- Define sets and vars used by this job file.
function init_gear_sets()

	sets.Burtgang = {main = "Burtgang"}
	sets.Excalibur = {main="Excalibur"}	
	sets.Almace = {main="Almace"}	
	sets.Naegling = {main="Naegling"}	

	sets.Ochain = {sub="Ochain"}
	sets.Priwen = {sub="Priwen"}
	sets.Aegis = {sub="Aegis"}
	
    --------------------------------------
    -- Precast sets | Shield Swapping Okay
    --------------------------------------

    sets.precast.JA['Invincible'] = {legs="Cab. Breeches +1"}
    sets.precast.JA['Holy Circle'] = {feet="Rev. Leggings +2"}
    sets.precast.JA['Shield Bash'] = {hands="Cab. Gauntlets +3", ear1 = "Knightly Earring"}
    sets.precast.JA['Sentinel'] = {feet="Cab. Leggings +3"}
    sets.precast.JA['Rampart'] = {head="Cab. Coronet +3"}
    sets.precast.JA['Fealty'] = {body="Cab. Surcoat +1"}
    sets.precast.JA['Divine Emblem'] = {feet="Chev. Sabatons +1"}
    sets.precast.JA['Cover'] = {"Rev. Coronet +1"}
    sets.precast.JA['Chivalry'] = {hands="Cab. Gauntlets +3"}
    
	--2500hp
	sets.Enmity = {
		ammo="Sapience Orb",
		head="Loess Barbuta +1",
		body="Souv. Cuirass +1",
		hands="Yorium Gauntlets",
		legs=OdysseanLegs.Enmity,
		feet="Eschite Greaves",
		neck="Moonlight Necklace",
		waist="Creed Baudrier",
		left_ear="Trux Earring",
		right_ear="Cryptic Earring",
		left_ring="Apeile Ring +1",
		right_ring="Eihwaz Ring",
		back=Rudianos.Tank,
		}
		
	--2800hp
	--sets.Emnity.Hybrid = set_combine(sets.Enmity, {
	--	hands=SouveranHands.C,
	--	legs="Souv. Diechlings +1",
	--	})
	
	--3000hp
	sets.Enmity.HP = set_combine(sets.Enmity, {
		ammo="Staunch Tathlum +1",
		head=SouveranHead.C,
		hands=SouveranHands.C,
		legs="Souv. Diechlings +1",
		feet="Souveran Schuhs +1",
		ring2="Defending Ring",
		})
		
	--2900hp | 95 + 10 (merits) SIRD | PDT 53
	sets.Enmity.SIRD = {
		ammo="Staunch Tathlum +1",
		head=SouveranHead.C, --20
		body="Souv. Cuirass +1",
		hands=SouveranHands.C,
		legs="Founder's Hose", --30
		feet="Souveran Schuhs +1",
		neck="Moonlight Necklace", --15
		waist="Audumbla Sash", --10
		left_ear="Knightly Earring", --9
		right_ear="Odnowa Earring +1",
		left_ring="Apeile Ring +1",
		right_ring="Defending Ring",
		back=Rudianos.Tank,
		}
	
    -- Fast cast sets for spells
	--2500hp 77 FC
	sets.precast.FC = {
		ammo="Sapience Orb", --2
		head="Carmine Mask +1", --14
		body={name="Rev. Surcoat +3", priority=3}, --10
		hands="Leyline Gloves", --8
		legs="Enif Cosciales", --8
		feet=OdysseanFeet.FC, --11
		neck="Baetyl Pendant", --4
		waist="Creed Baudrier",
		left_ear={name="Tuisto Earring", priority=6},
		right_ear="Etiolation Earring", --1
		left_ring="Weather. Ring", --5
		right_ring="Kishar Ring", --4
		back=Rudianos.FC, --10
		}
		
	--3k hp , 65 FC
    sets.precast.FC.HP = set_combine(sets.precast.FC, {
		ammo={name="Egoist's Tathlum", priority=4},
		feet="Carmine Greaves +1", --8
		neck="Unmoving Collar +1",
		ear2="Odnowa Earring +1",
		right_ring={name="Moonlight Ring", priority=1, bag="wardrobe1"},
		}) 

	--Cure Cheats--
	sets.precast.FC['Cure'] = {    
		ammo="Sapience Orb",
		head="Carmine Mask +1",
		body="Sacro Breastplate",
		hands="Leyline Gloves",
		legs="Enif Cosciales",
		feet=OdysseanFeet.FC,
		neck="Baetyl Pendant",
		waist="Acerbic Sash +1",
		left_ear="Mendi. Earring",
		right_ear="Nourish. Earring +1",
		left_ring="Weather. Ring",
		right_ring="Kishar Ring",
		back=Rudianos.FC,
	}
	
	sets.precast.FC['Cure'].HP = set_combine(sets.precast.FC['Cure'], {})
	
    sets.precast.FC['Enhancing Magic'] = set_combine(sets.precast.FC, {waist="Siegel Sash"})
    sets.precast.FC['Enhancing Magic'].HP = set_combine(sets.precast.FC.HP, {waist="Siegel Sash"})

	
-------------------------------------------------------------------------------------------------------------------	
-- Weaponskill sets
-------------------------------------------------------------------------------------------------------------------	
	
    -- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS = {
		ammo="Staunch Tathlum +1",
		head="Sakpata's Helm",
		body="Sakpata's Plate",
		hands="Sakpata's Gauntlets",
		legs="Sakpata's Cuisses",
		feet="Sakpata's Leggings",
		neck={ name="Unmoving Collar +1", augments={'Path: A',}},
		waist={ name="Sailfi Belt +1", augments={'Path: A',}},
		left_ear={ name="Moonshade Earring", augments={'"Mag.Atk.Bns."+4','TP Bonus +250',}},
		right_ear="Thrud Earring",
		left_ring="Regal Ring",
		right_ring="Epaminondas's Ring",
		back={ name="Rudianos's Mantle", augments={'STR+20','Accuracy+20 Attack+20','Weapon skill damage +10%',}},
		}	
	
	sets.precast.WS.DT = {}

	---------------
	---- Sword ----
	---------------

	sets.precast.WS['Savage Blade'] = set_combine(sets.precast.WS, {})
		
	sets.precast.WS['Savage Blade'].DT = {}
		
	sets.precast.WS["Knights of Round"] = set_combine(sets.precast.WS, {})

    sets.precast.WS['Chant du Cygne'] = {
		ammo="Coiste Bodhar",
		head="Flam. Zucchetto +2", --Blistering R15
		body="Hjarrandi Breast.",
		hands="Flam. Manopolas +2",
		legs="Lustr. Subligar +1",
		feet="Thereoid Greaves",
		neck="Fotia Gorget",
		waist="Fotia Belt",
		left_ear="Mache Earring +1",
		right_ear="Lugra Earring +1",
		left_ring="Regal Ring",
		right_ring="Begrudging Ring", 
		back=Rudianos.CRIT,
		}
		
	sets.precast.WS['Chant du Cygne'].DT = {}

	sets.precast.WS['Atonement'] = {
		ammo="Sapience Orb",
		head="Loess Barbuta +1",
		body="Souv. Cuirass +1",
		hands="Yorium Gauntlets",
		legs="Souv. Diechlings +1",
		feet="Eschite Greaves",
		neck="Moonlight Necklace",
		waist="Fotia Belt",
		left_ear="Trux Earring",
		right_ear="Moonshade Earring",
		left_ring="Apeile Ring +1",
		right_ring="Eihwaz Ring",
		back=Rudianos.Tank,
		} 
		
	--3kHP DTcapped,
	sets.precast.WS['Atonement'].DT = {
		ammo="Sapience Orb",
		head="Loess Barbuta +1",
		body="Souv. Cuirass +1", 
		hands=SouveranHands.C,
		legs="Souv. Diechlings +1",
		feet="Souveran Schuhs +1",
		neck="Moonlight Necklace",
		waist="Fotia Belt",
		left_ear="Tuisto Earring",
		right_ear="Moonshade Earring",
		left_ring="Apeile Ring +1",
		right_ring="Eihwaz Ring",
		back=Rudianos.Tank,
	}
	
	sets.precast.WS['Requiescat'] = {
		ammo="Coiste Bodhar",
		head="Sakpata's Helm",
		body="Sakpata's Plate",
		hands="Sakpata's Gauntlets",
		legs="Sakpata's Cuisses",
		feet="Sakpata's Leggings",
		neck="Fotia Gorget",
		waist="Fotia Belt",
		left_ear="Brutal Earring",
		right_ear="Lugra Earring +1",
		left_ring="Regal Ring",
		right_ring="Rufescent Ring",
		back=Rudianos.DA,
		}
	
	sets.precast.WS['Sanguine Blade'] = {
		ammo="Coiste Bodhar",
		head="Pixie Hairpin +1",
		body="Sacro Breastplate",
		hands="Founder's Gauntlets",
		legs="Eschite Cuisses",
		feet="Founder's Greaves",
		neck="Unmoving Collar +1",
		waist="Eschan Stone",
		left_ear="Moonshade Earring",
		right_ear="Friomisi Earring",
		left_ring="Archon Ring",
		right_ring="Epaminondas's Ring",
		back=Rudianos.WSD,
		}
	
	--------------------
	---- GreatSword ----
	--------------------
	
	sets.precast.WS['Resolution'] = {
	    ammo="Coiste Bodhar",
		head="Flam. Zucchetto +2",
		body="Sakpata's Plate",
		hands="Sakpata's Gauntlets",
		legs="Sakpata's Cuisses",
		feet="Flam. Gambieras +2",
		neck="Fotia Gorget",
		waist="Fotia Belt",
		left_ear="Moonshade Earring",
		right_ear="Lugra Earring +1",
		left_ring="Regal Ring",
		right_ring="Flamma Ring",
		back=Rudianos.DA, --STR here
		}

	
-------------------------------------------------------------------------------------------------------------------	
-- Midcast sets
-------------------------------------------------------------------------------------------------------------------	

	sets.midcast.FastRecast = sets.precast.FC
	sets.midcast.FastRecast.HP = sets.precast.FC.HP
	sets.midcast.FastRecast.SIRD = sets.precast.FC.SIRD
	sets.midcast.FastRecast.HPSIRD = sets.precast.FC.HPSIRD

    sets.midcast.Flash = set_combine(sets.Enmity, {waist = "Tempus Fugit"})
	sets.midcast.Flash.HP = set_combine(sets.Enmity.HP, {waist = "Tempus Fugit"})
	sets.midcast.Flash.SIRD = set_combine(sets.Enmity.SIRD, {waist = "Tempus Fugit"})
	sets.midcast.Flash.HPSIRD = set_combine(sets.Enmity.HPSIRD, {waist = "Tempus Fugit"})
		
	-- 3090hp | 91% + 10%merits
    sets.midcast.SIRD = {  
		ammo = "Staunch Tathlum +1", --11%
		head = "Souv. Schaller +1", --20%
		neck = "Moonlight Necklace", --15%
		ear1 = "Odnowa Earring +1",
		ear2 = "Cryptic Earring",
		body = "Souv. Cuirass +1",
		hands = SouveranHands.C, 
		ring1 = "Defending Ring",
		ring2 = "Moonbeam Ring",
		back = "Moonbeam Cape",
		waist = "Tempus Fugit",
		legs = "Founder's Hose", --30%
		feet = OdysseanFeet.FC, --20%
		}
	
    sets.midcast.Utsusemi = sets.midcast.SIRD

    sets.midcast.Cure = { 
		ammo="Staunch Tathlum +1",
		head=SouveranHead.C,
		body="Souv. Cuirass +1",
		hands="Macabre Gaunt. +1",
		legs="Founder's Hose",
		feet=OdysseanFeet.Cure,
		neck="Moonlight Necklace",
		waist="Audumbla Sash",
		left_ear="Nourish. Earring +1",
		right_ear="Odnowa Earring +1",
		left_ring="Defending Ring",
		right_ring="Apeile Ring +1",
		back=Rudianos.Cure,
		}

	sets.midcast.Cure.HP = {
		ammo="Staunch Tathlum +1", 
		head=SouveranHead.C, 
		body="Souv. Cuirass +1",
		hands=SouveranHands.C,
		legs="Founder's Hose", 
		feet=OdysseanFeet.Cure,
		neck="Sacro Gorget",
		waist="Audumbla Sash", 
		left_ear="Tuisto Earring",
		right_ear="Nourish. Earring +1", 
		left_ring="Defending Ring",
		right_ring="Gelatinous Ring +1",
		back=Rudianos.Cure,
		}
	
	sets.midcast['Enhancing Magic'] = {}
	sets.midcast['Enhancing Magic'].HP = {}
	sets.midcast['Enhancing Magic'].SIRD = {}
	sets.midcast['Enhancing Magic'].HPSIRD = {}
    
	--Next Tier at +28 skill for +1 dmg reduction (not worth)
	sets.midcast['Phalanx'] =  { 
		ammo = "Staunch Tathlum +1", 
		head = "Yorium Barbuta", --3, 
		neck = "Incanter's Torque", --10 skill
		ear1 = "Tuisto Earring",
		ear2 = "Odnowa Earring +1",
		body = "Yorium Cuirass", --3,
		hands = "Souv. Handsch. +1", --5
        ring1 = "Defending Ring",
        ring2 = "Gelatinous Ring +1",
		back = "Weard Mantle", --5
		waist = "Audumbla Sash", 
		legs = "Sakpata's Cuisses", --5,
		feet = "Souveran Schuhs +1", --5
		}
		
    sets.midcast['Reprisal'] = { --HP*2--
		ammo="Staunch Tathlum +1",
		head="Souv. Schaller +1",
		body="Shab. Cuirass +1",
		hands={ name="Souv. Handsch. +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
		legs="Founder's Hose", 
		feet="Carmine Greaves +1",
		neck="Moonlight Necklace",
		waist="Audumbla Sash",
		left_ear="Knightly Earring",
		right_ear="Odnowa Earring +1",
		left_ring={name="Stikini Ring", bag="wardrobe1"},
		right_ring="Gelatinous Ring +1",
		back={ name="Rudianos's Mantle", augments={'HP+60','Eva.+20 /Mag. Eva.+20','HP+20','"Fast Cast"+10','Phys. dmg. taken-10%',}},
		}
    
	sets.midcast.Stoneskin = set_combine(sets.midcast['Enhancing Magic'], {waist="Siegel Sash"})
    
	sets.midcast.Protect = set_combine(sets.midcast['Enhancing Magic'], {ear2 = "Brachyura Earring"})
   
    sets.midcast.Shell = sets.midcast.Protect
	
	--For Holy Damage Optimization if you care--
	sets.midcast['Divine Magic'] = {}
	sets.midcast['Divine Magic'].HP = {}
    sets.midcast['Divine Magic'].SIRD = {}
	sets.midcast['Divine Magic'].HPSIRD = {}
	
	--548 skill, +12 more to hit next breakpoint?
	sets.midcast['Enlight'] = {
		head="Jumalik Helm",
		body="Rev. Surcoat +3",
		hands="Eschite Gauntlets",
		neck="Incanter's Torque",
		left_ring={name="Stikini Ring", bag="wardrobe1"},
		right_ring={name="Stikini Ring", bag="wardrobe2"},
		}
	sets.midcast['Enlight II'] = sets.midcast['Enlight']
	
    sets.midcast.Diaga = sets.Enmity

    sets.midcast['Blue Magic'] = set_combine(sets.midcast.SIRD, {}) 
    sets.midcast['Blue Magic'].Enmity = {
		ammo="Staunch Tathlum +1",
		head={ name="Souv. Schaller +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
		body={ name="Souv. Cuirass +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
		hands={ name="Souv. Handsch. +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
		legs="Founder's Hose",
		feet={ name="Souveran Schuhs +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
		neck="Moonlight Necklace",
		waist="Audumbla Sash",
		left_ear="Knightly Earring",
		right_ear="Odnowa Earring +1",
		left_ring="Eihwaz Ring",
		right_ring="Apeile Ring +1",
		back={ name="Rudianos's Mantle", augments={'HP+60','Eva.+20 /Mag. Eva.+20','HP+20','Enmity+10','Phys. dmg. taken-10%',}},
		}
    sets.midcast['Blue Magic'].Cure = sets.midcast.Cure.SIRD
    sets.midcast['Blue Magic'].Buff = sets.midcast.SIRD

    --------------------------------------
    -- Idle/resting/defense/etc sets
    --------------------------------------
	
	sets.idle = {
		ammo="Brigantia Pebble",
		head="Sakpata's Helm",
		body="Sacro Breastplate",
		hands="Sakpata's Gauntlets",
		legs=="Carmine Cuisses +1",
		feet="Sakpata's Leggings",
		neck="Unmoving Collar +1",
		waist="Carrier's Sash",
		left_ear="Tuisto Earring",
		right_ear="Odnowa Earring +1",
		left_ring="Defending Ring",
		right_ring="Gelatinous Ring +1",
		back={ name="Rudianos's Mantle", augments={'HP+60','Eva.+20 /Mag. Eva.+20','HP+20','Enmity+10','Phys. dmg. taken-10%',}},
		}
		
	sets.idle.DT = set_combine(sets.idle ,{
		body="Sakpata's Plate",
		left_ring={name="Moonlight Ring", bag="wardrobe1"},
		})
	
    --------------------------------------
    -- Defense sets
    --------------------------------------
    
	-- Turtle Tanking 
    sets.defense.PDT = {
		ammo="Brigantia Pebble",
		head="Sakpata's Helm",
		body="Sakpata's Plate",
		hands="Sakpata's Gauntlets",
		legs="Sakpata's Cuisses",
		feet="Sakpata's Leggings",
		neck="Unmoving Collar +1",
		waist="Carrier's Sash",
		left_ear="Thureous Earring",
		right_ear="Odnowa Earring +1",
		left_ring={name="Moonlight Ring", bag="wardrobe1"},
		right_ring="Gelatinous Ring +1",
		back={ name="Rudianos's Mantle", augments={'HP+60','Eva.+20 /Mag. Eva.+20','HP+20','Enmity+10','Chance of successful block +5',}},
		}
		
	sets.defense.Block = {
	    ammo="Brigantia Pebble",
		head="Sakpata's Helm",
		body="Sakpata's Plate",
		hands={ name="Souv. Handsch. +1", augments={'HP+65','Shield skill +15','Phys. dmg. taken -4',}},
		legs="Sakpata's Cuisses",
		feet="Souveran Schuhs +1",
		neck="Combatant's Torque",
		waist="Carrier's Sash",
		left_ear="Thureous Earring",
		right_ear="Odnowa Earring +1",
		left_ring={name="Moonlight Ring", bag="wardrobe1"},
		right_ring="Gelatinous Ring +1",
		back={ name="Rudianos's Mantle", augments={'HP+60','Eva.+20 /Mag. Eva.+20','HP+20','Enmity+10','Chance of successful block +5',}},
	}

	
	-- Magic Defense Swap for them there booms
    sets.defense.MDT = {
		ammo="Egoist's Tathlum",
		head="Sakpata's Helm",
		body="Sacro Breastplate",
		hands="Sakpata's Gauntlets",
		legs="Sakpata's Cuisses",
		feet="Sakpata's Leggings",
		neck="Unmoving Collar +1",
		waist="Carrier's Sash",
		left_ear="Sanare Earring",
		right_ear="Odnowa Earring +1", 
		left_ring="Shadow Ring",
		right_ring="Gelatinous Ring +1",
		back={ name="Rudianos's Mantle", augments={'HP+60','Eva.+20 /Mag. Eva.+20','HP+20','Enmity+10','Phys. dmg. taken-10%',}},
		}
	
-------------------------------------------------------------------------------------------------------------------
-- Engaged Sets
-------------------------------------------------------------------------------------------------------------------	
	--Technically Hybrid
	sets.engaged = {
		ammo="Coiste Bodhar",
		head="Sakpata's Helm",
		body="Sakpata's Plate",
		hands="Sakpata's Gauntlets",
		legs="Sakpata's Cuisses",
		feet="Sakpata's Leggings",
		neck="Vim Torque +1",
		waist="Sailfi Belt +1",
		left_ear="Brutal Earring",
		right_ear="Cessance Earring",
		left_ring={name="Moonlight Ring", bag="wardrobe1"},
		right_ring={name="Moonlight Ring", bag="wardrobe2"},
		back=Rudianos.DA,
		}	
		
    sets.engaged.Acc = set_combine(sets.engaged, {
		neck="Combatant's Torque",
		left_ear_ear="Telos Earring",
		})
	
	sets.engaged.Aftermath = {
		ammo="Coiste Bodhar",
		head="Hjarrandi Helm",
		body="Hjarrandi Breast.",
		hands="Sakpata's Gauntlets",
		legs={ name="Odyssean Cuisses", augments={'"Store TP"+8','VIT+2','Accuracy+9','Attack+7',}},
		feet={ name="Valorous Greaves", augments={'Accuracy+7','"Store TP"+8','Attack+2',}},
		neck="Vim Torque +1",
		waist="Tempus Fugit",
		left_ear="Dedition Earring",
		right_ear="Telos Earring",
		left_ring={name="Moonlight Ring", bag="wardrobe1"},
		right_ring={name="Moonlight Ring", bag="wardrobe2"},
		back=Rudianos.STP,
		}
    
-------------------------------------------------------------------------------------------------------------------
-- Hybrid Sets
-------------------------------------------------------------------------------------------------------------------	
	--Offense Tanking
	sets.Hybrid = {}
	
	sets.engaged.DT = {
		ammo="Coiste Bodhar",
		head="Sakpata's Helm",
		body="Sakpata's Plate",
		hands="Sakpata's Gauntlets",
		legs="Sakpata's Cuisses",
		feet="Sakpata's Leggings",
		neck="Unmoving Collar +1",
		waist="Sailfi Belt +1",
		left_ear="Tuisto Earring",
		right_ear="Odnowa Earring +1",
		left_ring={name="Moonlight Ring", bag="wardrobe1"},
		right_ring={name="Moonlight Ring", bag="wardrobe2"},
		back=Rudianos.DA,
		}	
		
	sets.engaged.Acc.DT = set_combine(sets.Hybrid, {})	
	
	sets.engaged.Aftermath.DT = set_combine(sets.Hybrid, {})	

	------------------------------------
    -- Custom buff sets
    --------------------------------------

    sets.buff.Doom = {
        neck = "Nicander's Necklace", --20
        ring1 = "Purity Ring", --7
        ring2 = "Eshmun's Ring", --20
        waist = "Gishdubar Sash", --10
		}
    
	sets.PhalanxRecieved = {
		head="Yorium Barbuta", --3, 
		body="Yorium Cuirass", --3,
		hands=SouveranHands.C, --5
		back="Weard Mantle", --5 
		legs="Sakpata's Cuisses", --5
		feet="Souveran Schuhs +1", --5
		}
	
	sets.buff.Cover = {head="Reverence Coronet +1", body="Cab. Surcoat +3"}
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------
function job_precast(spell, action, spellMap, eventArgs)
    equip(sets[state.WeaponSet.current])
	equip(sets[state.ShieldSet.current])

	if buffactive['terror'] or buffactive['petrification'] or buffactive['stun'] then
        add_to_chat(167, 'Stopped due to status.')
        eventArgs.cancel = true
        return
    end
	
	if spell.type == "WeaponSkill" and player.status == 'Engaged' and spell.target.distance > target_distance then -- Cancel WS If You Are Out Of Range --
       eventArgs.cancel=true
       add_to_chat(123, spell.name..' Canceled: [Out of Range]')
       return
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
--[[
function job_post_precast(spelll, action, spellMap, eventArgs)
	if state.DefenseMode.value ~= 'None' then
		if spell.action_type == 'Magic' then
				if sets.precast.FC[spell.english] and sets.precast.FC[spell.english].HP then
					equip(sets.precast.FC[spell.english].HP)
				elseif sets.precast.FC[spellMap] and sets.precast.FC[spellMap].HP then
					equip(sets.precast.FC[spellMap].HP)
				elseif sets.precast.FC[spell.skill] and sets.precast.FC[spell.skill].HP then
					equip(sets.precast.FC[spell.skill].HP)
				elseif sets.precast.FC.HP then
					equip(sets.precast.FC.HP)
				else
					handle_equipping_gear(player.status)
				end
		elseif spell.type == 'WeaponSkill' then
				if sets.precast.WS[spell.english] and sets.precast.WS[spell.english].DT then
					equip(sets.precast.WS[spell.english].DT)
				elseif sets.precast.WS.DT then
					equip(sets.precast.WS.DT)
				else
					handle_equipping_gear(player.status)
				end
		end
	end
end
]]--
function job_midcast(spell, action, spellMap, eventArgs)
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
--	if state.mainshield and spell.english ~= 'Phalanx' and spell.english ~= 'Reprisal' then
--		equip(sets.mainshield[state.mainshield.value])
--	end
--[[
	if state.DefenseMode.value == 'Physical' or state.DefenseMode.value == 'Magical' or state.IdleMode.value == 'Turtle'
		and state.CastingMode.value ~= 'SIRD' and spell.english ~= "Phalanx" then
			eventArgs.handled = true
			if spell.skill == 'Healing Magic' then
				equip(sets.midcast.Cure)
				add_to_chat(1, 'Midcast Magic Swap')
			elseif spell.english == 'Flash' then
				equip(sets.midcast.Flash.HP)
				add_to_chat(1, 'Midcast Magic Swap')
			elseif blue_magic_maps.Enmity:contains(spell.english) then
				equip(sets.Enmity.HP)
				add_to_chat(1, 'Midcast Magic Swap')
			end
	end
]]--
    if spell.skill == 'Enhancing Magic' and classes.NoSkillSpells:contains(spell.english) then
        equip(sets.midcast.EnhancingDuration)
		if spellMap == 'Protect' then
			equip(sets.midcast.Protect)
		elseif spellMap == 'Shell' then
			equip(sets.midcast.Shell)
        end
    end
end

function job_aftercast(spell, action, spellMap, eventArgs)
	equip(sets[state.WeaponSet.current])
	equip(sets[state.ShieldSet.current])
	handle_equipping_gear(player.status)
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for non-casting events.
-------------------------------------------------------------------------------------------------------------------

-- Called by the 'update' self-command, for common needs.
-- Set eventArgs.handled to true if we don't want automatic equipping of gear.

function job_update(cmdParams, eventArgs)
	handle_equipping_gear(player.status)
	update_defense_mode()
end

function update_combat_form()
	if player.sub_job == 'NIN' or player.sub_job == 'DNC' then
        if player.equipment.sub and not player.equipment.sub:contains('Shield') and
           player.equipment.sub ~= 'Aegis' and player.equipment.sub ~= 'Ochain' then
			meleeSet = set_combine(meleeSet, sets.DW)
		end
	end
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
	
	if buff == "sleep" then
		if gain then
			equip(sets.buff.Sleep)
	    end
	end
	

    if buff:startswith('Aftermath') then
        state.Buff.Aftermath = gain
        customize_melee_set()
        handle_equipping_gear(player.status)
    end

	
end

function job_handle_equipping_gear(playerStatus, eventArgs)
	update_combat_form()
	update_defense_mode()
end

-- Handle notifications of general user state change.
function job_state_change(stateField, newValue, oldValue)
    if state.WeaponLock.value == true then
        disable('main','sub')
    else
        enable('main','sub')
    end

	equip(sets[state.WeaponSet.current])
	equip(sets[state.ShieldSet.current])
	update_combat_form()
end

-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------

function job_update(cmdParams, eventArgs)
    equip(sets[state.WeaponSet.current])
	equip(sets[state.ShieldSet.current])
    handle_equipping_gear(player.status)
	update_combat_form()
	update_defense_mode()
end

function customize_idle_set(idleSet)
	return idleSet

end

-- Modify the default melee set after it was constructed.
function customize_melee_set(meleeSet)

	if buffactive['Aftermath: Lv.3'] and player.equipment.main == "Burtgang"
        and state.DefenseMode.value == 'None' then
        if state.HybridMode.value == "DT" then
            meleeSet = set_combine(meleeSet, sets.engaged.Aftermath.DT)
        else
            meleeSet = set_combine(meleeSet, sets.engaged.Aftermath)
        end
    end

	if player.sub_job == 'NIN' or player.sub_job == 'DNC' then
        if player.equipment.sub and not player.equipment.sub:contains('Shield') and
           player.equipment.sub ~= 'Aegis' and player.equipment.sub ~= 'Ochain' then
			meleeSet = set_combine(meleeSet, sets.DW)
		end
	end
	
    return meleeSet
end

function customize_defense_set(defenseSet)
    return defenseSet
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
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------
function get_custom_wsmode(spell, action, spellMap)
 --[[
	if spell.type == 'WeaponSkill' then
        if state.AttackMode.value == 'Uncapped' and state.DefenseMode.value == 'None' and state.HybridMode.value == 'Normal' then
            return "Uncapped"
        elseif state.DefenseMode.value ~= 'None' or state.HybridMode.value == 'DT' then
            return "Safe"
        end
    end
	]]--
end

function job_self_command(cmdParams, eventArgs)
    if cmdParams[1] == 'tds' then
        local newTargetDistance = tonumber(cmdParams[2])
        if not newTargetDistance then
            add_to_chat(123, '[Invalid parameter. Example syntax: gs c tds 5.5]')
            return
        end
        if newTargetDistance > 0 then
            target_distance = newTargetDistance
            add_to_chat(122, '[Weaponskill max range set to '..newTargetDistance..' yalms.]')
        else
            add_to_chat(123, '[Invalid parameter. Example syntax: gs c tds 5.5]')
        end
    end
	if cmdParams[1] == 'dem' then
		send_command('input /equip ring2 "Dimensional ring (Dem)"; wait 12; input /item "Dimensional ring (Dem)" <me>')
        add_to_chat(158,'dem ring')
	end
end

function update_defense_mode()
    if player.sub_job == 'NIN' or player.sub_job == 'DNC' then
        if player.equipment.sub and not player.equipment.sub:contains('Shield') and
           player.equipment.sub ~= 'Aegis' and player.equipment.sub ~= 'Ochain' then
           state.CombatForm:set('DW')
        else
            state.CombatForm:reset()
        end
    end
end


-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    -- Default macro set/book
    if player.sub_job == 'WAR' then
        set_macro_page(1, 1)
    elseif player.sub_job == 'NIN' then
        set_macro_page(1, 1)
	elseif player.sub_job == 'DRK' then
        set_macro_page(1, 1)
    elseif player.sub_job == 'RDM' then
        set_macro_page(1, 1)
    else
        set_macro_page(1, 1)
    end
end
function set_lockstyle()
     send_command('wait 2; input /lockstyleset 20')
end