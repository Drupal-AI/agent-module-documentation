#!/usr/bin/env bash
# Execution CLEANUP: ensure the submodule is enabled again (documented baseline). Exit 0.
set -uo pipefail
cd /var/www/html
drush pm:install mailgun_email_templates_examples -y >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: mailgun_email_templates_examples enabled (baseline restored)"
