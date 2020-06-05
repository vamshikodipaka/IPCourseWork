%~~~~~~~~~~~~~~~~~~ Arithmetic Decoder ~~~~~~~~~~~~~~~~~~~~%

function seq = Arith_Decoder(Symb , Prob , code)

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

i = code;
THRESHOLD = 0.01;
seq = [];
while i >= THRESHOLD
    INDEX = 1;
    for iter2 = 1: length(newHigh)
        if i < newHigh(iter2) && i > newLow(iter2)
            INDEX=iter2;
            seq = [seq, Symb(INDEX)]; 
            
            break
        end
       
    end
    range = newHigh(INDEX) - newLow(INDEX);
    i =  vpa(i - newLow(INDEX))./range;
    
    
end

end
