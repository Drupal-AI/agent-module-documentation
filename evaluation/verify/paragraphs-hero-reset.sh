#!/usr/bin/env bash
# Reset the "field_eval_hero on Basic page" execution task to a clean slate between runs.
# Ensures the target exists and clears what the task creates:
#   - guarantees the 'page' (Basic page) content type exists (task target precondition)
#   - removes the node.page reference field field_eval_hero (field config + storage)
# then rebuilds caches. Safe to run repeatedly (create/delete are guarded).
set -uo pipefail
cd /var/www/html
drush php:eval '
  $efm = \Drupal::entityTypeManager();
  // Precondition: the Basic page content type must exist for the field to attach to.
  if (!$efm->getStorage("node_type")->load("page")) {
    $efm->getStorage("node_type")->create(["type" => "page", "name" => "Basic page"])->save();
  }
  // Clear the field the task under test would create.
  if ($fc = \Drupal\field\Entity\FieldConfig::loadByName("node", "page", "field_eval_hero")) { $fc->delete(); }
  if ($fs = \Drupal\field\Entity\FieldStorageConfig::loadByName("node", "field_eval_hero")) { $fs->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: page content type ensured; node.page field_eval_hero removed"
