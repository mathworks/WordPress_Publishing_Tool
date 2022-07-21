function delOldMlx(app, path, loc, auth, token, env)
    mlxKey = dir("mlxKey.mat");
    if ~isempty(mlxKey)
        load("mlxKey.mat");
        mlxs = dir(string(path) + filesep + "*.mlx");
        for index = 1:length(mlxs)
            mlxName = string(mlxs(index).name);
            if isKey(allMlx, mlxName)
                mlxId = allMlx(mlxName);
                delEndPoint = string(loc) + 'wp-json/wp/v2/media/' + string(mlxId) + "?force=true";
                delcmd = sprintf('curl --location --request DELETE "%s" --header "Authorization: %s %s"', delEndPoint, auth, token);
                [stats, output] = wpfunc.clientRequest(app, delcmd, env);
                if contains(output, "incorrect_password")
                    fprintf('Sorry, your WordPress password is not correct in token \n');
                    app.ErrorLabel.Text = "Sorry, your WordPress password is not correct in token";
                elseif contains(output, "error")
                    fprintf('Sorry, there are errors in your WordPress \n');
                    app.ErrorLabel.Text = "Sorry, there are errors in your WordPress";
                else
                    fprintf('Previous Live Script is deleted in WordPress \n');
                end
            end
        end
        clear allMlx;
        delete mlxKey.mat;
    end
end