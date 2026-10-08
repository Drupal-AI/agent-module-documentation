#!/usr/bin/env bash
# Reset the "weekly-only date_recur field on Article" execution task to a clean slate.
# Removes what the task creates: the node.article `field_eval_recur` field (config + storage).
# The Article content type ships with standard installs, so no precondition create is needed.
# Idempotent (deletes are guarded). Rebuilds caches. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  if ($fc = \Drupal\field\Entity\FieldConfig::loadByName("node", "article", "field_eval_recur")) { $fc->delete(); }
  if ($fs = \Drupal\field\Entity\FieldStorageConfig::loadByName("node", "field_eval_recur")) { $fs->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: node.article field_eval_recur removed"
