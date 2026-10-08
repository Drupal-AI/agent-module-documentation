#!/usr/bin/env bash
# Execution CLEANUP for bp_webform "embed a webform in a page": remove the task node, the
# field_bpwf_slot field and the bpwf_task_form webform created by the reset. Leaves the
# shipped bp_webform paragraph type untouched. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html

drush php:eval '
  use Drupal\node\Entity\Node;
  $ids = \Drupal::entityQuery("node")->accessCheck(FALSE)
    ->condition("title", "BP Webform Task")->execute();
  if ($ids) { \Drupal::entityTypeManager()->getStorage("node")->delete(Node::loadMultiple($ids)); }
' >/dev/null 2>&1

drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if ($fc = FieldConfig::loadByName("node", "article", "field_bpwf_slot")) { $fc->delete(); }
  if ($fs = FieldStorageConfig::loadByName("node", "field_bpwf_slot")) { $fs->delete(); }
' >/dev/null 2>&1

drush php:eval '
  use Drupal\webform\Entity\Webform;
  if ($w = Webform::load("bpwf_task_form")) { $w->delete(); }
' >/dev/null 2>&1

drush cr >/dev/null 2>&1
echo "cleanup: BP Webform Task node, field_bpwf_slot and webform bpwf_task_form removed"
