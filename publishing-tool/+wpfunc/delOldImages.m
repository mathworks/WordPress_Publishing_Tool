function delOldImages(app, loc, auth, token, env)
%   This function removes images that have already been uploaded to
%   WordPress for this blog post
    imgKey = dir("imgKey.mat");
    if ~isempty(imgKey)
        load("imgKey.mat");
        imgs = dir("*.png");
        for index = 1:length(imgs)
            imgName = string(imgs(index).name);
            if isKey(M, imgName)
                imgId = M(imgName);
                delEndPoint = string(loc) + 'wp-json/wp/v2/media/' + string(imgId) + "?force=true";
                delcmd = sprintf('curl --location --request DELETE "%s" --header "Authorization: %s %s"', delEndPoint, auth, token);
                [stats, output] = wpfunc.clientRequest(app, delcmd, env);
                if contains(output, "incorrect_password")
                    fprintf('Sorry, your WordPress password is not correct in token \n');
                    app.ErrorLabel.Text = "Sorry, your WordPress password is not correct in token";
                elseif contains(output, "error")
                    fprintf('Sorry, there are errors in your WordPress \n');
                    app.ErrorLabel.Text = "Sorry, there are errors in your WordPress";
                else
                    delete(imgName);
                    fprintf('Previous image is deleted in WordPress \n');
                end
            end
        end
        clear M;
        delete imgKey.mat;
    end
end