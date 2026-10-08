#!/usr/bin/env bash
# Introspection SETUP: create contact form ce_eval and a Contact Emails managed email
# (recipient_type=manual, recipients=team@ce-eval.example) so an agent can read the recipient
# back. Idempotent. Exit 0. (Config-entity save may trip an unrelated terminate error on this
# shared site; output is redirected and the record still persists.)
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\contact\Entity\ContactForm;
  if (!ContactForm::load("ce_eval")) {
    ContactForm::create(["id" => "ce_eval", "label" => "CE Eval Form", "recipients" => ["default@ce-eval.example"], "message" => "", "redirect" => ""])->save();
  }
  $storage = \Drupal::entityTypeManager()->getStorage("contact_email");
  $ids = \Drupal::entityQuery("contact_email")->accessCheck(FALSE)->condition("contact_form", "ce_eval")->execute();
  if ($ids) { $storage->delete($storage->loadMultiple($ids)); }
  $storage->create([
    "contact_form" => "ce_eval", "subject" => "CE Eval Notification",
    "recipient_type" => "manual", "recipients" => "team@ce-eval.example",
    "reply_to_type" => "default", "status" => TRUE,
  ])->save();
' >/dev/null 2>&1
echo "setup: contact_form ce_eval has a contact_email sending to team@ce-eval.example"
