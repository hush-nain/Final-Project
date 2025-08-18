%baselinerecording and saving to excel
fs = 48000;              % Sampling rate (Hz)
duration = 5;            % Duration of recording (seconds)
nBits = 24;              % Bit depth
nChannels = 1;           % Mono recording
filename = 'umik1_recording.xlsx';  % Excel file name

% Create audio recorder object
recObj = audiorecorder(fs, nBits, nChannels);

% Record
disp('Recording...');
recordblocking(recObj, duration);
disp('Recording complete.');

% Get the audio data
audioData = getaudiodata(recObj);

% Generate time vector
t = linspace(0, duration, length(audioData))';

% Plot the waveform
figure;
plot(t, audioData);
xlabel('Time (s)');
ylabel('Amplitude');
title('Raw Audio Waveform from UMIK-1');
grid on;

% Prepare data for Excel
dataToWrite = [t, audioData];  % Two columns: Time | Amplitude

% Write to Excel
xlswrite(filename, {'Time (s)', 'Amplitude'}, 1, 'A1');     % Write headers
xlswrite(filename, dataToWrite, 1, 'A2');                   % Write data

disp(['Audio data saved to ', filename]);

