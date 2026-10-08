#!/usr/bin/env bash
# Live-state verification for the "field_eval_hero on Basic page" Paragraphs task.
# Prints PASS/FAIL with detail and exits 0 (pass) / 1 (fail). No arguments.
# Two independent checks against real site config:
#   fld — node.page has a field field_eval_hero
#   err — that field's type is entity_reference_revisions targeting paragraph
set -uo pipefail
cd /var/www/html

out=$(drush php:eval '
  $fld = FALSE; $err = FALSE; $detail = "";
  if ($fc = \Drupal\field\Entity\FieldConfig::loadByName("node", "page", "field_eval_hero")) {
    $fld = TRUE;
    if ($fc->getType() === "entity_reference_revisions") {
      $target = (string) $fc->getSetting("target_type");
      $handler = (string) $fc->getSetting("handler");
      $storTarget = "";
      if ($fs = \Drupal\field\Entity\FieldStorageConfig::loadByName("node", "field_eval_hero")) {
        $storTarget = (string) $fs->getSetting("target_type");
      }
      if ($target === "paragraph" || $storTarget === "paragraph" || stripos($handler, "paragraph") !== FALSE) {
        $err = TRUE;
      }
      $detail = "type=" . $fc->getType() . " target=" . $target . " handler=" . $handler;
    }
    else { $detail = "type=" . $fc->getType(); }
  }
  $ok = $fld && $err;
  print ($ok ? "PASS" : "FAIL") . " fld=" . ($fld?1:0) . " err=" . ($err?1:0) . " " . $detail . "\n";
' 2>/dev/null)

echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
