function customizedPath = checkPath(app)
    appDir = wp_publisher.getAppDirectory();
    customizedPath = "";
    if isfile(appDir + "bloginfo.mat")
        load(appDir + "bloginfo.mat", 'toolpath');
        if ~isempty(toolpath)
            if (exist(toolpath, 'dir') ~= 0)
                if toolpath(end) == filesep
                    customizedPath = string(toolpath);
                else
                    customizedPath = string(toolpath) + filesep;
                end
            end
        end
    end
end