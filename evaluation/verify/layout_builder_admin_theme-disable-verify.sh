#!/usr/bin/env bash
# Execution VERIFY for "disable the admin theme for Layout Builder".
# PASS when layout_builder_admin_theme.config:lbat_enable_admin_theme reads as OFF.
# Type-robust: a correct agent may untick the checkbox (int 0), use configFactory
# (bool FALSE), or `drush config:set ... false` (which, with no config schema, stores the
# STRING "false"). All of those, plus 0/"0"/""/NULL, count as OFF; on values
# (TRUE/1/"1"/"true") do not. Prints PASS/FAIL; exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $v = \Drupal::config("layout_builder_admin_theme.config")->get("lbat_enable_admin_theme");
  $s = is_bool($v) ? ($v ? "true" : "false") : strtolower((string) $v);
  $off = in_array($s, ["", "0", "false"], TRUE);
  print ($off ? "PASS" : "FAIL") . " lbat_enable_admin_theme=" . var_export($v, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
