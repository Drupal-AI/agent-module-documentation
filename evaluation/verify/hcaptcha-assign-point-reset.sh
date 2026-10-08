#!/usr/bin/env bash
# Execution RESET: delete the CAPTCHA point "hcaptcha_eval_form" so verify FAILS on empty state
# until the agent creates it. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  if ($p = \Drupal::entityTypeManager()->getStorage("captcha_point")->load("hcaptcha_eval_form")) { $p->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: captcha.captcha_point.hcaptcha_eval_form removed"
