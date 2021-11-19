
N = [32, 64, 128];%size
T = [0.1:0.01:3.5; 3.6:0.1:10];%temperature
J
iter = 1000; %number of iterations
displayiter = 100; %displays updates at each inteveral number
Time = zeros(length(T));%intialized time array
for k = 1:length(N)
    for i = 1:length(T)
        
    end
end

function [E, M, x, state, Spins] = SWI(N, T, J, iter, displayiter)
    %n - dimensions
    %T - temperature
    %J- matrix
    %iter - number of iterations
    %displayiter - displays iteration 
    
   
    
    %spin state
    state = rng('shuffle','twister');
    
    %initial spin state
    x = (-1).^round(rand(N,1));
    
    %sparse the matrix saving memory space
    J = sparse(J);
    
    %takes lower part of J if symetric
    J = tril(J, -1);
    
    %applying function to sparse matrix to get link probability
    prob = spfun(@(x) 1 - exp(-2*x./T), J);
    
    %initializing the Energy and Magnitism array, Spins 
    E = zeros(iter, 1);
    M = zeros(iter, 1);
    Spins = zeros(iter, N);
    %getting the magtinization
    M(1) = mean(x);
    %getting the energy
    E(1) = -(x' * J * x)./N;
    
    %updates the iteration current
    if displayiter > 0 
        fprintf('temperature: %f, iteration: %d, Energy: %f\n', T, 1, E(1));
    end 
    
    for i = 2:iter
        %aligned spins
        aligned = tril(x' .*J.*x, -1) > 0;
        %adjancent matrix 
        A = (sprand(prob) <prob) .*aligned;
        A = A+speye(N);
        
        %Graph
        G = graph(A, 'lower');
        %finds connected parts
        C = conncomp(G, 'OutputForm', 'cell');
        
        %flips the clusters 
        for k = 1:length(C)
            if rand(1) < 0.5 %probability of 1/2
                x(C{k}) = -x(C{ind});
            end
        end
        Spins(k, :) = x;
        M(k) = mean(x);
        E(K) = -(x'*J*x)./N;
    end
end 
      