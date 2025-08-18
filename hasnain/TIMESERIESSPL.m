clear all
% Parameters
Mul_fac = ((10^6.1925)/10^0.0475)*(20e-6);                    
p_ref = 20e-6;               
window_size = 1024;         % Number of samples per block
overlap = 0;                
fs = 48000;                 
% Load mic data from Excel
filename = 'ind_prop.xlsx';
x = xlsread(filename, 1, 'B:B');   

% Convert to pressure signal
p = x * Mul_fac;

% Preprocessing
step = window_size - overlap;
n_samples = length(p);
n_windows = floor((n_samples - overlap) / step);
SPL_series = zeros(n_windows, 1);
time = zeros(n_windows, 1);

% Compute SPL per block
for i = 1:n_windows
    idx_start = (i-1)*step + 1;
    idx_end = idx_start + window_size - 1;
    if idx_end > n_samples
        break;
    end
    segment = p(idx_start:idx_end);
    segment_mean = mean(segment);
    perturb = segment - segment_mean;
    p_rms = sqrt(mean(perturb.^2));
    SPL_series(i) = 20 * log10(p_rms / p_ref);
    time(i) = (idx_start + window_size/2) / fs;  % Center time of window
end

% Plot SPL over time
figure;
plot(time, SPL_series, 'b', 'LineWidth', 1.5);
xlabel('Time (s)');
ylabel('SPL (dB)');
title('Instantaneous SPL over Time');
grid on;
