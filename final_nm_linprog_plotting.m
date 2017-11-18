machine = input(' Enter the number of machine : ');
jobs = input('Enter the number of jobs : ');

% finding matrix of time taken for each machine for each job
for i=1:1:jobs
    for j=1:1:machine
        fprintf('time taken for %d job on %d machine : ',i,j)
        p(i,j) = input('');
    end
end

%getting precedence matrix for precendence of machine over jobs
for i=1:1:jobs
    for j=1:1:machine
        fprintf('for %d job %d th machene in precedence : ',i,j)
        precedence(i,j) = input('');
    end
end
y= zeros(5,1+jobs*machine);
z= zeros(5,1+jobs*machine);

%getting answer
for i = 1:1:5
    figure(i);
    x = final_nm_linprog_formulation_ga_new(machine,jobs,p,precedence);
    y(i,:) = x(1,:);
    z(i,:) = x(2,:);
end
y
z