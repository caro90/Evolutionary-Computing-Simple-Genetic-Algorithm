function point2Crossover(population)
    populationCopy=population;
    #Generate two random points to perfom the crossover across the string of 1s and 0s.
    x=rand(1:size(population,2));
    y=rand(1:size(population,2));
    if(y>x) x,y= y,x; end
    i=1;
    while i<size(population,1)
        populationCopy[i,y:x],populationCopy[i+1,y:x]=populationCopy[i+1,y:x],populationCopy[i,y:x];
        i=i+2
    end

return populationCopy
end
