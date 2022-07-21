function [stats, output] = clientRequest(app, cmd, env)
    prodstr = "prod";
    if strcmp(prodstr, env)
        [stats, output] = system(cmd);
    else
        [stats, output] = deal(200, 'success');
    end
end