%% Copyright 2016 MERCIER David
function dataAnalyzed = ScratchPlot_Analysis(config, data)
%% Function to analyze Excel data from scratch tests

%% Find scratch indices
empty_elems = arrayfun(@(s) isempty(s.dispVert) & isempty(s.dispHori) & isempty(s.load), data.expValues);
data.expValues(empty_elems) = [];
numTestMax = length(data.expValues);

for ii = 1:numTestMax
    dispH = data.expValues(ii).dispHori;
    ind_MinDisp = find(dispH>=0.99*config.maxScratchLength);
    
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

%% Find cross profile indices
for ii = 1:numTestMax
    dispCross = data.expValues(ii).dispHoriCross;
    ind_DispCross1 = find(dispCross<=0.49*-config.crossProfileLength & ...
        dispCross<=1e300);
    ind_DispCross2 = find(dispCross>=0.49*config.crossProfileLength & ...
        dispCross<=1e300);
    ind_cross(1,ii) = nanmin(ind_DispCross1);
    ind_cross(2,ii) = nanmax(ind_DispCross2);
end
deltaMAXTABCross(1) = nanmin(ind_cross(2,:) - ind_cross(1,:));

%% Preallocation of variables
dataAnalyzed = struct();
dataAnalyzed.dispVertSum_1 = zeros(deltaMAXTAB(1)+1, 1);
dataAnalyzed.dispVertCorrSum_1 = zeros(deltaMAXTAB(1)+1, 1);
dataAnalyzed.dispHoriSum_1 = zeros(deltaMAXTAB(1)+1, 1);
dataAnalyzed.loadSum_1 = zeros(deltaMAXTAB(1)+1, 1);
dataAnalyzed.dispVertSum_2 = zeros(deltaMAXTAB(2)+1, 1);
dataAnalyzed.dispVertCorrSum_2 = zeros(deltaMAXTAB(2)+1, 1);
dataAnalyzed.dispHoriSum_2 = zeros(deltaMAXTAB(2)+1, 1);
dataAnalyzed.loadSum_2 = zeros(deltaMAXTAB(2)+1, 1);
dataAnalyzed.dispVertSum_3 = zeros(deltaMAXTAB(3)+1, 1);
dataAnalyzed.dispVertCorrSum_3 = zeros(deltaMAXTAB(3)+1, 1);
dataAnalyzed.dispHoriSum_3 = zeros(deltaMAXTAB(3)+1, 1);
dataAnalyzed.loadSum_3 = zeros(deltaMAXTAB(3)+1, 1);
dataAnalyzed.dispHoriCross = zeros(deltaMAXTABCross(1)+1, 1);
dataAnalyzed.dispVertCross = zeros(deltaMAXTABCross(1)+1, 1);
dataAnalyzed.dispHoriCrossSum = zeros(deltaMAXTABCross(1)+1, 1);
dataAnalyzed.dispVertCrossSum = zeros(deltaMAXTABCross(1)+1, 1);

%% All tests
for ii = 1:1:numTestMax
    dataAnalyzed.allVal(ii).dispVert_1 = data.expValues(ii).dispVert(ind_scratch(1,ii):(ind_scratch(1,ii)+deltaMAXTAB(1)),1);
    dataAnalyzed.allVal(ii).dispVertCorr_1 = data.expValues(ii).dispVertCorr(ind_scratch(1,ii):(ind_scratch(1,ii)+deltaMAXTAB(1)),1);
    dataAnalyzed.allVal(ii).dispHori_1 = data.expValues(ii).dispHori(ind_scratch(1,ii):(ind_scratch(1,ii)+deltaMAXTAB(1)),1);
    dataAnalyzed.allVal(ii).load_1 = data.expValues(ii).load(ind_scratch(1,ii):(ind_scratch(1,ii)+deltaMAXTAB(1)),1);
    
    dataAnalyzed.allVal(ii).dispVert_2 = data.expValues(ii).dispVert(ind_scratch(2,ii):(ind_scratch(2,ii)+deltaMAXTAB(2)),1);
    dataAnalyzed.allVal(ii).dispVertCorr_2 = data.expValues(ii).dispVertCorr(ind_scratch(2,ii):(ind_scratch(2,ii)+deltaMAXTAB(2)),1);
    dataAnalyzed.allVal(ii).dispHori_2 = data.expValues(ii).dispHori(ind_scratch(2,ii):(ind_scratch(2,ii)+deltaMAXTAB(2)),1);
    dataAnalyzed.allVal(ii).load_2 = data.expValues(ii).load(ind_scratch(2,:):(ind_scratch(2,ii)+deltaMAXTAB(2)),1);
    
    dataAnalyzed.allVal(ii).dispVert_3 = data.expValues(ii).dispVert(ind_scratch(3,ii):(ind_scratch(3,ii)+deltaMAXTAB(3)),1);
    dataAnalyzed.allVal(ii).dispVertCorr_3 = data.expValues(ii).dispVertCorr(ind_scratch(3,ii):(ind_scratch(3,ii)+deltaMAXTAB(3)),1);
    dataAnalyzed.allVal(ii).dispHori_3 = data.expValues(ii).dispHori(ind_scratch(3,ii):(ind_scratch(3,ii)+deltaMAXTAB(3)),1);
    dataAnalyzed.allVal(ii).load_3 = data.expValues(ii).load(ind_scratch(3,ii):(ind_scratch(3,ii)+deltaMAXTAB(3)),1);

    dataAnalyzed.allVal(ii).dispHoriCross = data.expValues(ii).dispHoriCross(ind_cross(1,ii):(ind_cross(1,ii)+deltaMAXTABCross(1)),1);
    dataAnalyzed.allVal(ii).dispVertCross = data.expValues(ii).dispVertCross(ind_cross(1,ii):(ind_cross(1,ii)+deltaMAXTABCross(1)),1);
end

%% Sum
for ii = 1:1:numTestMax
    % Pre-profile
    dataAnalyzed.dispVertSum_1 = dataAnalyzed.dispVertSum_1 + ...
        data.expValues(ii).dispVert(ind_scratch(1,ii):(ind_scratch(1,ii)+deltaMAXTAB(1)),1);
    dataAnalyzed.dispVertCorrSum_1 = dataAnalyzed.dispVertCorrSum_1 + ...
        data.expValues(ii).dispVertCorr(ind_scratch(1,ii):(ind_scratch(1,ii)+deltaMAXTAB(1)),1);
    dataAnalyzed.dispHoriSum_1 = dataAnalyzed.dispHoriSum_1 + ...
        data.expValues(ii).dispHori(ind_scratch(1,ii):(ind_scratch(1,ii)+deltaMAXTAB(1)),1);
    dataAnalyzed.loadSum_1 = dataAnalyzed.loadSum_1 + ...
        data.expValues(ii).load(ind_scratch(1,ii):(ind_scratch(1,ii)+deltaMAXTAB(1)),1);
    
    % Scratch
    dataAnalyzed.dispVertSum_2 = dataAnalyzed.dispVertSum_2 + ...
        data.expValues(ii).dispVert(ind_scratch(2,ii):(ind_scratch(2,ii)+deltaMAXTAB(2)),1);
    dataAnalyzed.dispVertCorrSum_2 = dataAnalyzed.dispVertCorrSum_2 + ...
        data.expValues(ii).dispVertCorr(ind_scratch(2,ii):(ind_scratch(2,ii)+deltaMAXTAB(2)),1);
    dataAnalyzed.dispHoriSum_2 = dataAnalyzed.dispHoriSum_2 + ...
        data.expValues(ii).dispHori(ind_scratch(2,ii):(ind_scratch(2,ii)+deltaMAXTAB(2)),1);
    dataAnalyzed.loadSum_2 = dataAnalyzed.loadSum_2 + ...
        data.expValues(ii).load(ind_scratch(2,ii):(ind_scratch(2,ii)+deltaMAXTAB(2)),1);
    
    % Post-profile
    dataAnalyzed.dispVertSum_3 = dataAnalyzed.dispVertSum_3 + ...
        data.expValues(ii).dispVert(ind_scratch(3,ii):(ind_scratch(3,ii)+deltaMAXTAB(3)),1);
    dataAnalyzed.dispVertCorrSum_3 = dataAnalyzed.dispVertCorrSum_3 + ...
        data.expValues(ii).dispVertCorr(ind_scratch(3,ii):(ind_scratch(3,ii)+deltaMAXTAB(3)),1);
    dataAnalyzed.dispHoriSum_3 = dataAnalyzed.dispHoriSum_3 + ...
        data.expValues(ii).dispHori(ind_scratch(3,ii):(ind_scratch(3,ii)+deltaMAXTAB(3)),1);
    dataAnalyzed.loadSum_3 = dataAnalyzed.loadSum_3 + ...
        data.expValues(ii).load(ind_scratch(3,ii):(ind_scratch(3,ii)+deltaMAXTAB(3)),1);

    % Cross profile
    dataAnalyzed.dispHoriCrossSum = dataAnalyzed.dispHoriCrossSum + ...
        data.expValues(ii).dispHoriCross(ind_cross(1,ii):(ind_cross(1,ii)+deltaMAXTABCross(1)),1);
    dataAnalyzed.dispVertCrossSum = dataAnalyzed.dispVertCrossSum + ...
        data.expValues(ii).dispVertCross(ind_cross(1,ii):(ind_cross(1,ii)+deltaMAXTABCross(1)),1);
end

%% Moving-average filter = smooth
if config.smoothFlag
    windowSize = config.smoothVal; 
    b = (1/windowSize)*ones(1,windowSize);
    a = 1;
    dataAnalyzed.dispVertSum_1 = filter(b,a,dataAnalyzed.dispVertSum_1);
    dataAnalyzed.dispVertCorrSum_1 = filter(b,a,dataAnalyzed.dispVertCorrSum_1);
    dataAnalyzed.dispHoriSum_1 = filter(b,a,dataAnalyzed.dispHoriSum_1);
    dataAnalyzed.loadSum_1 = filter(b,a,dataAnalyzed.loadSum_1);
	dataAnalyzed.dispVertSum_2 = filter(b,a,dataAnalyzed.dispVertSum_2);
    dataAnalyzed.dispVertCorrSum_2 = filter(b,a,dataAnalyzed.dispVertCorrSum_2);
	dataAnalyzed.dispHoriSum_2 = filter(b,a,dataAnalyzed.dispHoriSum_2);
    dataAnalyzed.loadSum_2 = filter(b,a,dataAnalyzed.loadSum_2);
    dataAnalyzed.dispVertSum_3 = filter(b,a,dataAnalyzed.dispVertSum_3);
    dataAnalyzed.dispVertCorrSum_3 = filter(b,a,dataAnalyzed.dispVertCorrSum_3);
    dataAnalyzed.dispHoriSum_3 = filter(b,a,dataAnalyzed.dispHoriSum_3);
    dataAnalyzed.loadSum_3 = filter(b,a,dataAnalyzed.loadSum_3);
    dataAnalyzed.dispHoriCrossSum = filter(b,a,dataAnalyzed.dispHoriCrossSum);
    dataAnalyzed.dispVertCrossSum = filter(b,a,dataAnalyzed.dispVertCrossSum);
end

%% Spline smooth
if config.splineFlag
    dataAnalyzed.dispVertSum_1 = smoothn(dataAnalyzed.dispVertSum_1, config.splineVal);
    dataAnalyzed.dispVertCorrSum_1 = smoothn(dataAnalyzed.dispVertCorrSum_1, config.splineVal);
    dataAnalyzed.dispHoriSum_1 = smoothn(dataAnalyzed.dispHoriSum_1, config.splineVal);
    dataAnalyzed.loadSum_1 = smoothn(dataAnalyzed.loadSum_1, config.splineVal);
    dataAnalyzed.dispVertSum_2 = smoothn(dataAnalyzed.dispVertSum_2, config.splineVal);
    dataAnalyzed.dispVertCorrSum_2 = smoothn(dataAnalyzed.dispVertCorrSum_2, config.splineVal);
    dataAnalyzed.dispHoriSum_2 = smoothn(dataAnalyzed.dispHoriSum_2, config.splineVal);
    dataAnalyzed.loadSum_2 = smoothn(dataAnalyzed.loadSum_2, config.splineVal);
    dataAnalyzed.dispVertSum_3 = smoothn(dataAnalyzed.dispVertSum_3, config.splineVal);
    dataAnalyzed.dispVertCorrSum_3 = smoothn(dataAnalyzed.dispVertCorrSum_3, config.splineVal);
    dataAnalyzed.dispHoriSum_3 = smoothn(dataAnalyzed.dispHoriSum_3, config.splineVal);
    dataAnalyzed.loadSum_3 = smoothn(dataAnalyzed.loadSum_3, config.splineVal);
    dataAnalyzed.dispHoriCrossSum = smoothn(dataAnalyzed.dispHoriCrossSum, config.splineVal);
    dataAnalyzed.dispVertCrossSum = smoothn(dataAnalyzed.dispVertCrossSum, config.splineVal);
end

%% Mean
dataAnalyzed.dispVertMean_1 = dataAnalyzed.dispVertSum_1 / numTestMax;
dataAnalyzed.dispVertCorrMean_1 = dataAnalyzed.dispVertCorrSum_1 / numTestMax;
dataAnalyzed.dispHoriMean_1 = dataAnalyzed.dispHoriSum_1 / numTestMax;
dataAnalyzed.loadMean_1 = dataAnalyzed.loadSum_1 / numTestMax;

dataAnalyzed.dispVertMean_2 = dataAnalyzed.dispVertSum_2 / numTestMax;
dataAnalyzed.dispVertCorrMean_2 = dataAnalyzed.dispVertCorrSum_2 / numTestMax;
dataAnalyzed.dispHoriMean_2 = dataAnalyzed.dispHoriSum_2 / numTestMax;
dataAnalyzed.loadMean_2 = dataAnalyzed.loadSum_2 / numTestMax;

dataAnalyzed.dispVertMean_3 = dataAnalyzed.dispVertSum_3 / numTestMax;
dataAnalyzed.dispVertCorrMean_3 = dataAnalyzed.dispVertCorrSum_3 / numTestMax;
dataAnalyzed.dispHoriMean_3 = dataAnalyzed.dispHoriSum_3 / numTestMax;
dataAnalyzed.loadMean_3 = dataAnalyzed.loadSum_3 / numTestMax;

dataAnalyzed.dispHoriCrossMean = dataAnalyzed.dispHoriCrossSum / numTestMax;
dataAnalyzed.dispVertCrossMean = dataAnalyzed.dispVertCrossSum / numTestMax;

%% Error bars calculations
for ii = 1:1:numTestMax
    DispVert_1(:,ii) = data.expValues(ii).dispVert(ind_scratch(1,ii):(ind_scratch(1,ii)+deltaMAXTAB(1)),1);
    DispVert_2(:,ii) = data.expValues(ii).dispVert(ind_scratch(2,ii):(ind_scratch(2,ii)+deltaMAXTAB(2)),1);
    DispVert_3(:,ii) = data.expValues(ii).dispVert(ind_scratch(3,ii):(ind_scratch(3,ii)+deltaMAXTAB(3)),1);
    DispVertCorr_1(:,ii) = data.expValues(ii).dispVertCorr(ind_scratch(1,ii):(ind_scratch(1,ii)+deltaMAXTAB(1)),1);
    DispVertCorr_2(:,ii) = data.expValues(ii).dispVertCorr(ind_scratch(2,ii):(ind_scratch(2,ii)+deltaMAXTAB(2)),1);
    DispVertCorr_3(:,ii) = data.expValues(ii).dispVertCorr(ind_scratch(3,ii):(ind_scratch(3,ii)+deltaMAXTAB(3)),1);
    DispHori_1(:,ii) = data.expValues(ii).dispHori(ind_scratch(1,ii):(ind_scratch(1,ii)+deltaMAXTAB(1)),1);
    DispHori_2(:,ii) = data.expValues(ii).dispHori(ind_scratch(2,ii):(ind_scratch(2,ii)+deltaMAXTAB(2)),1);
    DispHori_3(:,ii) = data.expValues(ii).dispHori(ind_scratch(3,ii):(ind_scratch(3,ii)+deltaMAXTAB(3)),1);
    Load_1(:,ii) = data.expValues(ii).load(ind_scratch(1,ii):(ind_scratch(1,ii)+deltaMAXTAB(1)),1);
    Load_2(:,ii) = data.expValues(ii).load(ind_scratch(2,ii):(ind_scratch(2,ii)+deltaMAXTAB(2)),1);
    Load_3(:,ii) = data.expValues(ii).load(ind_scratch(3,ii):(ind_scratch(3,ii)+deltaMAXTAB(3)),1);
    HoriCross(:,ii) = data.expValues(ii).dispHoriCross(ind_cross(1,ii):(ind_cross(1,ii)+deltaMAXTABCross(1)),1);
    VertCross(:,ii) = data.expValues(ii).dispVertCross(ind_cross(1,ii):(ind_cross(1,ii)+deltaMAXTABCross(1)),1);
end
for ii = 1:1:size(DispVert_1, 1)
    dataAnalyzed.dispVertError_1(ii) = ...
        (nanmax(DispVert_1(ii,:)) - nanmin(DispVert_1(ii,:)))/2;
    dataAnalyzed.dispVertCorrError_1(ii) = ...
        (nanmax(DispVertCorr_1(ii,:)) - nanmin(DispVertCorr_1(ii,:)))/2;
    dataAnalyzed.dispHoriError_1(ii) = ...
        (nanmax(DispHori_1(ii,:)) - nanmin(DispHori_1(ii,:)))/2;
    dataAnalyzed.loadError_1(ii) = ...
        (nanmax(Load_1(ii,:)) - nanmin(Load_1(ii,:)))/2;
end
for ii = 1:1:size(DispVert_2, 1)
    dataAnalyzed.dispVertError_2(ii) = ...
        (nanmax(DispVert_2(ii,:)) - nanmin(DispVert_2(ii,:)))/2;
    dataAnalyzed.dispVertCorrError_2(ii) = ...
        (nanmax(DispVertCorr_2(ii,:)) - nanmin(DispVertCorr_2(ii,:)))/2;
    dataAnalyzed.dispHoriError_2(ii) = ...
        (nanmax(DispHori_2(ii,:)) - nanmin(DispHori_2(ii,:)))/2;
    dataAnalyzed.loadError_2(ii) = ...
        (nanmax(Load_2(ii,:)) - nanmin(Load_2(ii,:)))/2;
end
for ii = 1:1:size(DispVert_3, 1)
    dataAnalyzed.dispVertError_3(ii) = ...
        (nanmax(DispVert_3(ii,:)) - nanmin(DispVert_3(ii,:)))/2;
    dataAnalyzed.dispVertCorrError_3(ii) = ...
        (nanmax(DispVertCorr_3(ii,:)) - nanmin(DispVertCorr_3(ii,:)))/2;
    dataAnalyzed.dispHoriError_3(ii) = ...
        (nanmax(DispHori_3(ii,:)) - nanmin(DispHori_3(ii,:)))/2;
    dataAnalyzed.loadError_3(ii) = ...
        (nanmax(Load_3(ii,:)) - nanmin(Load_3(ii,:)))/2;
end
for ii = 1:1:size(VertCross, 1)
    dataAnalyzed.dispHoriCrossError(ii) = ...
        (nanmax(HoriCross(ii,:)) - nanmin(HoriCross(ii,:)))/2;
    dataAnalyzed.dispVertCrossError(ii) = ...
        (nanmax(VertCross(ii,:)) - nanmin(VertCross(ii,:)))/2;
end

%% Set vertical displacement and error bars in microns
dataAnalyzed.dispVertMean_1 = dataAnalyzed.dispVertMean_1/1e3;
dataAnalyzed.dispVertError_1 = dataAnalyzed.dispVertError_1/1e3;
dataAnalyzed.dispVertMean_2 = dataAnalyzed.dispVertMean_2/1e3;
dataAnalyzed.dispVertError_2 = dataAnalyzed.dispVertError_2/1e3;
dataAnalyzed.dispVertMean_3 = dataAnalyzed.dispVertMean_3/1e3;
dataAnalyzed.dispVertError_3 = dataAnalyzed.dispVertError_3/1e3;
dataAnalyzed.dispVertCorrMean_1 = dataAnalyzed.dispVertCorrMean_1/1e3;
dataAnalyzed.dispVertCorrError_1 = dataAnalyzed.dispVertCorrError_1/1e3;
dataAnalyzed.dispVertCorrMean_2 = dataAnalyzed.dispVertCorrMean_2/1e3;
dataAnalyzed.dispVertCorrError_2 = dataAnalyzed.dispVertCorrError_2/1e3;
dataAnalyzed.dispVertCorrMean_3 = dataAnalyzed.dispVertCorrMean_3/1e3;
dataAnalyzed.dispVertCorrError_3 = dataAnalyzed.dispVertCorrError_3/1e3;

end