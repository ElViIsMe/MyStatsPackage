#= #implement a function called rse_sum 
#This function should return true if provided with the following test: 
#rse_sum(1:36) == 666. You should further make use of a for-loop.

function rse_sum(a)
    b = 0
    for k = a
        b = b+k
    end
    return b
#= 
    if sum(a) == 666
        return true
    else
        return false
    end =#
end
#---

##implement a second function called rse_mean, which calculates the mean of the provided vector. 
##Make sure to use the rse_sum function! Test it using rse_mean(-15:17) == 1

function rse_mean(a)
    c = rse_sum(a)/length(a)
    return c
end
#---

#Next implement a standard deviation function rse_std: \sqrt{\frac{\sum(x-mean(x))}{n-1}}
#, this time you should use elementwise/broadcasting operators. Test it with rse_std(1:3) == 1
import Statistics.std
function rse_std(a)
    std(a)
    #= for k = 1:length(a)
    d(k) = sqrt((rse_sum(sqr(k-rse_mean(k)))/(k-1))) =#
end
#---

#Finally, we will implement rse_tstat, returning the t-value with length(x)-1 DF, 
#that the provided Array actually has a mean of 0. 
#The formula is \frac{mean(x)}{std(x) / (sqrt(length(x)))} Test it with rse_tstat(2:3) == 5.. 
#Add the keyword argument σ that allows the user to optionally provide a pre-calculated standard deviation.

#= function rse_tstat(a)

end =#
#---

#Implement a type StatResult with fields for x, n, std and tvalue
struct StatResult
    x::Vector
    n::Vector
    std::Vector
    #tvalue::Int
end
 =#
#---
##Solutions##

#---
using ProgressMeter
import Base: length
function rse_sum(x)
    s = 0
    @showprogress for k in eachindex(x)
        s = s + x[k]
    end
    return s
end

rse_sum(1:36) == 666
#--- 

function rse_mean(x)
    return rse_sum(x) / length(x)
end

rse_mean(-15:17) == 1

#----
function rse_std(x)
    return sqrt(rse_sum((x .- rse_mean(x)) .^ 2) / (length(x) - 1))
end
rse_std([1, 2, 3]) == 1

#----
function rse_tstat(x; σ = rse_std(x))
    return rse_mean(x) ./ (σ / sqrt(length(x)))
end

rse_tstat(2:3) == 5

#---

struct StatResult
    x::Vector
    n::Int32
    std::Float64
    tvalue::Float64
end
Base.length(s::StatResult) = s.n
StatResult(x) = StatResult(x, length(x))

StatResult(x, n) = StatResult(x, n, rse_std(x))
StatResult(x, n, std) = StatResult(x, n, std, rse_tstat(x; σ = std))


StatResult([10, 500.0]) # <1>

function tstat(x)
    return StatResult(length(x), rse_tstat(x))
end

