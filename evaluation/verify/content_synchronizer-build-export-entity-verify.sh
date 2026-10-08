#!/usr/bin/env bash
# Execution VERIFY: PASS when an export_entity named 'CS Deploy Set' exists AND its
# getEntitiesList() includes a node titled 'CS Deploy Node'. exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\content_synchronizer\Entity\ExportEntity;
  $found = NULL;
  foreach (ExportEntity::loadMultiple() as $e) { if ($e->getName() === "CS Deploy Set") { $found = $e; } }
  $ok = FALSE; $names = [];
  if ($found) {
    foreach ($found->getEntitiesList() as $ent) {
      if ($ent) { $names[] = method_exists($ent,"label") ? $ent->label() : ""; if ($ent->getEntityTypeId()==="node" && $ent->label()==="CS Deploy Node") { $ok = TRUE; } }
    }
  }
  print ($ok ? "PASS" : "FAIL") . " export=" . ($found?"yes":"no") . " members=" . implode("|",$names) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
