
close all
numberOfWindows = (size(reshaped))
 
tpr_expected = zeros(1,numberOfWindows(2));
tpr_actual = zeros(1,numberOfWindows(2));
tpr_sigma_expected = zeros(1,numberOfWindows(2));
tpr_sigma_real = zeros(1,numberOfWindows(2));
tpr_ratio = zeros(1,numberOfWindows(2));
se = zeros(1,numberOfWindows(2));
rmssd = zeros(1,numberOfWindows(2));
 
 
 
thr_tpr(1:numberOfWindows(2)) = .54;
thr_se(1:numberOfWindows(2)) = .7;
thr_rmssd(1:numberOfWindows(2)) = .1*mean(RRintervals);
detected = zeros(1,28);
 
for i = 1:numberOfWindows(2)
window = reshaped(:,i);
[tpr_expected(i),tpr_actual(i),tpr_sigma_expected(i),tpr_sigma_real(i)] = turningPointRatio(window);
se(i) = shannonEntropy(window);
rmssd(i) = rootMeanSquareSuccessiveDifferences(window);
tpr_ratio(i) = tpr_actual(i) / (128-16-2);
if (tpr_ratio(i) > thr_tpr(i)) & (se(i)> thr_se(i)) & (rmssd(i) > thr_rmssd)
	detected(i) = 1;
    
end
end
 
%disp(detected)
 
%Plots
%x=1:numberOfWindows(2);
%figure
plot(detected),title('Detected AF');
%plot(ekg),title('EKG');
%plot(x,tpr_ratio,x,thr_tpr),title('Turning Point Ratio');
%plot(x,se,x,thr_se),title('Shannon Entropy');
%plot(x,rmssd,x,thr_rmssd),title('Root mean squared of Successive Differences');

