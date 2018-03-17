function bisectionSearch(crossOverChoice,fitnessChoice,deceptiveFactor)
 first=10;
 firstValue=0;
 lastValue=0;
 sumFirst=0;
#---------------------------------
# Finding the gap part for the bisection method
while(firstValue<24)
  for j=1:25
          x, temp1 ,temp2=geneticAlgorithm(first,100,crossOverChoice,fitnessChoice,deceptiveFactor);
          sumFirst=sumFirst+x;
  end

  firstValue=sumFirst;
  first=first*2;
  sumFirst=0;

end
sumLast=0;
#setting the first pointer to the last pointer
last=first
while(lastValue<24)
  for j=1:25
          x, temp1, temp2=geneticAlgorithm(last,100,crossOverChoice,fitnessChoice,deceptiveFactor);
          sumLast=sumLast+x;
  end
  lastValue=sumLast;
  last=last*2;
  sumLast=0;
end

println("firstValue=")
println(first)
println(firstValue)
println("lastValue=")
println(last)
println(lastValue)
#----------------------------------------

fitnessFunctionEvaluations=0;
generationsCounter=0;
time=0;
midPoint=0;
mValue=0;
while(first<last) #check convergence
  midPoint=div((first+last),2);
  midPoint=(midPoint- midPoint%10)
  #-------------------
  println("@@@@@@@@@@@@@")
  println(first)
  println(last)
  println(midPoint)
  println(mValue)
  println("@@@@@@@@@@@@@")
  #-----------------
  sum1=0;
  sum2=0;
  sum3=0;
  tic()
  for i=1:25

     x,fitnessFunctionEvaluations,generationsCounter=geneticAlgorithm(midPoint,l,crossOverChoice,fitnessChoice,deceptiveFactor);
     sum1=sum1+x;
     sum2=sum2+fitnessFunctionEvaluations;
     sum3=sum3+generationsCounter;

  end
  time=toc();
  mValue=sum1;
  fitnessFunctionEvaluations=sum2;
  generationsCounter=sum3;

  if firstValue<mValue
   firstValue=mValue;
   first=midPoint;
   #println(midPoint)
  else
   lastValue=mValue-10;
   last=midPoint;
  end

end


return midPoint,fitnessFunctionEvaluations,generationsCounter,time;
end
