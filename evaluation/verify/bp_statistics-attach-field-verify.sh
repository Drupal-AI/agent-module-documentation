#!/usr/bin/env bash
# Execution VERIFY for bp_statistics "attach a Statistics-only Paragraphs field to Article".
# PASS when node.article has field_bpstat_panel with:
#   - storage type entity_reference_revisions, target_type paragraph, cardinality 1
#   - handler_settings.target_bundles === exactly [bp_statistics]  (the OUTER bundle only —
#     bp_stat is reached through the bundle's own bp_statistic field, never directly)
# Prints PASS/FAIL; exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  $fs = FieldStorageConfig::loadByName("node", "field_bpstat_panel");
  $fc = FieldConfig::loadByName("node", "article", "field_bpstat_panel");
  $type = $fs ? $fs->getType() : "none";
  $target = $fs ? ($fs->getSetting("target_type") ?? "none") : "none";
  $card = $fs ? $fs->getCardinality() : 0;
  $bundles = [];
  if ($fc) {
    $hs = $fc->getSetting("handler_settings") ?: [];
    $bundles = array_values($hs["target_bundles"] ?? []);
    sort($bundles);
  }
  $ok = $fs && $fc
    && $type === "entity_reference_revisions"
    && $target === "paragraph"
    && (int) $card === 1
    && $bundles === ["bp_statistics"];
  print ($ok ? "PASS" : "FAIL")
    . " type=" . $type . " target=" . $target . " cardinality=" . $card
    . " bundles=[" . implode(",", $bundles) . "]\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
