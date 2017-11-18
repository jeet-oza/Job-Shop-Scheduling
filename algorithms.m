function result = algorithms(y)
% finding optimal time for given precedence order of Jobs on each machine
%using Genetic algoritm from matlab toolbox
%Jobs	Machine Sequence	Processing Times
%1       1,2,4,3             p11=10, p21=8,p41=6, p31=4
%2       2,1,3,4             p22=8, p12=3, p32=6, p42=5
%3       1,4,2               p13=4,  p43=3, p23=7

%time required by each job on different machine
%machine 1   2   3   4
p=   [ 6 8 4 6;...  job1
       3 8 6 5;...  job2
       4 7 0 3];     %job3
   
%precedence order of machine for each Job.[User input Data.]
precedence = [ 1 2 4 3;...
               2 1 3 4;...
               3 1 4 2];
%fun = @(x) (x(1));
fun = [1 ;0 ;0 ;0 ;0 ;0 ;0 ;0 ;0 ;0 ;0 ;0 ;0];
%var number 1   2   3   4   5   6   7   8   9  10  11  12  13
%var_n = [Cmax t11 t12 t13 t14 t21 t22 t23 t24 t31 t32 t33 t34]
A = zeros(1,13);b= zeros(3,1);
%machine_precedence_in_job_constraint
A(1,1 + precedence(1,4)) = 1 ; A(1,1) = -1; b(1) = -p(1,precedence(1,4));                        %var_n(1+x4) + p(1,x4) <= var_n(1)
A(2,5 + precedence(2,4)) = 1 ; A(2,1) = -1; b(2) = -p(2,precedence(2,4));                        %var_n(5+y4) + p(2,y4) <= var_n(1)
A(3,9 + precedence(3,4)) = 1 ; A(3,1) = -1; b(3) = -p(3,precedence(3,4));                        %var_n(9+z4) + p(3,z4) <= var_n(1)

A(4,1 + precedence(1,1)) = 1 ; A(4,1 + precedence(1,2)) = -1 ; b(4) = -p(1,precedence(1,1));      %var_n(1+x1) + p(1,x1) <= var_n(1+x2)
A(5,1 + precedence(1,2)) = 1 ; A(5,1 + precedence(1,3)) = -1 ; b(5) = -p(1,precedence(1,2));     %var_n(1+x2) + p(1,x2) <= var_n(1+x3)
A(6,1 + precedence(1,3)) = 1 ; A(6,1 + precedence(1,4)) = -1 ; b(6) = -p(1,precedence(1,3)) ;    %var_n(1+x3) + p(1,x3) <= var_n(1+x4)

A(7,5 + precedence(2,1)) = 1 ; A(7,5 + precedence(2,2)) = -1 ; b(7) = -p(2,precedence(2,1));     %var_n(5+y1) + p(2,y1) <= var_n(5+y2)
A(8,5 + precedence(2,2)) = 1 ; A(8,5 + precedence(2,3)) = -1 ; b(8) = -p(2,precedence(2,2)) ;    %var_n(5+y2) + p(2,y2) <= var_n(5+y3)
A(9,5 + precedence(2,3)) = 1 ; A(9,5 + precedence(2,4)) = -1 ; b(9) = -p(2,precedence(2,3))  ;   %var_n(5+y3) + p(2,y3) <= var_n(5+y4)

A(10,9 + precedence(3,1)) = 1 ; A(10,9 + precedence(3,2)) = -1 ; b(10) = -p(3,precedence(3,1));  %var_n(9+z1) + p(3,z1) <= var_n(9+z2)
A(11,9 + precedence(3,2)) = 1 ; A(11,9 + precedence(3,3)) = -1 ; b(11) = -p(3,precedence(3,2));  %var_n(9+z2) + p(3,z2) <= var_n(9+z3)
A(12,9 + precedence(3,3)) = 1 ; A(12,9 + precedence(3,4)) = -1 ; b(12) = -p(3,precedence(3,3));  %var_n(9+z3) + p(3,z3) <= var_n(9+z4)

%job_precedence_in_machine_constraint_given_by_y

j=1;k=1;m=1;
while j < 12
    A(12+m,1+k+(4*(y(j)-1))) = 1 ;A(12+m,1+k+(4*(y(j+1)-1))) = -1 ; b(12+m) = -p(y(j),k);       %var_n(1+k+(4*(y(j)-1))) + p(v(j),k) <= var_n(1+k+(4*(y(j+1)-1)))
    j=j+1;m=m+1;
    A(12+m,1+k+(4*(y(j)-1))) = 1 ;A(12+m,1+k+(4*(y(j+1)-1))) = -1 ; b(12+m) = -p(y(j),k);       %var_n(1+k+(4*(y(j)-1))) + p(v(j),k) <= var_n(1+k+(4*(y(j+1)-1)))
    j=j+2;m=m+1;
    k=k+1;
end

lb= zeros(1,13);
ub= Inf(1,13);

[x,fval] = linprog(fun,A,b,[],[],lb,ub); %genetic algorithm from matlab

r = fval;
if r < 1000
    result = r;
else
    result = p(1,1)+p(1,2)+p(1,3)+p(1,4)+p(2,1)+p(2,2)+p(2,3)+p(2,4)+p(3,1)+p(3,2)+p(3,3)+p(3,4);
end
