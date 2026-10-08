#!/usr/bin/env bash
# Execution RESET: delete Key ee_conf_secret so verify FAILS until the agent creates it (using the
# insecure config provider, which Easy Encryption auto-upgrades to easy_encrypted).
set -uo pipefail
cd /var/www/html
drush php:eval 'use Drupal\key\Entity\Key; if ($k = Key::load("ee_conf_secret")) { $k->delete(); }' >/dev/null 2>&1
echo "reset: Key ee_conf_secret removed"
