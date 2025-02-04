-- Original: Motenten / Modified: Arislan

-------------------------------------------------------------------------------------------------------------------
--  Keybinds
-------------------------------------------------------------------------------------------------------------------

--  Modes:      [ F9 ]              Cycle Offense Modes
--              [ CTRL+F9 ]         Cycle Hybrid Modes
--              [ WIN+F9 ]          Cycle Weapon Skill Modes
--              [ F10 ]             Emergency -PDT Mode
--              [ ALT+F10 ]         Toggle Kiting Mode
--              [ F11 ]             Emergency -MDT Mode
--              [ F12 ]             Update Current Gear / Report Current Status
--              [ CTRL+F12 ]        Cycle Idle Modes
--              [ ALT+F12 ]         Cancel Emergency -PDT/-MDT Mode
--              [ WIN+A ]           AttackMode: Capped/Uncapped WS Modifier
--              [ WIN+C ]           Toggle Capacity Points Mode
--
--
--              (Global-Binds.lua contains additional non-job-related keybinds)

-------------------------------------------------------------------------------------------------------------------
-- Setup functions for this job.  Generally should not be modified.
-------------------------------------------------------------------------------------------------------------------

-- Initialization function for this job file.
function get_sets()
    mote_include_version = 2

    -- Load and initialize the include file.
    include('Mote-Include.lua')
	include('organizer-lib')
    res = require 'resources'
end

-- Setup vars that are user-independent.
function job_setup()

    no_swap_gear = S{"Warp Ring", "Dim. Ring (Dem)", "Dim. Ring (Holla)", "Dim. Ring (Mea)",
              "Trizek Ring", "Echad Ring", "Facility Ring", "Capacity Ring"}
    wyv_breath_spells = S{'Dia', 'Poison', 'Blaze Spikes', 'Protect', 'Sprout Smack', 'Head Butt', 'Cocoon',
        'Barfira', 'Barblizzara', 'Baraera', 'Barstonra', 'Barthundra', 'Barwatera'}
    wyv_elem_breath = S{'Flame Breath', 'Frost Breath', 'Sand Breath', 'Hydro Breath', 'Gust Breath', 'Lightning Breath'}

    lockstyleset = 4

end

-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

function user_setup()
    state.OffenseMode:options('Normal', 'LowAcc', 'MidAcc', 'HighAcc', 'MaxAcc', 'STP')
    state.WeaponskillMode:options('Normal', 'Acc')
    state.HybridMode:options('Normal', 'DT')
    state.IdleMode:options('Normal', 'DT')

    state.AttackMode = M{['description']='Attack', 'Capped', 'Uncapped'}
    -- state.CP = M(false, "Capacity Points Mode")

    send_command('bind @a gs c cycle AttackMode')
    -- send_command('bind @c gs c toggle CP')

    select_default_macro_book()
    set_lockstyle()

    state.Auto_Kite = M(false, 'Auto_Kite')
    moving = false
end

function user_unload()
    send_command('unbind !f9')
    send_command('unbind ^f11')
    send_command('unbind ^insert')
    send_command('unbind ^delete')
	send_command('unbind ^home')
	send_command('unbind ^end')
    send_command('unbind @a')

end

-- Define sets and vars used by this job file.
function init_gear_sets()

    ------------------------------------------------------------------------------------------------
    ---------------------------------------- Precast Sets ------------------------------------------
    ------------------------------------------------------------------------------------------------

    sets.precast.JA['Spirit Surge'] = {body="Ptero. Mail +3"}
    sets.precast.JA['Call Wyvern'] = {body="Ptero. Mail +3"}
    sets.precast.JA['Ancient Circle'] = {legs="Vishap Brais +3"}

    sets.precast.JA['Spirit Link'] = {
        head="Vishap Armet +3",
        hands="Pel. Vambraces +1",
        feet="Ptero. Greaves +3",
        ear1="Pratik Earring",
        }

    sets.precast.JA['Steady Wing'] = {
        legs="Vishap Brais +3",
        feet="Ptero. Greaves +3",
        neck="Chanoix's Gorget",
        ear1="Lancer's Earring",
        ear2="Anastasi Earring",
        back="Updraft Mantle",
        }

    sets.precast.JA['Jump'] = {
        ammo="Aurgelmir Orb +1",
        head="Flam. Zucchetto +2",
        body="Vishap Mail +3",
        hands="Vis. Fng. Gaunt. +3",
        legs="Ptero. Brais +3",
        feet="Ostro Greaves",
        neck="Anu Torque",
        ear1="Sherida Earring",
        ear2="Telos Earring",
        ring1={name="Chirich Ring +1", bag="wardrobe3"},
        ring2="Niqmaddu Ring",
        back=gear.DRG_JMP_Cape,
        waist="Ioskeha Belt +1",
        }

    sets.precast.JA['High Jump'] = sets.precast.JA['Jump']
    sets.precast.JA['Spirit Jump'] = sets.precast.JA['Jump']
    sets.precast.JA['Soul Jump'] = set_combine(sets.precast.JA['Jump'], {body="Vishap Mail +3", hands="Emi. Gauntlets +1", legs=gear.Valo_STP_legs})
    sets.precast.JA['Super Jump'] = {}

    sets.precast.JA['Angon'] = {ammo="Angon", hands="Ptero. Fin. G. +3"}

    -- Fast cast sets for spells
    sets.precast.FC = {
        ammo="Sapience Orb", --2
        head="Carmine Mask +1", --14
        body="Sacro Breastplate", --10
        hands="Leyline Gloves", --8
        legs="Aya. Cosciales +2", --6
        feet="Carmine Greaves +1", --8
        neck="Orunmila's Torque", --5
        ear1="Loquacious Earring", --2
        ear2="Enchntr. Earring +1", --2
        ring2="Weather. Ring +1", --6(4)
        }

    ------------------------------------------------------------------------------------------------
    ------------------------------------- Weapon Skill Sets ----------------------------------------
    ------------------------------------------------------------------------------------------------

    sets.precast.WS = {
        ammo="Knobkierrie",
        head=gear.Valo_WSD_head,
        body=gear.Valo_WSD_body,
        hands="Ptero. Fin. G. +3",
        legs="Vishap Brais +3",
        feet="Sulev. Leggings +2",
        neck="Fotia Gorget",
        ear1="Sherida Earring",
        ear2="Moonshade Earring",
        ring1="Regal Ring",
        ring2="Niqmaddu Ring",
        back=gear.DRG_WS2_Cape,
        waist="Fotia Belt",
        }

    sets.precast.WS.Acc = set_combine(sets.precast.WS, {})

    sets.precast.WS['Camlann\'s Torment'] = set_combine(sets.precast.WS, {
        neck="Dgn. Collar +1",
        ear2="Ishvara Earring",
        ring2="Epaminondas's Ring",
        waist="Sailfi Belt +1",
        })

    sets.precast.WS['Camlann\'s Torment'].Acc = set_combine(sets.precast.WS['Camlann\'s Torment'], {})

    sets.precast.WS['Drakesbane'] = set_combine(sets.precast.WS, {
        head="Blistering Sallet +1",
        body="Hjarrandi Breast.",
        hands="Flamma Manopolas +2",
        legs="Zoar Subligar +1",
        neck="Dgn. Collar +1",
        ear2="Brutal Earring",
        ring1="Begrudging Ring",
        back=gear.DRG_WS4_Cape,
        waist="Sailfi Belt +1",
        })

    sets.precast.WS['Drakesbane'].Acc = set_combine(sets.precast.WS['Drakesbane'], {
        waist="Ioskeha Belt +1",
        })

    sets.precast.WS['Geirskogul'] = set_combine(sets.precast.WS, {
        head="Lustratio Cap +1",
        legs="Lustr. Subligar +1",
        ear2="Mache Earring +1",
        ring2="Epaminondas's Ring",
        back=gear.DRG_WS3_Cape,
        })

    sets.precast.WS['Geirskogul'].Acc = set_combine(sets.precast.WS['Geirskogul'], {})

    sets.precast.WS['Impulse Drive'] = set_combine(sets.precast.WS['Camlann\'s Torment'], {
        head="Blistering Sallet +1",
        body="Hjarrandi Breast.",
        hands="Flamma Manopolas +2",
        legs="Pelt. Cuissots +1",
        neck="Dgn. Collar +1",
        ear2="Moonshade Earring",
        ring1="Begrudging Ring",
        ring2="Epaminondas's Ring",
        back=gear.DRG_WS4_Cape,
        waist="Sailfi Belt +1",
        })

    sets.precast.WS['Impulse Drive'].Acc = set_combine(sets.precast.WS['Impulse Drive'], {
        legs="Vishap Brais +3",
        waist="Ioskeha Belt +1",
        })

    sets.precast.WS['Impulse Drive'].HighTP = set_combine(sets.precast.WS['Impulse Drive'], {
        head=gear.Valo_WSD_head,
        body=gear.Valo_WSD_body,
        hands="Ptero. Fin. G. +3",
        legs="Vishap Brais +3",
        back=gear.DRG_WS2_Cape,
        ear2="Ishvara Earring",
        ring1="Regal Ring",
        })

    sets.precast.WS['Sonic Thrust'] = sets.precast.WS['Camlann\'s Torment']
    sets.precast.WS['Sonic Thrust'].Acc = sets.precast.WS['Camlann\'s Torment'].Acc

    sets.precast.WS['Stardiver'] = set_combine(sets.precast.WS, {
        head="Flam. Zucchetto +2",
        body=gear.Valo_TP_body,
        hands="Sulev. Gauntlets +2",
        neck="Fotia Gorget",
        legs="Sulev. Cuisses +2",
        feet="Flam. Gambieras +2",
        back=gear.DRG_WS1_Cape,
        })

    sets.precast.WS['Stardiver'].Acc = set_combine(sets.precast.WS['Stardiver'], {
        head="Ptero. Armet +3",
        feet="Ptero. Greaves +3",
        })

    sets.precast.WS['Raiden Thrust'] = set_combine(sets.precast.WS, {
        ammo="Ghastly Tathlum +1",
        body="Carm. Sc. Mail +1",
        hands="Carmine Fin. Ga. +1",
        ear1="Crematio Earring",
        ear2="Friomisi Earring",
        ring1="Shiva Ring +1",
        back="Argocham. Mantle",
        })

    sets.precast.WS['Thunder Thrust'] = sets.precast.WS['Raiden Thrust']

    sets.precast.WS['Leg Sweep'] = set_combine(sets.precast.WS, {
        ammo="Pemphredo Tathlum",
        head="Blistering Sallet +1",
        body="Flamma Korazin +2",
        hands="Flam. Manopolas +2",
        legs="Flamma Dirs +2",
        feet="Flam. Gambieras +2",
        ear1="Digni. Earring",
        ring1="Metamor. Ring +1",
        ring2="Weather. Ring +1",
        })

    sets.WSDayBonus = {head="Gavialis Helm"}

    ------------------------------------------------------------------------------------------------
    ---------------------------------------- Midcast Sets ------------------------------------------
    ------------------------------------------------------------------------------------------------

    sets.midcast.HealingBreath = {
        head="Ptero. Armet +3",
        body=gear.Acro_Pet_body,
        hands=gear.Acro_Pet_hands,
        legs="Vishap Brais +3",
        feet="Ptero. Greaves +3",
        neck="Dgn. Collar +1",
        ear1="Lancer's Earring",
        ear2="Anastasi Earring",
        back="Updraft Mantle",
        waist="Glassblower's Belt",
        }

    sets.midcast.ElementalBreath = {
        head="Ptero. Armet +3",
        body=gear.Acro_Pet_body,
        hands=gear.Acro_Pet_hands,
        neck="Lancer's Torque",
        ear1="Enmerkar Earring",
        ear2="Dragoon's Earring",
        ring1="C. Palug Ring",
        back="Updraft Mantle",
        waist="Glassblower's Belt",
        }

    ------------------------------------------------------------------------------------------------
    ----------------------------------------- Idle Sets --------------------------------------------
    ------------------------------------------------------------------------------------------------

    sets.idle = {
        ammo="Staunch Tathlum +1", --3/3
        head="Hjarrandi Helm", --10/10
        body="Sacro Breastplate",
        hands="Sulev. Gauntlets +2", --5/5
        legs="Carmine Cuisses +1",
        feet="Ptero. Greaves +3",
        neck="Bathy Choker +1",
        ear1="Eabani Earring",
        ear2="Sanare Earring",
        ring1={name="Chirich Ring +1", bag="wardrobe3"},
        ring2={name="Chirich Ring +1", bag="wardrobe4"},
        back="Moonlight Cape", --6/6
        waist="Flume Belt +1", --4/0
        }

    sets.idle.DT = set_combine(sets.idle, {
        ammo="Staunch Tathlum +1", --3/3
        body="Hjarrandi Breast.", --12/12
        head="Hjarrandi Helm", --10/10
        hands="Flam. Manopolas +2",
        feet="Ptero. Greaves +3",
        neck="Loricate Torque +1", --6/6
        ear1="Sanare Earring",
        ear2="Anastasi Earring",
        ring1="Moonlight Ring", --5/5
        ring2="Defending Ring", --10/10
        waist="Carrier's Sash",
        })

    sets.idle.Pet = set_combine(sets.idle, {
        body="Vishap Mail +3",
        hands="Ptero. Fin. G. +3",
        feet="Ptero. Greaves +3",
        neck="Dgn. Collar +1",
        ear1="Enmerkar Earring",
        ear2="Anastasi Earring",
        waist="Isa Belt",
        })

    sets.idle.DT.Pet = set_combine(sets.idle.Pet, {
        head="Hjarrandi Helm", --10/10
        body="Emicho Haubert +1",
        legs="Ptero. Brais +3",
        neck="Dgn. Collar +1",
        ring1="Moonlight Ring", --5/5
        ring2="Defending Ring", --10/10
        back="Moonlight Cape", --6/6
        })

    sets.idle.Town = set_combine(sets.idle, {
        ammo="Aurgelmir Orb +1",
        head="Ptero. Armet +3",
        hands="Ptero. Fin. G. +3",
        feet="Ptero. Greaves +3",
        neck="Dgn. Collar +1",
        ear1="Sherida Earring",
        ear2="Telos Earring",
        back=gear.DRG_TP_Cape,
        waist="Ioskeha Belt +1",
        })

    sets.idle.Weak = sets.idle.DT
    sets.Kiting = {legs="Carmine Cuisses +1"}


    ------------------------------------------------------------------------------------------------
    ---------------------------------------- Defense Sets ------------------------------------------
    ------------------------------------------------------------------------------------------------

    sets.defense.PDT = sets.idle.DT
    sets.defense.MDT = sets.idle.DT

    ------------------------------------------------------------------------------------------------
    ---------------------------------------- Engaged Sets ------------------------------------------
    ------------------------------------------------------------------------------------------------

    sets.engaged = {
        ammo="Aurgelmir Orb +1",
        head="Flam. Zucchetto +2",
        body=gear.Valo_TP_body,
        hands="Sulev. Gauntlets +2",
        legs=gear.Valo_TP_legs,
        feet="Flam. Gambieras +2",
        neck="Anu Torque",
        ear1="Sherida Earring",
        ear2="Brutal Earring",
        ring1={name="Chirich Ring +1", bag="wardrobe3"},
        ring2="Niqmaddu Ring",
        back=gear.DRG_TP_Cape,
        waist="Sailfi Belt +1",
        }

    sets.engaged.LowAcc = set_combine(sets.engaged, {
        ear2="Cessance Earring",
        waist="Ioskeha Belt +1",
        })

    sets.engaged.MidAcc = set_combine(sets.engaged.LowAcc, {
        ammo="Voluspa Tathlum",
        neck="Combatant's Torque",
        ring1="Flamma Ring",
        ear2="Telos Earring",
        })

    sets.engaged.HighAcc = set_combine(sets.engaged.MidAcc, {
        ammo="Amar Cluster",
        body="Emicho Haubert +1",
        hands="Emi. Gauntlets +1",
        legs=gear.Valo_STP_legs,
        ring1="Regal Ring",
        })

    sets.engaged.MaxAcc = set_combine(sets.engaged.HighAcc, {
        body="Vishap Mail +3",
        head="Vishap Armet +3",
        legs="Ptero. Brais +3",
        feet="Vishap Greaves +3",
        ear2="Mache Earring +1",
        ring1="Flamma Ring",
        })

    sets.engaged.STP = set_combine(sets.engaged, {
        hands=gear.Acro_STP_hands,
        legs=gear.Valo_STP_legs,
        ear2="Telos Earring",
        back=gear.DRG_JMP_Cape,
        })


    ------------------------------------------------------------------------------------------------
    ---------------------------------------- Hybrid Sets -------------------------------------------
    ------------------------------------------------------------------------------------------------

    sets.engaged.Hybrid = {
        neck="Loricate Torque +1", --6/6
        body="Vishap Mail +3",
        ring1="Moonlight Ring", --5/5
        ring2="Defending Ring", --10/10
        }

    sets.engaged.DT = set_combine(sets.engaged, sets.engaged.Hybrid)
    sets.engaged.LowAcc.DT = set_combine(sets.engaged.LowAcc, sets.engaged.Hybrid)
    sets.engaged.MidAcc.DT = set_combine(sets.engaged.MidAcc, sets.engaged.Hybrid)
    sets.engaged.HighAcc.DT = set_combine(sets.engaged.HighAcc, sets.engaged.Hybrid)
    sets.engaged.STP.DT = set_combine(sets.engaged.STP, sets.engaged.Hybrid)

    ------------------------------------------------------------------------------------------------
    ---------------------------------------- Special Sets ------------------------------------------
    ------------------------------------------------------------------------------------------------

    sets.buff.Doom = {
        neck="Nicander's Necklace", --20
        ring1={name="Eshmun's Ring", bag="wardrobe3"}, --20
        ring2={name="Eshmun's Ring", bag="wardrobe4"}, --20
        waist="Gishdubar Sash", --10
        }

    -- sets.CP = {back="Mecisto. Mantle"}
    --sets.Reive = {neck="Ygnas's Resolve +1"}

end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------

function job_precast(spell, action, spellMap, eventArgs)
    -- Wyvern Commands
    if spell.name == 'Dismiss' and pet.hpp < 100 then
        eventArgs.cancel = true
        add_to_chat(50, 'Cancelling Dismiss! ' ..pet.name.. ' is below full HP! [ ' ..pet.hpp.. '% ]')
    elseif wyv_breath_spells:contains(spell.english) or (spell.skill == 'Ninjutsu' and player.hpp < 33) then
        equip(sets.precast.HealingBreath)
    end
    -- Jump Overrides
    --if pet.isvalid and player.main_job_level >= 77 and spell.name == "Jump" then
    --    eventArgs.cancel = true
    --    send_command('@input /ja "Spirit Jump" <t>')
    --end

    --if pet.isvalid and player.main_job_level >= 85 and spell.name == "High Jump" then
    --    eventArgs.cancel = true
    --    send_command('@input /ja "Soul Jump" <t>')
    --end
end

function job_post_precast(spell, action, spellMap, eventArgs)
    if spell.type == 'WeaponSkill' then
        if spell.english == 'Stardiver' and state.WeaponskillMode.current == 'Normal' then
            if world.day_element == 'Earth' or world.day_element == 'Light' or world.day_element == 'Dark' then
                equip(sets.WSDayBonus)
           end
        elseif spell.english == 'Impulse Drive' and player.tp > 2000 then
           equip(sets.precast.WS['Impulse Drive'].HighTP)
        end
    end
end

function job_pet_midcast(spell, action, spellMap, eventArgs)
    if spell.name:startswith('Healing Breath') or spell.name == 'Restoring Breath' then
        equip(sets.midcast.HealingBreath)
    elseif wyv_elem_breath:contains(spell.english) then
        equip(sets.midcast.ElementalBreath)
    end
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for non-casting events.
-------------------------------------------------------------------------------------------------------------------

function job_buff_change(buff,gain)
    -- If we gain or lose any haste buffs, adjust which gear set we target.
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

    if buff == 'Hasso' and not gain then
        add_to_chat(167, 'Hasso just expired!')
    end

end


-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------

function job_handle_equipping_gear(playerStatus, eventArgs)
    --check_gear()
    --check_moving()
end

function job_update(cmdParams, eventArgs)
    handle_equipping_gear(player.status)
end

function get_custom_wsmode(spell, action, spellMap)
    local wsmode
    if state.OffenseMode.value == 'MidAcc' or state.OffenseMode.value == 'HighAcc' then
        wsmode = 'Acc'
    end

    return wsmode
end

-- Modify the default idle set after it was constructed.
function customize_idle_set(idleSet)
    -- if state.CP.current == 'on' then
    --     equip(sets.CP)
    --     disable('back')
    -- else
    --     enable('back')
    -- end
    if state.Auto_Kite.value == true then
       idleSet = set_combine(idleSet, sets.Kiting)
    end

    return idleSet
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

    local am_msg = '(' ..string.sub(state.AttackMode.value,1,1).. ')'

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
        ..string.char(31,207).. ' WS' ..am_msg.. ': ' ..string.char(31,001)..ws_msg.. string.char(31,002)..  ' |'
        ..string.char(31,004).. ' Defense: ' ..string.char(31,001)..d_msg.. string.char(31,002)..  ' |'
        ..string.char(31,008).. ' Idle: ' ..string.char(31,001)..i_msg.. string.char(31,002)..  ' |'
        ..string.char(31,002)..msg)

    eventArgs.handled = true
end

-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------
--[[
function job_self_command(cmdParams, eventArgs)
    gearinfo(cmdParams, eventArgs)
end

function gearinfo(cmdParams, eventArgs)
    if cmdParams[1] == 'gearinfo' then
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

function check_moving()
    if state.DefenseMode.value == 'None'  and state.Kiting.value == false then
        if state.Auto_Kite.value == false and moving then
            state.Auto_Kite:set(true)
        elseif state.Auto_Kite.value == true and moving == false then
            state.Auto_Kite:set(false)
        end
    end
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

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    -- Default macro set/book: (set, book)
    --if player.sub_job == 'SAM' then
        set_macro_page(1, 8)
    --else
        --set_macro_page(2, 8)
    --end
end

function set_lockstyle()
    send_command('wait 2; input /lockstyleset ' .. lockstyleset)
end