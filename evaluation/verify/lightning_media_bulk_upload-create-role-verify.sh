#!/usr/bin/env bash
# Execution VERIFY: PASS when a role lm_bulk_editor exists holding BOTH permissions required by
# the lightning_media.bulk_upload route - 'dropzone upload files' and 'create media'.
# exit 0 = pass, 1 = fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $role = \Drupal::entityTypeManager()->getStorage("user_role")->load("lm_bulk_editor");
  $checks = [
    "role_exists" => (bool) $role,
    "dropzone_permission" => $role && $role->hasPermission("dropzone upload files"),
    "create_media_permission" => $role && $role->hasPermission("create media"),
  ];
  $bad = array_keys(array_filter($checks, fn ($v) => !$v));
  print ($bad ? "FAIL wrong=" . implode(",", $bad) : "PASS")
    . " permissions=" . json_encode($role ? $role->getPermissions() : NULL) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
