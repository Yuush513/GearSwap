
function define_global_sets ()

-------------------------
TelchineHead={};TelchineBody={};TelchineHands={};TelchineLegs={};TelchineFeet={}
HeliosHead={};HeliosBody={};HeliosHands={};HeliosLegs={};HeliosFeet={}
AcroHead={};AcroBody={};AcroHands={};AcroLegs={};AcroFeet={}
TaeonHead={};TaeonBody={};TaeonHands={};TaeonLegs={};TaeonFeet={}
ValorousHead={};ValorousBody={};ValorousHands={};ValorousLegs={};ValorousFeet={}
OdysseanHead={};OdysseanBody={};OdysseanHands={};OdysseanLegs={};OdysseanFeet={}
MerlinicHead={};MerlinicBody={};MerlinicHands={};MerlinicLegs={};MerlinicFeet={}
HerculeanHead={};HerculeanBody={};HerculeanHands={};HerculeanLegs={};HerculeanFeet={}
ApogeeHead={};

-------------------------
-----Ambuscade Capes-----

--RUN--
Ogma={}
Ogma.PDT={ name="Ogma's cape", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','"Enmity+10','Phys. dmg. taken-10%',}}
Ogma.Parry={ name="Ogma's cape", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','Enmity+10','Parrying rate+5%',}}
Ogma.FC={ name="Ogma's Cape", augments={'HP+60','Eva.+20 /Mag. Eva.+20','HP+20','"Fast Cast"+10','Mag. Evasion+15',}}

Ogma.STP={ name="Ogma's cape", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Store TP"+10','Phys. dmg. taken-10%',}}
Ogma.DA={ name="Ogma's cape", augments={'STR+20','Accuracy+20 Attack+20','STR+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}}
Ogma.DEX={ name="Ogma's cape", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','Weapon skill damage +10%','Phys. dmg. taken-10%',}}
Ogma.STR={ name="Ogma's cape", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%','Phys. dmg. taken-10%',}}

Ogma.Eva={ name="Ogma's Cape", augments={'AGI+20','Eva.+20 /Mag. Eva.+20','Evasion+10','Enmity+10','Evasion+15',}}
Ogma.DEF={ name="Ogma's Cape", augments={'VIT+20','Eva.+20 /Mag. Eva.+20','Enmity+10','DEF+50',}}
Ogma.MAB={ name="Ogma's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','"Mag.Atk.Bns."+10',}}

--WAR--
Cichol={}
Cichol.Enmity ={ name="Cichol's Mantle", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','Enmity+10','Damage taken-5%',}}
Cichol.MEVA ={ name="Cichol's Mantle", augments={'DEX+20','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','"Dbl.Atk."+10','Mag. Evasion+15',}}
Cichol.STR_DA ={ name="Cichol's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}}
Cichol.DEX_DA ={ name="Cichol's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}}
Cichol.STR_WSD ={ name="Cichol's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%','Phys. dmg. taken-10%',}}
Cichol.VIT_WSD ={ name="Cichol's Mantle", augments={'VIT+20','Accuracy+20 Attack+20','VIT+10','Weapon skill damage +10%','Phys. dmg. taken-10%',}}

--BLU--
Rosmerta={}
Rosmerta.FC ={ name="Rosmerta's Cape", augments={'MND+20','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','"Fast Cast"+10','Phys. dmg. taken-10%',}}
Rosmerta.MAB ={ name="Rosmerta's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','INT+10','"Mag.Atk.Bns."+10',}}
Rosmerta.Crit ={ name="Rosmerta's Cape", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','Crit.hit rate+10',}}
Rosmerta.DA ={ name="Rosmerta's Cape", augments={'DEX+20','Accuracy+20 Attack+20','"Dbl.Atk."+10','Phys. dmg. taken-10%',}}
Rosmerta.STP = { name="Rosmerta's Cape", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Store TP"+10','Phys. dmg. taken-10%',}}
Rosmerta.WSD ={ name="Rosmerta's Cape", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%',}}
Rosmerta.Evasion ={ name="Rosmerta's Cape", augments={'AGI+20','Eva.+20 /Mag. Eva.+20','Evasion+10','"Fast Cast"+10','Evasion+15',}}

--THF--
Toutatis={}
Toutatis.STP ={ name="Toutatis's Cape", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Store TP"+10','Phys. dmg. taken-10%',}}
Toutatis.WSD ={ name="Toutatis's Cape", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','Weapon skill damage +10%',}}
Toutatis.Crit ={ name="Toutatis's Cape", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','Crit.hit rate+10',}}
Toutatis.AGI ={ name="Toutatis's Cape", augments={'AGI+20','Accuracy+20 Attack+20','AGI+10','"Dbl.Atk."+10',}}
Toutatis.MEVA ={ name="Toutatis's Cape", augments={'DEX+20','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','"Store TP"+10','Mag. Evasion+15',}}
Toutatis.FC ={ name="Toutatis's Cape", augments={'"Fast Cast"+10',}}
	
--DRG--
Brigantia={}
Brigantia.DA_STR ={ name="Brigantia's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}}
Brigantia.DA_DEX ={ name="Brigantia's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}}
Brigantia.WSD ={ name="Brigantia's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%',}}
Brigantia.CRIT ={ name="Brigantia's Mantle", augments={'STR+20','Accuracy+20 Attack+20','Crit.hit rate+10',}}
Brigantia.STP ={ name="Brigantia's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','"Store TP"+10','Pet: "Regen"+5',}}
Brigantia.MEVA ={ name="Brigantia's Mantle", augments={'DEX+20','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}}

--SMN--
Campestres={}
Campestres.P ={ name="Campestres's Cape", augments={'Pet: Acc.+20 Pet: R.Acc.+20 Pet: Atk.+20 Pet: R.Atk.+20','Accuracy+20 Attack+20','Pet: Accuracy+10 Pet: Rng. Acc.+10','Pet: "Regen"+10','Damage taken-5%',}}
Campestres.M ={ name="Campestres's Cape", augments={'Pet: M.Acc.+20 Pet: M.Dmg.+20','Mag. Acc+20 /Mag. Dmg.+20','"Fast Cast"+10',}}

--COR--
Camulus={}
Camulus.DEX_DA ={ name="Camulus's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','"Dbl.Atk."+10',}}
Camulus.RA_STP ={ name="Camulus's Mantle", augments={'AGI+20','Rng.Acc.+20 Rng.Atk.+20','"Store TP"+10',}}
Camulus.STR_WSD ={ name="Camulus's Mantle", augments={'STR+20','Accuracy+20 Attack+20','Weapon skill damage +10%',}}
Camulus.RA_WSD ={ name="Camulus's Mantle", augments={'AGI+20','Rng.Acc.+20 Rng.Atk.+20','Weapon skill damage +10%',}}
Camulus.MAG_WSD ={ name="Camulus's Mantle", augments={'AGI+20','Mag. Acc+20 /Mag. Dmg.+20','Weapon skill damage +10%',}}
Camulus.Snap ={ name="Camulus's Mantle", augments={'"Snapshot"+10',}}

--DRK--
Ankou={}
Ankou.STR_DA ={ name="Ankou's Mantle", augments={'STR+20','Accuracy+20 Attack+20','"Dbl.Atk."+10',}}

--NIN--
Andartia={}
Andartia.STP ={ name="Andartia's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','"Store TP"+10',}}
Andartia.FC ={ name="Andartia's Mantle", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','"Fast Cast"+10',}}
Andartia.DEX_WSD ={ name="Andartia's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Weapon skill damage +10%',}}
	
--BLM--
Taranus={}
Taranus.Death ={ name="Taranus's Cape", augments={'MP+60','Mag. Acc+20 /Mag. Dmg.+20','MP+20','"Mag.Atk.Bns."+10',}}
Taranus.Nuke ={ name="Taranus's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','INT+10','"Mag.Atk.Bns."+10',}}

--GEO--
Nantosuelta={}
Nantosuelta.Regen ={ name="Nantosuelta's Cape", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Pet: "Regen"+10',}}

--WHM--
Alaunus={}
Alaunus.FC ={ name="Alaunus's Cape", augments={'MND+20','Mag. Acc+20 /Mag. Dmg.+20','"Fast Cast"+10',}}

-----Skirmish Items-----


--Telchine--
	
TelchineHead.Pet ={ name="Telchine Cap", augments={'Mag. Evasion+22','Pet: "Regen"+3','Pet: Damage taken -4%',}}
TelchineBody.Pet ={ name="Telchine Chas.", augments={'Mag. Evasion+15','Pet: "Regen"+3','Pet: Damage taken -4%',}}
TelchineLegs.Pet ={ name="Telchine Braconi", augments={'Mag. Evasion+19','Pet: "Regen"+3','Pet: Damage taken -4%',}}
TelchineFeet.Pet ={ name="Telchine Pigaches", augments={'Mag. Evasion+21','Pet: "Regen"+3','Pet: Damage taken -4%',}}

TelchineHead.Enhance ={ name="Telchine Cap", augments={'Mag. Evasion+24','Spell interruption rate down -9%','Enh. Mag. eff. dur. +10',}}
TelchineBody.Enhance ={ name="Telchine Chas.", augments={'Mag. Evasion+19','Spell interruption rate down -5%','Enh. Mag. eff. dur. +10',}}
TelchineLegs.Enhance ={ name="Telchine Braconi", augments={'Mag. Evasion+18','Spell interruption rate down -10%','Enh. Mag. eff. dur. +10',}}
TelchineFeet.Enhance ={ name="Telchine Pigaches", augments={'Mag. Evasion+18','Spell interruption rate down -2%','Enh. Mag. eff. dur. +10',}}

TelchineHands.Pet = { name="Telchine Gloves", augments={'Mag. Evasion+18','Pet: "Regen"+3','Enh. Mag. eff. dur. +10',}}
TelchineHands.Cure = { name="Telchine Gloves", augments={'Mag. Evasion+19','"Cure" potency +8%','HP+49',}}


--Helios--
HeliosHead.BP ={ name="Helios Band", augments={'Pet: Accuracy+28 Pet: Rng. Acc.+28','Pet: "Dbl. Atk."+8','Blood Pact Dmg.+7',}}
HeliosFeet.BP ={ name="Helios Boots", augments={'Pet: Accuracy+29 Pet: Rng.Acc.+29','Pet: "Dbl. Atk."+8','Blood Pact Dmg.+7',}}

HeliosHands.FC ={ name="Helios Gloves", augments={'"Fast Cast"+5','MP+38',}}


--Taeon--
TaeonBody.FC ={ name="Taeon Tabard", augments={'Mag. Evasion+20','"Fast Cast"+5','HP+50',}}


--Acro--
AcroBody.Breath  ={ name="Acro Surcoat", augments={'Pet: Mag. Acc.+25','Pet: Breath+8','HP+49',}}
AcroHands.Breath ={ name="Acro Gauntlets", augments={'Pet: Mag. Acc.+23','Pet: Breath+8','HP+49',}}
AcroLegs.Breath ={ name="Acro Breeches", augments={'Pet: Mag. Acc.+25','Pet: Breath+8','HP+47',}}
AcroFeet.Breath ={ name="Acro Leggings", augments={'Pet: Mag. Acc.+25','Pet: Breath+8','HP+50',}}

AcroHands.STP ={ name="Acro Gauntlets", augments={'Accuracy+18 Attack+18','"Store TP"+6','STR+7 DEX+7',}}



-----Resienjima Gear-----



--Valorous

ValorousBody.STP ={ name="Valorous Mail", augments={'Accuracy+29','"Store TP"+8','DEX+1','Attack+2',}}
ValorousLegs.STP ={ name="Valorous Hose", augments={'Accuracy+26','"Store TP"+8','DEX+3','Attack+8',}}

ValorousBody.DA ={ name="Valorous Mail", augments={'Accuracy+28','"Dbl.Atk."+5','CHR+5',}}
ValorousLegs.DA ={ name="Valorous Hose", augments={'Accuracy+23 Attack+23','"Dbl.Atk."+5','Accuracy+5',}}

ValorousHead.WSD ={ name="Valorous Mask", augments={'Accuracy+26','Weapon skill damage +4%','STR+7','Attack+15',}}
ValorousBody.WSD ={ name="Valorous Mail", augments={'Accuracy+27','Weapon skill damage +4%','STR+14','Attack+5',}}
ValorousLegs.WSD  ={ name="Valorous Hose", augments={'Accuracy+18 Attack+18','Weapon skill damage +4%','STR+9','Attack+3',}}
ValorousFeet.WSD = { name="Valorous Greaves", augments={'Accuracy+19','Weapon skill damage +5%','STR+10','Attack+9',}}

ValorousHead.STR_Crit = { name="Valorous Mask", augments={'Attack+10','Crit. hit damage +4%','STR+4','Accuracy+5',}}
ValorousBody.STR_Crit ={ name="Valorous Mail", augments={'Attack+26','Crit. hit damage +5%','STR+8','Accuracy+11',}}
ValorousHands.STR_Crit ={ name="Valorous Mitts", augments={'Accuracy+2','Crit. hit damage +4%','STR+12','Attack+15',}}
ValorousLegs.STR_Crit ={ name="Valorous Hose", augments={'Accuracy+2','Crit. hit damage +4%','STR+14','Attack+14',}}
ValorousFeet.STR_Crit ={ name="Valorous Greaves", augments={'Crit. hit damage +4%','STR+7','Accuracy+8',}}
    
ValorousHands.VIT_Crit ={ name="Valorous Mitts", augments={'Accuracy+16','Crit. hit damage +4%','VIT+9','Attack+4',}}
ValorousFeet.VIT_Crit ={ name="Valorous Greaves", augments={'Accuracy+16','Crit. hit damage +4%','VIT+9','Attack+2',}}

--Odyssean--
 
OdysseanHands.STR_WSD ={ name="Odyssean Gauntlets", augments={'Weapon skill damage +5%','STR+7','Attack+13',}}
OdysseanHands.VIT_WSD ={ name="Odyssean Gauntlets", augments={'Attack+25','Weapon skill damage +3%','VIT+15','Accuracy+13',}}
OdysseanLegs.VIT_WSD  ={ name="Odyssean Cuisses", augments={'Accuracy+3','Weapon skill damage +4%','VIT+13','Attack+2',}}

OdysseanLegs.STP ={ name="Odyssean Cuisses", augments={'Attack+28','"Store TP"+8','AGI+2','Accuracy+7',}}

OdysseanHead.FC = { name="Odyssean Helm", augments={'"Mag.Atk.Bns."+9','"Fast Cast"+5','INT+4',}}
OdysseanBody.FC = { name="Odyss. Chestplate", augments={'Mag. Acc.+17','"Fast Cast"+6','"Mag.Atk.Bns."+13',}}
OdysseanFeet.FC = { name="Odyssean Greaves", augments={'Mag. Acc.+4 "Mag.Atk.Bns."+4','"Fast Cast"+5','MND+7',}}


--Merlinic--

MerlinicHead.FC ={ name="Merlinic Hood", augments={'Attack+25','"Fast Cast"+5','MND+7','Mag. Acc.+6','"Mag.Atk.Bns."+3',}}
MerlinicBody.FC ={ name="Merlinic Jubbah", augments={'"Fast Cast"+6','"Mag.Atk.Bns."+11',}}
MerlinicFeet.FC ={ name="Merlinic Crackows", augments={'Mag. Acc.+23 "Mag.Atk.Bns."+23','"Fast Cast"+6','INT+3','Mag. Acc.+11',}}

MerlinicHands.P ={ name="Merlinic Dastanas", augments={'Pet: Accuracy+19 Pet: Rng. Acc.+19','Blood Pact Dmg.+10',}}
MerlinicHands.M  ={ name="Merlinic Dastanas", augments={'Pet: "Mag.Atk.Bns."+23','Blood Pact Dmg.+10',}}
	

MerlinicHead.MB ={ name="Merlinic Hood", augments={'"Mag.Atk.Bns."+27','Magic burst dmg.+10%','INT+10','Mag. Acc.+9',}}
MerlinicBody.MB ={ name="Merlinic Jubbah", augments={'Mag. Acc.+23 "Mag.Atk.Bns."+23','Magic burst dmg.+10%','INT+7','Mag. Acc.+14','"Mag.Atk.Bns."+12',}}
MerlinicLegs.MB ={ name="Merlinic Shalwar", augments={'Mag. Acc.+19 "Mag.Atk.Bns."+19','Magic burst dmg.+7%','CHR+10','Mag. Acc.+1','"Mag.Atk.Bns."+13',}}
MerlinicFeet.MB ={ name="Merlinic Crackows", augments={'Mag. Acc.+23 "Mag.Atk.Bns."+23','Magic burst dmg.+9%','CHR+6','Mag. Acc.+7',}}
		
MerlinicHead.Nuke ={ name="Merlinic Hood", augments={'Mag. Acc.+21 "Mag.Atk.Bns."+21','Mag. crit. hit dmg. +8%','MND+2','Mag. Acc.+11','"Mag.Atk.Bns."+9',}}
MerlinicLegs.Nuke ={ name="Merlinic Shalwar", augments={'Mag. Acc.+25 "Mag.Atk.Bns."+25','Magic dmg. taken -2%','CHR+2','"Mag.Atk.Bns."+15',}}
		
MerlinicFeet.Aspir ={ name="Merlinic Crackows", augments={'Mag. Acc.+19 "Mag.Atk.Bns."+19','"Drain" and "Aspir" potency +8','INT+9','"Mag.Atk.Bns."+3',}}



--Herculean--

HerculeanBody.Phalanx = { name="Herculean Vest", augments={'Pet: Attack+9 Pet: Rng.Atk.+9','"Store TP"+3','Phalanx +4','Accuracy+13 Attack+13','Mag. Acc.+5 "Mag.Atk.Bns."+5',}}
HerculeanHands.Phalanx = { name="Herculean Gloves", augments={'AGI+2','Attack+4','Phalanx +4',}}
HerculeanLegs.Phalanx = { name="Herculean Trousers", augments={'Rng.Acc.+18','STR+7','Phalanx +5',}}
HerculeanFeet.Phalanx  = { name="Herculean Boots", augments={'Chance of successful block +1','Haste+2','Phalanx +4','Accuracy+4 Attack+4',}}

HerculeanHands.DT ={ name="Herculean Gloves", augments={'Enmity+1','Potency of "Cure" effect received+2%','Damage taken-5%',}}

HerculeanHands.Refresh ={ name="Herculean Gloves", augments={'"Cure" spellcasting time -5%','Pet: AGI+2','"Refresh"+2','Mag. Acc.+10 "Mag.Atk.Bns."+10',}}	
HerculeanFeet.Refresh  ={ name="Herculean Boots", augments={'DEX+3','Mag. Acc.+24','"Refresh"+2','Accuracy+14 Attack+14',}}

HerculeanHead.FC = { name="Herculean Helm", augments={'"Mag.Atk.Bns."+13','"Fast Cast"+6','DEX+6','Mag. Acc.+2',}}
HerculeanLegs.FC = { name="Herculean Trousers", augments={'Mag. Acc.+16 "Mag.Atk.Bns."+16','"Fast Cast"+5','Mag. Acc.+4',}}
HerculeanFeet.FC = { name="Herculean Boots", augments={'Mag. Acc.+17','"Fast Cast"+6','MND+2',}}

HerculeanHead.MAB ={ name="Herculean Helm", augments={'Mag. Acc.+17 "Mag.Atk.Bns."+17','INT+12','"Mag.Atk.Bns."+15',}}

HerculeanBody.MAB_WSD = { name="Herculean Vest", augments={'Mag. Acc.+20 "Mag.Atk.Bns."+20','Weapon skill damage +4%','INT+10','"Mag.Atk.Bns."+12',}}
HerculeanHands.MAB_WSD =  {name="Herculean Gloves", augments={'Mag. Acc.+19 "Mag.Atk.Bns."+19','Weapon skill damage +4%','MND+13','"Mag.Atk.Bns."+5',}}
HerculeanLegs.MAB_WSD = { name="Herculean Trousers", augments={'"Mag.Atk.Bns."+23','Weapon skill damage +4%','INT+11','Mag. Acc.+7',}}
HerculeanFeet.MAB_WSD ={ name="Herculean Boots", augments={'Mag. Acc.+16 "Mag.Atk.Bns."+16','Weapon skill damage +4%','STR+8','"Mag.Atk.Bns."+13',}}

HerculeanHead.WSD ={ name="Herculean Helm", augments={'Haste+1','MND+4','Weapon skill damage +7%','Accuracy+8 Attack+8','Mag. Acc.+19 "Mag.Atk.Bns."+19',}}
HerculeanBody.WSD = { name="Herculean Vest", augments={'MND+7','STR+9','Weapon skill damage +9%',}}
HerculeanLegs.WSD ={ name="Herculean Trousers", augments={'"Drain" and "Aspir" potency +6','Pet: STR+8','Weapon skill damage +7%','Mag. Acc.+18 "Mag.Atk.Bns."+18',}}

HerculeanHead.STR_WSD = { name="Herculean Helm", augments={'Accuracy+15 Attack+15','Weapon skill damage +4%','STR+15','Accuracy+15',}}
HerculeanFeet.STR_WSD ={ name="Herculean Boots", augments={'Weapon skill damage +5%','STR+10','Accuracy+2','Attack+8',}}	

HerculeanBody.DEX_WSD = { name="Herculean Vest", augments={'Weapon skill damage +5%','DEX+7','Accuracy+15','Attack+10',}}
HerculeanHead.DEX_WSD = { name="Herculean Helm", augments={'Attack+24','Weapon skill damage +4%','DEX+15','Accuracy+8',}}

HerculeanLegs.Crit ={ name="Herculean Trousers", augments={'Crit. hit damage +4%','DEX+7','Accuracy+10','Attack+10',}}
HerculeanFeet.Crit ={ name="Herculean Boots", augments={'Accuracy+18 Attack+18','Crit. hit damage +4%','DEX+8','Attack+2',}}	
	
HerculeanBody.TA  ={ name="Herculean Vest", augments={'Accuracy+27','"Triple Atk."+4','AGI+3',}}
HerculeanHands.TA ={ name="Herculean Gloves", augments={'Accuracy+26','"Triple Atk."+4','DEX+5',}}
HerculeanFeet.TA  ={ name="Herculean Boots", augments={'Accuracy+21','"Triple Atk."+4','DEX+9','Attack+9',}}

HerculeanHands.STR_TA ={ name="Herculean Gloves", augments={'Accuracy+11 Attack+11','"Triple Atk."+3','STR+14','Attack+5',}}
HerculeanLegs.STR_TA  ={ name="Herculean Trousers", augments={'Accuracy+30','"Triple Atk."+4','STR+5','Attack+15',}}	
HerculeanFeet.STR_TA = { name="Herculean Boots", augments={'Attack+28','"Triple Atk."+3','STR+9','Accuracy+14',}}	

HerculeanFeet.STP = { name="Herculean Boots", augments={'Accuracy+17','"Store TP"+6','DEX+4','Attack+5',}}

HerculeanBody.TH = { name="Herculean Vest", augments={'Accuracy+19','Pet: Mag. Acc.+25','"Treasure Hunter"+2','Mag. Acc.+13 "Mag.Atk.Bns."+13',}}
HerculeanHands.TH = { name="Herculean Gloves", augments={'STR+8','Enmity-4','"Treasure Hunter"+2','Mag. Acc.+1 "Mag.Atk.Bns."+1',}}
HerculeanLegs.TH = { name="Herculean Trousers", augments={'Phys. dmg. taken -1%','Pet: "Subtle Blow"+5','"Treasure Hunter"+2','Accuracy+2 Attack+2',}}


---Ru'an Gear-----

---Weapons---

Grioavolr = {}
Grioavolr.Pet = { name="Grioavolr", augments={'Blood Pact Dmg.+8','Pet: INT+10','Pet: Mag. Acc.+9','Pet: "Mag.Atk.Bns."+28','DMG:+4',}}

--Armor--
AdhemarHead = {}
AdhemarHead.B = { name="Adhemar Bonnet +1", augments={'STR+12','DEX+12','Attack+20',}}
AdhemarHead.D = { name="Adhemar Bonnet +1", augments={'HP+105','Attack+13','Phys. dmg. taken -4',}}

LustratioFeet = {}
LustratioFeet.A = { name="Lustra. Leggings +1", augments={'Attack+20','STR+8','"Dbl.Atk."+3',}}
LustratioFeet.D = { name="Lustra. Leggings +1", augments={'HP+65','STR+15','DEX+15',}}

end