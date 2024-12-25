function define_global_sets ()
	
	TelchineHead={};TelchineBody={};TelchineHands={};TelchineLegs={};TelchineFeet={}
	ChironicHead={};ChironicBody={};ChironicHands={};ChironicLegs={};ChironicFeet={}
	MerlinicHead={};MerlinicBody={};MerlinicHands={};MerlinicLegs={};MerlinicFeet={}
	VanyaHead={};VanyaBody={};VanyaHands={};VanyaLegs={};VanyaFeet={}
	
	-- ===================================================================================================================
	--      Skirmish Augments
	-- ===================================================================================================================
	TelchineHead.Enhance = { name="Telchine Cap", augments={'Mag. Evasion+21','"Conserve MP"+5','Enh. Mag. eff. dur. +10',}}
    TelchineBody.Enhance = { name="Telchine Chas.", augments={'Mag. Evasion+25','"Conserve MP"+5','Enh. Mag. eff. dur. +10',}}
    TelchineHands.Enhance = { name="Telchine Gloves", augments={'Mag. Evasion+23','"Fast Cast"+4','Enh. Mag. eff. dur. +10',}}
    TelchineLegs.Enhance = { name="Telchine Braconi", augments={'Mag. Evasion+5','"Conserve MP"+5','Enh. Mag. eff. dur. +10',}}
    TelchineFeet.Enhance = { name="Telchine Pigaches", augments={'Mag. Evasion+11','"Conserve MP"+4','Enh. Mag. eff. dur. +10',}}
	
	TelchineHead.Pet={ name="Telchine Cap", augments={'Mag. Evasion+23','Pet: "Regen"+3','Pet: Damage taken -4%',}}
    TelchineBody.Pet={ name="Telchine Chas.", augments={'Mag. Evasion+24','Pet: "Regen"+3','Pet: Damage taken -4%',}}
    TelchineHands.Pet={ name="Telchine Gloves", augments={'Mag. Evasion+22','Pet: "Regen"+3','Pet: Damage taken -4%',}}
    TelchineLegs.Pet={ name="Telchine Braconi", augments={'Mag. Evasion+22','Pet: "Regen"+3','Pet: Damage taken -4%',}}
    TelchineFeet.Pet={ name="Telchine Pigaches", augments={'Mag. Evasion+22','Pet: "Regen"+3','Pet: Damage taken -4%',}}
	
	TelchineBody.Regen={ name="Telchine Chas.", augments={'"Regen" potency+3',}}
    TelchineHands.Regen={ name="Telchine Gloves", augments={'"Regen" potency+2',}}
    TelchineLegs.Regen={ name="Telchine Braconi", augments={'"Regen" potency+3',}}
    TelchineFeet.Regen={ name="Telchine Pigaches", augments={'"Regen" potency+3',}}
	
	-- ===================================================================================================================
	--      Escha Augments
	-- ===================================================================================================================
	
	VanyaHead.B = { name="Vanya Hood", augments={'Healing magic skill +20','"Cure" spellcasting time -7%','Magic dmg. taken -3',}}
	VanyaHead.C = { name="Vanya Hood", augments={'MND+10','Spell interruption rate down +15%','"Conserve MP"+6',}}
	VanyaHead.D = { name="Vanya Hood", augments={'MP+50','"Fast Cast"+10','Haste+2%',}}
	-- ===================================================================================================================
	--      Praise Oseem Augments
	-- ===================================================================================================================
	ChironicHands.Refresh = { name="Chironic Gloves", augments={'Spell interruption rate down -4%','Pet: "Store TP"+7','"Refresh"+2','Mag. Acc.+10 "Mag.Atk.Bns."+10',}}
	
	ChironicHands.TP ={ name="Chironic Gloves", augments={'"Triple Atk."+3','Accuracy+6 Attack+6','"Store TP"+5',}}
	
	ChironicHead.WSD = { name="Chironic Hat", augments={'Accuracy+2','Phys. dmg. taken -1%','Weapon skill damage +9%',}}
	ChironicBody.WSD = { name="Chironic Doublet", augments={'Pet: VIT+8','INT+9','Weapon skill damage +5%','Accuracy+7 Attack+7',}}
    ChironicFeet.WSD = { name="Chironic Slippers", augments={'MND+1','Weapon skill damage +5%','Accuracy+15 Attack+15','Mag. Acc.+17 "Mag.Atk.Bns."+17',}}
	
	ChironicBody.MAB ={ name="Chironic Doublet", augments={'"Mag.Atk.Bns."+29','"Resist Silence"+6','MND+5','Mag. Acc.+15',}}
    ChironicHands.MAB ={ name="Chironic Gloves", augments={'"Mag.Atk.Bns."+27','Accuracy+5','Mag. Acc.+20 "Mag.Atk.Bns."+20',}}
	ChironicLegs.MAB = { name="Chironic Hose", augments={'Mag. Acc.+25 "Mag.Atk.Bns."+25','MND+12','Mag. Acc.+10',}}
    ChironicFeet.MAB ={ name="Chironic Slippers", augments={'Mag. Acc.+25 "Mag.Atk.Bns."+25','"Resist Silence"+3','MND+1','Mag. Acc.+9','"Mag.Atk.Bns."+6',}}
	
	MerlinicHead.FC = { name="Merlinic Hood", augments={'Mag. Acc.+21','"Fast Cast"+7','CHR+6',}}
	
	MerlinicHead.MB = { name="Merlinic Hood", augments={'Mag. Acc.+25 "Mag.Atk.Bns."+25','Magic burst dmg.+10%','INT+11','"Mag.Atk.Bns."+14',}}
    MerlinicBody.MB = { name="Merlinic Jubbah", augments={'Mag. Acc.+19 "Mag.Atk.Bns."+19','Magic burst dmg.+10%','MND+7','Mag. Acc.+14','"Mag.Atk.Bns."+9',}}
    MerlinicLegs.MB = { name="Merlinic Shalwar", augments={'Mag. Acc.+23 "Mag.Atk.Bns."+23','Magic burst dmg.+10%','INT+7','"Mag.Atk.Bns."+5',}}
	
	MerlinicBody.Aspir = { name="Merlinic Jubbah", augments={'Mag. Acc.+25 "Mag.Atk.Bns."+25','"Drain" and "Aspir" potency +10',}}
    MerlinicHands.Aspir = { name="Merlinic Dastanas", augments={'Mag. Acc.+22','"Drain" and "Aspir" potency +9',}}
    MerlinicLegs.Aspir = { name="Merlinic Shalwar", augments={'Mag. Acc.+25 "Mag.Atk.Bns."+25','"Drain" and "Aspir" potency +9','INT+14','Mag. Acc.+11',}}
    MerlinicFeet.Aspir = { name="Merlinic Crackows", augments={'Mag. Acc.+13 "Mag.Atk.Bns."+13','"Drain" and "Aspir" potency +9','MND+8','Mag. Acc.+12',}}
	
	MerlinicHands.P = { name="Merlinic Dastanas", augments={'Pet: Accuracy+30 Pet: Rng. Acc.+30','Blood Pact Dmg.+9','Pet: INT+6','Pet: Mag. Acc.+9',}}
	MerlinicHands.M = { name="Merlinic Dastanas", augments={'Pet: Mag. Acc.+12 Pet: "Mag.Atk.Bns."+12','Blood Pact Dmg.+9','Pet: INT+4','Pet: Mag. Acc.+9','Pet: "Mag.Atk.Bns."+8',}}
	
	-- ===================================================================================================================
	--      Ambuscade/Reive Capes
	-- ===================================================================================================================
	Alaunus = {}
	Alaunus.Idle = { name="Alaunus's Cape", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','Enmity-10','Mag. Evasion+15',}}
	Alaunus.MEVA = { name="Alaunus's Cape", augments={'MND+20','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','Haste+10','Mag. Evasion+15',}}
	Alaunus.Cure = { name="Alaunus's Cape", augments={'MND+20','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','"Cure" potency +10%','Phys. dmg. taken-10%',}}
	
	Alaunus.MAB = { name="Alaunus's Cape", augments={'MND+20','Mag. Acc+20 /Mag. Dmg.+20','MND+10','"Mag.Atk.Bns."+10',}}

	Alaunus.DA = { name="Alaunus's Cape", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}}
	Alaunus.STP = { name="Alaunus's Cape", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Store TP"+10','Phys. dmg. taken-10%',}}
	Alaunus.Crit = { name="Alaunus's Cape", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Crit.hit rate+10',}}
	Alaunus.WSD = { name="Alaunus's Cape", augments={'MND+20','Accuracy+20 Attack+20','MND+10','Weapon skill damage +10%',}}
	
	Campestres = {}
	Campestres.P = { name="Campestres's Cape", augments={'Pet: Acc.+20 Pet: R.Acc.+20 Pet: Atk.+20 Pet: R.Atk.+20','Accuracy+20 Attack+20','Pet: Accuracy+10 Pet: Rng. Acc.+10','Pet: "Regen"+10',}}
	Campestres.M = { name="Campestres's Cape", augments={'Pet: M.Acc.+20 Pet: M.Dmg.+20','Mag. Acc+20 /Mag. Dmg.+20','"Fast Cast"+10',}}
	
	Lughs={}

	Lughs.MAB = { name="Lugh's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','INT+10','"Mag.Atk.Bns."+10',}}
	Lughs.MP = { name="Lugh's Cape", augments={'MP+60','Eva.+20 /Mag. Eva.+20','MP+20','Enmity-10','Phys. dmg. taken-10%',}}
	
	Bookworms = {}
	Bookworms.Regen = { name="Bookworm's Cape", augments={'INT+4','MND+1','Helix eff. dur. +11','"Regen" potency+10',}}
	Bookworms.Helix = { name="Bookworm's Cape", augments={'INT+2','MND+4','Helix eff. dur. +20',}}
	
	Nantosuelta = {}
	Nantosuelta.MAB = { name="Nantosuelta's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','INT+10','"Mag.Atk.Bns."+10',}}
    Nantosuelta.Pet = { name="Nantosuelta's Cape", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','Pet: "Regen"+10','Damage taken-5%',}}
	
	-- ===================================================================================================================
	--      Weapon Augments
	-- ===================================================================================================================
	Gada = {}
	Gada.Cmp = { name="Gada", augments={'"Conserve MP"+6','Mag. Acc.+19','"Mag.Atk.Bns."+22',}}
	Gada.Enhance = { name="Gada", augments={'Enh. Mag. eff. dur. +6','Mag. Acc.+3','"Mag.Atk.Bns."+20',}}
	
	Grio = {}
	Grio.FC = { name="Grioavolr", augments={'"Fast Cast"+6','MP+106','Mag. Acc.+2','"Mag.Atk.Bns."+16',}}

end
