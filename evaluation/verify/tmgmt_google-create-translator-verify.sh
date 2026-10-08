#!/usr/bin/env bash
# Execution VERIFY: PASS when translator tmgg_task exists with plugin google and a non-empty api_key.
# exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\tmgmt\Entity\Translator;
  $t = Translator::load("tmgg_task");
  $plugin = $t ? $t->getPluginId() : NULL;
  $key = $t ? $t->getSetting("api_key") : NULL;
  $ok = ($plugin === "google" && !empty($key));
  print ($ok ? "PASS" : "FAIL") . " plugin=" . var_export($plugin, TRUE) . " api_key=" . var_export($key, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
