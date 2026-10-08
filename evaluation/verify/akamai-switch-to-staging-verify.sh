#!/usr/bin/env bash
# Execution VERIFY: PASS when domain.staging===TRUE and domain.production===FALSE. exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '$d=\Drupal::config("akamai.settings")->get("domain"); $ok=(($d["staging"]??NULL)===TRUE && ($d["production"]??NULL)===FALSE); print ($ok?"PASS":"FAIL")." staging=".var_export($d["staging"]??NULL,TRUE)." production=".var_export($d["production"]??NULL,TRUE)."\n";' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
