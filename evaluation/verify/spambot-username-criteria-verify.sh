#!/usr/bin/env bash
# Execution VERIFY: PASS when spambot_criteria_username === 5 in live config. exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '$v=\Drupal::config("spambot.settings")->get("spambot_criteria_username"); print (((int)$v)===5?"PASS":"FAIL")." username_threshold=".var_export($v,TRUE)."\n";' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
