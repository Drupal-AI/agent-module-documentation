#!/usr/bin/env bash
# Introspection setup: set a KNOWN, non-default regex word-boundary mode so the agent can read
# it back. Sets scanner.admin_settings:word_boundaries = "icu" (install default is "auto").
set -uo pipefail
cd /var/www/html
drush php:eval 'error_reporting(0);
  \Drupal::configFactory()->getEditable("scanner.admin_settings")
    ->set("scanner_mode", TRUE)->set("scanner_wholeword", TRUE)->set("scanner_regex", FALSE)
    ->set("scanner_published", FALSE)->set("scanner_pathauto", FALSE)->set("scanner_language", "all")
    ->set("word_boundaries", "icu")->set("enabled_content_types", [])
    ->set("fields_of_selected_content_type", [])->save();
' 2>/dev/null
drush cr >/dev/null 2>&1
echo "setup: scanner word_boundaries=icu"
