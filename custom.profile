<?php

/**
 * @file
 * Enables modules and site configuration for a custom site installation.
 *
 * Created by: Topsitemakers
 * http://www.topsitemakers.com/
 */

/*
 * Define minimum execution time required to operate.
 */
define('DRUPAL_MINIMUM_MAX_EXECUTION_TIME', 60);

/**
 * Implements hook_form_FORM_ID_alter() for install_configure_form().
 *
 * Allows the profile to alter the site configuration form.
 */
function custom_form_install_configure_form_alter(&$form, $form_state) {
  // Prepare some variables to be used as default values of the final form.
  $server_name = $_SERVER['SERVER_NAME'];
  // Check if there is a dot in the server name. This is aimed for local
  // development environments, for example if the site is running at localhost.
  // In order to create a valid email address, the '.com' is appended.
  // This is added just to make creating a new dev site faster.
  if (!strpos($server_name, '.')) {
    $server_name = $server_name . '.com';
  }
  $admin_email = 'admin@' . $server_name;

  // Pre-populate the site name with the server name.
  $form['site_information']['site_name']['#default_value'] = $_SERVER['SERVER_NAME'];
  // Set the default admin email address to "admin@domain.com".
  $form['site_information']['site_mail']['#default_value'] = $admin_email;
  // Set the default admin username and email address.
  $form['admin_account']['account']['name']['#default_value'] = 'admin';
  $form['admin_account']['account']['mail']['#default_value'] = $admin_email;
}

/**
 * Implements hook_install_tasks_alter().
 */
function custom_install_tasks_alter(&$tasks, $install_state){
  global $install_state;
  // Skip the language selection screen and set the language to English by
  // default.
  $tasks['install_select_locale']['display'] = FALSE;
  $tasks['install_select_locale']['run']     = INSTALL_TASK_SKIP;
  $install_state['parameters']['locale']     = 'en';
}
