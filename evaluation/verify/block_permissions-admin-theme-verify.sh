#!/usr/bin/env bash
# Execution VERIFY: PASS when role bp_claro_role can administer blocks on the claro theme and
# only blocks provided by the user module, and does NOT have the olivero theme permission.
# exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $r = \Drupal\user\Entity\Role::load("bp_claro_role");
  if (!$r) { print "FAIL role-missing\n"; return; }
  $claro = $r->hasPermission("administer block settings for theme claro");
  $user_provider = $r->hasPermission("administer blocks provided by user");
  $no_olivero = !$r->hasPermission("administer block settings for theme olivero");
  $other_providers = 0;
  foreach ($r->getPermissions() as $p) {
    if (str_starts_with($p, "administer blocks provided by ") && $p !== "administer blocks provided by user") { $other_providers++; }
  }
  $ok = $claro && $user_provider && $no_olivero && $other_providers === 0;
  print ($ok ? "PASS" : "FAIL") . " claro=" . var_export($claro, TRUE)
    . " provider_user=" . var_export($user_provider, TRUE)
    . " olivero_absent=" . var_export($no_olivero, TRUE)
    . " extra_providers=" . $other_providers . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
