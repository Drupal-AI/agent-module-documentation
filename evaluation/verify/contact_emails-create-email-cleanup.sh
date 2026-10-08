#!/usr/bin/env bash
# Execution CLEANUP: remove ce_task's managed emails and the ce_task contact form. Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\contact\Entity\ContactForm;
  $storage = \Drupal::entityTypeManager()->getStorage("contact_email");
  $ids = \Drupal::entityQuery("contact_email")->accessCheck(FALSE)->condition("contact_form", "ce_task")->execute();
  if ($ids) { $storage->delete($storage->loadMultiple($ids)); }
  if ($cf = ContactForm::load("ce_task")) { $cf->delete(); }
' >/dev/null 2>&1
echo "cleanup: ce_task form and its contact emails removed"
