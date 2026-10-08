#!/usr/bin/env bash
# Live-state verification for "add an entity_reference_display field to the Article type".
# Prints PASS/FAIL with detail and exits 0 (pass) / 1 (fail). No arguments.
# Checks node.article.field_display_mode:
#   sto — field storage exists with field type exactly "entity_reference_display"
#   cfg — a field config (instance) of that storage exists on the article bundle
set -uo pipefail
cd /var/www/html

out=$(drush php:eval '
  $sto = FALSE; $cfg = FALSE; $type = "";
  $fs = \Drupal\field\Entity\FieldStorageConfig::loadByName("node", "field_display_mode");
  if ($fs) { $type = $fs->getType(); $sto = ($type === "entity_reference_display"); }
  $fc = \Drupal\field\Entity\FieldConfig::loadByName("node", "article", "field_display_mode");
  if ($fc && $fc->getType() === "entity_reference_display") { $cfg = TRUE; }
  $ok = $sto && $cfg;
  print ($ok ? "PASS" : "FAIL") . " sto=" . ($sto?1:0) . " cfg=" . ($cfg?1:0) . " type=" . $type . "\n";
' 2>/dev/null)

echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
