#!/usr/bin/env bash
# CLEANUP/RESET: restore empty_page.settings to its shipped baseline (new_id:1, no callbacks).
# Removes every callback_* key. Rebuilds the router. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $c = \Drupal::configFactory()->getEditable("empty_page.settings");
  foreach (array_keys($c->getRawData()) as $k) { if (strpos($k, "callback_") === 0) { $c->clear($k); } }
  $c->set("new_id", 1)->save();
' >/dev/null 2>&1
drush php:eval '\Drupal::service("router.builder")->rebuild();' >/dev/null 2>&1
echo "baseline: empty_page.settings reset (new_id=1, no callbacks)"
