function loadSavedSiteInfo(app, appDir)
    load(appDir + "bloginfo.mat", "site", "token", "username", "password", "auth", "toolpath");
    if isempty(token) || isempty(site) || isempty(token)
        app.TabGroup.SelectedTab = app.SettingsTab;
        app.BlogInfoActionLabel.Text = "Please input your blog information";
    else
        app.TabGroup.SelectedTab = app.PublishpostTab;
        app.BlogSiteEditField.Value = site;
        app.UsernameField.Value = username;
        app.PasswordField.Value = "******";
        if (~isempty(toolpath))
            app.PathField.Value = toolpath;
        end
        if (auth == 1)
            app.JwtButton.Value = true;
        elseif (auth == 2)
            app.BasicButton.Value = true;
        end
    end
end