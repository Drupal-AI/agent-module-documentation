#!/usr/bin/env bash
# Reset the "Math site default + CAPTCHA on user registration" eval to a clean, known
# baseline so each run is independent. Two moves:
#   1. delete the eval captcha_point for user_register_form.
#   2. set captcha.settings default_challenge to a NON-Math baseline
#      (image_captcha/Image) — the module's install default is already captcha/Math,
#      so we deliberately move it off Math here so the build (switch it TO Math) is a
#      real change and verify FAILs on this baseline. Only default_challenge is
#      touched; all other captcha.settings keys keep their install defaults.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $s = \Drupal::entityTypeManager()->getStorage("captcha_point");
  if ($p = $s->load("user_register_form")) { $p->delete(); }
  \Drupal::configFactory()->getEditable("captcha.settings")
    ->set("default_challenge", "image_captcha/Image")->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: captcha_point user_register_form removed; default_challenge set to non-Math baseline"
