#!/usr/bin/env bash
# Execution VERIFY: PASS when cloudflarepurger is enabled AND the purge purger plugin
# 'cloudflare' (types tag/url/everything) is registered.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $enabled = \Drupal::moduleHandler()->moduleExists("cloudflarepurger");
  $defs = \Drupal::service("plugin.manager.purge.purgers")->getDefinitions();
  $has = isset($defs["cloudflare"]);
  $ok = $enabled && $has;
  print ($ok ? "PASS" : "FAIL") . " module=" . var_export($enabled, TRUE) . " purger=" . var_export($has, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
