#!/usr/bin/env bash
# Execution RESET: (re)create webform wfv_range with two number elements (wfv_start, wfv_end)
# and NO validation, so verify FAILS until the agent adds a "compare" rule making wfv_end
# greater than wfv_start. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\webform\Entity\Webform;
  $w = Webform::load("wfv_range") ?: Webform::create(["id" => "wfv_range", "title" => "WFV Range"]);
  $w->setElements([
    "wfv_start" => ["#type" => "number", "#title" => "Start"],
    "wfv_end" => ["#type" => "number", "#title" => "End"],
  ]);
  $w->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: webform wfv_range present, no compare rule on wfv_end"
