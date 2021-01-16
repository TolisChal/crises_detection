function [V, Delta] = pic_clustering(A)

Delta=[];
V=[];

W=diag(sum(A,2))\A; %inv(diag(sum(A,2)))*A;

v_t0=rand(size(W(1,:)'));
% v_t0=W(1,:)';
% sum(v_t0)

V=[V; v_t0'];

for i=1:100
%     i
    Wv_t0=W*v_t0;
    
    v_t1=Wv_t0/norm(Wv_t0,1);
    
    delta=norm(v_t1-v_t0,inf);
    
    Delta=[Delta; delta];
    
    v_t0=v_t1;
    
    V=[V; v_t0'];
end