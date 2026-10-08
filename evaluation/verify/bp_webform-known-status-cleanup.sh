#!/usr/bin/env bash
# Introspection CLEANUP for bp_webform: delete the status eval node and its paragraph, the
# field_bpwf_gate field and the bpwf_status_form webform created by the matching setup.
# Leaves the shipped bp_webform paragraph type untouched. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html

drush php:eval '
  use Drupal\node\Entity\Node;
  $ids = \Drupal::entityQuery("node")->accessCheck(FALSE)
    ->condition("title", "BP Webform Status Node")->execute();
  if ($ids) { \Drupal::entityTypeManager()->getStorage("node")->delete(Node::loadMultiple($ids)); }
' >/dev/null 2>&1

drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if ($fc = FieldConfig::loadByName("node", "article", "field_bpwf_gate")) { $fc->delete(); }
  if ($fs = FieldStorageConfig::loadByName("node", "field_bpwf_gate")) { $fs->delete(); }
' >/dev/null 2>&1

drush php:eval '
  use Drupal\webform\Entity\Webform;
  if ($w = Webform::load("bpwf_status_form")) { $w->delete(); }
' >/dev/null 2>&1

drush cr >/dev/null 2>&1
echo "cleanup: BP Webform Status Node, field_bpwf_gate and webform bpwf_status_form removed"
