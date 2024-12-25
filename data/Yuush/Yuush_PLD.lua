
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

    blue_magic_maps.Enmity = S{'Blank Gaze', 'Jettatura', 'Soporific','Poison Breath', 'Blitzstrahl', 'Chaotic Eye',
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
    state.OffenseMode:options('Normal', 'Acc', 'MEVA')
    state.HybridMode:options('Normal', 'DT', 'HP', 'MEVA')
    state.WeaponskillMode:options('Normal', 'DT')
	state.CastingMode:options('Normal', 'SIRD', 'HP', 'HPSIRD')
    state.PhysicalDefenseMode:options('PDT','Block')
    state.MagicalDefenseMode:options('MDT','MEVA')
	state.IdleMode:options('Normal', 'Turtle')
	
	state.WeaponSet = M{['description']='Weapon Set', 'Burtgang', 'Excalibur', 'Almace', 'Naegling', 'Malevolence'}
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
	sets.Malevolence = {main="Malevolence"}
	
    --------------------------------------
    -- Precast sets | Shield Swapping Okay
    --------------------------------------

    sets.precast.JA['Invincible'] = {legs="Cab. Breeches +1"}
    sets.precast.JA['Holy Circle'] = {feet="Rev. Leggings +2"}
    sets.precast.JA['Shield Bash'] = {hands="Cab. Gauntlets +3", ear1 = "Knightly Earring"}
    sets.precast.JA['Sentinel'] = {feet="Cab. Leggings +3"}
    sets.precast.JA['Rampart'] = {head="Cab. Coronet +1"}
    sets.precast.JA['Fealty'] = {body="Cab. Surcoat +1"}
    sets.precast.JA['Divine Emblem'] = {feet="Chev. Sabatons +1"}
    sets.precast.JA['Cover'] = {"Cab. Coronet +1"}
    sets.precast.JA['Chivalry'] = {hands="Cab. Gauntlets +1"}
    
	sets.Enmity = {
		ammo = "Sapience Orb",
		head = "Loess Barbuta +1",
		neck = "Moonlight Necklace",
		--ear1 = "Trux Earring",
		ear1 = "Odnowa Earring +1",
		ear2 = "Cryptic Earring",
		body = "Souv. Cuirass +1",
		hands = "Yorium Gauntlets",
		ring1 = "Apeile Ring +1",
		ring2 = "Eihwaz Ring",
		back = Rudianos.Enmity,
		waist = "Creed Baudrier",
		legs = OdysseanLegs.Enmity,
		feet = "Eschite Greaves"
		}
	sets.Enmity.HP = set_combine(sets.Enmity, {
		head = {name= SouveranHead.C, priority=1},
		neck = "Unmoving Collar +1",
		ear1 = "Odnowa Earring +1",
		legs = {name="Souv. Diechlings +1", priority=2},
		feet = {name="Souveran Schuhs +1", priority=3},
		})
	
	sets.Enmity.SIRD = set_combine(sets.Enmity,{})
	sets.Enmity.HPSIRD = set_combine(sets.Enmity.HP,{})
	
    -- Fast cast sets for spells
	--2375 76 FC
	sets.precast.FC = {
		ammo = "Sapience Orb", --2
		head = "Carmine Mask +1", --14
		neck = "Baetyl Pendant", --4
		ear1 = {name="Tuisto Earring", priority=6},
		ear2 = "Etiolation Earring", --1
		body = {name="Rev. Surcoat +3", priority=3}, --10
		hands = "Leyline Gloves", --8
		ring1 = "Kishar Ring", --4
        ring2 = "Prolix Ring", --2
		back = Rudianos.FC, --10
		waist = "Creed Baudrier",
		legs = "Enif Cosciales", --8
		feet = OdysseanFeet.FC, --11
		}
		
	--3k hp , 55 FC
    sets.precast.FC.HP = set_combine(sets.precast.FC, {
		ammo = {name="Egoist's Tathlum", priority=4},
		--neck = "Unmoving Collar" -- +200 hp @r15
		hands = SouveranHands.C,
		ring2 = {name="Moonbeam Ring", priority=1},
		feet = "Carmine Greaves +1", --8
		}) 
	
	sets.precast.FC.SIRD = sets.precast.FC
	sets.precast.FC.HPSIRD = sets.precast.FC.HP
	
    sets.precast.FC['Enhancing Magic'] = set_combine(sets.precast.FC, {waist="Siegel Sash"})
    sets.precast.FC['Enhancing Magic'].HP = set_combine(sets.precast.FC.HP, {waist="Siegel Sash"})
	sets.precast.FC['Enhancing Magic'].SIRD =  set_combine(sets.precast.FC, {waist="Siegel Sash"})
	sets.precast.FC['Enhancing Magic'].HPSIRD = set_combine(sets.precast.FC.HP, {waist="Siegel Sash"})
	
-------------------------------------------------------------------------------------------------------------------	
-- Weaponskill sets
-------------------------------------------------------------------------------------------------------------------	
	
    -- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS = {
		ammo = "Aurgelmir Orb",
		head = ValorousHead.WSD,
		neck = "Caro Necklace",
		ear1 = "Moonshade Earring",
		ear2 = "Thrud Earring",
		body = ValorousBody.WSD,
		hands = OdysseanHands.WSD,
		ring1 = "Epaminondas's Ring",
		ring2 = "Karieyh Ring",
		back = Rudianos.WSD,
		waist = "Sailfi Belt +1",
		legs = OdysseanLegs.WSD, 
		feet = "Sulev. Leggings +2",
		}	
	
--	sets.precast.WS.HP = {}
	
	sets.precast.WS['Savage Blade'] = {
		ammo = "Aurgelmir Orb",
		head = ValorousHead.WSD,
		neck = "Caro Necklace",
		ear1 = "Moonshade Earring",
		ear2 = "Thrud Earring",
		body = ValorousBody.WSD,
		hands = OdysseanHands.WSD,
		ring1 = "Epaminondas's Ring",
		ring2 = "Karieyh Ring",
		back = Rudianos.WSD,
		waist = "Sailfi Belt +1",
		legs = OdysseanLegs.WSD, 
		feet = "Sulev. Leggings +2",
		}
	
	sets.precast.WS["Knights of Round"] = sets.precast.WS['Savage Blade']

    sets.precast.WS['Chant du Cygne'] = {
		ammo = "Aurgelmir Orb",
		head = "Flam. Zucchetto +2",
		neck = "Fotia Gorget",
		ear1 = "Mache Earring +1",
		ear2 = "Lugra Earring +1",
		body = "Hjarrandi Breast.",
		hands = "Flam. Manopolas +2",
		ring1 = "Regal Ring",
		ring2 = "Begrudging Ring",
--		ring2 = "Flamma Ring", Not sure if this is better than begrudging
		back = Rudianos.CRIT,
		waist = "Fotia Belt",
		legs = "Lustr. Subligar +1",
		feet = "Flam. Gambieras +2",
		}
	
	-- Focus on HP/DT/Enmity  Nobody cares about your 2k damage Nobody cares about your 2k damage
	-- Nobody cares about your 2k damage Nobody cares about your 2k damage Nobody cares about your 2k damage
	-- Nobody cares about your 2k damage Nobody cares about your 2k damage Nobody cares about your 2k damage
	-- Nobody cares about your 2k damage Nobody cares about your 2k damage Nobody cares about your 2k damage
	sets.precast.WS['Atonement'] = {-- Nobody cares about your 2k damage Nobody cares about your 2k damage
		ammo = "Staunch Tathlum +1",-- Nobody cares about your 2k damage Nobody cares about your 2k damage
		head = SouveranHead.C,-- Nobody cares about your 2k damage Nobody cares about your 2k damage
		neck = "Unmoving Collar +1",-- Nobody cares about your 2k damage Nobody cares about your 2k damage
		ear1 = "Moonshade Earring",-- Nobody cares about your 2k damage Nobody cares about your 2k damage
		ear2 = "Cryptic Earring",-- Nobody cares about your 2k damage Nobody cares about your 2k damage
		body = "Souv. Cuirass +1",-- Nobody cares about your 2k damage Nobody cares about your 2k damage
		hands = SouveranHands.C,-- Nobody cares about your 2k damage Nobody cares about your 2k damage
		ring1 = "Defending Ring",-- Nobody cares about your 2k damage Nobody cares about your 2k damage
		ring2 = "Eihwaz Ring",-- Nobody cares about your 2k damage Nobody cares about your 2k damage
		back = Rudianos.Enmity,-- Nobody cares about your 2k damage Nobody cares about your 2k damage
		waist = "Fotia Belt",-- Nobody cares about your 2k damage Nobody cares about your 2k damage
		legs = "Souveran Diechlings +1",-- Nobody cares about your 2k damage Nobody cares about your 2k damage
		feet = "Souveran Schuhs +1"-- Nobody cares about your 2k damage Nobody cares about your 2k damage
		} -- Nobody cares about your 2k damage Nobody cares about your 2k damage
	
	sets.precast.WS['Requiescat'] = {
		ammo = "Amar Cluster",
		head = "Hjarrandi Helm",
		neck = "Fotia Gorget",
		ear1 = "Brutal Earring",
		ear2 = "Cessance Earring",
		body = ValorousBody.DA,
		hands = "Sulev. Gauntlets +2",
		ring1 = "Rufescent Ring",
		ring2 = "Flamma Ring",
		back = Rudianos.DA,
		waist = "Fotia Belt",
		legs = "Sulev. Cuisses +2",
		feet = ValorousFeet.QA
		}
	
	sets.precast.WS['Sanguine Blade'] = {
		ammo = "Pemphredo Tathlum",
		head = "Pixie Hairpin +1",
		neck = "Baetyl Necklace",
		ear1 = "Moonshade Earring",
		ear2 = "Friomisi Earring",
		body = "Sacro Breastplate",
		hands = "Founder's Gauntlets +1",
		ring1 = "Epaminondas's Ring",
		ring2 = "Karieyh Ring",
		back = Rudianos.WSD,
		waist = "Fotia Belt",
		legs = "Eschite Cuisses",
		feet = "Founder's Greaves",
		}
	
	-- Dagger
	sets.precast.WS['Aeolian Edge'] = set_combine(sets.precast.WS['Sanguine Blade'],{
		head = "Jumalik Helm",
		hands = "Carmine Fin. Ga. +1",
		waist = "Fotia Belt",
		})


	
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
		main = "Burtgang",	   
	    ammo = "Sapience Orb",
		head = "Loess Barbuta +1",
		neck = {name="Sacro Gorget", priority=1}, --10 
		ear1 = "Nourish. Earring +1", --6~7
		ear2 = "Mendi. Earring", --5
		body = "Souveran Cuirass +1", --11
		hands = "Macabre Gaunt. +1", --11
        ring1 = "Eihwaz Ring",
        ring2 = "Apeile Ring +1",
		back = Rudianos.Cure, --10
		waist = "Creed Baudrier",
		legs = {name="Souv. Diechlings +1",priority=3}, 
		feet = {name="Souveran Schuhs +1", priority=2}, 
		}
	--**There is a more potent Emnity Combo that requires r15 Nourishing Earring and is 101% SIR**
	sets.midcast.Cure.SIRD = set_combine(sets.midcast.Cure, {
	    ammo = "Staunch Tathlum +1", --11%
		head = SouveranHead.C,
		--Loess +14~Emnity +20~ DT
		neck = "Loricate Torque +1",
		--Moonlight
		--ear2 Odnowa
		ring1 = "Defending Ring",
		--Eihwaz
		waist = "Audumbla Sash", --10%
		legs = "Founder's Hose", --30%
		feet = OdysseanFeet.Cure, --13 | 20%
		})

    sets.midcast.Cure.HP = set_combine(sets.midcast.Cure, {
		ammo = "Staunch Tathlum +1",
		head = SouveranHead.C,
        ring1 = "Defending Ring",
		ring2 = "Moonbeam Ring",
		})
		
	sets.midcast.Cure.HPSIRD = set_combine(sets.midcast.Cure.HP, {
		hands = SouveranHands.C,
		--ear1 = "Tuisto Earring",
		--ear2 = "Nourish. Earring +1",
		ear2 = "Odnowa Earring +1",
		ring2 = "Moonbeam Ring",
		--ring2 = "Gelatinous Ring +1" --r15
		waist = "Audumbla Sash", --10%
		legs = "Founder's Hose", --30%
		feet = OdysseanFeet.Cure, --13 | 20%
		})
	
	
	sets.midcast['Enhancing Magic'] = {}
	sets.midcast['Enhancing Magic'].HP = {}
	sets.midcast['Enhancing Magic'].SIRD = {}
	sets.midcast['Enhancing Magic'].HPSIRD = {}
    
	--Next Tier at +28 skill for +1 dmg reduction (not worth)
	sets.midcast['Phalanx'] =  { 
		sub = "Priwen",
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
		legs = "Yorium Cuisses", --3,
		feet = "Souveran Schuhs +1", --5
		}
		
    sets.midcast['Reprisal'] = { --HP*2--
		--sub = "Ajax +1", 15% duration
		ammo = "Egoist's Tathlum",
		head = "Souv. Schaller +1",
		neck = "Unmoving Collar +1",
		ear1 = "Tuisto Earring",
		ear2 = "Odnowa Earring +1",
		--body = "Rev. Surcoat +3",
		body = "Shabti Cuirass +1", --10% dura
		hands = "Souv. Handsch. +1",
		--Regal +20% Duration
        ring1 = "Gelatinous Ring +1",
        ring2 = "Moonbeam Ring",
		back = Rudianos.FC,
		waist = "Goading Belt",
		legs = "Souv. Diechlings +1",
		feet = "Souveran Schuhs +1",
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
		ammo = "Staunch Tathlum +1",
		head = "Jumalik Helm",
		neck = "Incanter's Torque",
		ear1 = "Odnowa Earring +1",
		ear2 = "Etiolation Earring",
		body = "Rev. Surcoat +3",
		hands = "Eschite Gauntlets",
		ring1 = "Defending Ring",
		ring2 = "Moonbeam Ring",
		back = "Moonbeam Cape",
		waist = "Creed Baudrier",
		legs = "Souv. Diechlings +1",
		feet = "Souveran Schuhs +1",
		}
	sets.midcast['Enlight II'] = sets.midcast['Enlight']
	
    sets.midcast.Diaga = sets.Enmity

    sets.midcast['Blue Magic'] = set_combine(sets.midcast.SIRD, {}) 
    sets.midcast['Blue Magic'].Enmity = sets.Enmity
	sets.midcast['Blue Magic'].Enmity.SIRD = {
		ammo = "Staunch Tathlum +1", --11%
		head = SouveranHead.C, --20%
		neck = "Moonlight Necklace", --15%
		ear1 = "Odnowa Earring +1",
		ear2 = "Knightly Earring", --9%
		body = "Souv. Cuirass +1",
		hands = SouveranHands.C, 
		ring1 = "Eihwaz Ring",
		ring2 = "Apeile Ring",
		back = Rudianos.Enmity,
		waist = "Audumbla Sash", --10%
		legs = "Founder's Hose", --30%
		feet = "Souveran Schuhs +1", 
		}--95+10merits
    sets.midcast['Blue Magic'].Cure = sets.midcast.Cure.SIRD
    sets.midcast['Blue Magic'].Buff = sets.midcast.SIRD

    --------------------------------------
    -- Idle/resting/defense/etc sets
    --------------------------------------
	
	sets.idle = {
		ammo = "Staunch Tathlum +1",
		head = SouveranHead.D,
		neck = "Loricate Torque +1",
		ear1 = "Tuisto Earring",
		ear2 = "Odnowa Earring +1",
		body = "Sacro Breastplate",
		hands = SouveranHands.D,
		ring1 = "Defending Ring",
        ring2 = "Moonbeam Ring",
		back = Rudianos.Tank,
		waist = "Flume Belt +1",
		legs = "Carmine Cuisses +1",
		feet = "Rev. Leggings +2", 
		}
		
	sets.idle.Turtle = set_combine(sets.idle,{
		--main = "Burtgang", -- 23
		head = SouveranHead.C, --9
		neck = "Unmoving Collar +1", --10
		body = "Souv. Cuirass +1", --20
		hands = SouveranHands.C, --9
        ring2 = "Apeile Ring +1", --5~9
		legs = "Souv. Diechlings +1", --9
		})--95~99 Emnity

    --------------------------------------
    -- Defense sets
    --------------------------------------
    
	-- Turtle Tanking 3000+ HP | 102 Emnity (100cap)
    sets.defense.PDT = {
		--main = "Burtgang", -- 23
		ammo = "Staunch Tathlum +1",
		head = SouveranHead.C, --9
		neck = "Unmoving Collar +1", --10
		ear1 = "Tuisto Earring",
		ear2 = "Odnowa Earring +1",
		body = "Souv. Cuirass +1", --20
		hands = SouveranHands.C, --9
		ring1 = "Defending Ring",
        ring2 = "Moonbeam Ring",
		back = Rudianos.Tank, --10
		waist = "Goading Belt", --3
		legs = "Souv. Diechlings +1", --9
		feet = "Souveran Schuhs +1", --9
		}
		
	--Ochain Math Reprisal UP, +30skill, and +10 Blockrate = 100% on ilvl150 mobs
	sets.defense.Block = set_combine(sets.defense.PDT, {
		sub = "Ochain",
		neck = "Combatant's Torque",
		hands = SouveranHands.D,
		back = Rudianos.Block,
		--Empy head has 11 skill
		--AF+3 feet have 21 skill and MP conversion
		--+10 skill on ear, +2 blockrate on ear.
		--Ear + Feet seem like a decent swap from neck + hands if needed.
		})
	
	-- Magic Defense Swap for them there booms
	-- Not PDT capped don't fulltime
    sets.defense.MDT = {
		sub = "Aegis",
		ammo = "Staunch Tathlum +1",
		head = "Hjarrandi Helm",
		neck = "Warder's Charm +1",
		ear1 = "Tuisto Earring",
		ear2 = "Odnowa Earring +1",
		body = "Sacro Breastplate",
		--hands = Volte??
		hands = "Cab. Gauntlets +3",
		ring1 = "Defending Ring",
        ring2 = "Shadow Ring",
		back = Rudianos.Tank,
		waist = "Asklepian Belt",
		legs = "Volte Brayettes",
		feet = "Cab. Leggings +3", 
		--feet = Volte??
		}
	
	--MEVA tanking
	--Fulltime is okie dokie
	sets.defense.MEVA = {
		sub = "Priwen",
		ammo = "Staunch Tathlum +1",
		head = "Hjarrandi Helm",
		--head = Volte
		neck = "Warder's Charm +1",
		ear1 = "Tuisto Earring",
		ear2 = "Odnowa Earring +1",
		body = "Sacro Breastplate",
		hands = "Macabre Gaunt. +1",
		ring1 = "Defending Ring",
        ring2 = "Moonbeam Ring",
		back = Rudianos.Tank,
		waist = "Asklepian Belt",
		legs = "Volte Brayettes",
		feet = "Cab. Leggings +3", 
		--feet = Volte
		}
	
-------------------------------------------------------------------------------------------------------------------
-- Engaged Sets
-------------------------------------------------------------------------------------------------------------------	
	--2.1k hp
	sets.engaged = {
		ammo = "Aurgelmir Orb",
		head = "Flam. Zucchetto +2",
		neck = "Combatant's Torque",
		--Vim Torque R15
		ear1 = "Brutal Earring",
		ear2 = "Cessance Earring",
		body = ValorousBody.STP,
		hands = "Sulev. Gauntlets +2",
		ring1 = "Petrov Ring",
		ring2 = "Flamma Ring",
		back = Rudianos.DA,
		waist = "Sailfi Belt +1",
		legs = OdysseanLegs.STP,
		feet = ValorousFeet.QA
		}	
		
    sets.engaged.Acc = set_combine(sets.engaged, {
		ear2 = "Telos Earring",
		feet = "Flam. Gambieras +2",
		})
	
	sets.engaged.Aftermath = {
		ammo = "Aurgelmir Orb",
		head = "Hjarrandi Helm",
		neck = "Combatant's Torque",
		--Vim Torque R15
		ear1 = "Dedition Earring",
		ear2 = "Telos Earring",
		body = "Hjarrandi Breast.",
		hands = "Flam. Manopolas +2",
		ring1 = "Petrov Ring",
		ring2 = "Flamma Ring",
		back = Rudianos.STP,
		waist = "Tempus Fugit",
		legs = OdysseanLegs.STP,
		feet = ValorousFeet.STP
		}
    
-------------------------------------------------------------------------------------------------------------------
-- Hybrid Sets
-------------------------------------------------------------------------------------------------------------------	
	
	sets.Hybrid = {
		ammo = "Aurgelmir Orb",
		head = "Hjarrandi Helm",
		neck = "Loricate Torque +1",
		ear1 = "Brutal Earring",
		ear2 = "Cessance Earring",
		body = "Hjarrandi Breast.",
		hands = "Flam. Manopolas +2",
        ring1 = "Defending Ring",
        ring2 = "Moonbeam Ring",
		back = Rudianos.DA,
		waist = "Tempus Fugit",
		legs = OdysseanLegs.DA,
		feet = ValorousFeet.QA
		}
	
	sets.engaged.DT = set_combine(sets.engaged, sets.Hybrid)			
	sets.engaged.Acc.DT = set_combine(sets.Hybrid, {})	
	sets.engaged.Aftermath.DT = set_combine(sets.Hybrid, {})	

	sets.engaged.HP = set_combine(sets.engaged, sets.Hybrid)			
	sets.engaged.Acc.HP = set_combine(sets.Hybrid, {})	
	sets.engaged.Aftermath.HP = set_combine(sets.Hybrid, {})	

	sets.engaged.MEVA = set_combine(sets.engaged, sets.Hybrid)			
	sets.engaged.Acc.MEVA = set_combine(sets.Hybrid, {})	
	sets.engaged.Aftermath.MEVA = set_combine(sets.Hybrid, {})	

	------------------------------------
    -- Custom buff sets
    --------------------------------------

    sets.buff.Doom = {
		neck = "Nicander's Necklace", --20
		ring1 = {name = "Eshmun's Ring", bag="wardrobe1"},  --20
        ring2 = {name = "Eshmun's Ring", bag="wardrobe2"},  --20
		waist = "Gishdubar Sash", --10
		legs = "Shabti Cuisses +1", --15
		}
    
	sets.buff.Cover = {head="Reverence Coronet +1", body="Cab. Surcoat +1"}
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------
function job_precast(spell, action, spellMap, eventArgs)
    equip(sets[state.WeaponSet.current])
	
	if buffactive['terror'] or buffactive['petrification'] or buffactive['stun'] or buffactive['sleep'] then
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
	update_combat_form()
end

-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------

function job_update(cmdParams, eventArgs)
    equip(sets[state.WeaponSet.current])
    handle_equipping_gear(player.status)
	update_combat_form()
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
     send_command('wait 2; input /lockstyleset 1')
end