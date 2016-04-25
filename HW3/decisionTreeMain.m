tree = hw2_train_DT_recursive(train_spam,3,1,[]);
display(tree);

%display(answer{1}(1));

labels = hw2_test_DT(tree,train_spam);

% Compute Loss
error_count = 0;
%change to 1000 when calling on test_spam
for i = 1:1000;
   
   if(labels(i) ~= train_spam(i,58))
       error_count = error_count + 1;
   end
   
end