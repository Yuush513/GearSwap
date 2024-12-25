-------------------------------------------------------------------------------------------------------------------
--  Keybinds
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
--------------------------------------------------------------------------------------------------------------------
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
    state.Buff['Burst Affinity'] = buffactive['Burst Affinity'] or false
    state.Buff['Chain Affinity'] = buffactive['Chain Affinity'] or false
    state.Buff.Convergence = buffactive.Convergence or false
    state.Buff.Diffusion = buffactive.Diffusion or false
    state.Buff.Efflux = buffactive.Efflux or false

    state.Buff['Unbridled Learning'] = buffactive['Unbridled Learning'] or false
    blue_magic_maps = {}

    -- Mappings for gear sets to use for various blue magic spells.
    -- While Str isn't listed for each, it's generally assumed as being at least
    -- moderately signficant, even for spells with other mods.

    -- Physical spells with no particular (or known) stat mods
    blue_magic_maps.Physical = S{'Bilgestorm'}

    -- Spells with heavy accuracy penalties, that need to prioritize accuracy first.
    blue_magic_maps.PhysicalAcc = S{'Heavy Strike'}

    -- Physical spells with Str stat mod
    blue_magic_maps.PhysicalStr = S{'Battle Dance','Bloodrake','Death Scissors','Dimensional Death',
        'Empty Thrash','Quadrastrike','Saurian Slide','Sinker Drill','Spinal Cleave','Sweeping Gouge',
        'Uppercut','Vertical Cleave'}

    -- Physical spells with Dex stat mod
    blue_magic_maps.PhysicalDex = S{'Amorphic Spikes','Asuran Claws','Barbed Crescent','Claw Cyclone',
        'Disseverment','Foot Kick','Frenetic Rip','Goblin Rush','Hysteric Barrage','Paralyzing Triad',
        'Seedspray','Sickle Slash','Smite of Rage','Terror Touch','Thrashing Assault','Vanity Dive'}

    -- Physical spells with Vit stat mod
    blue_magic_maps.PhysicalVit = S{'Body Slam','Cannonball','Delta Thrust','Glutinous Dart','Grand Slam',
        'Power Attack','Quad. Continuum','Sprout Smack','Sub-zero Smash'}

    -- Physical spells with Agi stat mod
    blue_magic_maps.PhysicalAgi = S{'Benthic Typhoon','Feather Storm','Helldive','Hydro Shot','Jet Stream',
        'Pinecone Bomb','Spiral Spin','Wild Oats'}

    -- Physical spells with Int stat mod
    blue_magic_maps.PhysicalInt = S{'Mandibular Bite','Queasyshroom'}

    -- Physical spells with Mnd stat mod
    blue_magic_maps.PhysicalMnd = S{'Ram Charge','Screwdriver','Tourbillion'}

    -- Physical spells with Chr stat mod
    blue_magic_maps.PhysicalChr = S{'Bludgeon'}

    -- Physical spells with HP stat mod
    blue_magic_maps.PhysicalHP = S{'Final Sting'}

    -- Magical spells with the typical Int mod
    blue_magic_maps.Magical = S{'Anvil Lightning','Blastbomb','Blazing Bound','Bomb Toss','Cursed Sphere',
        'Droning Whirlwind','Embalming Earth','Entomb','Firespit','Foul Waters','Ice Break','Leafstorm',
        'Maelstrom','Molting Plumage','Nectarous Deluge','Regurgitation','Rending Deluge','Scouring Spate',
        'Silent Storm','Spectral Floe','Subduction','Tem. Upheaval','Water Bomb'}

    blue_magic_maps.MagicalDark = S{'Dark Orb','Death Ray','Eyes On Me','Evryone. Grudge','Palling Salvo',
        'Tenebral Crush'}

    blue_magic_maps.MagicalLight = S{'Blinding Fulgor','Diffusion Ray','Radiant Breath','Rail Cannon',
        'Retinal Glare'}

    -- Magical spells with a primary Mnd mod
    blue_magic_maps.MagicalMnd = S{'Acrid Stream','Magic Hammer','Mind Blast'}

    -- Magical spells with a primary Chr mod
    blue_magic_maps.MagicalChr = S{'Mysterious Light'}

    -- Magical spells with a Vit stat mod (on top of Int)
    blue_magic_maps.MagicalVit = S{'Thermal Pulse'}

    -- Magical spells with a Dex stat mod (on top of Int)
    blue_magic_maps.MagicalDex = S{'Charged Whisker','Gates of Hades'}

    -- Magical spells (generally debuffs) that we want to focus on magic accuracy over damage.
    -- Add Int for damage where available, though.
    blue_magic_maps.MagicAccuracy = S{'1000 Needles','Absolute Terror','Actinic Burst','Atra. Libations',
        'Auroral Drape','Awful Eye', 'Blank Gaze','Blistering Roar','Blood Saber','Chaotic Eye',
        'Cimicine Discharge','Cold Wave','Corrosive Ooze','Demoralizing Roar','Digest','Dream Flower',
        'Enervation','Feather Tickle','Filamented Hold','Frightful Roar','Geist Wall','Hecatomb Wave',
        'Infrasonics','Jettatura','Light of Penance','Lowing','Mind Blast','Mortal Ray','MP Drainkiss',
        'Osmosis','Reaving Wind','Sandspin','Sandspray','Sheep Song','Soporific','Sound Blast',
        'Stinking Gas','Sub-zero Smash','Venom Shell','Voracious Trunk','Yawn'}

    -- Breath-based spells
    blue_magic_maps.Breath = S{'Bad Breath','Flying Hip Press','Frost Breath','Heat Breath','Hecatomb Wave',
        'Magnetite Cloud','Poison Breath','Self-Destruct','Thunder Breath','Vapor Spray','Wind Breath'}

    -- Stun spells
    blue_magic_maps.Stun = S{'Blitzstrahl','Frypan','Head Butt','Sudden Lunge','Tail slap','Temporal Shift',
        'Thunderbolt','Whirl of Rage'}

    -- Healing spells
    blue_magic_maps.Healing = S{'Healing Breeze','Magic Fruit','Plenilune Embrace','Pollen','Restoral',
        'White Wind','Wild Carrot'}

    -- Buffs that depend on blue magic skill
    blue_magic_maps.SkillBasedBuff = S{'Barrier Tusk','Diamondhide','Magic Barrier','Metallic Body',
        'Plasma Charge','Pyric Bulwark','Reactor Cool','Occultation'}

    -- Other general buffs
    blue_magic_maps.Buff = S{'Amplification','Animating Wail','Carcharian Verve','Cocoon',
        'Erratic Flutter','Exuviation','Fantod','Feather Barrier','Harden Shell','Memento Mori',
        'Nat. Meditation','Orcish Counterstance','Refueling','Regeneration','Saline Coat','Triumphant Roar',
        'Warm-Up','Winds of Promyvion','Zephyr Mantle'}

    blue_magic_maps.Refresh = S{'Battery Charge'}

    -- Spells that require Unbridled Learning to cast.
    unbridled_spells = S{'Absolute Terror','Bilgestorm','Blistering Roar','Bloodrake','Carcharian Verve','Cesspool',
        'Crashing Thunder','Cruel Joke','Droning Whirlwind','Gates of Hades','Harden Shell','Mighty Guard',
        'Polar Roar','Pyric Bulwark','Tearing Gust','Thunderbolt','Tourbillion','Uproot'}

    -- For th_action_check():
    -- JA IDs for actions that always have TH: Provoke, Animated Flourish
    info.default_ja_ids = S{35, 204}
    -- Unblinkable JA IDs for actions that always have TH: Quick/Box/Stutter Step, Desperate/Violent Flourish
    info.default_u_ja_ids = S{201, 202, 203, 205, 207}

    set_lockstyle()
end

-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
    state.OffenseMode:options('Normal', 'LowAcc', 'Acc')
    state.HybridMode:options('Normal', 'DT')
    state.CastingMode:options('Normal', 'Macc')
	state.PhysicalDefenseMode:options('PDT')
    state.MagicalDefenseMode:options('MDT')
    state.IdleMode:options('Normal', 'DT')

    state.MagicBurst = M(false, 'Magic Burst')
    state.CP = M(false, "Capacity Points Mode")

    --local binds
    send_command('bind !` gs c toggle MagicBurst')
    --send_command('bind @c gs c toggle CP')
	send_command('bind ^f11 gs c cycle MagicalDefenseMode')

    select_default_macro_book()
    set_lockstyle()

    moving = false
    update_combat_form()

end

-- Called when this job file is unloaded (eg: job change)
function user_unload()
    send_command('unbind !`')
    --send_command('unbind @c')
	send_command('unbind ^f11')
	send_command('unbind !f9')
end

-- Define sets and vars used by this job file.
function init_gear_sets()

    ------------------------------------------------------------------------------------------------
    ---------------------------------------- Precast Sets ------------------------------------------
    ------------------------------------------------------------------------------------------------

    -- Precast sets to enhance JAs

    -- Enmity set
    sets.Enmity = {}

    sets.precast.JA['Provoke'] = sets.Enmity

    --sets.buff['Burst Affinity'] = {legs="Assim. Shalwar +2", feet="Hashi. Basmak +1"}
    sets.buff['Diffusion'] = {feet="Luhlaza Charuqs +1"}
    sets.buff['Efflux'] = {legs="Hashishin Tayt +1"}

    --sets.precast.JA['Azure Lore'] = {hands="Luhlaza Bazubands"}
    --sets.precast.JA['Chain Affinity'] = {feet="Assim. Charuqs +1"}
    --sets.precast.JA['Convergence'] = {head="Luh. Keffiyeh +1"}
    --sets.precast.JA['Enchainment'] = {body="Luhlaza Jubbah +1"}
	
	-- Erratic Flutter set gives +15
    sets.precast.FC = {
		ammo = "Staunch Tathlum +1",
        head = "Carmine Mask +1", --14
		neck = "Baetyl Pendant", --4
		ear1 = "Loquacious Earring", --2
        ear2 = "Etiolation Earring", --1
        body = "Adhemar Jacket", --7
        hands = "Leyline Gloves", --8
		ring1 = "Kishar Ring", --4
		ring2 = "Prolix Ring", --2
		back = Rosmerta.FC, --10
        waist = "Witful Belt", --3/(3)
        legs = "Enif Cosciales", --8
        feet = "Carmine Greaves +1", --8
        } --71

    sets.precast.FC['Blue Magic'] = set_combine(sets.precast.FC, {
		body = "Hashishin Mintan +1" --14
		}) --79 
		
    sets.precast.FC['Enhancing Magic'] = set_combine(sets.precast.FC, {
		waist="Siegel Sash" --8
		}) --76
    
	sets.precast.FC.Cure = set_combine(sets.precast.FC, {})

    sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, {})


    ------------------------------------------------------------------------------------------------
    ------------------------------------- Weapon Skill Sets ----------------------------------------
    ------------------------------------------------------------------------------------------------

    sets.precast.WS = {
        ammo = "Coiste Bodhar",
        head = HerculeanHead.STR_WSD,
		neck = "Fotia Gorget",
        ear1 = "Moonshade Earring",
        ear2 = "Ishvara Earring",
        body = "Assim. Jubbah +3",
        hands = "Jhakri Cuffs +2",
		ring1 = "Ilabrat Ring",
        ring2 = "Karieyh Ring",
        back = Rosmerta.WSD,
        waist = "Fotia Belt",
        legs = "Luhlaza Shalwar +2",
        feet = HerculeanFeet.STR_WSD,
        }
	
    sets.precast.WS['Chant du Cygne'] = {
		ammo = "Coiste Bodhar",
		head = "Adhemar Bonnet +1",
		neck = "Fotia Gorget",
		--Blu +2 neck is BIS
		ear1 = "Mache Earring +1", 
		ear2 = "Odr Earring",
		body = HerculeanBody.CRIT,
		hands = AdhemarHands.B, 
		ring1 = "Epona's Ring",
		ring2 = "Begrudging Ring",
		back = Rosmerta.Crit,
		waist = "Fotia Belt",
		legs = "Samnuha Tights", 
		feet = "Adhe. Gamashes +1",
		--Crit herc Feet are BIS
        }

    sets.precast.WS['Vorpal Blade'] = sets.precast.WS['Chant du Cygne']

    sets.precast.WS['Savage Blade'] = {
        ammo = "Coiste Bodhar",
        head = HerculeanHead.STR_WSD,
		neck = "Caro Necklace",
        ear1 = "Moonshade Earring",
        ear2 = "Ishvara Earring", --2wsdmg
		--ear2 = "Regal Earring", --10MND + 15 acc 
        body = "Assim. Jubbah +3",
        hands = "Jhakri Cuffs +2",
		ring1 = "Rufescent Ring",
        ring2 = "Karieyh Ring",
        back = Rosmerta.WSD,
        waist = "Sailfi Belt +1",
        legs = "Luhlaza Shalwar +2",
        feet = HerculeanFeet.STR_WSD,
        }

    sets.precast.WS['Requiescat'] = {
		ammo = "Coiste Bodhar",
		head = "Jhakri Coronal +2",
		neck = "Fotia Gorget",
		ear1 = "Moonshade Earring", 
		ear2 = "Brutal Earring",
		body = "Jhakri Robe +2",
		hands = "Jhakri Cuffs +2",
		ring1 = "Epona's Ring",
		ring2 = "Rufescent Ring",
		back = Rosmerta.DA,
		waist = "Fotia Belt",
		legs = "Jhakri Slops +2",
		feet = "Jhakri Pigaches +2",
        }

    sets.precast.WS['Expiacion'] = sets.precast.WS['Savage Blade']

    sets.precast.WS['Sanguine Blade'] = {
		ammo = "Pemphredo Tathlum",
		head = "Pixie Hairpin +1",
		neck = "Baetyl Pendant",
		ear1 = "Regal Earring",
		ear2 = "Friomisi Earring",
		body = "Amalric Doublet +1",
		hands = "Jhakri Cuffs +2",
        ring1 = "Archon Ring",
        ring2 = "Karieyh Ring",
		back = Rosmerta.MAB,
		--Rosmerta's INT/macc/mdmg/WSD
		waist = "Eschan Stone",
		legs = "Luhlaza Shalwar +2",
		feet = "Amalric Gages +1",
		}

    sets.precast.WS['True Strike'] = sets.precast.WS['Savage Blade']
    
	sets.precast.WS['Judgment'] = sets.precast.WS['True Strike']
    
	--SB but with more multihit
	--*************************
	sets.precast.WS['Black Halo'] = sets.precast.WS['Savage Blade']
	
	sets.precast.WS['Realmrazer'] = sets.precast.WS['Requiescat']

    sets.precast.WS['Flash Nova'] = {
		ammo = "Pemphredo Tathlum",
		head = "Jhakri Coronal +2",
		neck = "Baetyl Pendant",
		ear1 = "Regal Earring",
		ear2 = "Friomisi Earring",
		body = "Amalric Doublet +1",
		hands = "Jhakri Cuffs +2",
        ring1 = "Rufescent Ring",
        ring2 = "Karieyh Ring",
		back = Rosmerta.MAB,
		waist = "Eschan Stone",
		legs = "Luhlaza Shalwar +2",
		feet = "Amalric Gages +1",
		}
    ------------------------------------------------------------------------------------------------
    ---------------------------------------- Midcast Sets ------------------------------------------
    ------------------------------------------------------------------------------------------------

	-- ilvl119 for midcast
    sets.midcast.FastRecast = set_combine(sets.precast.FC, {legs = "Aya. Cosciales +2"})

    sets.midcast.SpellInterrupt = {}
	
	--500skill
    sets.midcast['Blue Magic'] = set_combine(sets.midcast.FastRecast, {
		body = "Assim. Jubbah +3",
		})

    sets.midcast['Blue Magic'].Physical = {}
    sets.midcast['Blue Magic'].PhysicalAcc = set_combine(sets.midcast['Blue Magic'].Physical, {})
    sets.midcast['Blue Magic'].PhysicalStr = set_combine(sets.midcast['Blue Magic'].Physical, {})
    sets.midcast['Blue Magic'].PhysicalDex = set_combine(sets.midcast['Blue Magic'].Physical, {})
    sets.midcast['Blue Magic'].PhysicalVit = sets.midcast['Blue Magic'].Physical
    sets.midcast['Blue Magic'].PhysicalAgi = set_combine(sets.midcast['Blue Magic'].Physical, { })
    sets.midcast['Blue Magic'].PhysicalInt = set_combine(sets.midcast['Blue Magic'].Physical, {ear2="Regal Earring",})
	sets.midcast['Blue Magic'].PhysicalMnd = set_combine(sets.midcast['Blue Magic'].Physical, {ear2="Regal Earring",})
    sets.midcast['Blue Magic'].PhysicalChr = set_combine(sets.midcast['Blue Magic'].Physical, {ear1="Regal Earring"})

    sets.midcast['Blue Magic'].Magical = {
		ammo = "Pemphredo Tathlum",
		head = "Jhakri Coronal +2",
		neck = "Baetyl Pendant",
		ear1 = "Regal Earring",
		ear2 = "Friomisi Earring",
		body = "Amalric Doublet +1",
		hands = "Amalric Gages +1",
        ring1 = {name="Shiva Ring +1", bag="wardrobe1"}, 
		--metamorph ring +1 R15
        ring2 = {name="Shiva Ring +1", bag="wardrobe2"},
		back = Rosmerta.MAB,
		waist = "Eschan Stone",
		legs = "Amalric Slops +1",
		feet = "Amalric Nails +1",
		}
		
	sets.midcast['Blue Magic'].Magical.Macc = set_combine(sets.midcast['Blue Magic'].Magical, {
		legs = "Luhlaza Shalwar +2",
		})
	
	-- Assuming it's INT based, I have no idea though.
	sets.midcast['Dream Flower'] = {
		ammo = "Pemphredo Tathlum",
		head = "Jhakri Coronal +2",
		neck = "Baetyl Pendant",
		ear1 = "Regal Earring",
		ear2 = "Friomisi Earring",
		body = "Amalric Doublet +1",
		hands = "Amalric Gages +1",
        ring1 = {name="Stikini Ring", bag="wardrobe1"}, 
        ring2 = {name="Stikini Ring", bag="wardrobe2"},
		back = Rosmerta.MAB,
		waist = "Eschan Stone",
		legs = "Amalric Slops +1",
		feet = "Amalric Nails +1",
		}

    sets.midcast['Blue Magic'].MagicalDark = set_combine(sets.midcast['Blue Magic'].Magical, {
        head = "Pixie Hairpin +1",
        ring1 = "Archon Ring",
        })
		
    sets.midcast['Blue Magic'].MagicalLight = set_combine(sets.midcast['Blue Magic'].Magical, {})
    sets.midcast['Blue Magic'].MagicalMnd = set_combine(sets.midcast['Blue Magic'].Magical, {})
    sets.midcast['Blue Magic'].MagicalDex = set_combine(sets.midcast['Blue Magic'].Magical, {})
    sets.midcast['Blue Magic'].MagicalVit = set_combine(sets.midcast['Blue Magic'].Magical, {
		head = HerculeanHead.MAB_WSD,
		})
    sets.midcast['Blue Magic'].MagicalChr = set_combine(sets.midcast['Blue Magic'].Magical, {})
	
    sets.midcast['Blue Magic'].MagicAccuracy = {}

    sets.midcast['Blue Magic'].Breath = sets.midcast['Blue Magic'].Magical
	
    sets.midcast['Blue Magic'].Stun = sets.midcast['Blue Magic'].MagicAccuracy
	
    sets.midcast['Blue Magic'].Healing = {}

    sets.midcast['Blue Magic'].HealingSelf = {}
	
	sets.midcast['Blue Magic']['White Wind'] = {
		ammo = "Egoist's Tathlum",
		head = "Pinga Crown",
		neck = "Unmoving Collar +1",
		ear1 = "Odnowa Earring +1",
		ear2 = "Etiolation Earring",
		body = "Vrikodara Jupon",
		hands = "Telchine Gloves", 
		ring1 = "Meridian Ring",
		ring2 = "Eihwaz Ring",
		back = "Moonbeam Cape",
		waist = "Tempus Fugit",
		legs = "Despair Cuisses",
		feet = "Medium's Sabots",
		}
	
    sets.midcast['Blue Magic'].Buff = sets.midcast['Blue Magic']
	
    sets.midcast['Blue Magic'].Refresh = set_combine(sets.midcast['Blue Magic'], {})
	
    sets.midcast['Blue Magic'].SkillBasedBuff = sets.midcast['Blue Magic']
	
	-- +50skill tier, current [ 553 ]
    sets.midcast['Blue Magic']['Occultation'] = set_combine(sets.midcast['Blue Magic'], {
		neck = "Incanter's Torque",
        ring2 = {name="Stikini Ring", bag="wardrobe2"},
		back = "Cornflower Cape",
		legs = "Hashishin Tayt +1",
		})
	
    sets.midcast['Blue Magic']['Carcharian Verve'] = set_combine(sets.midcast['Blue Magic'].Buff, {})
   
   sets.midcast['Enhancing Magic'] = {}

    sets.midcast.EnhancingDuration = {}

    sets.midcast.Refresh = set_combine(sets.midcast.EnhancingDuration, {})
    sets.midcast.Stoneskin = set_combine(sets.midcast['Enhancing Magic'], {})

    sets.midcast.Phalanx = set_combine(sets.midcast['Enhancing Magic'], {})

    sets.midcast.Aquaveil = set_combine(sets.midcast.EnhancingDuration, {})

    sets.midcast.Protect = set_combine(sets.midcast.EnhancingDuration, {})
    sets.midcast.Protectra = sets.midcast.Protect
    sets.midcast.Shell = sets.midcast.Protect
    sets.midcast.Shellra = sets.midcast.Protect

    sets.midcast.Utsusemi = sets.midcast.SpellInterrupt

    ------------------------------------------------------------------------------------------------
    ----------------------------------------- Idle Sets --------------------------------------------
    ------------------------------------------------------------------------------------------------

    sets.idle = {
        ammo = "Staunch Tathlum +1",
        head = "Malignance Chapeau",
		neck = "Loricate Torque +1",
        ear1 = "Genmei Earring",
        ear2 = "Etiolation Earring",
        body = "Assim. Jubbah +3",
        hands = "Malignance Gloves",
		ring1 = "Defending Ring",
        ring2 = "Karieyh Ring",
        back = "Moonbeam Cape",
        waist = "Flume Belt +1",
        legs = "Carmine Cuisses +1",
        feet = "Malignance Boots",
        }
		
	sets.idle.DT = set_combine(sets.idle, {
        body = "Malignance Tabard",
		ring2 = "Gelatinous Ring +1",
		})

    --sets.idle.Learning = set_combine(sets.idle, sets.Learning)

    ------------------------------------------------------------------------------------------------
    ---------------------------------------- Defense Sets ------------------------------------------
    ------------------------------------------------------------------------------------------------

    sets.defense.PDT = {
		ammo="Staunch Tathlum +1",
		head="Aya. Zucchetto +2",
		body="Malignance Tabard",
		hands="Malignance Gloves",
		legs="Malignance Tights",
		feet="Malignance Boots",
		neck="Loricate Torque +1",
		waist="Flume Belt +1",
		left_ear="Genmei Earring",
		right_ear="Etiolation Earring",
		left_ring="Defending Ring",
		right_ring="Gelatinous Ring +1",
		back="Moonbeam Cape",
		}
		
    sets.defense.MDT = {
		ammo="Staunch Tathlum +1",
		head="Aya. Zucchetto +2",
		body="Malignance Tabard",
		hands="Malignance Gloves",
		legs="Malignance Tights",
		feet="Malignance Boots",
		neck="Loricate Torque +1",
		waist="Flume Belt +1",
		left_ear="Genmei Earring",
		right_ear="Etiolation Earring",
		left_ring="Defending Ring",
		right_ring="Gelatinous Ring +1",
		back="Moonbeam Cape",
		}

    ------------------------------------------------------------------------------------------------
    ---------------------------------------- Engaged Sets ------------------------------------------
    ------------------------------------------------------------------------------------------------

    -- Engaged sets

    -- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
    -- sets if more refined versions aren't defined.
    -- If you create a set with both offense and defense modes, the offense mode should be first.
    -- EG: sets.engaged.Dagger.Accuracy.Evasion

    sets.engaged = {
        ammo = "Coiste Bodhar",
        head = "Adhemar Bonnet +1",
		neck = "Ainia Collar",
        ear1 = "Suppanomimi",
        ear2 = "Dedition Earring",
        body = "Adhemar Jacket +1",
        hands = AdhemarHands.B,
        ring1 = "Epona's Ring",
		ring2 = "Petrov Ring",
        back = Rosmerta.DA,
        waist = "Sailfi Belt +1",
        legs = "Samnuha Tights",
        feet = HerculeanFeet.STR_TA ,
        }
		
    sets.engaged.LowAcc = set_combine(sets.engaged, {
		neck = "Asperity Necklace",
		hands = AdhemarHands.A,
		ear2 = "Telos Earring",
		ring2 = "Hetairoi Ring",
        }) -- +47~
		
    sets.engaged.Acc = set_combine(sets.engaged.LowAcc, {
        head = "Dampening Tam",
		ring2 = "Ilabrat Ring",
		legs = "Malignance Tights",
		feet = "Malignance Boots",
        })


    ------------------------------------------------------------------------------------------------
    ---------------------------------------- Hybrid Sets -------------------------------------------
    ------------------------------------------------------------------------------------------------

    sets.engaged.Hybrid = {
        }

    sets.engaged.DT = set_combine(sets.engaged, sets.engaged.Hybrid)
    sets.engaged.LowAcc.DT = set_combine(sets.engaged.LowAcc, sets.engaged.Hybrid)
    sets.engaged.Acc.DT = set_combine(sets.engaged.Acc, sets.engaged.Hybrid)



    ------------------------------------------------------------------------------------------------
    ---------------------------------------- Special Sets ------------------------------------------
    ------------------------------------------------------------------------------------------------

    sets.magic_burst = set_combine(sets.midcast['Blue Magic'].Magical, {})

    sets.Kiting = {legs="Carmine Cuisses +1"}

    sets.buff.Doom = {
        neck = "Nicander's Necklace", --20
        ring1 = {name="Eshmun's Ring", bag="wardrobe1"}, --20
        ring2 = {name="Eshmun's Ring", bag="wardrobe2"}, --20
        waist = "Gishdubar Sash", --10
        }

    sets.CP = {back="Mecisto. Mantle"}
    --sets.Reive = {neck="Ygnas's Resolve +1"}

end


-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
-- Set eventArgs.useMidcastGear to true if we want midcast gear equipped on precast.
function job_precast(spell, action, spellMap, eventArgs)
    if unbridled_spells:contains(spell.english) and not state.Buff['Unbridled Learning'] then
        eventArgs.cancel = true
        windower.send_command('@input /ja "Unbridled Learning" <me>; wait 1.5; input /ma "'..spell.name..'" '..spell.target.name)
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

-- Run after the default midcast() is done.
-- eventArgs is the same one used in job_midcast, in case information needs to be persisted.
function job_post_midcast(spell, action, spellMap, eventArgs)
    -- Add enhancement gear for Chain Affinity, etc.
    if spell.skill == 'Blue Magic' then
        for buff,active in pairs(state.Buff) do
            if active and sets.buff[buff] then
                equip(sets.buff[buff])
            end
        end
        if spellMap == 'Healing' and spell.target.type == 'SELF' then
            equip(sets.midcast['Blue Magic'].HealingSelf)
        end
    end

    if spell.skill == 'Enhancing Magic' and classes.NoSkillSpells:contains(spell.english) then
        equip(sets.midcast.EnhancingDuration)
        if spellMap == 'Refresh' then
            equip(sets.midcast.Refresh)
        end
    end
end

function job_post_midcast(spell, action, spellMap, eventArgs)
    if not spell.interrupted then
        if spell.english == "Dream Flower" then
            send_command('@timers c "Dream Flower ['..spell.target.name..']" 90 down spells/00098.png')
        elseif spell.english == "Soporific" then
            send_command('@timers c "Sleep ['..spell.target.name..']" 90 down spells/00259.png')
        elseif spell.english == "Sheep Song" then
            send_command('@timers c "Sheep Song ['..spell.target.name..']" 60 down spells/00098.png')
        elseif spell.english == "Yawn" then
            send_command('@timers c "Yawn ['..spell.target.name..']" 60 down spells/00098.png')
        elseif spell.english == "Entomb" then
            send_command('@timers c "Entomb ['..spell.target.name..']" 60 down spells/00547.png')
        end
    end
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for non-casting events.
-------------------------------------------------------------------------------------------------------------------

-- Called when a player gains or loses a buff.
-- buff == buff gained or lost
-- gain == true if the buff was gained, false if it was lost.
function job_buff_change(buff,gain)

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

function job_self_command(cmdParams, eventArgs)
	if cmdParams[1] == 'warp' then
		send_command('input /equip ring1 "Warp ring"; wait 12; input /item "Warp ring" <me>')
        add_to_chat(158,'warp ring')
	 elseif cmdParams[1] == 'dem' then
		send_command('input /equip ring2 "Dimensional ring (Dem)"; wait 12; input /item "Dimensional ring (Dem)" <me>')
        add_to_chat(158,'dem ring')
	 end

end


-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------

-- Called by the 'update' self-command, for common needs.
-- Set eventArgs.handled to true if we don't want automatic equipping of gear.

function update_combat_form()
    if DW == true then
        state.CombatForm:set('DW')
    elseif DW == false then
        state.CombatForm:reset()
    end
end

-- Custom spell mapping.
-- Return custom spellMap value that can override the default spell mapping.
-- Don't return anything to allow default spell mapping to be used.
function job_get_spell_map(spell, default_spell_map)
    if spell.skill == 'Blue Magic' then
        for category,spell_list in pairs(blue_magic_maps) do
            if spell_list:contains(spell.english) then
                return category
            end
        end
    end
end

-- Modify the default idle set after it was constructed.
function customize_idle_set(idleSet)
	if idleSet == sets.idle.DT and player.mpp < 60 then
       idleSet = sets.idle.RefreshDT
    end
    if state.CP.current == 'on' then
        equip(sets.CP)
        disable('back')
    else
        enable('back')
    end
    --if state.IdleMode.value == 'Learning' then
    --    equip(sets.Learning)
    --    disable('hands')
    --else
    --    enable('hands')
    --end

    return idleSet
end

-- Modify the default melee set after it was constructed.
function customize_melee_set(meleeSet)
    return meleeSet
end

-- Function to display the current relevant user state when doing an update.
-- Return true if display was handled, and you don't want the default info shown.
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

    if state.IdleMode.value ~= 'None' then
        msg = msg .. '[ Idle: ' .. state.IdleMode.value .. ' ]'
    end

    if state.Kiting.value then
        msg = msg .. '[ Kiting Mode: ON'
    end



    msg = msg .. ' ]'

    add_to_chat(060, msg)

    eventArgs.handled = true
end


-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------


function update_active_abilities()
    state.Buff['Burst Affinity'] = buffactive['Burst Affinity'] or false
    state.Buff['Efflux'] = buffactive['Efflux'] or false
    state.Buff['Diffusion'] = buffactive['Diffusion'] or false
end

-- State buff checks that will equip buff gear and mark the event as handled.
function apply_ability_bonuses(spell, action, spellMap)
    if state.Buff['Burst Affinity'] and (spellMap == 'Magical' or spellMap == 'MagicalLight' or spellMap == 'MagicalDark' or spellMap == 'Breath') then
        if state.MagicBurst.value then
            equip(sets.magic_burst)
        end
        equip(sets.buff['Burst Affinity'])
    end
    if state.Buff.Efflux and spellMap == 'Physical' then
        equip(sets.buff['Efflux'])
    end
    if state.Buff.Diffusion and (spellMap == 'Buffs' or spellMap == 'BlueSkill') then
        equip(sets.buff['Diffusion'])
    end

    if state.Buff['Burst Affinity'] then equip (sets.buff['Burst Affinity']) end
    if state.Buff['Efflux'] then equip (sets.buff['Efflux']) end
    if state.Buff['Diffusion'] then equip (sets.buff['Diffusion']) end
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

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    -- Default macro set/book
    if player.sub_job == 'WAR' then
        set_macro_page(1, 2)
    elseif player.sub_job == 'RDM' then
        set_macro_page(1, 2)
    else
        set_macro_page(1, 2)
    end
end

function set_lockstyle()
     send_command('wait 2; input /lockstyleset 2')
end