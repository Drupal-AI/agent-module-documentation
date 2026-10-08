#!/usr/bin/env bash
# Introspection setup: configure a KNOWN scannable-fields selection on the live site so the
# agent can read it back. Enables the Article Body field (node:article:body) as scannable in
# scanner.admin_settings; leaves other keys at install defaults.
set -uo pipefail
cd /var/www/html
drush php:eval 'error_reporting(0);
  \Drupal::configFactory()->getEditable("scanner.admin_settings")
    ->set("scanner_mode", TRUE)->set("scanner_wholeword", TRUE)->set("scanner_regex", FALSE)
    ->set("scanner_published", FALSE)->set("scanner_pathauto", FALSE)->set("scanner_language", "all")
    ->set("word_boundaries", "auto")
    ->set("enabled_content_types", ["node:article" => "node:article"])
    ->set("fields_of_selected_content_type", ["node:article:body" => "node:article:body"])->save();
' 2>/dev/null
drush cr >/dev/null 2>&1
echo "setup: scanner enabled_content_types=node:article, fields=node:article:body"
