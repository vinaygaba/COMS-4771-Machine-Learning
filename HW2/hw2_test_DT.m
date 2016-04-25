function labels = hw2_test_DT(tree, test_data)
%UNTITLED6 Summary of this function goes here
%   Detailed explanation goes here

    %chnge to 1000 when calling test_spam
    for i = 1:1000;
        
        test = test_data(i,1:57);
        j = 1;
        
        cell = tree;
        
        while true;  
            display(j);
           [row,column] = size(cell{j});
            if column == 1
                labels(i) = cell{j}(1);
                break;
            else
                value = test(1,cell{j}(1));
                
                if value <= cell{j}(2);
                    cell = cell{2 * j}
                    j = j*2;
                else
                     cell = cell{2 * j + 1}
                    j = j*2+1;
                end
                
            end
               
        end
   
    end


end

