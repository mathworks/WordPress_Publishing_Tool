function mlxTohtml(app)
    appDir = wp_publisher.getAppDirectory();
    if isfile(appDir + "bloginfo.mat")
        load(appDir + "bloginfo.mat", 'toolpath');
    end
    mlxname = app.SelectLiveScriptDropDown.Value;
    d = dir(mlxname);
    dname = d.name;
    dfolder = d.folder;

    if ~isempty(d)
        timestamp = datetime(d.datenum,"ConvertFrom","datenum",'Format','yyyy-MM-dd''T''HHmmss');
        ts = convertCharsToStrings(datestr(timestamp, 'mm-dd-yy'));
        tmpfile = char(convertCharsToStrings(d.name) + '-' + ts + '.html');
        mlxname = erase(d.name, ".mlx");
        if ~isempty(toolpath)
            if (exist(toolpath, 'dir') ~= 0)
                cd(toolpath)
                if ~exist(fullfile(cd, mlxname), 'dir')
                    mkdir(mlxname);
                end
                customizedPath = wpfunc.checkPath();
                mlxfile = string(dfolder) + filesep + string(dname);
                convertScript(convertStringsToChars(mlxfile), convertStringsToChars(customizedPath), mlxname, tmpfile);

            else
                cd(dfolder)
                if ~exist(fullfile(cd, mlxname), 'dir')
                    mkdir(mlxname);
                end
                convertScript(which(dname), dfolder, mlxname, tmpfile);
            end
        else
            cd(dfolder)
            if ~exist(fullfile(cd, mlxname), 'dir')
                mkdir(mlxname);
            end
            convertScript(which(dname), dfolder, mlxname, tmpfile);
        end
        fprintf('Live script is converted into HTML. \n');

        cd(mlxname)

    else
        fprintf('Sorry, there is no live script found in the folder \n');
        app.ErrorLabel.Text = "Sorry, there is no live script found in the folder";
    end
end