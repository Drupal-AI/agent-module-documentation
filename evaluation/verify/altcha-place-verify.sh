#!/usr/bin/env bash
# hard VERIFY (altcha): PASS when a CAPTCHA point for altcha_eval_form uses captchaType altcha/ALTCHA. exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $c = \Drupal::config("captcha.captcha_point.altcha_eval_form");
  $type = $c->get("captchaType");
  $ok = ($type === "altcha/ALTCHA");
  print ($ok ? "PASS" : "FAIL") . " form=" . var_export($c->get("formId"), TRUE) . " captchaType=" . var_export($type, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
