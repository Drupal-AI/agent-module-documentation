#!/usr/bin/env bash
# Execution VERIFY: PASS when api_key == mtx-test-key AND subaccount == mtx_sub. exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '$c=\Drupal::config("mailchimp_transactional.settings"); $k=$c->get("api_key"); $s=$c->get("subaccount"); $ok=($k==="mtx-test-key" && $s==="mtx_sub"); print ($ok?"PASS":"FAIL")." api_key=".$k." subaccount=".$s."\n";' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
