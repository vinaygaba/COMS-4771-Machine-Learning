function tree = hw2_train_DT_recursive(train_data, depth, z, usedFeatures)
    
    if depth == 0;
      [r,c] = size(train_data); 
      [M,F] = mode(train_data(:,c));
      tree{z} = M;
      return;
        
    else
         
        [rowSize, columnSize] = size(train_data);
              
     if rowSize == 1;
         label = train_data(:,columnSize);
         tree{z} = label;
         return;
     end
     
     
        
        %display(columnSize);
        
        for i = 1:columnSize-1;
        
        if ismember(i, usedFeatures(:)) == 1;
           minErrorForEveryFeature(i,1) = intmax('int64');
           minErrorForEveryFeature(i,2) = 0;
            continue;
        end  
            
            
        labelMatrix = train_data(1:rowSize,[i:i columnSize:columnSize]);
        sortedMatrix = sortrows(labelMatrix,1);
        
        uniqueValues = unique(sortedMatrix(1:rowSize,1));
        [UrowSize, UcolumnSize] = size(uniqueValues);
        minErrorForFeature = 100;
        minThresholdForFeature = 0;
        
        for j = 1 : UrowSize;
          
            tempThreshold = uniqueValues(j);
            
            left = [];
            right = [];
            
            for k = 1:rowSize;
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
       
        end
        
        
        if rowSize > 1; 
        
        [M,I] = min(minErrorForEveryFeature(:,1));
        usedFeatures(end+1) = I;
        
        
        globalMinThreshold =  minErrorForEveryFeature(I,2);
        
        
         %matrixSortedOnFeature = sortrows(train_data, I);
         %splitMatrixLeft = any(train_data <= globalMinThreshold, I); 
         splitMatrixLeft = train_data(train_data(:,I) <= globalMinThreshold , :);

         %splitMatrixRight = any(train_data > globalMinThreshold, I); 
         splitMatrixRight = train_data(train_data(:,I) > globalMinThreshold , :);
         
         [leftRS, leftCS] = size(splitMatrixLeft);
         [rightRS, rightCS] = size(splitMatrixRight);
         
        if leftRS == 0 || rightRS == 0
            ma = 0;
            if leftRS == 0
              [MAX,FREQ] = mode(splitMatrixRight(:,rightCS));
              ma = MAX;
            else
              [MAX,FREQ] = mode(splitMatrixLeft(:,leftCS));
              ma = MAX;
            end
           tree{z} = ma;
           return;
           
         else  
       tree{z} = [I,globalMinThreshold]; 
       tree{2*z} = hw2_train_DT_recursive(splitMatrixLeft, depth-1, 2*z, usedFeatures);
       tree{2*z+1} = hw2_train_DT_recursive(splitMatrixRight,depth-1, 2*z+1, usedFeatures); 
        end
        
       end
       
    end
end