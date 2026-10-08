#!/usr/bin/env bash
# Execution RESET: create webform spamaway_eval_h2 WITH the SpamAway handler, IP check ENABLED
# and allowed_count=5 (baseline), so verify (ip disabled + count 3) FAILS. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\webform\Entity\Webform;
  if ($w = Webform::load("spamaway_eval_h2")) { $w->delete(); }
  $w = Webform::create(["id" => "spamaway_eval_h2", "title" => "SpamAway Eval H2"]);
  $w->save();
  $h = \Drupal::service("plugin.manager.webform.handler")->createInstance("spamaway_anti_spam_forms", [
    "id" => "spamaway_anti_spam_forms", "handler_id" => "spamaway", "label" => "SpamAway",
    "status" => TRUE, "weight" => 0,
    "settings" => ["spamaway_ip_check_enabled" => TRUE, "spamaway_anti_spam_allowed_count" => 5],
  ]);
  $w->addWebformHandler($h);
  $w->save();
' >/dev/null 2>&1
echo "reset: webform spamaway_eval_h2 handler ip_check_enabled=TRUE allowed_count=5"
