clear all
close all
clc

load '/Users/maria/Documents/NSPN/docs/vars_label.mat'
load /Users/maria/Documents/NSPN/analysis/cca_analysis/results_100pca_age_gender_healthy.mat
% load /Users/maria/Documents/NSPN/analysis/cca_analysis/results_100pca_age_gender_healthy_depressed.mat

% Plot most important variables
ncomp = 20;
[s,si] = sort(grotBB);
% figure;plot(ones(size(s(end-ncomp-1:end),1),1),s(end-ncomp-1:end),'r+');
% hold on;
% plot(ones(size(s(1:ncomp),1),1),s(1:ncomp),'b+');
% for i = 1:ncomp, text(1.1,s(i+end-ncomp),char(varslabelsbaseline{si(i+end-ncomp)}),'FontSize',14); end
% for i = 1:ncomp, text(1.1,s(i),char(varslabelsbaseline{si(i)}),'FontSize',14); end

% New bar plot
scales = {'apsd','bis','cads','dasi','icu','k10','spq','wemwbs','ypq','ctq','wasi'};
clb = hsv(length(scales));
for i = 1:length(varslabelsbaseline)
    for j =1:length(scales)
        if strfind(varslabelsbaseline{i},scales{j})
            colorlabels(i,:) = j;
        end
    end
end
data = [s(1:ncomp),s(end-ncomp+1:end)];
datalab = [si(1:ncomp),si(end-ncomp+1:end)];
labelsw = cell(1,length(datalab));
for i = 1:length(datalab)
    labelsw{i} = char(varslabelsbaseline{datalab(i)});
end
grp = colorlabels(datalab);
for i = 1:length(scales), grp_labels{i,1} = scales{i}; grp_labels{i,2} = i; end
plot_w_joao(data, labelsw, grp, grp_labels)

% Plot projections CCA1 with color corresponding to variable
gender = csvread('/Users/maria/Documents/NSPN/docs/NSPN_gender_bin_baseline.csv');      % gender
gender = gender(:,2:end);
age = csvread('/Users/maria/Documents/NSPN/docs/NSPN_age_baseline_cambridge.csv');     % age
age = age(:,2:end);
aged = csvread('/Users/maria/Documents/NSPN/docs/NSPN_age_depressed.csv');     % age
aged = aged(:,2:end);
age = [age; aged];
% c(:)=vars(:,si(end-1));

c(:) = age;
ids = gender;
% dep = [zeros(299,1); ones(33,1)];
% ids = dep;
figure;scatter(grotU(ids==1,1),grotV(ids==1,1),100,c(ids==1),'filled','d');
hold on;
scatter(grotU(ids==0,1),grotV(ids==0,1),100,c(ids==0),'o');
hold off;
colorbar

figure;scatter(age,grotU(:,1),'filled','o');

% When projected
% c(:)=[ones(299,1);zeros(33,1)]; % controls and depressed
% figure;scatter([grotU(:,1);Udep(:,1)],[grotV(:,1);Vdep(:,1)],40,c(:),'filled');