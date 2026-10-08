#!/usr/bin/env bash
# Execution RESET: uninstall the mailgun_email_templates_examples submodule so verify FAILS until
# the agent installs (enables) it. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush pmu mailgun_email_templates_examples -y >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: mailgun_email_templates_examples uninstalled"
