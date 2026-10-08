#!/usr/bin/env bash
# Introspection SETUP: create a CAPTCHA point that protects the form "hcaptcha_eval_contact"
# with the hCaptcha challenge, so an agent can inspect which challenge type is assigned.
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $s = \Drupal::entityTypeManager()->getStorage("captcha_point");
  if (!$s->load("hcaptcha_eval_contact")) {
    $s->create([
      "id" => "hcaptcha_eval_contact", "formId" => "hcaptcha_eval_contact",
      "captchaType" => "hcaptcha/hCaptcha", "label" => "hCaptcha eval contact", "status" => TRUE,
    ])->save();
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: captcha.captcha_point.hcaptcha_eval_contact -> captchaType hcaptcha/hCaptcha"
