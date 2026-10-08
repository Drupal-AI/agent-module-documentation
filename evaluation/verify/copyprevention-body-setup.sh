#!/usr/bin/env bash
# Introspection SETUP: enable the 'disable right-click context menu' and 'disable copy' body
# options in copyprevention.settings, so an inspecting agent can read the live config. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("copyprevention.settings")
    ->set("copyprevention_body", ["selectstart" => 0, "copy" => "copy", "contextmenu" => "contextmenu"])
    ->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: copyprevention_body enables copy + contextmenu"
