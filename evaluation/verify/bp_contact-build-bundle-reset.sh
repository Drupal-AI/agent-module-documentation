#!/usr/bin/env bash
# Execution RESET (bp_contact): remove the paragraph bundle bpcontact_task and its contact_form
# reference field so the agent must recreate, on Drupal 11, the structure that bp_contact ships
# in config/install (bp_contact itself cannot be installed here: core_version_requirement
# ^8||^9||^10 plus the missing contrib module contact_formatter). verify FAILS here.
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  use Drupal\paragraphs\Entity\Paragraph;
  use Drupal\paragraphs\Entity\ParagraphsType;
  $pids = \Drupal::entityQuery("paragraph")->accessCheck(FALSE)->condition("type", "bpcontact_task")->execute();
  if ($pids) { \Drupal::entityTypeManager()->getStorage("paragraph")->delete(Paragraph::loadMultiple($pids)); }
  if ($fc = FieldConfig::loadByName("paragraph", "bpcontact_task", "field_bpcontact_task")) { $fc->delete(); }
  if ($fs = FieldStorageConfig::loadByName("paragraph", "field_bpcontact_task")) { $fs->delete(); }
  if ($t = ParagraphsType::load("bpcontact_task")) { $t->delete(); }
' >/dev/null 2>&1
drush php:eval 'field_purge_batch(200);' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: paragraph bundle bpcontact_task and field_bpcontact_task removed"
