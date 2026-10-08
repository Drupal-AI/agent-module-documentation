#!/usr/bin/env bash
# Execution RESET: (re)create webform wfv_task with two email elements (wfv_email, wfv_confirm)
# and NO validation rules, so verify FAILS until the agent adds an "equal values" rule.
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\webform\Entity\Webform;
  $w = Webform::load("wfv_task") ?: Webform::create(["id" => "wfv_task", "title" => "WFV Task"]);
  $w->setElements([
    "wfv_email" => ["#type" => "email", "#title" => "Email"],
    "wfv_confirm" => ["#type" => "email", "#title" => "Confirm email"],
  ]);
  $w->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: webform wfv_task present, no validation on wfv_confirm"
