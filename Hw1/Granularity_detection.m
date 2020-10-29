function [filter,g10,g20,g25,g30,out] = Granularity_detection(image)
   %% 平滑
   filter = my_open(image,5);
   filter = my_close(filter,5);
   temp = filter;
   out = zeros(1,35);
   for i = 6:35
       fprintf("模板半径为%d迭代中\n",i);
       k = my_open(filter,i);
       C = temp - k;
       out(i) = sum(C(:));
       temp = k;
       if(i == 10)
          g10 = k;
       elseif(i == 20)
          g20 = k;
       elseif(i == 25)
          g25 = k;
       elseif(i == 30)
          g30 = k;
       end
   end
   
%    g10 = my_open(filter,10);
%    g20 = my_open(filter,20);
%    g25 = my_open(filter,25);
%    g30 = my_open(filter,30);
end