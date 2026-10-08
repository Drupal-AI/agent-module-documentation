#!/usr/bin/env bash
# Live-state verification for the "add a classy-paragraphs style field to Article" task.
# PASS if the Article (node.article) bundle has at least one field whose storage is an
# entity_reference targeting classy_paragraphs_style. Exit 0 = pass, 1 = fail. No arguments.
# SPDX-License-Identifier: GPL-2.0-or-later
set -uo pipefail
cd /var/www/html

out=$(drush php:eval '
  $ok = FALSE; $hit = "";
  $efm = \Drupal::service("entity_field.manager");
  foreach ($efm->getFieldDefinitions("node", "article") as $name => $def) {
    if (!($def instanceof \Drupal\field\FieldConfigInterface)) { continue; }
    $st = $def->getFieldStorageDefinition();
    if ($st->getType() === "entity_reference" && $st->getSetting("target_type") === "classy_paragraphs_style") {
      $ok = TRUE; $hit = $name;
    }
  }
  print ($ok ? "PASS" : "FAIL") . " field=" . ($hit ?: "-") . "\n";
' 2>/dev/null)

echo "$out"
echo "$out" | grep -q "^PASS" && exit 0 || exit 1
