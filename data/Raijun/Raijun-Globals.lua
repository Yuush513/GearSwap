
function define_global_sets ()

TaeonHead={}; TaeonBody={}; TaeonHands={}; TaeonLegs={}; TaeonFeet={}
YoriumHead={}; YoriumBody={}; YoriumHands={}; YoriumLegs={}; YoriumFeet={}

ValorousHead={}; ValorousBody={}; ValorousHands={}; ValorousLegs={}; ValorousFeet={}
HerculeanHead={}; HerculeanBody={}; HerculeanHands={}; HerculeanLegs={}; HerculeanFeet={}
OdysseanHead={}; OdysseanBody={}; OdysseanHands={}; OdysseanLegs={}; OdysseanFeet={}

AdhemarHead={}; AdhemarBody={}; AdhemarHands={}; AdhemarLegs={}; AdhemarFeet={}
SouveranHead={}; SouveranBody={}; SouveranHands={}; SouveranLegs={}; SouveranFeet={}

----- Aug. Nolan ------
AdhemarHands.B = { name="Adhemar Wrist. +1", augments={'STR+12','DEX+12','Attack+20',}}
AdhemarHands.A = { name="Adhemar Wrist. +1", augments={'DEX+12','AGI+12','Accuracy+20',}}

SouveranHead.C = { name="Souv. Schaller +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}}
SouveranHead.D = { name="Souv. Schaller +1", augments={'HP+105','VIT+12','Phys. dmg. taken -4',}}

SouveranHands.C = { name="Souv. Handsch. +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}}
SouveranHands.D = { name="Souv. Handsch. +1", augments={'HP+65','Shield skill +15','Phys. dmg. taken -4',}}

----- Skirmish ------
TaeonHead.SNAP = { name="Taeon Chapeau", augments={'"Snapshot"+5','"Snapshot"+5',}}



----- Aug. Res ------

--Valorous--
ValorousFeet.QA = { name="Valorous Greaves", augments={'MND+10','"Dual Wield"+1','Quadruple Attack +3','Accuracy+5 Attack+5','Mag. Acc.+4 "Mag.Atk.Bns."+4',}}

ValorousHead.WSD  ={ name="Valorous Mask", augments={'Enmity-3','"Fast Cast"+1','Weapon skill damage +8%',}}
ValorousBody.WSD = { name="Valorous Mail", augments={'Accuracy+21 Attack+21','Weapon skill damage +5%','Attack+11',}}
ValorousHands.WSD ={ name="Valorous Mitts", augments={'"Cure" potency +4%','Accuracy+1','Weapon skill damage +7%','Accuracy+13 Attack+13','Mag. Acc.+10 "Mag.Atk.Bns."+10',}}
ValorousFeet.WSD  ={ name="Valorous Greaves", augments={'Attack+25','Weapon skill damage +5%','STR+10','Accuracy+11',}}

ValorousHead.TH = { name="Valorous Mask", augments={'Pet: STR+6','"Mag.Atk.Bns."+19','"Treasure Hunter"+2',}}
ValorousHands.TH = { name="Valorous Mitts", augments={'Crit. hit damage +2%','Damage taken-2%','"Treasure Hunter"+2','Accuracy+4 Attack+4',}}

ValorousBody.STP = { name="Valorous Mail", augments={'"Store TP"+8','Accuracy+3',}}
ValorousFeet.STP = { name="Valorous Greaves", augments={'Accuracy+7','"Store TP"+8','Attack+2',}}

--Odyssean--
OdysseanHands.STR_WSD = { name="Odyssean Gauntlets", augments={'Weapon skill damage +4%','STR+10','Accuracy+4','Attack+1',}}
OdysseanLegs.STR_WSD = { name="Odyssean Cuisses", augments={'Attack+1','Weapon skill damage +5%','STR+10',}}

OdysseanLegs.VIT_WSD = { name="Odyssean Cuisses", augments={'Attack+26','Weapon skill damage +5%','VIT+8','Accuracy+2',}}
	
OdysseanLegs.Enmity = { name="Odyssean Cuisses", augments={'Attack+8','Enmity+7','VIT+2','Accuracy+5',}}

OdysseanLegs.DA = { name="Odyssean Cuisses", augments={'Accuracy+15','"Dbl.Atk."+5',}}
OdysseanLegs.STP = { name="Odyssean Cuisses", augments={'"Store TP"+8','VIT+2','Accuracy+9','Attack+7',}}
	
OdysseanFeet.FC = { name="Odyssean Greaves", augments={'"Fast Cast"+6','Accuracy+5','Attack+6',}}

OdysseanFeet.Cure = { name="Odyssean Greaves", augments={'"Cure" potency +6%','MND+4',}}

--Herculean--
HerculeanHead.STR_WSD = { name="Herculean Helm", augments={'Attack+20','Weapon skill damage +4%','STR+9','Accuracy+1',}}
HerculeanBody.STR_WSD = { name="Herculean Vest", augments={'Accuracy+10','Weapon skill damage +4%','STR+8','Attack+14',}}
HerculeanHands.STR_WSD = { name="Herculean Gloves", augments={'Accuracy+14','Weapon skill damage +4%','STR+10','Attack+14',}}
HerculeanLegs.STR_WSD = { name="Herculean Trousers", augments={'Accuracy+18','Weapon skill damage +3%','STR+6','Attack+9',}}
HerculeanFeet.STR_WSD = { name="Herculean Boots", augments={'Accuracy+29','Weapon skill damage +4%','STR+12','Attack+1',}}

HerculeanBody.AGI_WSD = { name="Herculean Vest", augments={'Rng.Acc.+10','Weapon skill damage +4%','AGI+10',}}
HerculeanFeet.AGI_WSD = { name="Herculean Boots", augments={'Weapon skill damage +4%','AGI+12','Rng.Acc.+7','Rng.Atk.+5',}}

HerculeanBody.CRIT = { name="Herculean Vest", augments={'Attack+12','Crit. hit damage +4%','DEX+11','Accuracy+7',}}

HerculeanHead.MAB_WSD = { name="Herculean Helm", augments={'Mag. Acc.+17 "Mag.Atk.Bns."+17','Weapon skill damage +2%','STR+1','Mag. Acc.+10','"Mag.Atk.Bns."+13',}}
HerculeanBody.MAB_WSD = { name="Herculean Vest", augments={'Mag. Acc.+19 "Mag.Atk.Bns."+19','Weapon skill damage +4%','INT+10','Mag. Acc.+10','"Mag.Atk.Bns."+13',}}
HerculeanLegs.MAB_WSD = { name="Herculean Trousers", augments={'"Mag.Atk.Bns."+20','Weapon skill damage +4%','Mag. Acc.+2',}}

HerculeanHands.MAB = { name="Herculean Gloves", augments={'Mag. Acc.+13','"Mag.Atk.Bns."+28','Accuracy+17 Attack+17','Mag. Acc.+12 "Mag.Atk.Bns."+12',}}

HerculeanHands.STR_TA = { name="Herculean Gloves", augments={'Rng.Atk.+2','"Triple Atk."+4','STR+8','Accuracy+5','Attack+13',}}
HerculeanFeet.STR_TA = { name="Herculean Boots", augments={'"Triple Atk."+4','STR+10','Accuracy+12','Attack+5',}}
    
HerculeanHead.TH = { name="Herculean Helm", augments={'Pet: Attack+21 Pet: Rng.Atk.+21','STR+10','"Treasure Hunter"+2','Mag. Acc.+14 "Mag.Atk.Bns."+14',}}
HerculeanFeet.Phalanx = { name="Herculean Boots", augments={'Pet: STR+3','MND+9','Phalanx +5','Accuracy+4 Attack+4',}}

-----Ambuscade Capes-----

--SAM--
Smertrios={}
Smertrios.WSD ={ name="Smertrios's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%',}}
Smertrios.DA ={ name="Smertrios's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}}
Smertrios.MEVA ={ name="Smertrios's Mantle", augments={'DEX+20','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','"Store TP"+10','Phys. dmg. taken-10%',}}
Smertrios.STP ={ name="Smertrios's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Store TP"+10','Phys. dmg. taken-10%',}}
Smertrios.Enmity = { name="Smertrios's Mantle", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','Enmity+10','Damage taken-5%',}}
--Smertrios.MAB  STR Mdmg/macc MDMG WSDMG

--PLD--
Rudianos = {}
Rudianos.Block = { name="Rudianos's Mantle", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Enmity+10','Chance of successful block +5',}}
Rudianos.Tank = { name="Rudianos's Mantle", augments={'HP+60','Eva.+20 /Mag. Eva.+20','HP+20','Enmity+10','Phys. dmg. taken-10%',}}
Rudianos.Cure = { name="Rudianos's Mantle", augments={'HP+60','Eva.+20 /Mag. Eva.+20','HP+20','"Cure" potency +10%','Phys. dmg. taken-10%',}}
Rudianos.FC = { name="Rudianos's Mantle", augments={'HP+60','Eva.+20 /Mag. Eva.+20','HP+20','"Fast Cast"+10','Phys. dmg. taken-10%',}}

Rudianos.STP = { name="Rudianos's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','"Store TP"+10','Phys. dmg. taken-10%',}}
Rudianos.DA = { name="Rudianos's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','"Dbl.Atk."+10','Phys. dmg. taken-10%',}}
Rudianos.WSD = { name="Rudianos's Mantle", augments={'STR+20','Accuracy+20 Attack+20','Weapon skill damage +10%',}}
Rudianos.CRIT = { name="Rudianos's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Crit.hit rate+10',}}

--RNG--
Belenus = {}
Belenus.RA = { name="Belenus's Cape", augments={'AGI+20','Rng.Acc.+20 Rng.Atk.+20','AGI+10','"Store TP"+10',}}
Belenus.AGI_WSD = { name="Belenus's Cape", augments={'AGI+20','Rng.Acc.+20 Rng.Atk.+20','AGI+10','Weapon skill damage +10%',}}
Belenus.MAB_WSD = { name="Belenus's Cape", augments={'AGI+20','Mag. Acc+20 /Mag. Dmg.+20','AGI+10','Weapon skill damage +10%',}}
Belenus.SNAP = { name="Belenus's Cape", augments={'"Snapshot"+10',}}
Belenus.DW = { name="Belenus's Cape", augments={'DEX+20','Accuracy+20 Attack+20','"Dual Wield"+10','Phys. dmg. taken-10%',}}
Belenus.STR = { name="Belenus's Cape", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%',}}
Belenus.Crit = { name="Belenus's Cape", augments={'AGI+20','Rng.Acc.+20 Rng.Atk.+20','AGI+10','Crit.hit rate+10',}}


--MNK--
Segomo = {}
Segomo.CRIT = { name="Segomo's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Crit.hit rate+10',}}
Segomo.MEVA = { name="Segomo's Mantle", augments={'DEX+20','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','"Dbl.Atk."+10','Mag. Evasion+15',}}
Segomo.STR_WSD = { name="Segomo's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%',}}
Segomo.STR_DA = { name="Segomo's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','"Dbl.Atk."+10','System: 1 ID: 640 Val: 4',}}
Segomo.DEX_DA = { name="Segomo's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}}
Segomo.FC = { name="Segomo's Mantle", augments={'VIT+20','Eva.+20 /Mag. Eva.+20','"Fast Cast"+10','Phys. dmg. taken-10%',}}

--NIN--
Andartia = {}
Andartia.DEX_DA = { name="Andartia's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','"Dbl.Atk."+10',}}
Andartia.AGI_WSD = { name="Andartia's Mantle", augments={'AGI+20','Accuracy+20 Attack+20','Weapon skill damage +10%',}}
Andartia.FC = { name="Andartia's Mantle", augments={'HP+60','Eva.+20 /Mag. Eva.+20','"Fast Cast"+10',}}

--BLU--
Rosmerta = {}
Rosmerta.FC = { name="Rosmerta's Cape", augments={'"Fast Cast"+10',}}
Rosmerta.Crit = { name="Rosmerta's Cape", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','Crit.hit rate+10',}}
Rosmerta.WSD = { name="Rosmerta's Cape", augments={'STR+20','Accuracy+20 Attack+20','Weapon skill damage +10%',}}
Rosmerta.DA = { name="Rosmerta's Cape", augments={'DEX+20','Accuracy+20 Attack+20','"Dbl.Atk."+10',}}
Rosmerta.MAB = { name="Rosmerta's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','"Mag.Atk.Bns."+10',}}



end