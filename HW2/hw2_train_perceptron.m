function weights = hw2_train_perceptron(train_data, passes)
%UNTITLED12 Summary of this function goes here
%   Detailed explanation goes here

    weights = zeros(58,1);
    

    for t = 1 : passes;
    
        for j = 1:3601;

            y = train_data(j,58);
            
            if y == 0;
                y = -1;
            end
            
            x = train_data(j,1:57);
            x(:,58) = 1; 
            
            if(sign(dot(weights,x)) * sign(y) <= 0);
                weights = weights + transpose(y * x);
            end
            
        end
        
    end
    
end

