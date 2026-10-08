#!/usr/bin/env bash
# Live-state verification for the "rich body sections for Articles" Paragraphs task.
# Prints PASS/FAIL with detail and exits 0 (pass) / 1 (fail). No arguments.
# Three independent checks against real site config:
#   pt  — a paragraphs_type 'eval_quote' exists AND carries a field_quote_text field
#   fld — node.article has a field field_eval_sections
#   err — that field's type is entity_reference_revisions targeting paragraph
set -uo pipefail
cd /var/www/html

out=$(drush php:eval '
  $pt = FALSE; $ptField = FALSE; $fld = FALSE; $err = FALSE; $detail = "";
  // Paragraph type + its formatted-text field.
  $type = \Drupal::entityTypeManager()->getStorage("paragraphs_type")->load("eval_quote");
  $pt = (bool) $type;
  if ($fc = \Drupal\field\Entity\FieldConfig::loadByName("paragraph", "eval_quote", "field_quote_text")) {
    $ptField = TRUE;
  }
  // Article host field must be entity_reference_revisions -> paragraph.
  if ($afc = \Drupal\field\Entity\FieldConfig::loadByName("node", "article", "field_eval_sections")) {
    $fld = TRUE;
    if ($afc->getType() === "entity_reference_revisions") {
      $target = $afc->getSetting("target_type");
      $handler = (string) $afc->getSetting("handler");
      $storTarget = "";
      if ($afs = \Drupal\field\Entity\FieldStorageConfig::loadByName("node", "field_eval_sections")) {
        $storTarget = (string) $afs->getSetting("target_type");
      }
      if ($target === "paragraph" || $storTarget === "paragraph" || stripos($handler, "paragraph") !== FALSE) {
        $err = TRUE;
      }
      $detail = "type=" . $afc->getType() . " target=" . $target . " handler=" . $handler;
    }
    else { $detail = "type=" . $afc->getType(); }
  }
  $ok = $pt && $ptField && $fld && $err;
  print ($ok ? "PASS" : "FAIL")
    . " pt=" . ($pt?1:0) . " pt_field=" . ($ptField?1:0)
    . " fld=" . ($fld?1:0) . " err=" . ($err?1:0)
    . " " . $detail . "\n";
' 2>/dev/null)

echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
