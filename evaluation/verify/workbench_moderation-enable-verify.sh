#!/usr/bin/env bash
# Execution VERIFY: PASS when workbench moderation is enabled on the Article node type. exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $t = \Drupal::entityTypeManager()->getStorage("node_type")->load("article");
  $en = $t->getThirdPartySetting("workbench_moderation","enabled",FALSE);
  $def = $t->getThirdPartySetting("workbench_moderation","default_moderation_state","");
  $ok = ($en === TRUE);
  print ($ok ? "PASS" : "FAIL") . " enabled=" . var_export($en, TRUE) . " default=" . $def . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
