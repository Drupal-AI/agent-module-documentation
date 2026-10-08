#!/usr/bin/env bash
# HARD verify: PASS iff the entity-type JSON key is "contentType" AND the
# site-name JSON key is "siteTitle" in live datalayer.settings. Exits 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $c = \Drupal::config("datalayer.settings");
  $et = $c->get("entity_type"); $sn = $c->get("site_name");
  $ok = ($et === "contentType" && $sn === "siteTitle") ? 1 : 0;
  print "MARK " . ($ok ? "PASS" : "FAIL") . " entity_type=$et site_name=$sn MARK";
' 2>/dev/null | grep -oE 'MARK .* MARK')
out=${out#MARK }; out=${out% MARK}
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
