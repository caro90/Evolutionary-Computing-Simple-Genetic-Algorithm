#alternative
function countingOnes(population,offsprings)
    parentSum=Array{Int64}(size(population,1));
    offspringSum=Array{Int64}(size(population,1));

    progress=0;
    ## Fitness calculation
    for i=1:size(population,1)
        parentSum[i]=sum(population[i,:]);
        offspringSum[i]=sum(offsprings[i,:]);

    end
    if maximum(parentSum)==size(population,2) || maximum( offspringSum)==size(population,2)
    #Solution found=> a string of all 1s.
        progress=-1;
    end


return  parentSum,offspringSum,progress;
end
