close all; clc; clear all;


addpath('clustering'); addpath('compute_emd'); addpath('copula_compuration');
addpath('indicators'); addpath('plots'); addpath('reconstruction');
addpath('small_copulas');

returns = read_data();
    
copulas = compute_copulas(returns, 100, 60, 500000);

indicators = comp_indicators_mask(copulas);
ind_lbl = indicators_lbl(indicators);