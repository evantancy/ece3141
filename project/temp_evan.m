clear all; close all; clc;
format short; format compact;

%% Simulate arrival of packets
    % Simulation setup
        samples = 10;
        normalised_arrival_rate = 0.5;
        output_limit = 5;

    % Poisson distributed random number generator
        lambda = samples*normalised_arrival_rate; % 0.5, 0.95, 0.99
        r = poissrnd(lambda, [1 samples]);
        
        fprintf("r:\n")
        disp(r)
        
        
        

%% 
    % Calculate number of packets arrived in each time slot
        queue = zeros(size(r));
        running_queue = zeros(size(r));
        fprintf("\nqueue:\n")
        for i = 1:samples
            if r(i) > output_limit
                % number of extra packets
                queue(i) = r(i) - output_limit;
            elseif r(i) < output_limit && queue(i) ~= 0
                % clear from queue
                queue(i) = output_limit - r(i);
            end
            running_queue(i) = sum(queue(1:i));
        end
        disp(queue)
        disp(running_queue)
        % if current_packets > output_limit
            % queue (current_packets - output_limit) packets
