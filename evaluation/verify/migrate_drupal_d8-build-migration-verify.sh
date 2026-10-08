#!/usr/bin/env bash
# Execution VERIFY: PASS when a migration mdd8_task exists whose source plugin is d8_entity and
# source entity_type is node. exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\migrate_plus\Entity\Migration;
  $m = Migration::load("mdd8_task");
  $s = $m ? $m->get("source") : [];
  $ok = $m && (($s["plugin"] ?? "") === "d8_entity") && (($s["entity_type"] ?? "") === "node");
  print ($ok ? "PASS" : "FAIL")." plugin=".($s["plugin"] ?? "none")." entity_type=".($s["entity_type"] ?? "none")."\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
