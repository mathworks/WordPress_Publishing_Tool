function sendMlxToWp(app, path, loc, auth, token, env)
    mlxname = app.SelectLiveScriptDropDown.Value;
    mlx = dir(string(path) + filesep + string(mlxname));
    if ~isempty(mlx)
        allMlx = containers.Map({'mlxName'}, {'id'});
        mlxName = mlx.name;
        mlxDir = string(path) + filesep + mlxName;
        disp(mlxDir);
        endPoint = string(loc) + 'wp-json/wp/v2/media/';
        cmd = sprintf('curl --location --silent --request POST "%s" --header "Content-Disposition: attachment;filename=%s" --header "Authorization: %s %s" --header "Content-Type: application/octet-stream" --data-binary "@%s"', endPoint, mlxName, auth, token, mlxDir);
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
                % cmdout is JSON
                json = jsondecode(cmdout);
                disp(json);
                mlxUrl = json.source_url;
                mlxId = json.id;
            else
                mlxUrl = string(loc) + 'wp-json/wp/v2/media?search=' + string(mlxName);
                disp(mlxUrl);
                uploadedMlx = webread(mlxUrl);
                if ~isequaln(uploadedMlx, [])
                    disp(uploadedMlx);
                    mlxId = uploadedMlx.id;
                    disp(mlxId);
                    mlxUrl = uploadedMlx.source_url;
                else
                    date = datetime('now', 'Format', 'yyyy/MM/');
                    fprintf('Live Script "%s" upload failed, please upload Live Script in WordPress directly. \n', mlxName);
                    mlxId = datetime('now', 'Format', 'yyyyMMdd');
                    mlxUrl = string(loc) + 'wp-content/uploads/' + string(date) + string(mlxName);
                end
            end

            bodyHtml = dir("article_body.html").name;
            downLoadSetting = app.EnableDownLoadCheckBox.Value;
            if downLoadSetting == 1
                mlxButton = sprintf('<a href="%s"><button class="btn btn-sm btn_color_blue pull-right add_margin_10">Download Live Script</button></a>', mlxUrl);
                str = convertCharsToStrings(fileread(bodyHtml)) + mlxButton;
            else
                str = convertCharsToStrings(fileread(bodyHtml));
            end
            allMlx(mlxName) = string(mlxId);
            save mlxKey.mat allMlx;
            fileid = fopen("article_body.html", 'wb');
            fwrite(fileid, str, 'char');
            fclose(fileid);
        end
        fprintf('Live script is uploaded to WordPress. \n');
    end
end