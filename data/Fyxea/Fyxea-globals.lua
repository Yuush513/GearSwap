
function define_global_sets ()

-------------------------
TaeonHead={};TaeonBody={};TaeonHands={};TaeonLegs={};TaeonFeet={}
HerculeanHead={};HerculeanBody={};HerculeanHands={};HerculeanLegs={};HerculeanFeet={}
Rostam={}

--Weps--
Rostam.A = { name="Rostam", augments={'Path: A',}}
Rostam.B = { name="Rostam", augments={'Path: B',}}
Rostam.C = { name="Rostam", augments={'Path: C',}}

--COR--
Camulus={}
Camulus.STP = { name="Camulus's Mantle", augments={'AGI+20','Rng.Acc.+20 Rng.Atk.+20','AGI+10','"Store TP"+10',}}
Camulus.CRIT = { name="Camulus's Mantle", augments={'AGI+20','Rng.Acc.+20 Rng.Atk.+20','AGI+10','Crit.hit rate+10',}}
Camulus.DW = { name="Camulus's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dual Wield"+10','Phys. dmg. taken-10%',}}
Camulus.DA = { name="Camulus's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}}
Camulus.STR = { name="Camulus's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%',}}
Camulus.AGI = { name="Camulus's Mantle", augments={'AGI+20','Rng.Acc.+20 Rng.Atk.+20','AGI+10','Weapon skill damage +10%',}}
Camulus.MAB = { name="Camulus's Mantle", augments={'AGI+20','Mag. Acc+20 /Mag. Dmg.+20','AGI+10','Weapon skill damage +10%',}}
Camulus.FC = { name="Camulus's Mantle", augments={'HP+60','Eva.+20 /Mag. Eva.+20','"Fast Cast"+10','"Regen"+5',}}
Camulus.Snap = { name="Camulus's Mantle", augments={'INT+20','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','"Snapshot"+10','Phys. dmg. taken-10%',}}


--Taeon--


--Herculean--
HerculeanHead.FC = { name="Herculean Helm", augments={'"Fast Cast"+6','INT+8','"Mag.Atk.Bns."+8',}}
HerculeanLegs.FC = { name="Herculean Trousers", augments={'"Mag.Atk.Bns."+15','"Fast Cast"+6','MND+4',}}

HerculeanHead.MAB = { name="Herculean Helm", augments={'Mag. Acc.+19 "Mag.Atk.Bns."+19','Weapon skill damage +1%','AGI+7','"Mag.Atk.Bns."+14',}}
HerculeanHands.MAB = { name="Herculean Gloves", augments={'MND+11','"Mag.Atk.Bns."+27','Accuracy+20 Attack+20','Mag. Acc.+18 "Mag.Atk.Bns."+18',}}
HerculeanLegs.MAB = { name="Herculean Trousers", augments={'Mag. Acc.+20 "Mag.Atk.Bns."+20','Weapon skill damage +1%','STR+9','Mag. Acc.+13','"Mag.Atk.Bns."+12',}}

HerculeanHead.DEX_WSD = { name="Herculean Helm", augments={'Accuracy+22 Attack+22','Weapon skill damage +5%','DEX+7','Attack+1',}}
HerculeanHead.STR_WSD = { name="Herculean Helm", augments={'Rng.Acc.+19','Weapon skill damage +5%','STR+9','Attack+8',}}

HerculeanLegs.WSD = { name="Herculean Trousers", augments={'Pet: INT+8','Pet: DEX+1','Weapon skill damage +9%',}}	
HerculeanLegs.AGI_WSD = { name="Herculean Trousers", augments={'Rng.Atk.+6','Weapon skill damage +4%','AGI+13','Rng.Acc.+7',}}
HerculeanLegs.STR_WSD = { name="Herculean Trousers", augments={'Accuracy+16 Attack+16','Weapon skill damage +5%','STR+4',}}
	
HerculeanFeet.TA = { name="Herculean Boots", augments={'"Triple Atk."+4','DEX+4','Accuracy+11','Attack+5',}}

HerculeanBody.TH = { name="Herculean Vest", augments={'Magic dmg. taken -4%','Pet: Phys. dmg. taken -3%','"Treasure Hunter"+2','Accuracy+6 Attack+6',}}
HerculeanHands.TH ={ name="Herculean Gloves", augments={'DEX+6','Accuracy+3 Attack+3','"Treasure Hunter"+2',}}
HerculeanFeet.TH = { name="Herculean Boots", augments={'AGI+3','Pet: Accuracy+1 Pet: Rng. Acc.+1','"Treasure Hunter"+2','Mag. Acc.+4 "Mag.Atk.Bns."+4',}}
---Ru'an Gear-----


end