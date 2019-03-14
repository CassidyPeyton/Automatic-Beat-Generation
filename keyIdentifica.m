[S, Fs]=audioread(nameOfFile);
%sec=10;
%start=0;
%S=S(start+1:start+sec*Fs);

T = 1/Fs;
L = length(S);
t = (0:L-1)*T;

%figure()
%plot(t,S)
%title('Input Audio Signal')
%xlabel('Time')
%ylabel('X(t)')

f = Fs*(0:(L/2))/L;

Y = fft(S);
P2 = abs(Y/L);
P1 = P2(1:L/2+1);
P1(2:end-1) = 2*P1(2:end-1);

%figure()
%plot(f,P1)
%title('Spectrum')
%xlabel('f (Hz)')
%ylabel('|P1(f)|')

[M,I]=max(P1(round(200/(Fs/L)):round(1000/(Fs/L))));
freq=f(I);

note = 69+12*log2(freq/440);
Rnote=round(note);
tonic=mod(Rnote,12);

name = 'invalid';

if(tonic==0)
    name = 'C';
elseif(tonic==1)
    name = 'C#';
elseif(tonic==2)
    name = 'D';
elseif(tonic==3)
    name = 'D#';
elseif(tonic==4)
    name = 'E';
elseif(tonic==5)
    name = 'F';
elseif(tonic==6)
    name = 'F#';
elseif(tonic==7)
    name = 'G';
elseif(tonic==8)
    name = 'G#';
elseif(tonic==9)
    name = 'A';
elseif(tonic==10)
    name = 'A#';
elseif(tonic==11)
    name = 'B';
end

name;