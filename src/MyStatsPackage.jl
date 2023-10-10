module MyStatsPackage

using ProgressMeter
include("statistic_functions.jl")
include("printOwner.jl")

export rse_sum
export rse_mean, rse_tstat, printOwner

end # module MyStatsPackage https://github.com/ElViIsMe/MyStatsPackage
#add https://github.com/ElViIsMe/nwietersMyStatsPackage
