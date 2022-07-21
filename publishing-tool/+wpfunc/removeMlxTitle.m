function removeMlxTitle(html)
    tree = htmlTree(fileread(html));
    postTitle = extractHTMLText(findElement(tree,"H1"));
    if ~isempty(postTitle)
        str = convertCharsToStrings(fileread(html));
        treeStr = regexprep(str,'<h1.*?<\/h1>', '');
        fileid = fopen('article_body.html', 'wb');
        fwrite(fileid, treeStr, 'char');
        fclose(fileid);
    else
        copyfile(html, "article_body.html");
    end
end