#!/usr/bin/env bash
# Execution VERIFY: PASS when role wtp_owner exists, holds 'translate own webform', and does NOT
# hold 'translate any webform' or 'translate configuration'. Prints PASS/FAIL; exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\user\Entity\Role;
  $r = Role::load("wtp_owner");
  $own = $r && $r->hasPermission("translate own webform");
  $no_any = $r && !$r->hasPermission("translate any webform");
  $no_conf = $r && !$r->hasPermission("translate configuration");
  $ok = $own && $no_any && $no_conf;
  print ($ok ? "PASS" : "FAIL") . " exists=" . ($r ? "yes" : "no") . " own=" . ($own ? "1" : "0") . " any=" . (($r && $r->hasPermission("translate any webform")) ? "1" : "0") . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
