#!/usr/bin/env bash
# Execution VERIFY: PASS when a user account named lm_bulk_user exists, is active, holds the
# lm_bulk_team role, and the access manager grants that account access to the
# lightning_media.bulk_upload route (/admin/content/media/bulk-upload).
# exit 0 = pass, 1 = fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $users = \Drupal::entityTypeManager()->getStorage("user")->loadByProperties(["name" => "lm_bulk_user"]);
  $user = $users ? reset($users) : NULL;
  $access = FALSE;
  if ($user) {
    $access = \Drupal::service("access_manager")->checkNamedRoute("lightning_media.bulk_upload", [], $user);
  }
  $checks = [
    "user_exists" => (bool) $user,
    "active" => $user && $user->isActive(),
    "has_role" => $user && in_array("lm_bulk_team", $user->getRoles(), TRUE),
    "route_access" => (bool) $access,
  ];
  $bad = array_keys(array_filter($checks, fn ($v) => !$v));
  print ($bad ? "FAIL wrong=" . implode(",", $bad) : "PASS")
    . " roles=" . json_encode($user ? $user->getRoles() : NULL)
    . " access=" . var_export((bool) $access, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
