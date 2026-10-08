#!/usr/bin/env bash
# Execution VERIFY: PASS when the vfs_reset view's views_filters_summary area has
# show_reset_link === TRUE. Prints PASS/FAIL; exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\views\Entity\View;
  $v = View::load("vfs_reset");
  $val = NULL;
  if ($v) {
    $d = $v->get("display");
    $val = $d["default"]["display_options"]["footer"]["views_filters_summary"]["show_reset_link"] ?? NULL;
  }
  $ok = ($val === TRUE || $val === 1 || $val === "1");
  print ($ok ? "PASS" : "FAIL") . " show_reset_link=" . var_export($val, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
