#!/usr/bin/env bash
# PASS when prevent_complete_own === true. exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '$v=\Drupal::config("registration_workflow.settings")->get("prevent_complete_own");print (($v===TRUE)?"PASS":"FAIL")." prevent_complete_own=".var_export($v,true)."\n";' 2>/dev/null)
echo "$out"; echo "$out" | grep -q '^PASS' && exit 0 || exit 1
