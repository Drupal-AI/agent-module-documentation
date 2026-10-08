#!/usr/bin/env bash
# Execution VERIFY: PASS when config_log ignores user.* config: the log_ignored_config list
# contains a "user.*" pattern and negate is off (so a match means "do not log"). exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $c = \Drupal::config("config_log.settings");
  $list = $c->get("log_ignored_config") ?: [];
  $negate = (bool) $c->get("log_ignored_config_negate");
  $ok = in_array("user.*", $list, TRUE) && $negate === FALSE;
  print ($ok ? "PASS" : "FAIL") . " list=" . json_encode($list) . " negate=" . var_export($negate, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
