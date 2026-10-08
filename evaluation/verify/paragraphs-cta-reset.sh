#!/usr/bin/env bash
# Reset the "eval_cta paragraph type" execution task to a clean slate between runs.
# Removes anything the task under test would create:
#   - the eval_cta paragraph type and its fields field_cta_link + field_cta_label
#     (field config + storage), then rebuilds caches.
# Safe to run when nothing exists (every delete is guarded).
set -uo pipefail
cd /var/www/html
drush php:eval '
  $efm = \Drupal::entityTypeManager();
  foreach (["field_cta_link", "field_cta_label"] as $f) {
    if ($fc = \Drupal\field\Entity\FieldConfig::loadByName("paragraph", "eval_cta", $f)) { $fc->delete(); }
    if ($fs = \Drupal\field\Entity\FieldStorageConfig::loadByName("paragraph", $f)) { $fs->delete(); }
  }
  if ($pt = $efm->getStorage("paragraphs_type")->load("eval_cta")) { $pt->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: eval_cta paragraph type + field_cta_link + field_cta_label removed"
