#!/usr/bin/env bash
set -uo pipefail
cd /var/www/html
drush php:eval '$c=\Drupal::configFactory()->getEditable("helper.settings"); $e=$c->get("enabled")?:[]; $e["core_form_novalidate"]=FALSE; $c->set("enabled",$e)->save();' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: core_form_novalidate restored to FALSE"
