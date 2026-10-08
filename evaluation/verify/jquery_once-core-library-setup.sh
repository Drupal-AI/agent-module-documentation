#!/usr/bin/env bash
# Introspection SETUP: make sure jquery_once is enabled and the asset library registry is
# rebuilt, so the live site reflects jquery_once_library_info_alter()'s overrides of the
# core/jquery and core/jquery.once libraries. (The module has NO configuration of its own -
# its entire observable state is the altered library registry.) Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush pm:install jquery_once -y >/dev/null 2>&1
drush cr >/dev/null 2>&1
drush php:eval '
  $l = \Drupal::service("library.discovery")->getLibraryByName("core", "jquery.once");
  print "known state: core/jquery.once version=" . ($l["version"] ?? "MISSING")
    . " js=" . ($l["js"][0]["data"] ?? "MISSING") . "\n";
'
