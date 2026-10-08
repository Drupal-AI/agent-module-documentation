#!/usr/bin/env bash
# Introspection CLEANUP (bp_contact): remove the bpcontact_eval paragraph bundle, its
# contact_form reference field and the bpcontact_eval_form contact form created by setup.
# Never touches the real bp_contact bundle (which is not installed on this site).
# Restores baseline. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\contact\Entity\ContactForm;
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  use Drupal\paragraphs\Entity\Paragraph;
  use Drupal\paragraphs\Entity\ParagraphsType;
  $pids = \Drupal::entityQuery("paragraph")->accessCheck(FALSE)->condition("type", "bpcontact_eval")->execute();
  if ($pids) { \Drupal::entityTypeManager()->getStorage("paragraph")->delete(Paragraph::loadMultiple($pids)); }
  if ($fc = FieldConfig::loadByName("paragraph", "bpcontact_eval", "field_bpcontact_form")) { $fc->delete(); }
  if ($fs = FieldStorageConfig::loadByName("paragraph", "field_bpcontact_form")) { $fs->delete(); }
  if ($t = ParagraphsType::load("bpcontact_eval")) { $t->delete(); }
  if ($cf = ContactForm::load("bpcontact_eval_form")) { $cf->delete(); }
' >/dev/null 2>&1
drush php:eval 'field_purge_batch(200);' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: bpcontact_eval bundle, field_bpcontact_form and bpcontact_eval_form removed"
