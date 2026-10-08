#!/usr/bin/env bash
# Introspection setup: turn ON the "regular expression search" default (non-default) so the
# agent must read live config, not recite the doc default. Sets scanner_regex = TRUE
# (install default is FALSE).
set -uo pipefail
cd /var/www/html
drush php:eval 'error_reporting(0);
  \Drupal::configFactory()->getEditable("scanner.admin_settings")
    ->set("scanner_mode", TRUE)->set("scanner_wholeword", TRUE)->set("scanner_regex", TRUE)
    ->set("scanner_published", FALSE)->set("scanner_pathauto", FALSE)->set("scanner_language", "all")
    ->set("word_boundaries", "auto")->set("enabled_content_types", [])
    ->set("fields_of_selected_content_type", [])->save();
' 2>/dev/null
drush cr >/dev/null 2>&1
echo "setup: scanner scanner_regex=TRUE"
