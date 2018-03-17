#old approach
function countingOnesFitness(population,offsprings)
    parentSum=Array{Int64}(size(population,1));
    offspringSum=Array{Int64}(size(population,1));
    V=Array{Int64}(Int( 4));
    newGen=Array{Int64,2}(size(population,1),size(population,2));
    progress=0;
    ## Fitness calculation
    k=1;
    for i=1:size(population,1)
        parentSum[i]=sum(population[i,:]);
        offspringSum[i]=sum(offsprings[i,:]);

        if parentSum[i]==size(population,2) || offspringSum[i]==size(population,2)
        #Solution found=> a string of all 1s.
            progress=-1;
        end
        if(i%2==0)
            ## Finding the best 2 out of 4 solutions
            V[:]=sortperm([ parentSum[i-1],offspringSum[i-1],parentSum[i],offspringSum[i] ])
            ## Picking up the best 2:
            #1ST solution
            if  ( V[3]%2!=0 )
                #found a parent
                if( V[3]==1)
                    #*** Checking whether a parent and a child have the same best fitness.
                    #if so, the child  is copied to the next generation
                    if     (parentSum[i-1]==offspringSum[i-1] )
                            newGen[k,:]=offsprings[i-1,:];

                    elseif ( parentSum[i-1]==offspringSum[i] )
                            newGen[k,:]=offspringSum[i,:];
                    else
                        newGen[k,:]=population[i-1,:];
                    end

                else
                    #V[3]==3
                    #***
                    if     (parentSum[i]==offspringSum[i-1] )
                            newGen[k,:]=offsprings[i-1,:];

                    elseif ( parentSum[i]==offspringSum[i])
                            newGen[k,:]=offsprings[i,:];
                    else
                            newGen[k,:]=population[i,:];
                    end
                end
            end
            #1ST solution
            if  ( V[3]%2==0 )
                #found a child
                if( V[3]==2)
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
                    if     (parentSum[i-1]==offspringSum[i-1] )
                            newGen[k+1,:]=offsprings[i-1,:];

                    elseif ( parentSum[i-1]==offspringSum[i] )
                            newGen[k+1,:]=offspringSum[i,:];
                    else
                            newGen[k+1,:]=population[i-1,:];
                    end
                else
                    #V[4]==3
                    #***
                    if     (parentSum[i]==offspringSum[i-1] )
                            newGen[k+1,:]=offsprings[i-1,:];

                    elseif ( parentSum[i]==offspringSum[i])
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
            println(V[:])
            print(parentSum[i-1] );print(" ");print(offspringSum[i-1]);print(" ");print(parentSum[i]);print(" ");print( offspringSum[i]);
        end

    end
if progress==-1 println("\nSolution found\n"); end
return  parentSum,offspringSum,newGen,progress;
end
