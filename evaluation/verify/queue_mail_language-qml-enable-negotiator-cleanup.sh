#!/usr/bin/env bash
set -uo pipefail
cd /var/www/html
drush pm:list --status=enabled --field=name 2>/dev/null | grep -qx queue_mail_language || drush en queue_mail_language -y >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: queue_mail_language enabled (baseline restored)"
