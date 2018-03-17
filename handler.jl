include("geneticAlgorithm.jl")
include("populationInitialization.jl");
include("2pointCrossover.jl");
include("countingOnes.jl");
include("uniformCrossover.jl");
include("trapFunctionTightlyLinked.jl");
include("trapFunctionRandomlyLinked.jl");
include("bisectionSearch.jl")
opt=2;
N=10;
l=100;

if opt==1

    crossOverChoice=2;
    fitnessChoice=3;
    deceptiveFactor=2.5;
    sum1=0;
    x=0;
    exp5NonDeceptiveTrapfunctionRandomlyLinkedUX=Array{Int64,1}(8);
    #p for population counting
    p=1;
    while N<=1280
        for j=1:30
            x ,temp1, temp2=geneticAlgorithm(N,l,crossOverChoice,fitnessChoice,deceptiveFactor);
            sum1=sum1+x;
        end
        println("--------------------------")
        println("sum=")
        print(sum1)
        exp5NonDeceptiveTrapfunctionRandomlyLinkedUX[p]=sum1;
        sum1=0;
        p=p+1;
        N=N*2;
    end
end

if opt==2
    #-------
    #bisectionSearch(crossOverChoice,fitnessChoice,deceptiveFactor)
    println("Minimum population is: ")
    midPoint,fitnessFunctionsEvaluations,generationsCounter,time=bisectionSearch(2,3,2.5) ;

    minimumPopulationCountingOnes2X=midPoint
    AVGfitness=fitnessFunctionsEvaluations/25
    AVGgenerations=generationsCounter/25
    AVGtime=time/25

end
