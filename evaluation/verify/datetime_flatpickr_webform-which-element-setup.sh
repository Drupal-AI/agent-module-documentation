#!/usr/bin/env bash
# Introspection SETUP: webform dtf_wf_two, picker_a=flatpickr_date, picker_b=date. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\webform\Entity\Webform;
  $els = ["picker_a"=>["#type"=>"flatpickr_date","#title"=>"Picker A"], "picker_b"=>["#type"=>"date","#title"=>"Picker B"]];
  $w = Webform::load("dtf_wf_two") ?: Webform::create(["id"=>"dtf_wf_two","title"=>"DTF WF Two"]);
  $w->setElements($els); $w->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: dtf_wf_two picker_a=flatpickr_date picker_b=date"
