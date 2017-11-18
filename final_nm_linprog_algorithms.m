function result = final_nm_linprog_algorithms(y,machines,jobs,p,precedence)
% finding optimal time for given precedence order of Jobs on each machine

fun = zeros(1+machines*jobs,1);
fun(1) = 1;% objective function Cmax
%var number 1   2   3   4   5   6   7   8   9  10  11  12  13
%var_n = [Cmax t11 t12 t13 t14 t21 t22 t23 t24 t31 t32 t33 t34...]
A = zeros(1,1+machines*jobs);b= zeros(jobs,1);

equation = 1;

%constraint for Cmax
for i = 1:1:jobs
    A(equation,1 + (i-1)*machines + precedence(i,machines)) = 1 ;
    A(equation,1) = -1; 
    b(equation) = -p(i,precedence(i,machines));
    equation = equation + 1;
end

%machine_precedence_in_job_constraint
for i = 1:1:jobs
    for j = 1:1:(machines-1)
        A(equation,1 + (i-1)*machines + precedence(i,j)) = 1 ; 
        A(equation,1 + (i-1)*machines + precedence(i,j+1)) = -1 ; 
        b(equation) = -p(i,precedence(i,j));
        equation = equation + 1;
    end
end

%job_precedence_in_machine_constraint_given_by_y
for i= 1:1:machines
    k = (i-1)*jobs;
    for j = 1:1:(jobs-1)
        Jin = y(k+j);Jf = y(k+j+1);
        A(equation,1 + (Jin-1)*machines + i) = 1 ; 
        A(equation,1 + (Jf-1)*machines + i) = -1 ; 
        b(equation) = -p(Jin,i);
        equation = equation +1;
    end
end

lb= zeros(1,1+machines*jobs);
ub= Inf(1,1+machines*jobs);

[x,fval] = linprog(fun,A,b,[],[],lb,ub); %linear program from matlab

r = fval;
if r < 100000
    result = r;
else
    result = p(1,1)+p(1,2)+p(1,3)+p(1,4)+p(2,1)+p(2,2)+p(2,3)+p(2,4)+p(3,1)+p(3,2)+p(3,3)+p(3,4);
end
