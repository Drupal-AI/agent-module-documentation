#!/usr/bin/env bash
# Introspection CLEANUP: delete the contact_email(s) for ce_eval and the ce_eval contact form.
# Restores baseline. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\contact\Entity\ContactForm;
  $storage = \Drupal::entityTypeManager()->getStorage("contact_email");
  $ids = \Drupal::entityQuery("contact_email")->accessCheck(FALSE)->condition("contact_form", "ce_eval")->execute();
  if ($ids) { $storage->delete($storage->loadMultiple($ids)); }
  if ($cf = ContactForm::load("ce_eval")) { $cf->delete(); }
' >/dev/null 2>&1
echo "cleanup: ce_eval form and its contact emails removed"
