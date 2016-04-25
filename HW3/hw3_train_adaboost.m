function [ decisionStumps ] = hw3_train_adaboost( train_data, num_rounds)
%HW3_TRAIN_ADABOOST Summary of this function goes here
%   Detailed explanation goes here
    [rowSize,columnSize] = size(train_data);
    weights = ones(rowSize) * (1/rowSize);
    weights = weights(:,1);
    display(weights);
    decisionStumps = [];
    for i = 1:num_rounds; 
    
    [concatMatrix,decisionStumps] = hw2_train_DT_recursive2(train_data,decisionStumps,i,weights);
        
        zt = 0;
        
%         for z = 1:3601;
%             
%             zt = zt + (weights(z,1) * train_data(z,58) * concatMatrix(z,60));
%         
%         end;
        
        zt = sum(weights(:,1) .* train_data(:,58) .* concatMatrix(:,60));
        
       display(sum(weights(:,1),1));
       display(zt);
       
        alpha = 0.5 * (log(1+zt) - log(1-zt));
        
        display(alpha);
        
        sum_weights = 0;
        
%         for j = 1:3601;
%         sum_weights = sum_weights + (weights(j,1) * exp(-alpha * train_data(j,58) * concatMatrix(j,60)));
%         end
%         
%         for j = 1:3601;
%         weights (j,1) = (weights(j,1) * exp(-alpha * train_data(j,58) * concatMatrix(j,60)))/sum_weights;
%         end
        
        
        weights = (weights(:,1) .* exp(-alpha .* train_data(:,58) .* concatMatrix(:,60)));
        weights = weights/sum(weights);
        
        decisionStumps(i,5) = alpha;
        
     
    end
    
    display(decisionStumps);

end

