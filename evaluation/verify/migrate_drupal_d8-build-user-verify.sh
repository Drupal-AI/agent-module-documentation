#!/usr/bin/env bash
# PASS when migration mdd8_users has source plugin d8_entity and entity_type user. exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\migrate_plus\Entity\Migration;
  $m = Migration::load("mdd8_users"); $s = $m ? $m->get("source") : [];
  $ok = $m && (($s["plugin"] ?? "") === "d8_entity") && (($s["entity_type"] ?? "") === "user");
  print ($ok ? "PASS" : "FAIL")." plugin=".($s["plugin"] ?? "none")." entity_type=".($s["entity_type"] ?? "none")."\n";
' 2>/dev/null)
echo "$out"; echo "$out" | grep -q '^PASS' && exit 0 || exit 1
