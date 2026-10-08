#!/usr/bin/env bash
# Introspection SETUP: webform dtf_wf_known with a flatpickr_date element 'my_date'. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\webform\Entity\Webform;
  $els = ["my_date"=>["#type"=>"flatpickr_date","#title"=>"My date"]];
  $w = Webform::load("dtf_wf_known") ?: Webform::create(["id"=>"dtf_wf_known","title"=>"DTF WF Known"]);
  $w->setElements($els); $w->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: webform dtf_wf_known element my_date = flatpickr_date"
