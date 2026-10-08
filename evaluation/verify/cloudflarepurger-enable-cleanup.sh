#!/usr/bin/env bash
set -uo pipefail
cd /var/www/html
drush en cloudflarepurger -y >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: cloudflarepurger enabled"
