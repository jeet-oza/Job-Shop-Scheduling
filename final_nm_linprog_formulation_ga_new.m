function answer = final_nm_linprog_formulation_ga_new(machine,jobs,p,precedence)
%function to find optimal answer for Job-Shop scheduling by different
%approach by Jeet Oza
%jobs = 3;
%machine = 4;
counter = 1;
x= zeros((jobs-1)*(machine-1),jobs*machine+1);%initial population matrix x,setting its value to 0

%getting initial population matrix
for a = 1:1:(jobs-1)*(machine-1)
    x(a,1:jobs*machine) = population();
end

%finding the result for its population
for a = 1:1:(jobs-1)*(machine-1)
    result = final_nm_linprog_algorithms(x(a,1:jobs*machine),machine,jobs,p,precedence);
    x(a,1+jobs*machine) = result;
end

x = sortrows(-x,1+jobs*machine);                    %sorting rows according to objective function
x = -x;

%method for finding optimal answer
for i=1:1:200
    for a = 1:1:((jobs-1)*(machine-1)-2)
        for j= 1:1:3
            x(a,1:jobs*machine)=new_pop(x(a+2,1:jobs*machine)); %changingposition of two jobs
        end
        result = final_nm_linprog_algorithms(x(a,1:jobs*machine),machine,jobs,p,precedence);%adding result
        x(a,1+jobs*machine) = result;
    end
    x = sortrows(-x,1+jobs*machine);                    %sorting rows according to objective function
    x = -x;
    bestcurve(i) = x((jobs-1)*(machine-1),1+jobs*machine);           %storing best value in each iteration
    secondcurve(i) = x((jobs-1)*(machine-1)-1,1+jobs*machine);         %storing second best solution in each iteration
end

for i=1:1:200
    counter(i) = i ;
    value1(i) = bestcurve(i);
    value2(i) = secondcurve(i);
end
plot(counter,value1,'-b',counter,value2,'-r')% plotting best and second best curve
axis([0 200 20 50])
%hold all;
answer= zeros(2,1+jobs*machine);
answer(1,:) = x((jobs-1)*(machine-1),:);
answer(2,:) = x((jobs-1)*(machine-1)-1,:);

    function newpop = new_pop(pop)            %function generates new population by changing position of jobs in given machine
        rand_machine = random1tomachine();
        random_jobs = random1tojobs();
        rand_num1 = (rand_machine-1)*jobs + random_jobs(1);
        rand_num2 = (rand_machine-1)*jobs + random_jobs(2);
        stack = pop(rand_num1);
        pop(rand_num1) = pop(rand_num2);
        pop(rand_num2) = stack;
        newpop = pop;
    end
    function random = random1tojobs()          %function generates randon 2 numbers for jobs to exchange
        U = jobs*rand();
        randoms = ceil(U);
        if U == 0
            random(1) = 1;
        else
            random(1) = randoms;
        end
        while 1
            U = jobs*rand();
            randoms = ceil(U);
            if U == 0
                random(2) = 1;
            else
                random(2) = randoms;
            end
            if random(2) ~= random(1)
                break;
            end
        end
    end
    function random = random1tomachine()         %function generate random integer for machine,gets machine randomly whose jos we need to exchange
        U = machine*rand();
        randoms = ceil(U);
        if U == 0
            random = 1;
        else
            random = randoms;
        end
    end
    function z = population()               %creating population
        i=1;z = zeros (1,jobs*machine);
        for k = 1:1:machine
            z((k-1)*jobs+1:k*jobs) = randperm(jobs);
        end      
    end
end

