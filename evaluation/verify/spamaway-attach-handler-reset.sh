#!/usr/bin/env bash
# Execution RESET: create webform spamaway_eval_h1 with NO handlers so verify FAILS until the
# agent attaches the SpamAway handler. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\webform\Entity\Webform;
  if ($w = Webform::load("spamaway_eval_h1")) { $w->delete(); }
  $w = Webform::create(["id" => "spamaway_eval_h1", "title" => "SpamAway Eval H1"]);
  $w->save();
' >/dev/null 2>&1
echo "reset: webform spamaway_eval_h1 created with no handlers"
