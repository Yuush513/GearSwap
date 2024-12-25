
function define_global_sets()
	-- Weapons --
	Gada = {}
	Gada.Enhance = { name="Gada", augments={'Enh. Mag. eff. dur. +6','MND+2','Mag. Acc.+20',}}
	Gada.Indi = { name="Gada", augments={'Indi. eff. dur. +10','STR+5','Mag. Acc.+13',}}
	
	Colada = {}
	Colada.Enhance = { name="Colada", augments={'Enh. Mag. eff. dur. +4','INT+6','Mag. Acc.+7','DMG:+1',}}
	Colada.Refresh = { name="Colada", augments={'"Refresh"+2','Mag. Acc.+9',}}

	
	-- Telchine --
	TelchineHead={};TelchineBody={};TelchineHands={};TelchineLegs={};TelchineFeet={}
		
	TelchineHead.Pet = { name="Telchine Cap", augments={'Mag. Evasion+24','Pet: "Regen"+3','Pet: Damage taken -4%',}}
	TelchineBody.Pet = { name="Telchine Chas.", augments={'Mag. Evasion+24','Pet: "Regen"+3','Pet: Damage taken -4%',}} 
	TelchineHands.Pet = { name="Telchine Gloves", augments={'Mag. Evasion+25','Pet: "Regen"+3','Pet: Damage taken -4%',}}
    TelchineLegs.Pet = { name="Telchine Braconi", augments={'Mag. Evasion+25','Pet: "Regen"+3','Pet: Damage taken -4%',}}
    TelchineFeet.Pet = { name="Telchine Pigaches", augments={'Mag. Evasion+25','Pet: "Regen"+3','Pet: Damage taken -4%',}}
		
	TelchineHead.Enhance = { name="Telchine Cap", augments={'Mag. Evasion+23','"Conserve MP"+5','Enh. Mag. eff. dur. +10',}}
    TelchineBody.Enhance = { name="Telchine Chas.", augments={'Mag. Evasion+23','"Conserve MP"+4','Enh. Mag. eff. dur. +10',}}
	TelchineHands.Enhance = { name="Telchine Gloves", augments={'Mag. Evasion+23','"Conserve MP"+5','Enh. Mag. eff. dur. +10',}}
	TelchineLegs.Enhance = { name="Telchine Braconi", augments={'Mag. Evasion+19','"Conserve MP"+5','Enh. Mag. eff. dur. +10',}}
	TelchineFeet.Enhance = { name="Telchine Pigaches", augments={'Mag. Evasion+25','"Conserve MP"+2','Enh. Mag. eff. dur. +10',}}

	-- Merlinic --
	MerlinicHead={};MerlinicBody={};MerlinicHands={};MerlinicLegs={};MerlinicFeet={}

	MerlinicHead.Phalanx={ name="Merlinic Hood", augments={'Rng.Acc.+25','INT+15','Phalanx +4','Accuracy+19 Attack+19','Mag. Acc.+6 "Mag.Atk.Bns."+6',}}
    MerlinicLegs.Phalanx={ name="Merlinic Shalwar", augments={'Pet: "Mag.Atk.Bns."+1','AGI+3','Phalanx +5','Accuracy+5 Attack+5','Mag. Acc.+14 "Mag.Atk.Bns."+14',}}
    MerlinicFeet.Phalanx={ name="Merlinic Crackows", augments={'Accuracy+14 Attack+14','STR+9','Phalanx +5','Mag. Acc.+14 "Mag.Atk.Bns."+14',}}	
	
    MerlinicBody.Drain = { name="Merlinic Jubbah", augments={'Mag. Acc.+29','"Drain" and "Aspir" potency +10','MND+5',}}
    MerlinicHands.Drain = { name="Merlinic Dastanas", augments={'Mag. Acc.+29','"Drain" and "Aspir" potency +10','"Mag.Atk.Bns."+15',}}
    MerlinicLegs.Drain = { name="Merlinic Shalwar", augments={'Accuracy+25','"Drain" and "Aspir" potency +10','INT+3','Mag. Acc.+14','"Mag.Atk.Bns."+13',}}
    MerlinicFeet.Drain = { name="Merlinic Crackows", augments={'Mag. Acc.+20 "Mag.Atk.Bns."+20','"Drain" and "Aspir" potency +10','VIT+8','Mag. Acc.+12',}}
	
	MerlinicHead.TH = { name="Merlinic Hood", augments={'Accuracy+7','INT+4','"Treasure Hunter"+2','Accuracy+15 Attack+15',}}
    MerlinicLegs.TH = { name="Merlinic Shalwar", augments={'VIT+9','AGI+4','"Treasure Hunter"+2','Accuracy+17 Attack+17','Mag. Acc.+19 "Mag.Atk.Bns."+19',}}
	
	MerlinicFeet.WSD = { name="Merlinic Crackows", augments={'STR+2','Mag. Acc.+2','Weapon skill damage +9%',}}
	
	-- Chironic --
	ChironicHead={};ChironicBody={};ChironicHands={};ChironicLegs={};ChironicFeet={}
	ChironicHands.Refresh = { name="Chironic Gloves", augments={'Pet: VIT+1','Pet: "Store TP"+2','"Refresh"+2','Mag. Acc.+8 "Mag.Atk.Bns."+8',}}
	
	ChironicLegs.MND = { name="Chironic Hose", augments={'Mag. Acc.+22 "Mag.Atk.Bns."+22','MND+9','Mag. Acc.+12',}}
	
	-- Capes --
	Nantosuelta={}
	
    Nantosuelta.Pet={ name="Nantosuelta's Cape", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','Pet: "Regen"+10','Damage taken-5%',}}
    Nantosuelta.ExtraRegen={ name="Nantosuelta's Cape", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','Pet: "Regen"+10','Pet: "Regen"+5',}}
    Nantosuelta.PetDT={ name="Nantosuelta's Cape", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','Pet: "Regen"+10','Pet: Damage taken -5%',}}
    
	Nantosuelta.MAB={ name="Nantosuelta's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','INT+10','"Mag.Atk.Bns."+10',}}
    Nantosuelta.FC={ name="Nantosuelta's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','Mag. Acc.+10','"Fast Cast"+10','Spell interruption rate down-10%',}}
    Nantosuelta.Cure={ name="Nantosuelta's Cape", augments={'MND+20','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','"Cure" potency +10%','Phys. dmg. taken-10%',}}
	
	Nantosuelta.STP={ name="Nantosuelta's Cape", augments={'DEX+20','Accuracy+20 Attack+20','"Store TP"+10','Pet: "Regen"+5',}}
    Nantosuelta.WSD={ name="Nantosuelta's Cape", augments={'MND+20','Accuracy+20 Attack+20','MND+10','Weapon skill damage +10%','Damage taken-5%',}}
	
	Lifestream = {}
	Lifestream.Indi = { name="Lifestream Cape", augments={'Geomancy Skill +10','Indi. eff. dur. +20','Pet: Damage taken -3%',}}
	
	Sucellos={}
	Sucellos.MEVA = { name="Sucellos's Cape", augments={'MND+20','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','Enmity-10','Mag. Evasion+15',}}
	Sucellos.DW = { name="Sucellos's Cape", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dual Wield"+10','Phys. dmg. taken-10%',}}
	Sucellos.INT = { name="Sucellos's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','INT+10','"Mag.Atk.Bns."+10',}}
	Sucellos.MND = { name="Sucellos's Cape", augments={'MND+20','Mag. Acc+20 /Mag. Dmg.+20','MND+10','Weapon skill damage +10%',}}
	Sucellos.STR = { name="Sucellos's Cape", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%',}}
	Sucellos.FC = { name="Sucellos's Cape", augments={'MND+20','Mag. Acc+20 /Mag. Dmg.+20','Mag. Acc.+10','"Fast Cast"+10',}}
	
end