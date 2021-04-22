function [queue] = simulate_packets(input_packets, output_packets)
%SIMULATE_PACKETS Summary of this function goes here
%   Input(s):
%       input_packets: number of packets arriving at each timestep
%       output_packets: number of packets being serviced at each timestep
%   Output(s):
%       queue: number of packets in queue at each timestep

    n_samples = length(input_packets);
    assert(length(input_packets) == length(output_packets))

    % preallocating
    queue = zeros(size(input_packets));

    % can be +ve or -ve
    % +ve when packets(i) > output_limit, surplus so add to queue
    % -ve when packets(i) < output_limit, deficit so remove from queue
    num_packets = zeros(size(input_packets));
    for i = 1:n_samples
        num_packets(i) = input_packets(i) - output_packets(i);
        if i == 1
            queue(i) = num_packets(i);
        else
            queue(i) = queue(i-1) + num_packets(i);
        end
        % check for underflow, resolve negative queues
        if num_packets(i) < 0 && queue(i) < 0
            queue(i) = 0;
        end
    end
end

