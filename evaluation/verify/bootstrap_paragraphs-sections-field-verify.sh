#!/usr/bin/env bash
# Execution VERIFY for "attach a Bootstrap Paragraphs sections field to Article".
# PASS when node.article has a field field_bp_task_sections that is:
#   - storage type entity_reference_revisions, target_type paragraph, cardinality -1 (unlimited)
#   - handler_settings.target_bundles == exactly {bp_simple, bp_image, bp_columns}
#   - present on core.entity_form_display.node.article.default with a paragraphs widget
# Prints PASS/FAIL; exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;

  $fs = FieldStorageConfig::loadByName("node", "field_bp_task_sections");
  $fc = FieldConfig::loadByName("node", "article", "field_bp_task_sections");
  if (!$fs || !$fc) {
    print "FAIL field missing (storage=" . ($fs ? "yes" : "no") . " instance=" . ($fc ? "yes" : "no") . ")\n";
    return;
  }
  $type = $fs->getType();
  $target = $fs->getSetting("target_type");
  $card = $fs->getCardinality();

  $bundles = $fc->getSetting("handler_settings")["target_bundles"] ?? [];
  $got = array_values($bundles);
  sort($got);
  $want = ["bp_columns", "bp_image", "bp_simple"];

  $fd = \Drupal::entityTypeManager()->getStorage("entity_form_display")->load("node.article.default");
  $comp = $fd ? $fd->getComponent("field_bp_task_sections") : NULL;
  $widget = $comp["type"] ?? "none";
  $widget_ok = in_array($widget, ["entity_reference_paragraphs", "paragraphs"], TRUE);

  $ok = ($type === "entity_reference_revisions")
    && ($target === "paragraph")
    && ((int) $card === -1)
    && ($got === $want)
    && $widget_ok;

  print ($ok ? "PASS" : "FAIL")
    . " type=" . $type
    . " target=" . $target
    . " cardinality=" . $card
    . " bundles=[" . implode(",", $got) . "]"
    . " widget=" . $widget . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
