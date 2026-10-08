#!/usr/bin/env bash
# MEDIUM setup: put genpass.settings into a KNOWN state so the agent can read the
# generated-password length back off the live site. Cleanup restores the install default.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("genpass.settings")->set("genpass_length", 24)->save();' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: genpass_length = 24"
