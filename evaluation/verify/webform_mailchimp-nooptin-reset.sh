#!/usr/bin/env bash
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\webform\Entity\Webform;
  if ($w = Webform::load("wmc_cfg")) { $w->delete(); }
  Webform::create(["id"=>"wmc_cfg","title"=>"WMC Cfg"])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: webform wmc_cfg exists with no mailchimp handler"
