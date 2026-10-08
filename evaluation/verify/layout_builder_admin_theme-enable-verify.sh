#!/usr/bin/env bash
# Execution VERIFY for "enable the admin theme for Layout Builder".
# PASS when layout_builder_admin_theme.config:lbat_enable_admin_theme reads as ON.
# Type-robust: a correct agent may set it via the checkbox (int 1), configFactory
# (bool TRUE), or `drush config:set ... true` (which, with no config schema, stores the
# STRING "true"). All of those count as ON; off/unset values (FALSE/0/"0"/""/"false"/NULL)
# do not. Prints PASS/FAIL; exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $v = \Drupal::config("layout_builder_admin_theme.config")->get("lbat_enable_admin_theme");
  $s = is_bool($v) ? ($v ? "true" : "false") : strtolower((string) $v);
  $on = in_array($s, ["1", "true"], TRUE);
  print ($on ? "PASS" : "FAIL") . " lbat_enable_admin_theme=" . var_export($v, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
