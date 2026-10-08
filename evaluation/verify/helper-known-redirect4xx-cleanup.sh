#!/usr/bin/env bash
set -uo pipefail
cd /var/www/html
drush php:eval '$c=\Drupal::configFactory()->getEditable("helper.settings"); $e=$c->get("enabled")?:[]; $e["redirect_entity_4xx_to_edit"]=FALSE; $c->set("enabled",$e)->save();' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: redirect_entity_4xx_to_edit restored to FALSE"
