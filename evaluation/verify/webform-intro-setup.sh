#!/usr/bin/env bash
# Introspection setup: install a KNOWN webform `eval_intro` on the live site so the agent
# can be asked about its current configuration and must inspect the running site (drush) to
# answer. Idempotent — deletes any prior eval_intro first, then recreates the exact known
# config. Known facts the medium cases probe:
#   - confirmation message string: "Thank you — your enquiry reference is ENQ-4815."
#   - elements: full_name (textfield, required), email (email, required),
#               department (select, required), subscribe (checkbox, optional)
#   - email handler recipient (to_mail): intake@eval.example.org
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\webform\Entity\Webform;
  $storage = \Drupal::entityTypeManager()->getStorage("webform");
  $subs = \Drupal::entityTypeManager()->getStorage("webform_submission");
  $ids = $subs->getQuery()->condition("webform_id", "eval_intro")->accessCheck(FALSE)->execute();
  if ($ids) { $subs->delete($subs->loadMultiple($ids)); }
  if ($old = $storage->load("eval_intro")) { $old->delete(); }

  $elements = [
    "full_name"  => ["#type" => "textfield", "#title" => "Full name", "#required" => TRUE],
    "email"      => ["#type" => "email", "#title" => "Email address", "#required" => TRUE],
    "department" => ["#type" => "select", "#title" => "Department", "#required" => TRUE,
      "#options" => ["sales" => "Sales", "support" => "Support", "billing" => "Billing"]],
    "subscribe"  => ["#type" => "checkbox", "#title" => "Subscribe to our newsletter"],
  ];
  $wf = Webform::create(["id" => "eval_intro", "title" => "Eval Intro"]);
  $wf->setElements($elements);
  $wf->setSettings([
    "confirmation_type" => "message",
    "confirmation_message" => "Thank you — your enquiry reference is ENQ-4815.",
  ] + $wf->getSettings());
  $wf->save();
  $wf->addWebformHandler(\Drupal::service("plugin.manager.webform.handler")->createInstance("email", [
    "id" => "email_notify", "handler_id" => "email_notify", "label" => "Email notification",
    "status" => 1, "weight" => 0,
    "settings" => ["to_mail" => "intake@eval.example.org", "from_mail" => "_default"],
  ]));
  $wf->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: eval_intro webform installed (conf=ENQ-4815, recipient=intake@eval.example.org)"
