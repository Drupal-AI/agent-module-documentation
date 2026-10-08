#!/usr/bin/env bash
# Execution RESET: webform dtf_wf_task2 with a flatpickr_date 'booking' element, enableTime not set. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\webform\Entity\Webform;
  $els = ["booking"=>["#type"=>"flatpickr_date","#title"=>"Booking"]];
  $w = Webform::load("dtf_wf_task2") ?: Webform::create(["id"=>"dtf_wf_task2","title"=>"DTF WF Task 2"]);
  $w->setElements($els); $w->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: dtf_wf_task2 booking flatpickr_date without enableTime"
