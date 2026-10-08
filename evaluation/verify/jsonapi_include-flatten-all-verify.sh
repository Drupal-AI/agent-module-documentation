#!/usr/bin/env bash
# Execution VERIFY: PASS when use_include_query evaluates to FALSE (flatten every response).
# Interprets the stored value robustly (bool false, "0", "false" all count). exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '$v=\Drupal::config("jsonapi_include.settings")->get("use_include_query"); $b=filter_var($v, FILTER_VALIDATE_BOOLEAN); print((!$b?"PASS":"FAIL")." use_include_query=".var_export($v,TRUE));' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
