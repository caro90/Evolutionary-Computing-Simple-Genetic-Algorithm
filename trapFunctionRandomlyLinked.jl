function trapFunctionRandomlyLinked(population,offsprings,deceptiveFactor,randomPermutationRandomlyLinked)
    parentSum=Array{Int64}(size(population,1));
    offspringSum=Array{Int64}(size(population,1));
    tempPopulation=Array{Int64}(1,4);
    tempOffspring=Array{Int64}(1,4);
    COparent=0;
    COoffspring=0;
    totalParentSum=Array{Float64}(size(population,1));
    totalParentSum[:]=0;
    totalOffspringSum=Array{Float64}(size(population,1));
    totalOffspringSum[:]=0;
    progress=0;
    progress2=0;
    k=4;

    populationCopy=population;
    offspringCopy=offsprings;

    for i=1:size(population,1)
        populationCopy[i,:]=populationCopy[i,sortperm(randomPermutationRandomlyLinked)];
        offspringCopy[i,:]= offspringCopy[i,sortperm(randomPermutationRandomlyLinked)];
        for j=1:4:size(populationCopy,2)
            tempPopulation=populationCopy[i,j:j+3];
            tempOffspring=offspringCopy[i,j:j+3];
            tempPopulation=reshape(tempPopulation,1,4);
            tempOffspring=reshape(tempOffspring,1,4);

            COparent,COoffspring,progress=countingOnes(tempPopulation,tempOffspring);
            progress=0;
            if COparent[1]==k

                #CO(x1...xk)=k
                totalParentSum[i]=totalParentSum[i]+k;#COparent[1];
            else#CO(x1...xk)<k
                totalParentSum[i]=totalParentSum[i] +( (k-deceptiveFactor)-(k-deceptiveFactor)/(k-1) *COparent[1]);
            end
            if (COoffspring[1]==k)
                #CO(x1...xk)=k
                totalOffspringSum[i]=totalOffspringSum[i]+k;#COoffspring[1];
            else#CO(x1...xk)<k
                totalOffspringSum[i]=totalOffspringSum[i] +( (k-deceptiveFactor)-(k-deceptiveFactor)/(k-1) *COoffspring[1]);
            end

        end
    end
    if  maximum(totalParentSum)==size(population,2) ||  maximum(totalOffspringSum)==size(population,2)
    #Solution found=> a string of all 1s.
        progress2=-1;
    end

return totalParentSum, totalOffspringSum, progress2;
end
