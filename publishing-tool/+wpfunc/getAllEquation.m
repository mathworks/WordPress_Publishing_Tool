function getAllEquation(app, html)
    str = convertCharsToStrings(fileread(html));
    treeStr = regexp(str,'((?<=<body>).*(?=<\/body>))','match');
    spanTrees = regexp(treeStr,'<span[^>]*>(.*?)</span>','match');
    if ~isempty(spanTrees)
        O = containers.Map({'span'}, {'newSpan'});
        for index = 1:length(spanTrees)
            if contains(spanTrees(index), "mathmlencoding") == 1
                newSpan = regexprep(string(spanTrees(index)), '<img .*?>', "equation_placeholder");
                O(string(spanTrees(index))) = string(newSpan);
            end
        end
        k = keys(O);
        val = values(O);
        for i = 1:(length(O)-1)
            str = strrep(str, string(k{i}), string(val{i}));
        end
    end

    fileid = fopen('article_body.html', 'wb');
    fwrite(fileid, str, 'char');
    fclose(fileid);

    fprintf('Equations convert completed. \n');

end