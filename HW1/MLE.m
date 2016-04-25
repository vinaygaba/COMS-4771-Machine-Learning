

output = hw1_train_NB(train_usps);
display(output);
result = [];

for i = 1:10000;
    array = [1,1,1,1,1,1,1,1,1,1];
    
    for j = 1:256;
        
        val = train_usps(i,j);
        
        for k = 1:10;
            
            if(val == 1)
               array(k) = array(k) * output(k,j);
            else
               array(k) = array(k) * (1 - output(k,j));
            end
            
        end
    
    end
    
    [max_value,index]=max(array);
    result(i) = index-1;
end

loss = hw1_test_NB(result,train_usps);
display(loss);



