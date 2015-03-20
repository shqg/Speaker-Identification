
%============SPEAKER INDENTIFCATION FROM YOUTUBE DATA======================
%==============Nitesh Kumar Chaudahry , LNMIIT Jaipur======================
%================Email : nitesh.lnmiit@gmail.com===========================


n = input('Enter the number of Sound to be identified = ');
 THRESHOLD=0.06; 
 l=0;
for i = 1:n
      

    % Read audio data from test folder for performing operations
    st = strcat('DATA\',num2str(l+i),'.wav');
  
    %samplingfrequency=12500;
    %samplingbits=16;
    [st2, fst1] = wavread(st);
    samplePerFrame=floor(fst1/100);
bgSampleCount=floor(fst1/5); %according to formula, 1600 sample needed for 8 khz


%----------
%calculation of mean and std
bgSample=[];

       for x=1:1:bgSampleCount
            bgSample=[bgSample st2(x)];
       end
       
meanVal=mean(bgSample);
sDev=std(bgSample);
%----------
%identify voiced or not for each value
    for x=1:1:length(st2) %#ok<ALIGN>
        if(abs(st2(x)-meanVal)/sDev > THRESHOLD)
             voiced(x)=1;
        else
             voiced(x)=0;
        end
   
    end
abs(st2(5)-meanVal)/sDev 

% identify voiced or not for each frame
%discard insufficient samples of last frame

usefulSamples=length(st2)-mod(length(st2),samplePerFrame);
frameCount=usefulSamples/samplePerFrame;
voicedFrameCount=0;
for x=1:1:frameCount
   cVoiced=0;
   cUnVoiced=0;
   for y=x*samplePerFrame-samplePerFrame+1:1:(x*samplePerFrame)
       if(voiced(y)==1)
           cVoiced=(cVoiced+1);
       else
           cUnVoiced=cUnVoiced+1;
       end
   end
   %mark frame for voiced/unvoiced
   if(cVoiced>cUnVoiced)
       voicedFrameCount=voicedFrameCount+1;
       voicedUnvoiced(x)=1;
   else
       voicedUnvoiced(x)=0;
   end
end

st3=[];

%-----
for x=1:1:frameCount
    if(voicedUnvoiced(x)==1)
    for y=x*samplePerFrame-samplePerFrame+1:1:(x*samplePerFrame)
            st3= [st3 st2(y)];
    end
    end
end
    st1 = st3(fst1*1/4:fst1*1/2);
  
    %wavwrite(st1,samplingfrequency,samplingbits,st);
    ste{i} = st1; fste{i} = fst1;
    p=audioplayer(ste{i},fste{i});
    play(p);
    pause(0.5);
   

    % Compute MFCC of the audio data to be used in Speech Processing for Test
    % Folder
    cte{i} = mfcc(ste{i},fste{i});


    % Compute Vector Quantization of the audio data to be used in Speech
    % Processing for Test Folder
    dte{i} = vqlbg(cte{i},16);
    
    
end


for i=1:n
    distmin = 11;
    k1 = 0;

    for j=1:n
        d=disteu(cte{i},dte{j});
	     dist = sum(min(d,[],2) / size(d,1));
        
	    
            if dist < distmin
                fprintf('Distance between Speaker %s and Speaker %s is' ,num2str(i) , num2str(j) );
                fprintf(' = %f \n',dist);
                
            end
         
              D(i ,j)=dist;
             
         
        
    end
           
    
end

D
figure
 bar3(D,'DisplayName','D')
 title('3D Plot of Speakers Variations')
 xlabel('Utterances of i speech Sample')
 ylabel('Utterances of i speech Sample')
 zlabel('Distortion measure between i & j Uttrences')
 figure
 bar(D,'DisplayName','D')
 title('2D Plot of Speakers Variations')
 xlabel('Utterances of i & j speech Sample')
 ylabel('Distortion measure between i & j Uttrences')
 
 