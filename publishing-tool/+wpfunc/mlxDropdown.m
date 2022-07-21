function mlxDropdown(app, file)
    mlx = dir("*.mlx");
    if ~isempty(mlx)
        if ~strcmp(file, "all")
            if isfile(file)
                mlx = mlx(~startsWith({mlx.name}, file));
                mlx = [dir(file); mlx];
                app.SelectLiveScriptDropDown.Items = {mlx.name};
            else
                fprintf('Sorry, the file you input is not found in the folder \n');
                app.ErrorLabel.Text = "File not found, please select from dropdown";
                app.SelectLiveScriptDropDown.Items = {mlx.name};
            end
        else
            app.SelectLiveScriptDropDown.Items = {mlx.name};
        end
        mlxfile = app.SelectLiveScriptDropDown.Value;
        mlxname = erase(mlxfile, ".mlx");
        customizedPath = wpfunc.checkPath();
        newpath = customizedPath + mlxname;
        if exist(newpath, 'dir') && isfile(newpath + "/post_info.mat")
            load(fullfile(newpath,"/post_info.mat"));
            app.AppLabel.Text = "Edit existing blog article";
            delete(newpath + "/*.html");
        else
            app.AppLabel.Text = "Post new blog article";
        end

    else
        fprintf('Sorry, there are no live scripts found in the folder \n');
        app.ErrorLabel.Text = "Sorry, there are no live scripts found in the folder";
    end
end