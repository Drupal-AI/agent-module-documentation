#!/usr/bin/env bash
# Introspection CLEANUP for bp_webform: delete the eval node and its Webform paragraph, the
# field_bpwf_form field and the bpwf_eval_contact webform created by the matching setup.
# Leaves the shipped bp_webform paragraph type untouched. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html

drush php:eval '
  use Drupal\node\Entity\Node;
  $ids = \Drupal::entityQuery("node")->accessCheck(FALSE)
    ->condition("title", "BP Webform Eval Node")->execute();
  if ($ids) { \Drupal::entityTypeManager()->getStorage("node")->delete(Node::loadMultiple($ids)); }
' >/dev/null 2>&1

drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if ($fc = FieldConfig::loadByName("node", "article", "field_bpwf_form")) { $fc->delete(); }
  if ($fs = FieldStorageConfig::loadByName("node", "field_bpwf_form")) { $fs->delete(); }
' >/dev/null 2>&1

drush php:eval '
  use Drupal\webform\Entity\Webform;
  if ($w = Webform::load("bpwf_eval_contact")) { $w->delete(); }
' >/dev/null 2>&1

drush cr >/dev/null 2>&1
echo "cleanup: BP Webform Eval Node, field_bpwf_form and webform bpwf_eval_contact removed"
