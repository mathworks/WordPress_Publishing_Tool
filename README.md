
# Publishing tool for MATLAB® live script to WordPress
[![View <File Exchange Title> on File Exchange](https://www.mathworks.com/matlabcentral/images/matlab-file-exchange.svg)](https://www.mathworks.com/matlabcentral/fileexchange/103730-publishing-tool-for-matlab-live-script-to-wordpress)  
 
This MATLAB® App provides a fast and easy way for users to publish their MATLAB® live scripts as blog posts to their WordPress sites. What the users type in live script is what the users will see in WordPress. 
The App will:
1. Keeps all the styles in the live script as well as outputs such as graphs and tables and convert entire live script into HTML markup and send to WordPress via WordPress JSON API.
2. All the images in the live script will be converted to media files and uploaded to WordPress automatically.
3. The animation output will be automatically converted into GIF files and uploaded to WordPress automatically.
4. All the equations and formulas will be rendered nicely via [MathJax](https://www.mathjax.org/) in WordPress. 
5. Users also have the option to let the app upload their original live script as attachment for readers to download or not from their WordPress site.  

## Setup 
### Prerequisite
- Be connected to internet
### MathWorks® Products ([https://www.mathworks.com](https://www.mathworks.com))
 - Requires MATLAB® release R2020a or newer
### 3rd Party Products:
- WordPress V4.7 and above with WP JSON API enabled
	- Update the setting of permalink to not be **plain**
- Have [JWT Authentication for WP REST API](https://wordpress.org/plugins/jwt-authentication-for-wp-rest-api/) (preferred) or [Basic Authentication](https://github.com/WP-API/Basic-Auth) installed and configured in your WordPress site

## Deployment Steps 
### MATLAB®

 1. Get **wp_publisher.mlapp** and **convertScript.p** in your workspace

![enter image description here](https://github.com/mathworks/WordPress_Publishing_Tool/blob/master/images/deployment.png)
 2. Add wp_publisher MATLAB® App directory into your MATLAB® path permanently

![enter image description here](https://www.mathworks.com/matlabcentral/answers/uploaded_files/227308/Untitled.png)

### WordPress

 1. Upload **live-script-support** to your WordPress plugin (/wp-content/plugins)
 2. Activate **Live Script Support** plugin:

![enter image description here](https://github.com/mathworks/WordPress_Publishing_Tool/blob/master/images/plugin.png)

## Getting Started
According to your habits, you can create a folder for all your blog post live scripts, or a folder for all your blog post live scripts for a particular year (e.g. 2021_blog_posts).
#### Note: If you are not in your blog post folder, please close the publishing tool, go to your blog post folder with live scripts and reopen the App. 

### First time user
 - Go to your blog post folder with live scripts
 - In MATLAB® Command Window, simply type `wp_publisher`:

![enter image description here](https://github.com/mathworks/WordPress_Publishing_Tool/blob/master/images/blogs.png)
	
 - The publishing tool will be opened and lead you to the **settings** tab, where you can input your WordPress blog site information. 
	 - You also can choose the location to store the output files for your blog post live script
	 - Choose your installed WordPress API authentication
	 - Save your settings and your blog information will be saved in your workspace

![enter image description here](https://github.com/mathworks/WordPress_Publishing_Tool/blob/master/images/blog_setting.png)

 - Switch to **Publish post** tab, you will see a dropdown menu to choose the live script you want to post as article to your WordPress blog

![enter image description here](https://github.com/mathworks/WordPress_Publishing_Tool/blob/master/images/post.png)


- You can check "**Allow your readers to download your source Live Script**" and your live script will be uploaded to your WordPress media library for users to download
 - Once you finish choosing your blog post, click **Publish draft** button, your live script will be posted to your WordPress as a draft.
	 - The link to the draft of your post will be displayed in your MATLAB® Command Window (you need to log in your WordPress to see the draft)
	 
![enter image description here](https://github.com/mathworks/WordPress_Publishing_Tool/blob/master/images/after_post.png)

 - You can preview the post, once you are happy about the post, you can then publish it.
	 
### Return user
 - Go to your blog post folder with live scripts
 - In MATLAB® Command Window, simply type `wp_publisher`:
	 - The publishing tool will be opened and lead you to the  **Publish post** tab, you will see a dropdown menu to choose the live script you want to post as article to your WordPress blog
	 - You can check "**Allow your readers to download your source Live Script**" and your live script will be uploaded to your WordPress media library for users to download
 - Once you finish choosing your blog post, click **Publish draft** button, your live script will be posted to your WordPress as a draft.
	 - The link to the draft of your post will be displayed in your MATLAB® Command Window (you need to log in your WordPress to see the draft)
 - You can preview the post, once you are happy about the post, you can then publish it.

## Note

 - If you are not in your blog post folder, please close the publishing tool, go to your blog post folder with live scripts and reopen the App. 
 - Once you click **Publish draft** button, the App will create a folder named as your live script to store the information of the article and images from your live script
 - To avoid additional formatting by WordPress Editor, please select 'No Character Encoding' value at the bottom of the editor
 ![enter image description here](https://github.com/mathworks/WordPress_Publishing_Tool/blob/master/images/no_encoding.png)
 - You can update your WordPress settings in the App whenever your are using the App
 - In your live script of blog post, we suggest you add your article title so the publishing tool will know what's your blog post title. If you did not add title in your live script, the publishing tool will add a placeholder title for your blog post, you can modify it later in your blog draft.
 - Once the live script is published to your WordPress site by the App and you want to make some editing on the article, instead updating directly in your WordPress, we'd suggest you edit your article in your MATLAB® live scripts and use the App again to keep content consistent. The App will know the post information from the output folder:

![enter image description here](https://github.com/mathworks/WordPress_Publishing_Tool/blob/master/images/update.png)
  	

## License

The license is available in the [License file](https://github.com/mathworks/WordPress_Publishing_Tool/blob/master/license.txt) within this repository.

## [](#community-support)Community Support

[MATLAB Central](https://www.mathworks.com/matlabcentral)

Copyright 2021-2023 The MathWorks, Inc.
