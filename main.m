close all; clc; clear all;

addpath('clustering'); addpath('compute_emd'); addpath('copula_computation');
addpath('indicators'); addpath('plots'); addpath('reconstruction');
addpath('small_copulas');

%T = readtable('asset_returns_daily_30_industry.csv');
%AssRets = table2array(T) / 100;
load('AssReturns_daily_30_industry.mat')
    
copulas = compute_copulas(AssRets, 100, 60, 500000);
save('copulas_30_industry.mat', 'copulas')

indicators = comp_indicators_mask(copulas);
ind_lbl = indicators_lbl(indicators);
save('indicators_30_industry.mat', 'indicators')
save('ind_lbl_30_industry.mat', 'ind_lbl')
