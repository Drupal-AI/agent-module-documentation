#!/usr/bin/env bash
# Cleanup for scanner-introspect-fields: restore scanner.admin_settings to install defaults
# (no entity types / fields enabled).
set -uo pipefail
cd /var/www/html
drush php:eval 'error_reporting(0);
  \Drupal::configFactory()->getEditable("scanner.admin_settings")
    ->set("scanner_mode", TRUE)->set("scanner_wholeword", TRUE)->set("scanner_regex", FALSE)
    ->set("scanner_published", FALSE)->set("scanner_pathauto", FALSE)->set("scanner_language", "all")
    ->set("word_boundaries", "auto")->set("enabled_content_types", [])
    ->set("fields_of_selected_content_type", [])->save();
' 2>/dev/null
drush cr >/dev/null 2>&1
echo "cleanup: scanner settings restored to install defaults"
