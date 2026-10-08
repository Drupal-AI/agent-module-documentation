#!/usr/bin/env bash
# Introspection CLEANUP (medium tier) — restores baseline after the agent inspected the
# known config installed by paragraphs_asymmetric-introspect-setup.sh. Removes the form
# display component and the node.article field_asym_para (field config + storage).
# Idempotent: every delete is guarded, safe when nothing exists.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $fd = \Drupal::service("entity_display.repository")->getFormDisplay("node", "article", "default");
  if ($fd && $fd->getComponent("field_asym_para")) { $fd->removeComponent("field_asym_para")->save(); }
  if ($fc = \Drupal\field\Entity\FieldConfig::loadByName("node", "article", "field_asym_para")) { $fc->delete(); }
  if ($fs = \Drupal\field\Entity\FieldStorageConfig::loadByName("node", "field_asym_para")) { $fs->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: node.article field_asym_para + its form display component removed"
