#!/usr/bin/env bash
# Introspection SETUP: ensure queue_mail_language is enabled so the queue_mail worker is the
# language-aware one, then the agent can read the class from the running site. Idempotent.
set -uo pipefail
cd /var/www/html
drush pm:list --status=enabled --field=name 2>/dev/null | grep -qx queue_mail_language || drush en queue_mail_language -y >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: queue_mail_language enabled; queue_mail worker is language-aware"
