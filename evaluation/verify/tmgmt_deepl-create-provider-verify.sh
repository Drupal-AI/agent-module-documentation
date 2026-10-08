#!/usr/bin/env bash
# Execution VERIFY: PASS when a tmgmt translator tdeepl_task exists using the deepl_free plugin.
# Read-only. Prints PASS/FAIL. exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\tmgmt\Entity\Translator;
  $t = Translator::load("tdeepl_task");
  $plugin = $t ? $t->getPluginId() : "none";
  $ok = ($t && $plugin === "deepl_free");
  print ($ok ? "PASS" : "FAIL") . " plugin=" . $plugin . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
