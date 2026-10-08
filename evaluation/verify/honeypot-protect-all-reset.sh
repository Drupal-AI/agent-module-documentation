#!/usr/bin/env bash
# Reset honeypot.settings to a clean install-default baseline so each eval run is
# independent. Restores every key the honeypot tests touch: protection off, the
# default time limit / element name, and the shipped unprotected_forms +
# form_settings maps (all per-form protection off).
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("honeypot.settings")
    ->set("protect_all_forms", FALSE)
    ->set("unprotected_forms", ["user_login_form", "search_form", "search_block_form", "views_exposed_form", "honeypot_settings_form"])
    ->set("log", FALSE)
    ->set("element_name", "url")
    ->set("time_limit", 5)
    ->set("expire", 300)
    ->set("form_settings", ["user_register_form" => FALSE, "user_pass" => FALSE, "feedback_contact_message_form" => FALSE, "_contact_message_form" => FALSE])
    ->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: honeypot.settings restored to install-default baseline"
