function sendImgToWp(app, loc, auth, token, env)
    imgs = dir("*.png");
    if ~isempty(imgs)
        date = datetime('now', 'Format', 'yyyy/MM/');
        M = containers.Map({'imgName'}, {'id'});
        bodyHtml = dir("article_body.html").name;
        str = convertCharsToStrings(fileread(bodyHtml));
        for index = 1:length(imgs)
            imgName = string(imgs(index).name);
            imgDir = string(pwd) + filesep + imgName;
            disp(imgDir);
            endPoint = string(loc) + 'wp-json/wp/v2/media/';
            cmd = sprintf('curl --location --request POST "%s" --header "Content-Disposition: attachment;filename=%s" --header "Authorization: %s %s" --header "Content-Type: image/png" --data-binary "@%s"', endPoint, imgName, auth, token, imgDir);
            disp(cmd);
            [~,cmdout] = wpfunc.clientRequest(app, cmd, env);
            disp(cmdout);
            if contains(cmdout, "incorrect_password")
                fprintf('Sorry, your WordPress password is not correct in token \n');
                app.ErrorLabel.Text = "Sorry, your WordPress password is not correct in token";
            elseif contains(cmdout, "error", "IgnoreCase", true)
                fprintf('Sorry, there are errors in your WordPress \n');
                app.ErrorLabel.Text = "Sorry, there are errors in your WordPress";
            else
                if contains(cmdout, '"id":')
                    imgId = string(extractBetween(cmdout, '"id":', ',"date"'));
                    disp(imgId);
                    imgUrl = string(loc) + "wp-content/uploads/" + string(date) + string(imgName);
                    disp(imgUrl);
                    imgNewUrl = string(extractBetween(cmdout, ',"raw":"', '"},"modified"'));
                    disp(imgNewUrl);
                    imgNewUrl = erase(imgNewUrl, "\");
                    str = strrep(str, imgUrl, imgNewUrl);
                    M(imgName) = string(imgId);
                else
                    imgUrl = string(loc) + 'wp-json/wp/v2/media?search=' + string(imgName);
                    disp(imgUrl);
                    uploadedImg = webread(imgUrl);
                    if ~isequaln(uploadedImg, [])
                        disp(uploadedImg);
                        imgId = uploadedImg.id;
                        disp(imgId);
                        imgNewUrl = uploadedImg.source_url;
                        imgUrl = string(loc) + "wp-content/uploads/" + string(date) + string(imgName);
                        str = strrep(str, imgUrl, imgNewUrl);
                        M(imgName) = string(imgId);
                    else
                        fprintf('Image "%s" upload failed, please upload image in WordPress directly. \n', imgName);
                        imgId = datetime('now', 'Format', 'yyyyMMdd');
                        imgNewUrl = string(loc) + 'files/' + string(date) + string(imgName);
                        imgUrl = string(loc) + "wp-content/uploads/" + string(date) + string(imgName);
                        str = strrep(str, imgUrl, imgNewUrl);
                        M(imgName) = string(imgId);
                    end
                end
            end
        end
        fileid = fopen("article_body.html", 'wb');
        fwrite(fileid, str, 'char');
        fclose(fileid);
        save imgKey.mat M;
        fprintf('Images are uploaded to WordPress. \n');
    end
end