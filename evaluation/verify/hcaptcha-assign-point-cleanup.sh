#!/usr/bin/env bash
# Execution CLEANUP: remove the CAPTCHA point created during the case. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  if ($p = \Drupal::entityTypeManager()->getStorage("captcha_point")->load("hcaptcha_eval_form")) { $p->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: captcha.captcha_point.hcaptcha_eval_form removed"
