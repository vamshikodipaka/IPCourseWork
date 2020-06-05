%~~~~~~~~~~~~~~~~~~ Arithmetic Encoder ~~~~~~~~~~~~~~~~~~~~%
function Low  = Arith_Encoder(Symb , Prob , Seq)

newHigh = zeros(length(Symb));
newLow = zeros(length(Symb));

tempH = 0;
tempL = 1;

for iter = 1:length(Symb)
    
    newHigh(iter) = 1 - tempH;
    tempH = tempH + Prob(iter);
    
    tempL = tempL - Prob(iter);
    newLow(iter) = tempL; 
end

Low = 0;
High = 1;

iter = 1;
while iter < length(Seq)+1

    INDEX = 0;
    
    for iter2 = 1: length(Symb)
        if Seq(iter) == Symb(iter2)
            INDEX = iter2;
        end
    end
    
    range = High - Low ;
    High  = Low + ( range * newHigh(INDEX));
    Low = Low + (range * newLow (INDEX));
    iter = iter + 1;
end

end