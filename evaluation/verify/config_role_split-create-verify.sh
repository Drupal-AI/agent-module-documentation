#!/usr/bin/env bash
# Execution VERIFY: PASS when role_split crs_task exists, is active, mode=split, and manages the
# 'access content' permission on the authenticated role. exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $e = \Drupal::entityTypeManager()->getStorage("role_split")->load("crs_task");
  if (!$e) { print "FAIL missing\n"; return; }
  $mode = $e->get("mode"); $status = (bool) $e->get("status"); $roles = $e->get("roles") ?: [];
  $perms = $roles["authenticated"] ?? [];
  $ok = ($mode === "split" && $status && in_array("access content", $perms, TRUE));
  print ($ok ? "PASS" : "FAIL") . " mode=" . var_export($mode, TRUE) . " status=" . var_export($status, TRUE) . " authperms=" . implode("|", $perms) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
