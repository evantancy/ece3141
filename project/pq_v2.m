clear all; close all; clc

%% Simulate arrival and processing of packets
    % Simulation setup
        samples = 1000;
        normalised_arrival_rate = 0.90;                                         % efficiency of packet arrival rate
        normalised_service_rate = 0.93;                                         % efficiency of packet service rate

    % Poisson distributed random number generator
        lambda_arrival = samples*normalised_arrival_rate;                           
        input_packets = poissrnd(lambda_arrival, [1 samples]);                  % randomise arrival of packets 
        
        lambda_service = samples*normalised_service_rate;                         
        output_limit = poissrnd(lambda_service, [1 samples]);                   % randomise output limit
                
    % TEST CASE - use in place of Poisson
        %input_packets = [0 88 796 1627 51 34 966 714 1276 494 933 107 241 16 671 643 812 262 218 1378 507 15 820 1253 307 540 190 500 96 943 105 183 447 542 166 165 490 510 877 37 163 104 42 291 645 363 134 920 1507 598 172];                      %pg 185
        %input_packets = [0 167 1512 3091 97 65 1835 1357 2424 939 1773 203 458 30 1275 1222 1543 498 414 2618 963 29 1558 2381 583 1026 361 950 182 1792 200 348 849 1030 315 314 931 969 1666 70 310 198 80 553 1226 690 255 1748 2863 1136 327];     %pg 186
        %input_packets = [174 1576 3221 101 67 1913 1414 2526 978 1847 212 477 32 1329 1273 1608 519 432 2728 1004 30 1624 2481 608 1069 376 990 190 1867 208 362 885 1073 329 327 970 1010 1736 73 323 206 83 576 1277 719 265 1822 2984 1184 341];    %pg 187
        %samples = length(input_packets);
        %output_limit = 1000*ones(1,samples);
        
    % Calculate number of packets arrived in each time slot
        output_packets = zeros(1,samples);
        queue = zeros(1,samples);
        buffer = zeros(1,samples);
    
        for i = 1:samples
            if i == 1                                                           % for first sample, where i-1 does not exist
                if input_packets(i) >= output_limit(i)
                    queue(i) = input_packets(i) - output_limit(i);
                    output_packets(i) = output_limit(i);
                else
                    output_packets(i) = input_packets(i);
                end
                
            elseif input_packets(i)+queue(i-1) >= output_limit(i)               % if packet surplus
                queue(i) = queue(i-1) + (input_packets(i) - output_limit(i));   % update queue
                output_packets(i) = output_limit(i);                            % output max packets
                
            else 
                if queue(i) > 0                                                 % if queued packets exist
                    queue(i) = queue(i-1);                                      % queue carries forward
                end
                output_packets(i) = queue(i-1) + input_packets(i);              % output current + queued packets
            end
        end
        
    % Generate Queue Behaviour Table
        output(:,1) = input_packets;
        output(:,2) = output_packets;
        output(:,3) = queue;
        
    % Plot results
        resolution = 5;                                                        % minimum resolution is 1
        x = 1:samples;
        plot(x,input_packets,'o',x,output_packets,'o',x,queue,'o','MarkerIndices',1:resolution:samples)
        axis([0 samples 0 samples+200])
        title(['Plot of Queue Behaviour with Normalised Arrival Rate of ',num2str(100*normalised_arrival_rate),'% and Normalised Service Rate of ',num2str(100*normalised_service_rate),'%'])
        xlabel('Time (seconds)')
        ylabel('Packets')
        legend input output queue
        grid on, grid minor
        