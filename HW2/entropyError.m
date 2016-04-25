function [ error ] = entropyError(left,right )

%UNTITLED9 Summary of this function goes here
%   Detailed explanation goes here

rowSize1 = 0;columnSize1 = 0;rowSize2 = 0;columnSize2 = 0;leftError = 0;rightError = 0;


if isempty(left) == false
[M,F] = mode(left);
 [rowSize1,columnSize1] = size(left);
 %display(F);
 %display(columnSize1);
 pl1 = F/columnSize1;
 pl2 = 1 - (F/columnSize1);
 leftError = pl1 * log(1/pl1) + pl2 * log(1/pl2);
end

if isempty(right) == false
[M,F] = mode(right);
[rowSize2,columnSize2] = size(right);
 %display(F);
 %display(columnSize2);
 pr1 = F/columnSize2;
 pr2 = 1 - (F/columnSize2);
 rightError = pr1 * log(1/pr1) + pr2 * log(1/pr2);
end


%display(leftError);
%display(rightError);
 totalSize = columnSize1 +columnSize2;
 
 error = (columnSize1 / totalSize * leftError) + (columnSize2 / totalSize * rightError);

end

