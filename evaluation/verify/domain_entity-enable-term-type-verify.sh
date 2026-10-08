#!/usr/bin/env bash
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $m = \Drupal::service("domain_entity.mapper");
  $ok = (bool) $m->loadFieldStorage("taxonomy_term") && isset($m->getEnabledEntityTypes()["taxonomy_term"]);
  print $ok ? "PASS" : "FAIL";
' 2>/dev/null)
echo "$out"; echo "$out" | grep -q '^PASS' && exit 0 || exit 1
