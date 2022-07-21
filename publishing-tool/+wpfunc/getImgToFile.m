function getImgToFile(app, mlxname, html, blog_url)
%     This function is used to extract the images from the .mlx file
%     and save them to a newly created sub-directory so they can be
%     uploaded to the target WordPress website

    str = convertCharsToStrings(fileread(html));
    headStr = extractBetween(str, '<style type="text/css">', '</style>');
    styleStr = regexprep(regexprep(headStr, '.rtcContent { padding: 30px; } ',''), '[\n\r]+',' ');
    styleScript = sprintf("<script type=\""text/javascript\"">var css = '%s'; var head = document.head || document.getElementsByTagName('head')[0], style = document.createElement('style'); head.appendChild(style); style.type = 'text/css'; if (style.styleSheet){ style.styleSheet.cssText = css; } else { style.appendChild(document.createTextNode(css)); }</script>", strrep(styleStr, '''', ''));
    treeStr = regexp(str,'((?<=<body>).*(?=<\/body>))','match') + styleScript;
    tree = htmlTree(treeStr);
    imgs = findElement(tree,"div.rtcContent img");
    imgsrcs = getAttribute(imgs, "src");
    date = datetime('now', 'Format', 'yyyy/MM/');
    if ~isempty(imgsrcs)
        for index = 1:length(imgsrcs)
            imgType = extractBetween(imgsrcs(index), "data:image/", ";base64");
            newStr = extractAfter(imgsrcs(index), ";base64,");
            raw = matlab.net.base64decode(newStr);
            if strcmp(imgType, "jpeg") == 1
                imgFile = string(mlxname) + "_" + string(index) + ".jpg";
            else
                imgFile = string(mlxname) + "_" + string(index) + ".png";
            end
            imgName = string(mlxname) + "_" + string(index) + ".png";
            imgUrl = string(blog_url) + "wp-content/uploads/" + string(date) + string(imgName);
            treeStr = strrep(treeStr, imgsrcs(index), imgUrl);
            % decode base64 to images
            fid = fopen(imgFile, 'wb');
            fwrite(fid, raw);
            fclose(fid);
        end
        f=dir('*.jpg');
        fil={f.name};
        for k=1:numel(fil)
            file = fil{k};
            new_file = strrep(file,'.jpg','.png');
            im = imread(file);
            imwrite(im,new_file);
            delete(file);
        end
    end

    fileid = fopen("article_body.html", 'wb');
    fwrite(fileid, treeStr, 'char');
    fclose(fileid);
    fprintf('Images convert completed. \n');
end