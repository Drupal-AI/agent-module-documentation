#!/usr/bin/env bash
# Introspection CLEANUP: leave the submodule enabled (its enabled state is the documented baseline). Exit 0.
set -uo pipefail
cd /var/www/html
drush pm:install mailgun_email_templates_examples -y >/dev/null 2>&1
echo "cleanup: mailgun_email_templates_examples left enabled (baseline)"
