function res = fillspaces(seq)
    res = seq;
    for i=length(seq)+1:16
        res = [res ' '];
    end
end