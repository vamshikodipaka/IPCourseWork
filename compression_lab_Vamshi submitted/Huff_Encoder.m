%~~~~~~~~~~~~~~~~~~ Huffman Encoder ~~~~~~~~~~~~~~~~~~~~%

function code = Huff_Encoder( Prob )

code = cell(1,length(Prob));
tempP = Prob;
queue = [];

mark = length(Prob);

    for i= length(tempP) : -1 : 1
        if i == 1 
            if isempty(queue)
            break;
            else
                code{i} = [ {1},code{i}];
                for j1 = i : length(Prob)
                    code{j1} = [ {0},code{j1}];
                end
            end
         elseif ( tempP(i) <= tempP(i-1))
            if ~isempty(queue) 
                for q =1:length(queue)
                    if queue{q}(1)< tempP(i)+ tempP(i-1)
                        tempP(i) = tempP(i)+ queue{q}(1);
                        code{i-1} = [ {1},code{i-1}];
                        for j = i : mark
                            code{j} = [ {0},code{j}];
                        end
                        tempP(i-1) = tempP(i)+ tempP(i-1);
                         
                        for j = i-1 : queue{q}(2)-1
                           code{j} = [ {1},code{j}];
                        end
                         
                        if q == length(queue)
                            destn = length(Prob);
                        else
                             destn = queue{q+1}(2);
                        end
                         
                        for j = queue{q}(2) : destn
                           code{j} = [ {0},code{j}];
                        end
                         
                        queue = queue(1:length(queue)-1);
                    end
                    break;
                    
                end
            else
             code{i-1} = [ {1},code{i-1}];
            for j = i : mark
                code{j} = [ {0},code{j}];
            end
            tempP(i-1) = tempP(i)+ tempP(i-1);       
            end
        else
            queue = [{[tempP(i), i]} ,queue];
            mark = i-1;
        end
    end

end 
