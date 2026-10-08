#!/usr/bin/env bash
# Introspection SETUP: ensure the mailgun_email_templates_examples submodule is enabled so an
# inspecting agent can find its example email theme hooks in the live theme registry. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush pm:install mailgun_email_templates_examples -y >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: mailgun_email_templates_examples enabled (theme hooks mailgun__password_reset etc. registered)"
