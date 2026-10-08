#!/usr/bin/env bash
# Execution VERIFY: PASS when the active theme's settings enable devel + live reload and set
# live_reload_port to 9000 (the keys at_tool reads). Prints PASS/FAIL; exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $t = \Drupal::config("system.theme")->get("default");
  $s = \Drupal::config("$t.settings")->get("settings") ?? [];
  $devel = $s["enable_devel"] ?? NULL;
  $lr = $s["enable_live_reload"] ?? NULL;
  $port = (string) ($s["live_reload_port"] ?? "");
  $ok = ((bool) $devel) && ((bool) $lr) && ($port === "9000");
  print ($ok ? "PASS" : "FAIL") . " theme=" . $t . " enable_devel=" . var_export($devel, TRUE) . " enable_live_reload=" . var_export($lr, TRUE) . " port=" . $port . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
