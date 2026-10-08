#!/usr/bin/env bash
# Execution VERIFY: PASS when role wtp_translator exists, holds 'translate any webform', and does
# NOT hold 'translate configuration'. Prints PASS/FAIL; exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\user\Entity\Role;
  $r = Role::load("wtp_translator");
  $any = $r && $r->hasPermission("translate any webform");
  $noconf = $r && !$r->hasPermission("translate configuration");
  $ok = $any && $noconf;
  print ($ok ? "PASS" : "FAIL") . " exists=" . ($r ? "yes" : "no") . " any=" . ($any ? "1" : "0") . " has_translate_configuration=" . (($r && $r->hasPermission("translate configuration")) ? "1" : "0") . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
