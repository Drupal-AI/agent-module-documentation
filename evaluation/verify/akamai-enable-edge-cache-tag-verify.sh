#!/usr/bin/env bash
# Execution VERIFY: PASS when akamai.settings:edge_cache_tag_header === TRUE. exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '$v=\Drupal::config("akamai.settings")->get("edge_cache_tag_header"); print (($v===TRUE)?"PASS":"FAIL")." edge_cache_tag_header=".var_export($v,TRUE)."\n";' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
