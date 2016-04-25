

result = hw2_train_perceptron(train_spam, 1000);
%display(result);

error_count = 0;
for i = 1:1000;
   ans(i) = sign(dot(result(1:57,:),test_spam(i,1:57)) + result(58,:));
   if(ans(i) == -1)
       ans(i) = 0;
   end
   if(ans(i) ~= test_spam(i,58))
       error_count = error_count + 1;
   end
end


display(ans);

