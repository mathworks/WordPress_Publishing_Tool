function postArticle(app, title, loc, auth, token)
    html = dir("article_body.html").name;
    postInfo = dir("post_info.mat");
    if ~isempty(html)
        if ~isempty(postInfo)
            load post_info.mat;
            endPoint = string(loc) + 'wp-json/wp/v2/posts/' + string(postId);
        else
            endPoint = string(loc) + 'wp-json/wp/v2/posts/';
        end
        str = convertCharsToStrings(fileread(string(html)));
        content = regexprep(str, '\n<br>*\n<!--(.*?)-->','');
        auth = sprintf('%s %s', auth, token);
        options = weboptions('HeaderFields',{'Authorization' auth});
        data = struct('title',title,'status', 'draft', 'content', content);
        response = webwrite(endPoint,data,options);
        postId = response.id;
        postLink = response.link;
        editLink = string(loc) + 'wp-admin/post.php?post=' + postId + '&action=edit';
        postTitle = response.title.raw;
        save post_info.mat postId postLink postTitle;
        fprintf('SUCCESS! Please see your blog article here - <a href="%s">%s</a> \n', postLink, response.title.raw);
        web(postLink);
        web(editLink);
    end
end