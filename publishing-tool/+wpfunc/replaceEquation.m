function replaceEquation(app, origHtml, convertedHtml)
    origStr = convertCharsToStrings(fileread(origHtml));
    origTreeStr = regexp(origStr,'((?<=<body>).*(?=<\/body>))','match');
    origSpanTrees = regexp(origTreeStr,'<span[^>]*>(.*?)</span>','match');

    if ~isempty(origSpanTrees)
        P = containers.Map({'span'}, {'newSpan'});
        for i = 1:length(origSpanTrees)
            if contains(origSpanTrees(i), "mathmlencoding") == 1
                latexSpan = htmlTree(origSpanTrees(i));
                latex = getAttribute(findElement(latexSpan, "span"), "mathmlencoding");
                newSpan = regexprep(string(origSpanTrees(i)), '<img .*?>', latex);
                P(string(origSpanTrees(i))) = string(newSpan);
            end
        end
        val = values(P);
    end

    convertedStr = convertCharsToStrings(fileread(convertedHtml));
    convertedSpanTrees = regexp(convertedStr,'<span[^>]*>(.*?)</span>','match');
    if ~isempty(convertedSpanTrees)
        Q = containers.Map({'span'}, {'newSpan'});
        for i = 1:length(convertedSpanTrees)
            if contains(convertedSpanTrees(i), "mathmlencoding") == 1
                Q(string(convertedSpanTrees(i))) = "";
            end
        end
        key = keys(Q);
        for i = 1:(length(Q)-1)
            convertedStr = strrep(convertedStr, string(key{i}), string(val{i}));
        end
    end

    fileid = fopen('article_body.html', 'wb');
    fwrite(fileid, convertedStr, 'char');
    fclose(fileid);
    fprintf('Equations replacement completed. \n');
end