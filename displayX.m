displayg = zeros(7,6);
for i = 1 : 42
    if x(i,1) == 1
        x_c = mod(i,6);
        if x_c == 0
            x_c = 6;
            x_r = i/6;
        else
            x_r = fix(i/6) + 1;
        end  
        displayg(x_r,x_c) = 1;
    end
end