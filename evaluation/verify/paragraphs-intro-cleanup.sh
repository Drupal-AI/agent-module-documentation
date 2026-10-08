#!/usr/bin/env bash
# Introspection CLEANUP (medium tier) — restores baseline after the agent has inspected
# the known config installed by paragraphs-intro-setup.sh. Removes:
#   - node.article field  field_intro_sections  (field config + storage)
#   - paragraph type  eval_intro_pt  and its field  field_intro_body  (config + storage)
# Idempotent: every delete is guarded, so it is safe when nothing exists.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $efm = \Drupal::entityTypeManager();
  if ($fc = \Drupal\field\Entity\FieldConfig::loadByName("node", "article", "field_intro_sections")) { $fc->delete(); }
  if ($fs = \Drupal\field\Entity\FieldStorageConfig::loadByName("node", "field_intro_sections")) { $fs->delete(); }
  if ($fc = \Drupal\field\Entity\FieldConfig::loadByName("paragraph", "eval_intro_pt", "field_intro_body")) { $fc->delete(); }
  if ($fs = \Drupal\field\Entity\FieldStorageConfig::loadByName("paragraph", "field_intro_body")) { $fs->delete(); }
  if ($pt = $efm->getStorage("paragraphs_type")->load("eval_intro_pt")) { $pt->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: eval_intro_pt + field_intro_body + field_intro_sections removed"
