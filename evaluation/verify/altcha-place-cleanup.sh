#!/usr/bin/env bash
# hard CLEANUP (altcha): remove the altcha_eval_form CAPTCHA point. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  if ($p = \Drupal::entityTypeManager()->getStorage("captcha_point")->load("altcha_eval_form")) { $p->delete(); }
' >/dev/null 2>&1
echo "cleanup: captcha point altcha_eval_form removed"
