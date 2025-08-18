clear all

% Parameters
Mul_fac = ((10^6.1925)/10^0.0475)*(20e-6);  % Calibration and sensitivity factor
p_ref = 20e-6;                           % Reference pressure in air

% Load mic data from Excel
filename = '30_120.xlsx';
x = xlsread(filename, 1, 'B:B');   

% Convert to pressure signal (Pa)
p = x * Mul_fac;

% Remove DC offset (mean)
p_perturb = p - mean(p);    

% Calculate RMS over entire signal
p_rms_total = sqrt(mean(p_perturb.^2));

% Calculate OASPL
OASPL = 20 * log10(p_rms_total / p_ref);

% Display the result
fprintf('OASPL = %.2f dB\n', OASPL);
