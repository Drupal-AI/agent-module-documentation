#!/usr/bin/env bash
# Reset the "CAPTCHA on the user login form" eval to a clean, known baseline so each
# run is independent: delete the eval captcha_point for user_login_form. The module
# ships this point as *disabled* default config doing nothing, so removing it leaves
# the login form challenge-free (verify must FAIL on this empty state).
set -uo pipefail
cd /var/www/html
drush php:eval '
  $s = \Drupal::entityTypeManager()->getStorage("captcha_point");
  if ($p = $s->load("user_login_form")) { $p->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: captcha_point user_login_form removed"
