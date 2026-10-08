#!/usr/bin/env bash
# Execution VERIFY: PASS when role ps_secrets_manager exists and holds the
# 'sync pantheon_secrets keys' permission. exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $r = \Drupal\user\Entity\Role::load("ps_secrets_manager");
  $ok = $r && $r->hasPermission("sync pantheon_secrets keys");
  print ($ok ? "PASS" : "FAIL") . " role=" . ($r ? "present" : "missing")
    . " perms=" . ($r ? implode("|", $r->getPermissions()) : "-") . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
