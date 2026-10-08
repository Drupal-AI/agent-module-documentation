#!/usr/bin/env bash
# Execution RESET: ensure contact form ce_task exists and has NO Contact Emails managed emails
# (so verify FAILS until the agent adds one). Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\contact\Entity\ContactForm;
  if (!ContactForm::load("ce_task")) {
    ContactForm::create(["id" => "ce_task", "label" => "CE Task Form", "recipients" => ["default@ce-task.example"], "message" => "", "redirect" => ""])->save();
  }
  $storage = \Drupal::entityTypeManager()->getStorage("contact_email");
  $ids = \Drupal::entityQuery("contact_email")->accessCheck(FALSE)->condition("contact_form", "ce_task")->execute();
  if ($ids) { $storage->delete($storage->loadMultiple($ids)); }
' >/dev/null 2>&1
echo "reset: contact_form ce_task present with zero managed emails"
