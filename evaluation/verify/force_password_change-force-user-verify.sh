#!/usr/bin/env bash
# Execution VERIFY: PASS when fpc_task@example.com has user.data force_password_change/pending_force
# truthy. exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $ex = \Drupal::entityTypeManager()->getStorage("user")->loadByProperties(["mail" => "fpc_task@example.com"]);
  $u = $ex ? reset($ex) : NULL;
  $p = $u ? \Drupal::service("user.data")->get("force_password_change", $u->id(), "pending_force") : NULL;
  print (($u && $p) ? "PASS" : "FAIL") . " user=" . ($u ? $u->id() : "none") . " pending_force=" . var_export($p, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
