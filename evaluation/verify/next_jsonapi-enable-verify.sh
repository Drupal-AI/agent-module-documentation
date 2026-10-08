#!/usr/bin/env bash
# next_jsonapi execution VERIFY (enable case): PASS when the module is enabled AND jsonapi.entity_resource
# is served by next_jsonapi's EntityResource subclass. exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $enabled = \Drupal::moduleHandler()->moduleExists("next_jsonapi");
  $class = \Drupal::hasService("jsonapi.entity_resource") ? get_class(\Drupal::service("jsonapi.entity_resource")) : "none";
  $ok = $enabled && ($class === "Drupal\\next_jsonapi\\Controller\\EntityResource");
  print ($ok ? "PASS" : "FAIL") . " enabled=" . var_export($enabled, TRUE) . " class=" . $class . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
