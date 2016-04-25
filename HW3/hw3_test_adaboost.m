function [error] = hw3_test_adaboost(params, test_data,k)
error_count  = 0;

[rs, cs] = size(test_data);
[prs, pcs] = size(params);
for i = 1 : rs
    classifier = 0;
    finalPredictedLabel = 0;
    
    label = test_data(i,58);
    for j = 1 : k
        feature_no = params(j,1);
        alpha = params(j,5);
        threshold = params(j,2);
        
        feature_value = test_data(i,feature_no);
        
        if(feature_value <= threshold)
            predictedLabel = params(j,3);
        else
            predictedLabel = params(j,4);
        end;
        classifier = classifier + (alpha * predictedLabel);
     
    end;
     
     if classifier <= 0;
         finalPredictedLabel = -1;
     else
          finalPredictedLabel = 1;
     end   
         
     if(finalPredictedLabel ~= label)
         error_count = error_count+1;
     end;
end;
 error  = error_count / rs;
 
end
         
     
     



