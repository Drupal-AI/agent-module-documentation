#!/usr/bin/env bash
# Execution VERIFY (bp_card): PASS when Article has field_bpcard_deck, an unlimited
# entity_reference_revisions field targeting paragraphs whose target_bundles include bp_card.
# exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\field\Entity\FieldConfig;
  $fc = FieldConfig::loadByName("node", "article", "field_bpcard_deck");
  $type = $fc ? $fc->getType() : "none";
  $sd = $fc ? $fc->getFieldStorageDefinition() : NULL;
  $target = $sd ? ($sd->getSetting("target_type") ?? "none") : "none";
  $card = $sd ? $sd->getCardinality() : 0;
  $bundles = ($fc && is_array($fc->getSetting("handler_settings")["target_bundles"] ?? NULL))
    ? array_keys($fc->getSetting("handler_settings")["target_bundles"]) : [];
  $ok = $fc && $type === "entity_reference_revisions" && $target === "paragraph"
        && $card === -1 && in_array("bp_card", $bundles, TRUE);
  print ($ok ? "PASS" : "FAIL") . " type=" . $type . " target=" . $target . " cardinality=" . $card . " bundles=" . (implode(",", $bundles) ?: "none") . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
