<?php
/**
* Plugin Name: Live Script Support
* Plugin URI: http://www.mathworks.com
* Description: This plugin will provide necessary support files and settings for users to publish their blog posts via MATLAB Live Script.
* Version: 1.0.0
* Author: Cheng Chen
* Author URI: http://www.mathworks.com
*/

remove_filter('the_content', 'wpautop');
function WP_auto_formatting($content) {
    global $post;
    if(get_post_meta($post->ID, 'disable_auto_formatting', true) == 1) {
        remove_filter('the_content', 'wpautop');
    }
    return $content;
}
add_filter( "the_content", "WP_auto_formatting", 1 );

function upload_mlx_files( $allowed ) {
    if ( !current_user_can( 'manage_options' ) )
        return $allowed;
    $allowed['mlx'] = 'application/octet-stream';
    return $allowed;
}
add_filter( 'upload_mimes', 'upload_mlx_files');

function upload_bmp_files( $allowed ) {
    if ( !current_user_can( 'manage_options' ) )
        return $allowed;
    $allowed['bmp'] = 'image/bmp';
    return $allowed;
}
add_filter( 'upload_mimes', 'upload_bmp_files');

add_action('init', 'register_script');
function register_script() {
    wp_register_script( 'mathjax_setting', plugins_url('/static/mathjax.js', __FILE__), array('jquery'), null, true );

    wp_enqueue_script( 'mathjax', 'https://cdnjs.cloudflare.com/ajax/libs/mathjax/2.7.5/MathJax.js?config=TeX-AMS-MML_HTMLorMML');

    wp_register_style( 'live_scripts_style', plugins_url('/static/rtc.css', __FILE__), false, '1.0.0',);
}

// use the registered jquery and style above
add_action('wp_enqueue_scripts', 'enqueue_static_files');

function enqueue_static_files(){
   wp_enqueue_script('mathjax');
   wp_enqueue_script('mathjax_setting');
   wp_enqueue_style( 'live_scripts_style' );
}


?>
