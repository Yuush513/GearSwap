-- Initialization function for this job file.
 
local jobs = T{ "Reive_RDM", "PUPsets", "Reive_BLU", "Reive_GEO", "Reive_BRD", "Reive_SCH"}
 
mysets = {}
 
for k,v in pairs(jobs) do
    include(v .. '.lua')
    get_sets()
    mysets[v] = sets
    sets = {}
 end
 
 
function get_sets()
    for k,v in pairs(mysets) do sets[k] = v end
end