function uniformCrossover(population)
    populationCopy=Array{Int64,2}(size(population,1),size(population,2));
    randomNum=Array{Float64,2}(Int(size(population,1)/2),size(population,2));
    # Generate randomNum array with values between [0-1] to perform the crossover
    #Size N/2 , l because we use every row for every two parents
    for j=1:Int(size(population,1)/2)
        for i=1:size(population,2)
            randomNum[j,i]=rand();
        end
    end
    j=1;
    k=1;
    while j< size(population,1)
        #1st offspring creation
        for i=1:size(population,2)
            if(randomNum[k,i]>=0.5)
                populationCopy[j,i]=population[j,i];
            else
                populationCopy[j,i]=population[j+1,i];
            end
        end
        #2nd offspring creation
        for i=1:size(population,2)
            if(randomNum[k,i]<0.5)
                populationCopy[j+1,i]=population[j,i];
            else
                populationCopy[j+1,i]=population[j+1,i];
            end
        end
    k=k+1;
    j=j+2;
    end
return populationCopy
end
