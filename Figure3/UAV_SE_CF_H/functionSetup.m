function [R,HMean,H,HMeanx,H_Rayleigh,channelGain] = functionSetup(L,N,ASD,nbrOfRealizations)

%Size of the coverage area (as a square with wrap-around)
squareLength = 100; %meter

% %Communication bandwidth
% B = 20e6;
% 
% %Noise figure (in dB)
% noiseFigure = 9;
% 
% %Compute noise power
% noiseVariancedBm = -174 + 10*log10(B) + noiseFigure;

%The received power at the reference distance (e.g., d = 1 m) between the
%transmitter and the receiver. (dB)
beta_0= -40;

%Define the antenna spacing (in number of wavelengths)
antennaSpacing = 1/2; %Half wavelength distance

%Angular standard deviation around the nominal angle (measured in degrees)
ASDdeg = ASD;

%Prepare to save results
R = zeros(N,N,L);
HMean = zeros(N,L);

%% Go through all setups
    
    %Random AP locations with uniform distribution
    APpositions = (rand(L,1) + 1i*rand(L,1)) * squareLength;
    %Random UE locations with uniform distribution
    UEpositions= (rand(1,1) + 1i*rand(1,1)) * squareLength;
    
    %The height of Access Point
    APheigth=0;  
    %The height of User Equipment
    UEheigth=15;  
    %The height difference between AP and UE 
    verticalDistance=UEheigth-APheigth;
            
        %Compute distances between each of the APs to UE k
        distancetoUE = abs(APpositions - UEpositions);
        distancesUAV = sqrt(verticalDistance.^2 + distancetoUE.^2);

        
        %Compute the channel gain divided by the noise power
        gainOverNoisedB =beta_0 - 10*log10(distancesUAV.^2) ;%- noiseVariancedBm;
        channelGain=db2pow(gainOverNoisedB);
        
        %Calculate the distance based Rician Factor 
        ricianFactor=10.^(1.3-0.003*distancesUAV);
        
        %Scale with Rician factor
        channelGain_LoS =  ricianFactor./(ricianFactor + 1 ).*(channelGain);
        channelGain_NLoS = (1./(ricianFactor +1 )).*(channelGain);
        
        %Go through all APs
        for l = 1:L
            
            %Compute nominal angle between UE k and AP l
            %angletoUE = angle(UEpositions-APpositions(l));
            angletoUE = atan(verticalDistance/abs(UEpositions-APpositions(l)));
            
            %Generate normalized spatial correlation matrix using the local
            %scattering model
            correlationMatrix = functionRlocalscattering(N,angletoUE,ASDdeg,antennaSpacing);
            HMean_norm=(exp(1i*2*pi.*(0:(N-1))*sin(angletoUE)*antennaSpacing)); %Normalized Mean vector

            R(:,:,l) = channelGain_NLoS(l)*correlationMatrix;
            %R(:,:,l) = channelGain_NLoS(l)*eye(N);
            HMean(:,l)=sqrt(channelGain_LoS(l))*HMean_norm;

        end

       %%
        %Generate the channel realizations
        %Generate uncorrelated random variables
        W = sqrt(0.5)*(randn(N,nbrOfRealizations,L)+1i*randn(N,nbrOfRealizations,L));
        
        %Prepare to store channel realizations
        H=zeros(N,nbrOfRealizations,L);
        H_Rayleigh=zeros(N,nbrOfRealizations,L);
        
        %Reshape the mean vectors to get same mean vector for all realizations
        HMeanx=reshape(repmat(HMean,nbrOfRealizations,1),N,nbrOfRealizations,L);
        
        for l=1:L
            Rsqrt = sqrtm(R(:,:,l));
            H(:,:,l) = Rsqrt*W(:,:,l) + HMeanx(:,:,l);
            H_Rayleigh(:,:,l) = Rsqrt*W(:,:,l);
            
        end








