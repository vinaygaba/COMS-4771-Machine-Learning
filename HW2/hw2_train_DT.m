function tree = hw2_train_DT(train_spam, depth)
%UNTITLED9 Summary of this function goes here
%   Detailed explanation goes here
    
%allLabels = train_data(1:3601,57);
%[M,F] = mode(allLabels);

%rootUncertanity = 1 - (F/3601);
    
    %minThresholdForEveryFeature = [];
    spcz=0;
    sprz = 0;
    label = 0;
    for d = 0:depth;
        
          minErrorForEveryFeature = zeros(57 - d,2);
      
        for l = 0:power(2,depth)-1;
        
            if d > 0
                
             parentIndex = tree(floor((power(2,d)+l)/2),1);
             parentThreshold =  tree(floor((power(2,d)+l)/2),2);
            
             %display(parentIndex);
             %(parentThreshold);
             remainder = mod((power(2,d)+l), 2);
             if remainder == 0
                 
                 matrixSortedOnFeature = sortrows(train_spam, parentIndex);
                 splitMatrix = any(matrixSortedOnFeature <= parentThreshold); 
                 splitMatrix(:,parentIndex) = [];
                 %choose values smaller than parentThreshold
                 
             else
                 %choose values greater than parentThreshold
                  matrixSortedOnFeature = sortrows(train_spam, parentIndex);
                 splitMatrix = any(matrixSortedOnFeature > parentThreshold); 
                 splitMatrix(:,parentIndex) = [];
                 
             end
              
            else 
               splitMatrix = train_spam(:,:);
               
            end
            
           [splitMatrixRowSize,splitMatrixColumnSize] = size(splitMatrix); 
           spcz = splitMatrixColumnSize;
           sprz = splitMatrixRowSize;
           
           
           
        if d == depth
          [Mode,Freq]  =  mode(splitMatrix(:,spcz));
          label = Mode;
        else       
            
        for i = 1:spcz-1;
        labelMatrix = splitMatrix(1:sprz,[i:i spcz:spcz]);
        sortedMatrix = sortrows(labelMatrix,1);
        
        uniqueValues = unique(sortedMatrix(1: sprz,1));
        [rowSize,columnSize] = size(uniqueValues);
        minErrorForFeature = 100;
        minThresholdForFeature = 0;
        
        for j = 1 : rowSize;
          
            tempThreshold = uniqueValues(j);
            
            left = [];
            right = [];
            
            for k = 1:sprz;
              a = sortedMatrix(k,2);
                
                if sortedMatrix(k,1) <= tempThreshold;
                    
                   left(end + 1) = a;
                    
                else
                    
                    right(end + 1) = a;
                    
                end
                
            end
             
                classError = classificationError(left,right);
                
                
                
                if classError < minErrorForFeature;
                    
                    minErrorForFeature = classError;
                    minThresholdForFeature = tempThreshold;
                    
                    
                    
                end
    
        end
    
        minErrorForEveryFeature(i,1) = minErrorForFeature;
        minErrorForEveryFeature(i,2) = minThresholdForFeature;
        
        
        %display(minErrorForEveryFeature);

        end
        end
        
     if d ~= depth   
        [M,I] = min(minErrorForEveryFeature(:,1));
        globalMinThreshold =  minErrorForEveryFeature(I,2);
        tree(power(2,d)+l,1) = I;
        tree(power(2,d)+l,2) = globalMinThreshold; 
     else
         tree(power(2,d)+l,1) = label;
        tree(power(2,d)+l,2) =label; 
     end
        end
    
    end

    
end

