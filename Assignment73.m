%{
Compuational Physics II
William Jones

%}



%Assingment 7.3
np = 1000; %number of polymers
N = 500; %number of steps
%for lengths of 10
[average10, xwalk10,ywalk10,zwalk10, timeone, it1] = polymer(N, np, 10);
displayplots(np, 10,1,2, average10, xwalk10, ywalk10, zwalk10, timeone, it1);

%for lengths of 20
[average20, xwalk20,ywalk20,zwalk20, timetwo, it2] = polymer(N, np, 20);
displayplots(np, 20,3,4, average20, xwalk20, ywalk20, zwalk20, timetwo,it2);
disp(average20)
%for lengths of 30
[average30, xwalk30,ywalk30,zwalk30, timeththree, it3] = polymer(N, np, 30);
displayplots(np, 30,5,6, average30, xwalk30, ywalk30, zwalk30, timeththree, it3);

%for lengths of 40
[average40, xwalk40,ywalk40,zwalk40, timefour, it4] = polymer(N, np, 40);
displayplots(np, 40,7,8, average40, xwalk40, ywalk40, zwalk40, timefour, it4);

%%for displaying the requested graph and the 3d random walk 
function displayplots(np, pl,fig, fig2 ,average, xwalk, ywalk, zwalk, time, it)    
    cmap = hsv(np); % color set for the plot
   
    figure(fig)
    for i = 2:np
    %plotting the average vs. time
        plot3(average(i,:), time(i,:),it(i,:),'Color',cmap(i,:));
        hold on
    end 
    hold off
    grid on;
    xlabel('average')
    ylabel('time')
    zlabel('iteration')
    title(['Assignment 7.3 for ' num2str(pl) ' '])
    %for the whole movement 
    figure(fig2)
    plot3(xwalk, ywalk,zwalk);
    grid on
    xlabel('x')
    ylabel('y')
    zlabel('z')
    title(['Movements for length ' num2str(pl) ' '])
    
end 
function [average, xwalk, ywalk,zwalk, time, it] = polymer(N, np, len)
    it = zeros(np,N);
    step = [ -1 1];%different steps it can take
    %setting the sizes of the arrays
    ywalk = zeros(np,len);
    xwalk = zeros(np,len);
    zwalk = zeros(np, len);
    distance = zeros(np, N);
    average = zeros(np,N);
    time = zeros(np, N);
    
   %setting the starting values for polymer
    for w = 2:len
        %y = 1;
        x = 1;
        %z = 1;
        %ywalk(:,w) = ywalk(1,w-1)+y; THIS IS COMMENTED OUT TO HELP WITH AVERAGE LATER
        xwalk(:,w) = xwalk(1,w-1) +x;
        %zwalk(:,w) = zwalk(1,w-1) + z;
    end
    for k = 1:np
        sum = 0;
        tic%STARTS TIME COUNTING
        for j = 1:N
            %saves the tail
            tailx = xwalk(k,1);
            taily = ywalk(k,1);
            tailz = zwalk(k,1);
        %%%%%%REMOVE MONOMER%%%%%%
            for i = 1:(len-1)
                ywalk(k,i) = ywalk(k,i+1);
                xwalk(k,i) = xwalk(k, i+1);
                zwalk(k,i) = zwalk(k, i+1);
            end
        
            %clears last positon 
            xwalk(k,len) = 0;
            ywalk(k,len) = 0;
            zwalk(k,len) = 0;
        %%%%%%%%%%%%%%%%%%%%%%%%%
    
        %%%%%%ADD MONOMER%%%%%%%%%
            yr = randi(2);%random number 1 or 2
            y = step(yr);%picking the number to use 
            xr = randi(2);%same as above
            x = step(xr);
            zr = randi(2);%same as above
            z = step(zr);
            %stores head
            ywalk(k,len) =ywalk(k,(len-1)) + y;%adding the number choosen to the previous step and storing value
            xwalk(k,len) = xwalk(k,(len-1)) + x;
            zwalk(k,len) = zwalk(k,(len-1)) + z;
            %makes sure its not the same as second to last monomer
            while( xwalk(k,len) == xwalk(k,(len-2)) && ywalk(k,len) == ywalk(k,(len-2)) && zwalk(k,len) == zwalk(k,(len-2)))
                yr = randi(2);%random number 1 or 2
                y = step(yr);%picking the number to use 
                xr = randi(2);%same as above
                x = step(xr);
                zr = randi(2);%same as above
                z = step(zr);
                ywalk(k,len) =ywalk(k,(len-1)) + y;%adding the number choosen to the previous step and storing value
                xwalk(k,len) = xwalk(k,(len-1)) + x;
                zwalk(k,len) = zwalk(k,(len-1)) + z;
            end 
        %%%%%%%%%%%%%%%%%%%%%%%%%%%
    
        %%%%%%%%SELF AVOIDANCE%%%%% 
            if ywalk(k,len) == 50 || ywalk(k,len) == -50 || xwalk(k,len) == 50 || xwalk(k,len) == -50 || zwalk(k,len) == 50 || zwalk(k,len) == -50
            
                ywalk(k,len) = taily;
                xwalk(k,len) = tailx;
                zwalk(k,len) = tailz;
                for i = 1:(len-1)
                    tempx = xwalk(k,i);
                    xwalk(k,i) = xwalk(k,length(xwalk(k,:))-i);
                    xwalk(k, length(xwalk(k,:))-i) = tempx;
                    tempy = ywalk(k,i);
                    ywalk(k,i) = ywalk(k,length(ywalk(k,:))-i);
                    ywalk(k,length(ywalk(k,:))-i) = tempy;
                    tempz = zwalk(k,i);
                    zwalk(k,i) = zwalk(k,length(zwalk(k,:))-i);
                    zwalk(k, length(zwalk(k,:))-i) = tempz;
                end  
             
            end
     %%%%%%%%%%%%%%%%%%%%%%%%%%
   
    %%%%%%RANDOM CHOICE%%%%%%%
            choice = step(randi(2));
            if choice == 1 
                xwalk(k,:) = fliplr(xwalk(k,:));
                ywalk(k,:) = fliplr(ywalk(k,:));
                zwalk(k,:) = fliplr(zwalk(k,:));
            end 
    %%%%%%%%%%%%%%%%%%%%%%%%%%%
   
    %%%%%%GETTING THE MEAN %%%%%%
            
            %xsorted = sort(xwalk(k,:));
            %ysorted = sort(ywalk(k,:));
            %zsorted = sort(zwalk(k,:));
            %xdistance = xsorted(len) - xsorted(1);
            %ydistance = ysorted(len) - ysorted(1);
            %zdistance = zsorted(len) - zsorted(1);
            xdistance = xwalk(k, len) - xwalk(k, 1);
            ydistance = ywalk(k, len) - ywalk(k, 1);
            zdistance = zwalk(k, len) - zwalk(k, 1);
            distance(k,j) = sqrt(xdistance.^2 + ydistance.^2 + zdistance.^2);
            sum = sum + distance(k,j);
            average(k,j) = sum./j;
   %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
   %%%%%%%%%%For Time%%%%%%%%%%%%%%%%%
            if j == 1
                time(k,1) = toc;
                continue
            end 
            timestop = toc;
            time(k,j) = time(k,j-1) + timestop;
            it(k,j) = j;
   %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%     
            
        
        end
    end
end 
