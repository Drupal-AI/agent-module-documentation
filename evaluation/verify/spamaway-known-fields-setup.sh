#!/usr/bin/env bash
# Introspection SETUP: create webform spamaway_eval_m2 with the SpamAway handler configured
# with spamaway_anti_spam_field_names=email. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\webform\Entity\Webform;
  if ($w = Webform::load("spamaway_eval_m2")) { $w->delete(); }
  $w = Webform::create(["id" => "spamaway_eval_m2", "title" => "SpamAway Eval M2"]);
  $w->save();
  $h = \Drupal::service("plugin.manager.webform.handler")->createInstance("spamaway_anti_spam_forms", [
    "id" => "spamaway_anti_spam_forms", "handler_id" => "spamaway", "label" => "SpamAway",
    "status" => TRUE, "weight" => 0,
    "settings" => ["spamaway_anti_spam_field_names" => "email"],
  ]);
  $w->addWebformHandler($h);
  $w->save();
' >/dev/null 2>&1
echo "setup: webform spamaway_eval_m2 handler spamaway_anti_spam_field_names=email"
