#!/usr/bin/env bash
# Execution VERIFY (bp_callout): PASS when Article has a field_bpcallout_task field of type
# entity_reference_revisions targeting paragraphs whose handler_settings.target_bundles
# include bp_callout. exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\field\Entity\FieldConfig;
  $fc = FieldConfig::loadByName("node", "article", "field_bpcallout_task");
  $type = $fc ? $fc->getType() : "none";
  $target = $fc ? ($fc->getFieldStorageDefinition()->getSetting("target_type") ?? "none") : "none";
  $bundles = ($fc && is_array($fc->getSetting("handler_settings")["target_bundles"] ?? NULL))
    ? array_keys($fc->getSetting("handler_settings")["target_bundles"]) : [];
  $ok = $fc && $type === "entity_reference_revisions" && $target === "paragraph" && in_array("bp_callout", $bundles, TRUE);
  print ($ok ? "PASS" : "FAIL") . " type=" . $type . " target=" . $target . " bundles=" . (implode(",", $bundles) ?: "none") . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
