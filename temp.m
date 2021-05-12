prob_vec = [0.2, 0.33, 0.1, 0.07, 0.3];

entropy_vec = [];
for i=1:length(prob_vec)
    entropy_vec(i) = -prob_vec(i) * log2(prob_vec(i));
end

entropy = sum(entropy_vec);
fprintf("\nEntropy = %f\n", entropy)