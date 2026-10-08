#!/usr/bin/env bash
# Reset the "add a yearonly vintage field to the Basic page type" execution task to a clean
# slate. Removes what the task creates: the node.page `field_eval_vintage` field
# (config + storage). The Basic page (page) content type ships with standard installs, so no
# precondition create is needed. Idempotent (deletes are guarded). Rebuilds caches. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  if ($fc = \Drupal\field\Entity\FieldConfig::loadByName("node", "page", "field_eval_vintage")) { $fc->delete(); }
  if ($fs = \Drupal\field\Entity\FieldStorageConfig::loadByName("node", "field_eval_vintage")) { $fs->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: node.page field_eval_vintage removed"
