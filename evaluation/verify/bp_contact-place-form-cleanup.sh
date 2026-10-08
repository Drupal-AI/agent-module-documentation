#!/usr/bin/env bash
# Execution CLEANUP (bp_contact): remove the bpcontact_place bundle, its field, its paragraphs
# and both contact forms created by reset. Restores baseline. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\contact\Entity\ContactForm;
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  use Drupal\paragraphs\Entity\Paragraph;
  use Drupal\paragraphs\Entity\ParagraphsType;
  $pids = \Drupal::entityQuery("paragraph")->accessCheck(FALSE)->condition("type", "bpcontact_place")->execute();
  if ($pids) { \Drupal::entityTypeManager()->getStorage("paragraph")->delete(Paragraph::loadMultiple($pids)); }
  if ($fc = FieldConfig::loadByName("paragraph", "bpcontact_place", "field_bpcontact_place")) { $fc->delete(); }
  if ($fs = FieldStorageConfig::loadByName("paragraph", "field_bpcontact_place")) { $fs->delete(); }
  if ($t = ParagraphsType::load("bpcontact_place")) { $t->delete(); }
  foreach (["bpcontact_support", "bpcontact_sales"] as $id) {
    if ($cf = ContactForm::load($id)) { $cf->delete(); }
  }
' >/dev/null 2>&1
drush php:eval 'field_purge_batch(200);' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: bpcontact_place bundle, its field and both eval contact forms removed"
