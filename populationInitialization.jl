#N population,  l string length
function populationInitialization(N::Int,l::Int)
    rng = MersenneTwister(1234);
    #Random population
    return population=rand(rng,[0,1],(N,l))

end
