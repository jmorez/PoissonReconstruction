function validstr=backward2ForwardSlash(str)
%This function converts all backward slashes to forward slashes. Copying a
%directory in Windows will result in backward slashes, which messes up
%fprint and others because it is an escape character in that context.
    for j=1:length(str)
        ch=double(str(j));
        if(ch==92)
            validstr(j)=char(47);
        else
            validstr(j)=str(j);
        end
    end
end