#!/usr/bin/env bash
# Execution VERIFY: PASS when login_redirection === '/dashboard'. exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '$v=\Drupal::config("simple_pass_reset.settings")->get("login_redirection"); print (($v==="/dashboard")?"PASS":"FAIL")." login_redirection=".var_export($v,TRUE)."\n";' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
