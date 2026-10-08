#!/usr/bin/env bash
# Execution RESET: ensure helper 'core_form_novalidate' is OFF so verify FAILS until the agent
# disables HTML5 validation via the Helper module. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '$c=\Drupal::configFactory()->getEditable("helper.settings"); $e=$c->get("enabled")?:[]; $e["core_form_novalidate"]=FALSE; $c->set("enabled",$e)->save();' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: core_form_novalidate=FALSE"
