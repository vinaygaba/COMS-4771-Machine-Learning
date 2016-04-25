function [concatMatrix,decisionStumps] = hw2_train_DT_recursive(train_data,decisionStumps, roundNo,weights)
    
       display(roundNo);
         
        [rowSize, columnSize] = size(train_data);
        
        %display(columnSize);
        
        for i = 1:columnSize-1;
              
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
                    
                   temp(1,1) = a;
                   temp(1,2) = weights(k,1);
                   
                   left = [left;temp];
                  
                 
                    
                else
                    
                    temp(1,1) = a;
                    temp(1,2) = weights(k,1);
                    right = [right;temp];
        
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
        
        
        [M,I] = min(minErrorForEveryFeature(:,1));
        
        
        
        globalMinThreshold =  minErrorForEveryFeature(I,2);
        
        
        decisionStumps(roundNo,1) = I;
        decisionStumps(roundNo,2) = globalMinThreshold;
        
        
         %matrixSortedOnFeature = sortrows(train_data, I);
         %splitMatrixLeft = any(train_data <= globalMinThreshold, I); 
         
         for index = 1:rowSize
            
             train_data(index,59) = index;
         end    
        
       
         
         splitMatrixLeft = train_data(train_data(:,I) <= globalMinThreshold , :); 
         %splitMatrixRight = any(train_data > globalMinThreshold, I); 
         splitMatrixRight = train_data(train_data(:,I) > globalMinThreshold , :);
         
         [leftRS, leftCS] = size(splitMatrixLeft);
         [rightRS, rightCS] = size(splitMatrixRight);
         
          leftposLabelWeightCount = 0;
          leftnegLabelWeightCount = 0;
          rightposLabelWeightCount = 0;
          rightnegLabelWeightCount = 0;
  
         
         for t = 1 : leftRS;
             indexIntoWeightsArray = splitMatrixLeft(t,59);
             if(splitMatrixLeft(t,58) == 1)
                 leftposLabelWeightCount = leftposLabelWeightCount + weights(indexIntoWeightsArray,1);
             else
                 leftnegLabelWeightCount = leftnegLabelWeightCount +  weights(indexIntoWeightsArray,1);   
             end;
         end;
         
         if(leftposLabelWeightCount <=  leftnegLabelWeightCount)
             mal = -1;
         else 
             mal = 1;
         end   
             
         
         for t = 1 : rightRS;
             indexIntoWeightsArray = splitMatrixRight(t,59);
             if(splitMatrixRight(t,58) == 1)
                 rightposLabelWeightCount = rightposLabelWeightCount + weights(indexIntoWeightsArray,1);
             else
                 rightnegLabelWeightCount = rightnegLabelWeightCount +  weights(indexIntoWeightsArray,1);   
             end;
         end;
         
         
          if(rightposLabelWeightCount <= rightnegLabelWeightCount)
            mar = -1;
          else
            mar = 1;
          end
         
          decisionStumps(roundNo,3) = mal;
          decisionStumps(roundNo, 4) = mar;
         
               
        if leftRS == 0 || rightRS == 0
%             ma = 0;
            if leftRS == 0
%               [MAX,FREQ] = mode(splitMatrixRight(:,rightCS-1));
%               ma = MAX;
              maMatrix = ones(rightRS) * mar;
              maMatrix = maMatrix(:,1);
              splitMatrixRight = [splitMatrixRight maMatrix];
              concatMatrix = splitMatrixRight;
            else
%               [MAX,FREQ] = mode(splitMatrixRight(:,leftCS-1));
%               ma = MAX;
              maMatrix = ones(leftRS) * mal;
              maMatrix = maMatrix(:,1);
              splitMatrixLeft = [splitMatrixLeft maMatrix];
               concatMatrix = splitMatrixLeft;
            end
            
        else  
            
%              [MAXL,FREQ] = mode(splitMatrixLeft(:,leftCS-1));
%               mal = MAXL;
%               
%              [MAXR,FREQ] = mode(splitMatrixRight(:,rightCS-1));
%               mar = MAXR;
              
              maMatrixl = ones(leftRS) * mal;
              maMatrixl = maMatrixl(:,1);
              
              maMatrixr = ones(rightRS) * mar;
              maMatrixr = maMatrixr(:,1);
              
              splitMatrixLeft = [splitMatrixLeft maMatrixl];
              splitMatrixRight = [splitMatrixRight maMatrixr];
           
              concatMatrix = [splitMatrixLeft; splitMatrixRight];  
        end
        
        concatMatrix = sortrows(concatMatrix,59);
        return;
       
    
end