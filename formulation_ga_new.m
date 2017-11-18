function formulation_ga_new
%function to find optimal answer for Job-Shop scheduling by different
%approach by Jeet Oza
%finding the precedence order of Jobs on each machine
pop1 = population();                        %gives me first population
pop2 = population() ;                       %second population
x = [pop1 ; pop2];                          %population matrix
result1 = algorithms(pop1);
x(1,13)=result1;
result2 = algorithms(pop2);
x(2,13)=result2;
x(3,:)=x(1,:);                              %generating pop1 and pop2 again since they are only best as well as second best solution
x(4,:)=x(2,:);
if result1 < result2
    x(5,:)=x(1,:);
else
    x(5,:)=x(2,:);
end
counter = 1;
for num = 1:1:200                            % iterating loop for 50 times
    pop1 = x(3,1:12);                       
    pop2 = x(4,1:12);
    for no = 1:1:6                          %making new population out of pop1
        pop1 = new_pop(pop1);
        
    end
    for number = 1:1:6                     %making new population out of pop2
        pop2 = new_pop(pop2);
    end
    result1 = algorithms(pop1);
    pop1(1,13)=result1;
    result2 = algorithms(pop2);
    pop2(1,13)=result2;
    x(1,1:13) = pop1;                       %storing new population 1 at 1st row
    x(2,1:13) = pop2;                       %storing new population2 at second row
    x = sortrows(-x,13);                    %sorting rows according to objective function
    x = -x;
    bestcurve(counter) = x(4,13);           %storing best value in each iteration
    secondcurve(counter) = x(3,13);         %storing second best solution in each iteration
    counter = counter+1;
end
for i=1:1:200
    counter(i) = i ;
    value1(i) = bestcurve(i);
    value2(i) = secondcurve(i);
end
plot(counter,value1,'-b',counter,value2,'-r')% plotting best and second best curve
%hold all;
x(4,:)
x(3,:)

    function newpop = new_pop(pop)            %function generates new population
        rand_num1 = random1to12();
        lower_int = 3*(floor((rand_num1-1)/3));
        remainder = mod(rand_num1,3);
        random = random1to2();
        modulo = mod(remainder + random,3);
        if modulo == 0 
            modulo = 3;
        end
        rand_num2 = lower_int + modulo;
        stack = pop(rand_num1);
        pop(rand_num1) = pop(rand_num2);
        pop(rand_num2) = stack;
        newpop = pop;
    end
    function random = random1to2()          %function generates randon number 1 or 2
        U = rand();
        if U < 0.5
            random = 1;
        else
            random = 2;
        end
    end
    function random = random1to12()         %function generate random integer from 1 to 12
        U = 12*rand();
        randoms = ceil(U);
        if U == 0
            random = 1;
        else
            random = randoms;
        end
    end
    function z = population()               %creating population
        i=1;z = zeros (1,12);
        while i < 12
            U1= rand();
            if U1 < (1/3)
                z(i) = 0;
            elseif U1 < (2/3)
                z(i) = 1;
            else
                z(i) = 2;
            end
            U2 = rand();
            if U2 < 0.5
                z(i+1) = mod(z(i)+1,3);
                z(i+2) = mod(z(i)+2,3);
            else
                z(i+1) = mod(z(i)+2,3);
                z(i+2) = mod(z(i)+1,3);
            end
            i = i + 3;
        end
        z = z + 1;
    end
end

