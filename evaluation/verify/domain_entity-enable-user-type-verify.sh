#!/usr/bin/env bash
# Execution VERIFY: PASS when the user entity type has domain access enabled (domain_access
# field storage exists). exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $m = \Drupal::service("domain_entity.mapper");
  $ok = (bool) $m->loadFieldStorage("user") && isset($m->getEnabledEntityTypes()["user"]);
  print $ok ? "PASS" : "FAIL";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
