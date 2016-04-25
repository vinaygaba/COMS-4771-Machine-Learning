function [ output ] = hw1_train_NB(train_usps)

%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
    for i = 0:9
    for m = 1:256
        countLabel = 0;
        countFeature = 0;
        for n = 1:10000
            if train_usps(n,257) == i
                countLabel = countLabel + 1;
                if train_usps(n,m) == 1
                    countFeature = countFeature + 1;
                end
            end
        end
        probability = double(countFeature) / double(countLabel) ;
        output(i+1,m) = probability;
    end
    output(i+1,257) = double(countLabel/10000);
    end

end








