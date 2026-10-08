#!/usr/bin/env bash
# HARD reset: remove any classy_paragraphs class field from the Article content type so the
# "add a style-class field to Article" task starts empty (verify must FAIL beforehand).
# Deletes every entity_reference field on node.article whose target_type is
# classy_paragraphs_style (and its storage). Idempotent.
# SPDX-License-Identifier: GPL-2.0-or-later
set -uo pipefail
cd /var/www/html
drush php:eval '
  $efm = \Drupal::service("entity_field.manager");
  foreach ($efm->getFieldDefinitions("node", "article") as $name => $def) {
    if (!($def instanceof \Drupal\field\FieldConfigInterface)) { continue; }
    $st = $def->getFieldStorageDefinition();
    if ($st->getSetting("target_type") === "classy_paragraphs_style") {
      $def->delete();
      if ($sc = \Drupal\field\Entity\FieldStorageConfig::loadByName("node", $name)) { $sc->delete(); }
    }
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: classy_paragraphs class fields removed from node.article"
