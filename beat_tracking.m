[x, fs]=audioread(nameOfFile);
%sec=10;
%start=0;
%y=x(start+1:start+sec*fs);
y=x;
checkLength = 10000;
beatTracked=zeros(1,length(y));
break1 = 0;
break2 = 0;
beatSampleCounter = [];

for i = 1: length(y)%Finds The beats in y (part 1), saves array beatTracked of 1's and 0's
    if break2 == 0
        if i-checkLength<0
            if break1 == 0
                maximum = max(abs(y(1:i+checkLength)));
                if abs(y(i))==abs(maximum)
                    beatTracked(i)=1;
                    i = i+checkLength+1;
                    break1 = 1;
                    beatSampleCounter = i;
                end
            end
            
        elseif i + checkLength>length(y)
            if break2 == 0
                maximum = max(abs(y(i-checkLength:end)));
                if abs(y(i))==abs(maximum)
                    beatTracked(i)=1;
                    i = i+checkLength+1;
                    beatSampleCounter = [beatSampleCounter, i];
                    break2 = 1;
                end
            end
            
        else
            maximum = max(abs(y(i-checkLength+1:i+checkLength-1)));
            if abs(y(i))==abs(maximum)
                beatTracked(i)=1;
                beatSampleCounter = [beatSampleCounter, i];
                i = i+checkLength+1;
            end
        end
        
    end
end

%Counts the distance between each beat detected
beatToSample = zeros(1, length(beatSampleCounter)-1);
for i = 1: length(beatToSample)
    beatToSample(i)=beatSampleCounter(i+1)-beatSampleCounter(i);
end

%t=1/fs:1/fs:sec;
%figure();
%plot(t,y);
%hold on;
%plot(t,beatTracked);

samplesPerBeat = round(median(beatToSample));%Determines most likely BPM
BPM = (fs*60)/samplesPerBeat;
BPMguess = round(BPM);


beat = zeros(1,4);
count=1;
for i = 1 : length(y)
    if beatTracked(i) == 1
        beat(count) = i;
        count=count+1;
    end
end
beatTracked2 = zeros(length(beat),length(beatTracked));
for j = 1 : length(beat)
    for i = beat(j):samplesPerBeat:length(beatTracked)
        beatTracked2(j,i)=1;
    end
    for i = beat(j):-samplesPerBeat:1
        beatTracked2(j,i)=1;
    end
end

%figure();
%plot(t,y);
%hold on;
%plot(t,beatTracked2);

beat2=zeros(1,length(beat));
count = 1;
for j = 1 : length(beat)
    for i = 1 : length(beatTracked)
        if beatTracked2(j,i) == 1
            beat2(j,count)=i;
            count=count+1;
        end
    end
    count=1;
end
[m,n] = size(beat2);
edsum1=0;
edsum2=zeros(1,length(beat));
ed = zeros(1,m);
for i = 1 : m
    edsum = 0;
    for j = 1 : n
        for k = 1 : length(beat)
            edsum2(k) = (beat(k)-beat2(i,j))^2;
        end 
        edsum1 = min(edsum2);
        edsum=edsum+edsum1;
    end
    ed(i) = sqrt(edsum);
end
edSorted=sort(ed);
for i = 1 : length(ed)
    if edSorted(1) == ed(i)
        beatNum=i;
        break;
    end
end
finalBeat=beatTracked2(beatNum,:);

%figure();
%plot(t,y);
%hold on;
%plot(t,finalBeat);