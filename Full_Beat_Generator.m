%Beat Generator Main Function
%Runs Key Identifation
%Runs Beat Tracking
%Adds Random Beat

%Will only run on first 10 seconds of song

warning('off','all');%Surpress the warnings (Clipping)

%Set the Length of the Input Recording
recordingLength = 10;

% Recording clip of song from user to be identified by the program
fs = 44100; %Sampling Rate
recorder = audiorecorder(fs,16,1); %Creating audio recording object to record clip of song to be identified
disp('Start Recording.')
recordblocking(recorder, recordingLength); %sets length of recroding to be 10 seconds long
disp('End Recording.');

% Store data in an array.
xo = getaudiodata(recorder);

%figure();
%plot(xo);
%title('Recorded Input');
%ylabel('Amplitude');
%xlabel('Time');

audiowrite('input.wav',xo,fs);

nameOfFile = 'input.wav';%Name of File to Read

run('keyIdentifica');
run('beat_tracking');
run('addBeat');
