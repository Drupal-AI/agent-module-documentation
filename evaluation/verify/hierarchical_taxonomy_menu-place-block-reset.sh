#!/usr/bin/env bash
# Execution RESET: remove any Hierarchical Taxonomy Menu block built from the 'tags' vocabulary
# (and our htm_new id), so verify FAILS until the agent places one for the tags vocabulary.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\block\Entity\Block;
  foreach (\Drupal::entityTypeManager()->getStorage("block")->loadMultiple() as $b) {
    if ($b->getPluginId() === "hierarchical_taxonomy_menu" && (($b->get("settings")["vocabulary"] ?? "") === "tags")) { $b->delete(); }
  }
  if ($b = Block::load("htm_new")) { $b->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: no Hierarchical Taxonomy Menu block for the tags vocabulary"
