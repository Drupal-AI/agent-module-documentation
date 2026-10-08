#!/usr/bin/env bash
# Introspection SETUP: enable the helper 'core_form_novalidate' so the agent can inspect
# helper.settings and report that HTML5 form validation is disabled site-wide. Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '$c=\Drupal::configFactory()->getEditable("helper.settings"); $e=$c->get("enabled")?:[]; $e["core_form_novalidate"]=TRUE; $c->set("enabled",$e)->save();' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: helper.settings enabled.core_form_novalidate=TRUE"
