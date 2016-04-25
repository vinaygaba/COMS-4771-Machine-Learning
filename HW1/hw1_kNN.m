function result = hw1_kNN(k, train_data, test_data)
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here

result = [];

for i = 1:1000;
    distanceArray = [];
    labelArray = [];
    for j = 1:10000;
        
        sum = 0;
        for z = 1:256;
            
        sum = sum + (train_data(j,z) - test_data(i,z))^2;
            
        end
        
        sum = sqrt(sum);
        %distanceArray(j) = sum;
        %labelArray(j) = train_data(j,257);
        matrix(j,1) = sum;
        matrix(j,2) = train_data(j,257);
        
    end
    
    %[value,index] = min(distanceArray);
    %result(i) = labelArray(index);
    
    % Sort rows to get top k values
    sortedMatrix = sortrows(matrix,1);
   
    topK = sortedMatrix(1:k,2);
     [M,F] = mode(topK);
     result(i) = M;
    end

end

