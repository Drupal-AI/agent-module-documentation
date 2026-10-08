#!/usr/bin/env bash
# Reset the "field_eval_address on Article" execution task to a clean slate between runs.
# Removes what the task creates: the node.article `address` field (field config + storage).
# The Article content type ships with standard installs, so no precondition create is needed.
# Then rebuilds caches. Safe to run repeatedly (deletes are guarded). Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  // Clear the field the task under test would create.
  if ($fc = \Drupal\field\Entity\FieldConfig::loadByName("node", "article", "field_eval_address")) { $fc->delete(); }
  if ($fs = \Drupal\field\Entity\FieldStorageConfig::loadByName("node", "field_eval_address")) { $fs->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: node.article field_eval_address removed"
