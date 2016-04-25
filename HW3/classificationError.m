function [ error ] = classificationError(left,right )
%UNTITLED11 Summary of this function goes here
%   Detailed explanation goes here
rowSize1 = 0;columnSize1 = 0;rowSize2 = 0;columnSize2 = 0;leftError = 0;rightError = 0; totalWeightLeft = 0; totalWeightRight = 0; totalWeight = 0;


 if isempty(left) == false        
  [rowSize1,columnSize1] = size(left);
  totalWeightLeft = sum(left(:,2),1);
  posLabelWeightCount = 0;
  negLabelWeightCount = 0;
                                                                                                                                                                                                                                                                  
  for iter = 1:rowSize1;
    
      if (left(iter,1) == 1);
          posLabelWeightCount = posLabelWeightCount + left(iter,2);    
      else
          negLabelWeightCount = negLabelWeightCount + left(iter,2);
      end
  
  end
  
  if posLabelWeightCount <= negLabelWeightCount;
     leftError =  posLabelWeightCount/totalWeightLeft;
  else
     leftError =  negLabelWeightCount/totalWeightLeft;
  end
  
end 






%  
% if isempty(left) == false
% [M,F] = mode(left(:,1));
%  [rowSize1,columnSize1] = size(left);
%   wrongLabels = left(left(:,1) ~=  M , :);
%   res = sum(wrongLabels(:,2),1);
%   totalSum = sum(left(:,2),1);
%  
%  leftError = res/totalSum;
%   
% end

% if isempty(right) == false
% [M,F] = mode(right(:,1));
% [rowSize2,columnSize2] = size(right);
%     
%  wrongLabels = right(right(:,1) ~=  M , :);
%  res = sum(wrongLabels(:,2),1);
%  totalSum = sum(right(:,2),1);
%  
%  rightError = res/totalSum;
%  
% end
 


if isempty(right) == false
            
  [rowSize2,columnSize2] = size(right);
  posLabelWeightCount = 0;
  negLabelWeightCount = 0;
  totalWeightRight = sum(right(:,2),1);
  
  for iter = 1:rowSize2;
    
      if (right(iter,1) == 1);
          posLabelWeightCount = posLabelWeightCount + right(iter,2);    
      else
          negLabelWeightCount = negLabelWeightCount + right(iter,2);
      end
  
  end
  
  if posLabelWeightCount <= negLabelWeightCount;
     rightError =  posLabelWeightCount/totalWeightRight;
  else
     rightError =  negLabelWeightCount/totalWeightRight;
  end
  
end 

totalWeight = totalWeightLeft + totalWeightRight;

%display(leftError);
%display(rightError);
totalSize = columnSize1 +columnSize2;
 
 error = (totalWeightLeft / totalWeight * leftError) + (totalWeightRight / totalWeight * rightError);
 %error = leftError + rightError;
 

end

