#!/usr/bin/env bash
# Live-state verification for the "create an Instagram-backed media type" task.
# Prints PASS/FAIL with detail and exits 0 (pass) / 1 (fail). No arguments.
# Config-level checks only (live Instagram fetching needs network + credentials — out of
# scope). Three independent checks against real site config:
#   typ  — a media type `ig_eval` exists
#   src  — its source plugin id is `oembed:instagram`
#   fld  — it has a source field of an allowed type (string or link)
set -uo pipefail
cd /var/www/html

out=$(drush php:eval '
  use Drupal\media\Entity\MediaType;
  $typ = FALSE; $src = FALSE; $fld = FALSE; $detail = "";
  if ($t = MediaType::load("ig_eval")) {
    $typ = TRUE;
    $pid = (string) $t->getSource()->getPluginId();
    if ($pid === "oembed:instagram") { $src = TRUE; }
    $fieldName = $t->getSource()->getSourceFieldDefinition($t) ? $t->getSource()->getSourceFieldDefinition($t)->getName() : "";
    $fieldType = "";
    if ($fieldName && $fc = \Drupal\field\Entity\FieldConfig::loadByName("media", "ig_eval", $fieldName)) {
      $fieldType = (string) $fc->getType();
      if (in_array($fieldType, ["string", "link"], TRUE)) { $fld = TRUE; }
    }
    $detail = "source=" . $pid . " field=" . $fieldName . " field_type=" . $fieldType;
  }
  $ok = $typ && $src && $fld;
  print ($ok ? "PASS" : "FAIL") . " typ=" . ($typ?1:0) . " src=" . ($src?1:0) . " fld=" . ($fld?1:0) . " " . $detail . "\n";
' 2>/dev/null)

echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
