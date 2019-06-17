% simulation using artificial synapse and dendrites
%
% imgLst: a list of raw data, each with height x width x depth x channel
% annoLst: a list of annotation, each is a list of pixels for each puncta
%          allow to contain only one pixel per puncta
% annoMapLst: a list of binary annotation maps, same size as raw data
%             for pixel level supervised methods
%
% all index start from 1 (MATLAB convension)
% freemanwyz@gmail.com

var0 = 0.0001;  % Gaussian noise 0.0005
var1Vec = [4e-4,25e-4,0.01];  % Poisson noise coefficient
smin = 9;  % min synpase area in random simulation
smaxVec = [16,50,150];  % max synpase area in random simulation

% generate simulation data
N = 10;
for mm=1:numel(var1Vec)
    var1 = var1Vec(mm);
    for nn=1:numel(smaxVec)
        smax = smaxVec(nn);
        imgLst = cell(N,1);
        annoLst = cell(N,1);
        annoMapLst = cell(N,1);
        snrLst = zeros(N,1);
        
        for ii=1:N
            fprintf('Dat %d\n',ii)
            [dat,datClean,kMap,snr0] = simGuilaiFlexSize( var0,var1,smin,smax );
            imgLst{ii} = dat;
            annoMapLst{ii} = kMap>0;
            annoLst{ii} = label2idx(kMap);
            snrLst(ii) = snr0;
        end
        
        save(['synthetic_smax_',num2str(smax),'_var1_',num2str(var1),'.mat'],...
            'imgLst','annoLst','annoMapLst','snrLst');
    end
end





