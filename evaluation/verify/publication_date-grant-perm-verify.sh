#!/usr/bin/env bash
# Live-state verification for the "grant pd_evaluator the Published on date permission" task.
# Prints PASS/FAIL and exits 0 (pass) / 1 (fail). No arguments.
# PASS when the pd_evaluator role holds a permission that lets it edit the Published on date
# for any content type: either the global 'set any published on date' or the per-type
# 'set article published on date'.
set -uo pipefail
cd /var/www/html

out=$(drush php:eval '
  $ok = FALSE; $perms = [];
  if ($r = \Drupal\user\Entity\Role::load("pd_evaluator")) {
    $perms = $r->getPermissions();
    $ok = in_array("set any published on date", $perms, TRUE)
       || in_array("set article published on date", $perms, TRUE)
       || in_array("administer publication date", $perms, TRUE);
  }
  print ($ok ? "PASS" : "FAIL") . " perms=[" . implode(",", $perms) . "]\n";
' 2>/dev/null)

echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
