function title = getPostTitle(app, html)
    tree = htmlTree(fileread(html));
    postTitle = extractHTMLText(findElement(tree,"H1"));
    if ~isempty(postTitle)
        title = postTitle;
        fprintf('Article - %s is ready to be published to your blog \n', postTitle);
    else
        title = "Post title placeholder";
        app.ErrorLabel.Text = "Article title is empty";
        fprintf('Article is ready to be published to your blog, please don\''t forget to change title of your article. \n');
    end
end