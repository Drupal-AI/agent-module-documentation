#!/usr/bin/env bash
# Execution RESET: (re)create webform wmc_task with NO mailchimp handler so verify FAILS. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\webform\Entity\Webform;
  if ($w = Webform::load("wmc_task")) { $w->delete(); }
  Webform::create(["id"=>"wmc_task","title"=>"WMC Task"])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: webform wmc_task exists with no mailchimp handler"
