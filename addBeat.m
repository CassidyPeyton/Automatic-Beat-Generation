
ThighHatRand=round(rand);
if(ThighHatRand == 1)
    [hat1,~] = audioread('Hits/hat1.wav');
    hat = hat1(:,1);
else
    [hat2,~] = audioread('Hits/hat2.wav');
    hat = hat2(:,1);
end

TsnareRand=round(rand);
if(TsnareRand == 1)
    [snare1,~] = audioread('Hits/snare1.wav');
    snare = snare1(:,1);
else
    [snare2,~] = audioread('Hits/snare2.wav');
    snare = snare2(:,1);
end

TkickRand=round(rand);
if(TkickRand == 1)
    [kick1,~] = audioread('Hits/kick1.wav');
    kick = kick1(:,1);
else
    [kick2,~] = audioread('Hits/kick2.wav');
    kick = kick2(:,1);
end
kick=10*kick;

if(strcmp(name,'A')==1)
    [bass,~] = audioread('808/A_Bass.wav');
    bassRoot = bass(1:samplesPerBeat,1);
    [bass,~] = audioread('808/E_Bass.wav');
    bassFifth = bass(1:samplesPerBeat,1);
elseif(strcmp(name,'A#')==1)
    [bass,~] = audioread('808/A#_Bass.wav');
    bassRoot = bass(1:samplesPerBeat,1);
    [bass,~] = audioread('808/F_Bass.wav');
    bassFifth = bass(1:samplesPerBeat,1);
elseif(strcmp(name,'B')==1)
    [bass,~] = audioread('808/B_Bass.wav');
    bassRoot = bass(1:samplesPerBeat,1);
    [bass,~] = audioread('808/F#_Bass.wav');
    bassFifth = bass(1:samplesPerBeat,1);
elseif(strcmp(name,'C')==1)
    [bass,~] = audioread('808/C_Bass.wav');
    bassRoot = bass(1:samplesPerBeat,1);
    [bass,~] = audioread('808/G_Bass.wav');
    bassFifth = bass(1:samplesPerBeat,1);
elseif(strcmp(name,'C#')==1)
    [bass,~] = audioread('808/C#_Bass.wav');
    bassRoot = bass(1:samplesPerBeat,1);
    [bass,~] = audioread('808/G#_Bass.wav');
    bassFifth = bass(1:samplesPerBeat,1);
elseif(strcmp(name,'D')==1)
    [bass,~] = audioread('808/D_Bass.wav');
    bassRoot = bass(1:samplesPerBeat,1);
    [bass,~] = audioread('808/A_Bass.wav');
    bassFifth = bass(1:samplesPerBeat,1);
elseif(strcmp(name,'D#')==1)
    [bass,~] = audioread('808/D#_Bass.wav');
    bassRoot = bass(1:samplesPerBeat,1);
    [bass,~] = audioread('808/A#_Bass.wav');
    bassFifth = bass(1:samplesPerBeat,1);
elseif(strcmp(name,'E')==1)
    [bass,~] = audioread('808/E_Bass.wav');
    bassRoot = bass(1:samplesPerBeat,1);
    [bass,~] = audioread('808/B_Bass.wav');
    bassFifth = bass(1:samplesPerBeat,1);
elseif(strcmp(name,'F')==1)
    [bass,~] = audioread('808/F_Bass.wav');
    bassRoot = bass(1:samplesPerBeat,1);
    [bass,~] = audioread('808/C_Bass.wav');
    bassFifth = bass(1:samplesPerBeat,1);
elseif(strcmp(name,'F#')==1)
    [bass,~] = audioread('808/F#_Bass.wav');
    bassRoot = bass(1:samplesPerBeat,1);
    [bass,~] = audioread('808/C#_Bass.wav');
    bassFifth = bass(1:samplesPerBeat,1);
elseif(strcmp(name,'G')==1)
    [bass,~] = audioread('808/G_Bass.wav');
    bassRoot = bass(1:samplesPerBeat,1);
    [bass,~] = audioread('808/D_Bass.wav');
    bassFifth = bass(1:samplesPerBeat,1);
else%(strcmp(name,'G#')==1)
    [bass,~] = audioread('808/G#_Bass.wav');
    bassRoot = bass(1:samplesPerBeat,1);
    [bass,~] = audioread('808/D#_Bass.wav');
    bassFifth = bass(1:samplesPerBeat,1);
end
bassRoot=bassRoot*0.5;
for i = 1:length(finalBeat)
    if (finalBeat(i)==1)
        firstBeat = i;
        break;
    end
end

RhighHatRand=round(5*rand);
if(BPM>120)
    RhighHatRand=2*round(2*rand);
end
finalBeatHH=finalBeat;

for i = firstBeat+round(samplesPerBeat/2):samplesPerBeat:length(finalBeat)
    finalBeatHH(i)=1;
end
for i = firstBeat+round(samplesPerBeat/4):samplesPerBeat:length(finalBeat)
    finalBeatHH(i)=1;
end
for i = firstBeat+round(3*samplesPerBeat/4):samplesPerBeat:length(finalBeat)
    finalBeatHH(i)=1;
end

z= 4*y;
if(RhighHatRand==0)%eighth notes
    a = 1;
    for i = 1: length(z)
        if finalBeatHH(i) == 1
            if(mod(a,2)==1)
                for j = 1: length(hat)
                    if i+j > length(z)
                        break;
                    end
                    z(i+j-2)=hat(j)+z(i+j-1);
                end
            end
            a=a+1;
        end
    end
    
elseif (RhighHatRand==1)%16th notes
    for i = 1: length(z)
        if finalBeatHH(i) == 1
            for j = 1: length(hat)
                if i+j > length(z)
                    break;
                end
                z(i+j-1)=hat(j)+z(i+j-1);
            end
        end
    end
    
elseif (RhighHatRand==2)%eighth notes end beat triplets
    a = 1;
    for i = 1: length(z)
        if finalBeatHH(i) == 1
            if(mod(a,2)==1)
                for j = 1: length(hat)
                    if i+j > length(z)
                        break;
                    end
                    z(i+j-1)=hat(j)+z(i+j-1);
                end
                if(mod(a,16)==15)
                    t2 = round((samplesPerBeat/2)/3);
                    for j = 1: length(hat)
                        if i+j+t2 > length(z)
                            break;
                        end
                        z(i+j-1+t2)=hat(j)+z(i+j-1+t2);
                    end
                    t3 = 2*round((samplesPerBeat/2)/3);
                    for j = 1: length(hat)
                        if i+j+t3 > length(z)
                            break;
                        end
                        z(i+j-1+t3)=hat(j)+z(i+j-1+t3);
                    end
                end
            end
            a=a+1;
        end
    end
    
elseif (RhighHatRand==3)%16th note end beat triplets
    a=1;
    for i = 1: length(z)
        if finalBeatHH(i) == 1
            for j = 1: length(hat)
                if i+j > length(z)
                    break;
                end
                z(i+j-1)=hat(j)+z(i+j-1);
            end
            if(mod(a,16)==0)
                t2 = round((samplesPerBeat/4)/3);
                for j = 1: length(hat)
                    if i+j+t2 > length(z)
                        break;
                    end
                    z(i+j-1+t2)=hat(j)+z(i+j-1+t2);
                end
                t3 = 2*round((samplesPerBeat/4)/3);
                for j = 1: length(hat)
                    if i+j+t3 > length(z)
                        break;
                    end
                    z(i+j-1+t3)=hat(j)+z(i+j-1+t3);
                end
            end
            a=a+1;
        end
    end
elseif (RhighHatRand==4)%eighth note beginning beat triplets
    a = 1;
    for i = 1: length(z)
        if finalBeatHH(i) == 1
            if(mod(a,2)==1)
                for j = 1: length(hat)
                    if i+j > length(z)
                        break;
                    end
                    z(i+j-1)=hat(j)+z(i+j-1);
                end
                if(mod(a,16)==1)
                    t2 = round((samplesPerBeat/2)/3);
                    for j = 1: length(hat)
                        if i+j+t2 > length(z)
                            break;
                        end
                        z(i+j-1+t2)=hat(j)+z(i+j-1+t2);
                    end
                    t3 = 2*round((samplesPerBeat/2)/3);
                    for j = 1: length(hat)
                        if i+j+t3 > length(z)
                            break;
                        end
                        z(i+j-1+t3)=hat(j)+z(i+j-1+t3);
                    end
                end
            end
            a=a+1;
        end
    end
    
elseif (RhighHatRand==5)%16th note beginning beat triplets
    a=1;
    for i = 1: length(z)
        if finalBeatHH(i) == 1
            for j = 1: length(hat)
                if i+j > length(z)
                    break;
                end
                z(i+j-1)=hat(j)+z(i+j-1);
            end
            if(mod(a,16)==1)
                t2 = round((samplesPerBeat/4)/3);
                for j = 1: length(hat)
                    if i+j+t2 > length(z)
                        break;
                    end
                    z(i+j-1+t2)=hat(j)+z(i+j-1+t2);
                end
                t3 = 2*round((samplesPerBeat/4)/3);
                for j = 1: length(hat)
                    if i+j+t3 > length(z)
                        break;
                    end
                    z(i+j-1+t3)=hat(j)+z(i+j-1+t3);
                end
            end
            a=a+1;
        end
    end
end
%snare
RsnareRand=round(3*rand);
if(RsnareRand==0)%2&4
    a = 1;
    for i = 1: length(z)
        if finalBeatHH(i) == 1
            if(mod(a,16)==5||mod(a,16)==13)
                for j = 1: length(snare)
                    if i+j > length(z)
                        break;
                    end
                    z(i+j-1)=snare(j)+z(i+j-1);
                end
                
            end
            a=a+1;
        end
    end
elseif (RsnareRand==1)%3
    a = 1;
    for i = 1: length(z)
        if finalBeatHH(i) == 1
            if(mod(a,16)==9)
                for j = 1: length(snare)
                    if i+j > length(z)
                        break;
                    end
                    z(i+j-1)=snare(j)+z(i+j-1);
                end
                
            end
            a=a+1;
        end
    end
elseif (RsnareRand==2)
    a = 1;
    for i = 1: length(z)
        if finalBeatHH(i) == 1
            if(mod(a,16)==5||mod(a,16)==13||mod(a,16)==0)
                for j = 1: length(snare)
                    if i+j > length(z)
                        break;
                    end
                    z(i+j-1)=snare(j)+z(i+j-1);
                end
                
            end
            a=a+1;
        end
    end
elseif (RsnareRand==3)
    a = 1;
    for i = 1: length(z)
        if finalBeatHH(i) == 1
            if(mod(a,16)==5||mod(a,16)==13||mod(a,16)==10)
                for j = 1: length(snare)
                    if i+j > length(z)
                        break;
                    end
                    z(i+j-1)=snare(j)+z(i+j-1);
                end
                
            end
            a=a+1;
        end
    end
end
%kick
RkickRand=round(2*rand);
if(RkickRand==0)
    a = 1;
    for i = 1: length(z)
        if finalBeatHH(i) == 1
            if(mod(a,16)==0||mod(a,16)==10)
                for j = 1: length(kick)
                    if i+j > length(z)
                        break;
                    end
                    z(i+j-1)=kick(j)+z(i+j-1);
                end
                
                for j = 1: length(bassRoot)
                    if i+j > length(z)
                        break;
                    end
                    z(i+j-1)=bassRoot(j)+z(i+j-1);
                end
                
            end
            a=a+1;
        end
    end
elseif(RkickRand==1)
    a = 1;
    for i = 1: length(z)
        if finalBeatHH(i) == 1
            if(mod(a,16)==1||mod(a,16)==7||mod(a,16)==13)
                for j = 1: length(kick)
                    if i+j > length(z)
                        break;
                    end
                    z(i+j-1)=kick(j)+z(i+j-1);
                end
                
                for j = 1: length(bassRoot)
                    if i+j > length(z)
                        break;
                    end
                    z(i+j-1)=bassRoot(j)+z(i+j-1);
                end
                
            end
            a=a+1;
        end
    end
elseif(RkickRand==2)
    a = 0;
    for i = 1: length(z)
        if finalBeatHH(i) == 1
            if(mod(a,16)==1||mod(a,16)==7)
                for j = 1: length(kick)
                    if i+j > length(z)
                        break;
                    end
                    z(i+j-1)=kick(j)+z(i+j-1);
                end
                
                for j = 1: length(bassRoot)
                    if i+j > length(z)
                        break;
                    end
                    z(i+j-1)=bassRoot(j)+z(i+j-1);
                end
                
            end
            a=a+1;
        end
    end
end

sound(z, fs)
%figure();
%plot(t,z);
audiowrite('beat.wav',z,fs);

