#!/usr/bin/env bash
# Introspection SETUP: enable 'redirect_entity_4xx_to_edit' so the agent can inspect and report it.
set -uo pipefail
cd /var/www/html
drush php:eval '$c=\Drupal::configFactory()->getEditable("helper.settings"); $e=$c->get("enabled")?:[]; $e["redirect_entity_4xx_to_edit"]=TRUE; $c->set("enabled",$e)->save();' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: helper.settings enabled.redirect_entity_4xx_to_edit=TRUE"
