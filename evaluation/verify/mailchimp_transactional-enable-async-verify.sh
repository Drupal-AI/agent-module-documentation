#!/usr/bin/env bash
# Execution VERIFY: PASS when process_async === true AND queue_worker_timeout == 25. exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '$c=\Drupal::config("mailchimp_transactional.settings"); $a=$c->get("process_async"); $t=$c->get("queue_worker_timeout"); $ok=($a===TRUE && (int)$t===25); print ($ok?"PASS":"FAIL")." process_async=".var_export($a,TRUE)." timeout=".var_export($t,TRUE)."\n";' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
