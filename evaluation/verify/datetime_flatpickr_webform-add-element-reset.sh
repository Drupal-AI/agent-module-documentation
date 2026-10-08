#!/usr/bin/env bash
# Execution RESET: webform dtf_wf_task with only a plain date element (no flatpickr_date). Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\webform\Entity\Webform;
  $els = ["some_date"=>["#type"=>"date","#title"=>"Some date"]];
  $w = Webform::load("dtf_wf_task") ?: Webform::create(["id"=>"dtf_wf_task","title"=>"DTF WF Task"]);
  $w->setElements($els); $w->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: dtf_wf_task has no flatpickr_date element"
