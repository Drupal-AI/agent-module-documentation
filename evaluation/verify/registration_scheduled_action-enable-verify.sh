#!/usr/bin/env bash
# PASS when reg_sched_build exists with a datetime offset and a plugin set. exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $sa = \Drupal::entityTypeManager()->getStorage("registration_scheduled_action")->load("reg_sched_build");
  if (!$sa) { print "FAIL missing\n"; return; }
  $dt = $sa->get("datetime"); $plugin = $sa->get("plugin");
  $ok = is_array($dt) && !empty($dt["type"]) && isset($dt["length"]) && !empty($plugin);
  print (($ok)?"PASS":"FAIL")." plugin=".var_export($plugin,true)." datetime=".json_encode($dt)."\n";
' 2>/dev/null)
echo "$out"; echo "$out" | grep -q '^PASS' && exit 0 || exit 1
