function geneticAlgorithm(N,l,crossOverChoice,fitnessChoice,deceptiveFactor)
    include("populationInitialization.jl");
    population=populationInitialization(N,l);
    newGen=Array{Int64,2}(size(population,1),size(population,2));
    V=Array{Int64}(Int( 4));
    solution=0;
    fitnessFunctionEvaluations=0;

    parentSum=Array{Int64}(size(population,1));
    offspringSum=Array{Int64}(size(population,1));
    progress=0;

    # crossoverChoice: 1 for 2pointCrossover
    #                  2 for UniformCrossover
    ##crossOverChoice=2;
    #=fitnessChoice: 1 for CountingOnes
                     2 for TrapFunctionTightlyLinked
                     3) for TrapFunctionRandomLinked
                     ...
    =#
    ## randomPermutation for trapFunctionRandomlyLinked
    randomPermutationRandomlyLinked=randperm(l);

    #Generations:
    generationsCounter=1;
    while progress!=-1
        # 1)Shuffling the population:
        population = population[shuffle(1:end), :];
        # 2)Pairing using crossover:
        if (crossOverChoice==1)
            offsprings=point2Crossover(population);
        elseif (crossOverChoice==2)
            offsprings=uniformCrossover(population);
        end
        # 3) Evaluate Fitness:
        if    (fitnessChoice==1)
            parentSum,offspringSum,progress=countingOnes(population,offsprings);
        elseif (fitnessChoice==2)
            parentSum,offspringSum,progress=trapFunctionTightlyLinked(population,offsprings,deceptiveFactor);
        elseif (fitnessChoice==3)
            parentSum,offspringSum,progress=trapFunctionRandomlyLinked(population,offsprings,deceptiveFactor,randomPermutationRandomlyLinked);
        end

        # 4)Family competition: the best 2 solutions of each family of 4 are copied to the next
        # population P(t + 1):
        k=1;
        for i=2:2:size(population,1)
            ## Finding the best 2 out of 4 solutions
            V[:]=sortperm([ parentSum[i-1],offspringSum[i-1],parentSum[i],offspringSum[i] ])
            ## Picking up the best 2:
            #1ST solution
            if  ( V[3]%2!=0 )
                #found a parent
                if ( V[3]==1)
                    #*** Checking whether a parent and a child have the same best fitness.
                    #if so, the child  is copied to the next generation

                    #=if     (parentSum[i-1]==offspringSum[i-1] && V[4]!=2 )
                            newGen[k,:]=offsprings[i-1,:];

                    elseif ( parentSum[i-1]==offspringSum[i] && V[4]!=4)
                            newGen[k,:]=offsprings[i,:];
                    else=#
                        newGen[k,:]=population[i-1,:];
                   #end

                else
                    #V[3]==3
                    #***

                  #=if     (parentSum[i]==offspringSum[i-1] && V[4]!=2 )
                            newGen[k,:]=offsprings[i-1,:];

                    elseif ( parentSum[i]==offspringSum[i] && V[4]!=4)
                            newGen[k,:]=offsprings[i,:];
                    else=#
                            newGen[k,:]=population[i,:];
                   #end
                end
            end
            #1ST solution
            if  ( V[3]%2==0 )
                #found a child
                if ( V[3]==2)
                    newGen[k,:]=offsprings[i-1,:];
                else
                    #V[3]==4
                    newGen[k,:]=offsprings[i,:];
                end
            end
            #2ND solution
            if  ( V[4]%2!=0 )
                #found a parent
                if( V[4]==1)
                    #***

                    if     (parentSum[i-1]==offspringSum[i-1] && V[3]!=2 )
                            newGen[k+1,:]=offsprings[i-1,:];

                    elseif ( parentSum[i-1]==offspringSum[i] && V[3]!=4 )
                            newGen[k+1,:]=offsprings[i,:];
                    else
                            newGen[k+1,:]=population[i-1,:];
                    end
                else
                    #V[4]==3
                    #***
                   if     (parentSum[i]==offspringSum[i-1] && V[3]!=2  )
                            newGen[k+1,:]=offsprings[i-1,:];

                    elseif ( parentSum[i]==offspringSum[i] && V[3]!=4)
                            newGen[k+1,:]=offsprings[i,:];
                    else
                            newGen[k+1,:]=population[i,:];
                   end
                end
            end
            #2ND solution
            if  ( V[4]%2==0 )
                #found a child
                if( V[4]==2)
                    newGen[k+1,:]=offsprings[i-1,:];
                else
                    #V[3]==4
                    newGen[k+1,:]=offsprings[i,:];
                end
            end
            k=k+2;
        # println(V[:])
          #println("------------------");
        #  print(parentSum[i-1] );print(" ");print(offspringSum[i-1]);print(" ");print(parentSum[i]);print(" ");print( offspringSum[i]);
     end

    if progress==-1 #println("\nSolution found\n");
        solution=1; end
    # When no ofspring solution has entered the next generation,
    # then the GA run is stopped.
    if ( minimum(population-newGen)==0 && sum(population-newGen)==0 )
            #println("\nNo offsprings solutions has entered the next generations =>\n
            #  No improvement");
            progress=-1;
    end
        population=newGen;

    fitnessFunctionEvaluations=( sum(parentSum)+sum(offspringSum) )/2;
    generationsCounter=generationsCounter+1;
    end
return solution ,fitnessFunctionEvaluations, generationsCounter;
end
