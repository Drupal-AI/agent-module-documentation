#!/usr/bin/env bash
# Execution VERIFY: PASS when first_time_login_password_change is TRUE. exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
val=$(drush cget force_password_change.settings first_time_login_password_change --format=string 2>/dev/null | tr -d '[:space:]')
if [ "$val" = "1" ] || [ "$val" = "true" ]; then
  echo "PASS first_time_login_password_change=$val"; exit 0
fi
echo "FAIL first_time_login_password_change=$val"; exit 1
