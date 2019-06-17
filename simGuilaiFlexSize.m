function [G,G_org,synMask,snr0] = simGuilaiFlexSize(var0,var1,smin,smax)
    
    if nargin<2
        var0 = 0.0005;  % background noise, nosie for intensity=0, 1e-4
        var1 = 0.001;  % noise for intensity=maximum, 2e-3
        smin = 9;
        smax = 100;
    end
    
    % parameters
    synDenDifScale = 10;  % local contrast    
    d = load('./cfg/17_process.mat');
    dres = d.res_all;
    [H,W,~] = size(d.img_all);   
    
    r0 = round((sqrt(smin)-1)/2);
    r1 = round((sqrt(smax)-1)/2);
    gapxy = r1+2;    
    
    % add synapse and noise for each dendrite
    G = zeros(H,W);
    occupyMask = G;
    synMask = G;
    
    nSynTot = 1;
    %rng(888);
    rg0 = randperm(length(dres));
    
    sig0 = zeros(10,1);
    base0 = zeros(10,1);
    
    for jj=rg0
        G0 = zeros(H,W);
        
        dresx = dres(jj);
        denMean = dresx.meanScore*256*(rand()+0.2);
        denIdx = dresx.process;
        G0(denIdx) = denMean;
        G0 = imgaussfilt(G0,1);
        
        % places where we can add synapse
        [r,c] = find(G0>=denMean/2);
        flg = r>gapxy & r<(H-gapxy) & c>gapxy & c<(W-gapxy);
        r = r(flg);
        c = c(flg);
        if isempty(r)
            continue
        end
        nSynSim = ceil(length(dresx.path)/50);
        
        % add synapse to this dendrite
        fprintf('%d -- denMean %f -- syn %d\n',jj,denMean,nSynTot);
        nSynNow = 0;
        nTry = 0;
        
        % generate a synapse
        while nSynNow<nSynSim && nTry<=1000*nSynSim
            idxEle = max(round(rand()*length(r)),1);            
            nTry = nTry + 1;
            h0 = r(idxEle);
            w0 = c(idxEle);
            
            gap0 = randi([r0,r1]);
            rgh0 = h0-gap0:h0+gap0;
            rgw0 = w0-gap0:w0+gap0;
            
            oc0 = occupyMask(rgh0,rgw0);
            if sum(oc0(:))>0
                continue
            end
            
            % puncta shape
            rga = -gap0:gap0;
            d0 = ones(length(rga),length(rga));
            if gap0>1
                d0(1,1) = 0; d0(1,end) = 0; d0(end,1) = 0; d0(end,end) = 0;
            end
            
            % local contrast
            synDenDifScale0 = rand()*synDenDifScale + synDenDifScale*0.5;
            d0 = d0*synDenDifScale0*sqrt(denMean);
            sig0(nSynTot) = max(d0(:));            
            d0(d0>0) = d0(d0>0) + G0(h0,w0);
            base0(nSynTot) = max(d0(:));
            
            % add synapse to dendrite
            G0(rga+h0,rga+w0) = max(G0(rga+h0,rga+w0),d0);
            synMask(rga+h0,rga+w0) = synMask(rga+h0,rga+w0) + (d0>0)*nSynTot;                 
            
            % locations occupied by this puncta
            occupyMask(h0-gap0-2:h0+gap0+2,w0-gap0-2:w0+gap0+2) = 1;
            
            nSynNow = nSynNow + 1;
            nSynTot = nSynTot + 1;            
        end
        
        G = max(G,G0);
        
        if nSynTot>=1001
            break
        end
    end
    
    G(G>255) = 255;
    G_org = G/255;
    
    % add noise
    image_intensity = 0:1/255:1;
    image_var = var0:(var1-var0)/255:var1;
    G_noise_norm = imnoise(G_org,'localvar',image_intensity,image_var);
    G = G_noise_norm*255; 
    
    sig0a = sig0/255;
    noise0a = base0/255*(var1-var0)+var0;
    snr0 = mean(20*log10(sig0a./sqrt(noise0a)));
    
end





