#!/usr/bin/env bash
# Restore cookiebot.settings to shipped install defaults explicitly (State is unreliable here).
# Used as cleanup (medium) and reset (hard). Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("cookiebot.settings")
    ->set("cookiebot_cbid", "")
    ->set("cookiebot_block_cookies", TRUE)
    ->set("cookiebot_iab_enabled", FALSE)
    ->set("cookiebot_drupal_culture", FALSE)
    ->set("cookiebot_disable_async_loading", FALSE)
    ->set("cookiebot_show_declaration", FALSE)
    ->set("cookiebot_show_declaration_node", "")
    ->set("exclude_paths", "")
    ->set("exclude_admin_theme", FALSE)
    ->set("disabled_for_roles", [])
    ->set("message_placeholder_cookieconsent_optout_marketing_show", FALSE)
    ->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "restore: cookiebot.settings reset to shipped defaults"
