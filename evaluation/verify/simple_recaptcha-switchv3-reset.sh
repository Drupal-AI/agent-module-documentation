#!/usr/bin/env bash
# Execution RESET: force v2 + score 80 so verify (wants v3 + 75) FAILS. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("simple_recaptcha.config")->set("recaptcha_type","v2")->set("v3_score",80)->save();' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: simple_recaptcha.config recaptcha_type=v2 v3_score=80"
