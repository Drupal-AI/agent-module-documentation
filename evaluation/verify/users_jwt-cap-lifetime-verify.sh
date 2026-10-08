#!/usr/bin/env bash
# Execution VERIFY for "cap the user JWT max_expiration at 3600 seconds".
# PASS iff users_jwt.config max_expiration === 3600. Prints PASS/FAIL; exit 0
# pass / 1 fail (fails when the config key is unset, e.g. straight off reset).
set -uo pipefail
cd /var/www/html
val=$(drush php:eval '
  $v = \Drupal::config("users_jwt.config")->get("max_expiration");
  print ($v === NULL ? "" : (string) $v);
' 2>/dev/null)
if [ "$val" = "3600" ]; then
  echo "PASS max_expiration=$val"
  exit 0
else
  echo "FAIL max_expiration=${val:-<unset>}"
  exit 1
fi
