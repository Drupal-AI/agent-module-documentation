#!/usr/bin/env bash
# Medium/introspection setup: KNOWN state — cva enabled so its CvaSandboxPolicy is installed
# on the live Twig sandbox (whitelisting Twig\Extra\Html\Cva). Agent inspects to confirm.
set -uo pipefail
cd /var/www/html
drush pm:install cva -y >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: cva enabled; CvaSandboxPolicy active on the Twig sandbox"
