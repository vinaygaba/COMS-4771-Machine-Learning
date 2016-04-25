function [loss] = hw1_test_NB(params,test_data)

    error_count = 0;
    for i = 1:1000
    
        if test_data(i,257) ~= params(i) 
            
             error_count =  error_count + 1;
             display(i)
            
        end
    end
    
    loss = error_count;
end

