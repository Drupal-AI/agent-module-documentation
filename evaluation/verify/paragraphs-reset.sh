#!/usr/bin/env bash
# Reset the Paragraphs "rich body sections" state between eval runs so each condition
# starts from a clean slate. Removes anything the task under test would create:
#   - the node.article reference field field_eval_sections (field config + storage)
#   - the eval_quote paragraph type and its field_quote_text (field config + storage)
# then rebuilds caches. Safe to run when nothing exists (deletes are guarded).
set -uo pipefail
cd /var/www/html
drush php:eval '
  $efm = \Drupal::entityTypeManager();
  // Article reference field: delete field config then storage.
  if ($fc = \Drupal\field\Entity\FieldConfig::loadByName("node", "article", "field_eval_sections")) { $fc->delete(); }
  if ($fs = \Drupal\field\Entity\FieldStorageConfig::loadByName("node", "field_eval_sections")) { $fs->delete(); }
  // eval_quote paragraph type: delete its field (config + storage) then the bundle itself.
  if ($fc = \Drupal\field\Entity\FieldConfig::loadByName("paragraph", "eval_quote", "field_quote_text")) { $fc->delete(); }
  if ($fs = \Drupal\field\Entity\FieldStorageConfig::loadByName("paragraph", "field_quote_text")) { $fs->delete(); }
  if ($pt = $efm->getStorage("paragraphs_type")->load("eval_quote")) { $pt->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: field_eval_sections + eval_quote paragraph type removed"
