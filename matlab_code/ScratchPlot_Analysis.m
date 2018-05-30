%% Copyright 2016 MERCIER David
function dataAnalyzed = ScratchPlot_Analysis(config, data)
%% Function to analyze Excel data from scratch tests

%% Find scratch indices
empty_elems = arrayfun(@(s) isempty(s.dispVert) & isempty(s.dispHori) & isempty(s.load), data.expValues);
data.expValues(empty_elems) = [];
numTestMax = length(data.expValues);

for ii = 1:numTestMax
    dispH = data.expValues(ii).dispHori;
    ind_MinDisp = find(dispH>=config.maxScratchLength);
    
    dispV = data.expValues(ii).dispVert;
    ind_MinDisp2 = find(isnan(dispV));
    
    indAll = intersect(ind_MinDisp2,ind_MinDisp);
    indMin(ii) = indAll(1);
    for jj = 1:length(indAll)
        if indAll(2) == indAll(1) + jj
            
        else
            indMax(ii) = indAll(jj+1);
            break
        end
    end
    
    ind_scratch(1,ii) = 1;
    ind_scratch(2,ii) = indMin(ii);
    ind_scratch(3,ii) = indMax(ii);
    ind_scratch(4,ii) = nanmax(indAll);
end
deltaMAXTAB(1) = nanmin(ind_scratch(2,:) - 1);
deltaMAXTAB(2) = nanmin(ind_scratch(3,:) - ind_scratch(2,:));
deltaMAXTAB(3) = nanmin(nanmax(ind_scratch(4,:)) - ind_scratch(3,:));

%% Preallocation of variables
dataAnalyzed = struct();
dataAnalyzed.dispVertSum_1 = zeros(deltaMAXTAB(1)+1, 1);
dataAnalyzed.dispHoriSum_1 = zeros(deltaMAXTAB(1)+1, 1);
dataAnalyzed.loadSum_1 = zeros(deltaMAXTAB(1)+1, 1);
dataAnalyzed.dispVertSum_2 = zeros(deltaMAXTAB(2)+1, 1);
dataAnalyzed.dispHoriSum_2 = zeros(deltaMAXTAB(2)+1, 1);
dataAnalyzed.loadSum_2 = zeros(deltaMAXTAB(2)+1, 1);
dataAnalyzed.dispVertSum_3 = zeros(deltaMAXTAB(3)+1, 1);
dataAnalyzed.dispHoriSum_3 = zeros(deltaMAXTAB(3)+1, 1);
dataAnalyzed.loadSum_3 = zeros(deltaMAXTAB(3)+1, 1);

%% All tests
for ii = 1:1:numTestMax
    dataAnalyzed.allVal(ii).dispVert_1 = data.expValues(ii).dispVert(ind_scratch(1,:):(ind_scratch(1,:)+deltaMAXTAB(1)),1);
    dataAnalyzed.allVal(ii).dispHori_1 = data.expValues(ii).dispHori(ind_scratch(1,:):(ind_scratch(1,:)+deltaMAXTAB(1)),1);
    dataAnalyzed.allVal(ii).load_1 = data.expValues(ii).load(ind_scratch(1,:):(ind_scratch(1,:)+deltaMAXTAB(1)),1);
    
    dataAnalyzed.allVal(ii).dispVert_2 = data.expValues(ii).dispVert(ind_scratch(2,:):(ind_scratch(2,:)+deltaMAXTAB(2)),1);
    dataAnalyzed.allVal(ii).dispHori_2 = data.expValues(ii).dispHori(ind_scratch(2,:):(ind_scratch(2,:)+deltaMAXTAB(2)),1);
    dataAnalyzed.allVal(ii).load_2 = data.expValues(ii).load(ind_scratch(2,:):(ind_scratch(2,:)+deltaMAXTAB(2)),1);
    
    dataAnalyzed.allVal(ii).dispVert_3 = data.expValues(ii).dispVert(ind_scratch(3,:):(ind_scratch(3,:)+deltaMAXTAB(3)),1);
    dataAnalyzed.allVal(ii).dispHori_3 = data.expValues(ii).dispHori(ind_scratch(3,:):(ind_scratch(3,:)+deltaMAXTAB(3)),1);
    dataAnalyzed.allVal(ii).load_3 = data.expValues(ii).load(ind_scratch(3,:):(ind_scratch(3,:)+deltaMAXTAB(3)),1);
end

%% Sum
for ii = 1:1:numTestMax
    % Pre-scratch
    dataAnalyzed.dispVertSum_1 = dataAnalyzed.dispVertSum_1 + ...
        data.expValues(ii).dispVert(ind_scratch(1,ii):(ind_scratch(1,ii)+deltaMAXTAB(1)),1);
    dataAnalyzed.dispHoriSum_1 = dataAnalyzed.dispHoriSum_1 + ...
        data.expValues(ii).dispHori(ind_scratch(1,ii):(ind_scratch(1,ii)+deltaMAXTAB(1)),1);
    dataAnalyzed.loadSum_1 = dataAnalyzed.loadSum_1 + ...
        data.expValues(ii).load(ind_scratch(1,ii):(ind_scratch(1,ii)+deltaMAXTAB(1)),1);
    
    % Scratch
    dataAnalyzed.dispVertSum_2 = dataAnalyzed.dispVertSum_2 + ...
        data.expValues(ii).dispVert(ind_scratch(2,ii):(ind_scratch(2,ii)+deltaMAXTAB(2)),1);
    dataAnalyzed.dispHoriSum_2 = dataAnalyzed.dispHoriSum_2 + ...
        data.expValues(ii).dispHori(ind_scratch(2,ii):(ind_scratch(2,ii)+deltaMAXTAB(2)),1);
    dataAnalyzed.loadSum_2 = dataAnalyzed.loadSum_2 + ...
        data.expValues(ii).load(ind_scratch(2,ii):(ind_scratch(2,ii)+deltaMAXTAB(2)),1);
    
    % Post-scratch
    dataAnalyzed.dispVertSum_3 = dataAnalyzed.dispVertSum_3 + ...
        data.expValues(ii).dispVert(ind_scratch(3,ii):(ind_scratch(3,ii)+deltaMAXTAB(3)),1);
    dataAnalyzed.dispHoriSum_3 = dataAnalyzed.dispHoriSum_3 + ...
        data.expValues(ii).dispHori(ind_scratch(3,ii):(ind_scratch(3,ii)+deltaMAXTAB(3)),1);
    dataAnalyzed.loadSum_3 = dataAnalyzed.loadSum_3 + ...
        data.expValues(ii).load(ind_scratch(3,ii):(ind_scratch(3,ii)+deltaMAXTAB(3)),1);
end

%% Mean
dataAnalyzed.dispVertMean_1 = dataAnalyzed.dispVertSum_1 / numTestMax;
dataAnalyzed.dispHoriMean_1 = dataAnalyzed.dispHoriSum_1 / numTestMax;
dataAnalyzed.loadMean_1 = dataAnalyzed.loadSum_1 / numTestMax;

dataAnalyzed.dispVertMean_2 = dataAnalyzed.dispVertSum_2 / numTestMax;
dataAnalyzed.dispHoriMean_2 = dataAnalyzed.dispHoriSum_2 / numTestMax;
dataAnalyzed.loadMean_2 = dataAnalyzed.loadSum_2 / numTestMax;

dataAnalyzed.dispVertMean_3 = dataAnalyzed.dispVertSum_3 / numTestMax;
dataAnalyzed.dispHoriMean_3 = dataAnalyzed.dispHoriSum_3 / numTestMax;
dataAnalyzed.loadMean_3 = dataAnalyzed.loadSum_3 / numTestMax;

%% Error bars calculations
for ii = 1:1:numTestMax
    DispVert_1(:,ii) = data.expValues(ii).dispVert(ind_scratch(2,ii):(ind_scratch(2,ii)+deltaMAXTAB(1)),1);
    DispVert_2(:,ii) = data.expValues(ii).dispVert(ind_scratch(2,ii):(ind_scratch(2,ii)+deltaMAXTAB(2)),1);
    DispVert_3(:,ii) = data.expValues(ii).dispVert(ind_scratch(2,ii):(ind_scratch(2,ii)+deltaMAXTAB(3)),1);
    
end
for ii = 1:1:size(DispVert_1, 1)
    dataAnalyzed.dispVertError_1(ii) = ...
        (max(DispVert_1(ii,:)) - min(DispVert_1(ii,:)))/2;
end
for ii = 1:1:size(DispVert_2, 1)
    dataAnalyzed.dispVertError_2(ii) = ...
        (max(DispVert_2(ii,:)) - min(DispVert_2(ii,:)))/2;
end
for ii = 1:1:size(DispVert_3, 1)
    dataAnalyzed.dispVertError_3(ii) = ...
        (max(DispVert_3(ii,:)) - min(DispVert_3(ii,:)))/2;
end

%% Set vertical displacement and error bars in microns
dataAnalyzed.dispVertMean_1 = dataAnalyzed.dispVertMean_1/1e3;
dataAnalyzed.dispVertError_1 = dataAnalyzed.dispVertError_1/1e3;
dataAnalyzed.dispVertMean_2 = dataAnalyzed.dispVertMean_2/1e3;
dataAnalyzed.dispVertError_2 = dataAnalyzed.dispVertError_2/1e3;
dataAnalyzed.dispVertMean_3 = dataAnalyzed.dispVertMean_3/1e3;
dataAnalyzed.dispVertError_3 = dataAnalyzed.dispVertError_3/1e3;

end