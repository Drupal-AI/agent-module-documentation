#!/usr/bin/env bash
# PASS when workflow === single_step. exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '$v=\Drupal::config("registration_change_host.settings")->get("workflow");print (($v==="single_step")?"PASS":"FAIL")." workflow=".var_export($v,true)."\n";' 2>/dev/null)
echo "$out"; echo "$out" | grep -q '^PASS' && exit 0 || exit 1
