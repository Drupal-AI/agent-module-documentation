#!/usr/bin/env bash
# Execution VERIFY: PASS when content_entity_clone is enabled for node.page (config exists with
# enabled === true). exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $c = \Drupal::config("content_entity_clone.bundle.settings.node.page");
  $enabled = $c->get("enabled");
  $ok = ($enabled === TRUE || $enabled === 1 || $enabled === "1");
  print ($ok ? "PASS" : "FAIL") . " enabled=" . var_export($enabled, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
