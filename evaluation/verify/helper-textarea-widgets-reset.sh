#!/usr/bin/env bash
# Execution RESET: ensure helper 'core_text_textarea_widgets' is OFF so verify FAILS until the
# agent enables it. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '$c=\Drupal::configFactory()->getEditable("helper.settings"); $e=$c->get("enabled")?:[]; $e["core_text_textarea_widgets"]=FALSE; $c->set("enabled",$e)->save();' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: core_text_textarea_widgets=FALSE"
