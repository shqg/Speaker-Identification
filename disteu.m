%============SPEAKER INDENTIFCATION FROM YOUTUBE DATA======================
%==============Nitesh Kumar Chaudahry , LNMIIT Jaipur======================
%===================Email : nitesh.lnmiit@gmail.com========================
%====================Distance Mesurement for VQ============================
function d = disteu(x, y) 
[M, N] = size(x); 
[M2, P] = size(y); 
if (M ~= M2) 
error('Matrix dimensions do not match.') 
end 
d = zeros(N, P);
% if (N < P) 
% copies = zeros(1,P); 
% for n = 1:N 
% d(n,:) = sum((x(:, n+copies) - y) .^2, 1); 
% end 
% else 
% copies = zeros(1,N); 
% for p = 1:P 
% d(:,p) = sum((x - y(:, p+copies)) .^2, 1)'; 
% end 
% end 
% d = d.^0.5; 
for ii=1:N 
for jj=1:P 
%d(ii,jj)=sum((x(:,ii)-y(:,jj)).^2).^0.5; 
d(ii,jj) = mydistance(x(:,ii),y(:,jj),2); 
end 
end
%-------------------------------------------------------------------------- 
%--------------------------------------------------------------------------
end

function [out] = mydistance(x,y,tipo) 
if tipo == 0 
out = sum((x-y).^2).^0.5; 
end 
% Distance sum | x -y | 
if tipo == 1 
out = sum(abs(x-y)); 
end 
% Weighted distance 
if tipo == 2 
pesi = zeros(size(x));
pesi(1) = 0.20; 
pesi(2) = 0.90; 
pesi(3) = 0.95; 
pesi(4) = 0.90; 
pesi(5) = 0.70; 
pesi(6) = 0.90; 
pesi(7) = 1.00; 
pesi(8) = 1.00; 
pesi(9) = 1.00; 
pesi(10) = 0.95; 
pesi(11:13) = 0.30; 
out = sum(abs(x-y).*pesi); 
%out = sum(pesi.*(x-y).^2).^0.5; 
end
end