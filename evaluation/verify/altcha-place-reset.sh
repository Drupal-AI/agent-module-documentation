#!/usr/bin/env bash
# hard RESET (altcha): ensure NO CAPTCHA point exists for form id altcha_eval_form so verify FAILS
# until the agent creates one with the ALTCHA challenge. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  if ($p = \Drupal::entityTypeManager()->getStorage("captcha_point")->load("altcha_eval_form")) { $p->delete(); }
' >/dev/null 2>&1
echo "reset: no captcha point for altcha_eval_form"
