function getAllLatex(html)
    str = convertCharsToStrings(fileread(html));
    treeStr = regexp(str,'((?<=<body>).*(?=<\/body>))','match');
    spanTrees = regexp(treeStr,'<span[^>]*>(.*?)</span>','match');
    if ~isempty(spanTrees)
        O = containers.Map({'span'}, {'newSpan'});
        for index = 1:length(spanTrees)
            if contains(spanTrees(index), "texencoding") == 1
                latexSpan = htmlTree(spanTrees(index));
                latex = "$ " + getAttribute(findElement(latexSpan, "span"), "texencoding") + " $";
                newSpan = regexprep(string(spanTrees(index)), '<img .*?>', 'placeholder');
                sp = strrep(newSpan, 'placeholder', latex);
                O(string(spanTrees(index))) = string(sp);
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

    fprintf('LaTeX convert completed. \n');

end