function x = pflat(x)
    x = x(1:end-1,:)./x(end,:);
    
end