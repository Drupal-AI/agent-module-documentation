#!/usr/bin/env bash
# Execution VERIFY: PASS when a CAPTCHA point "hcaptcha_eval_form" exists and its captchaType is
# hcaptcha/hCaptcha. Prints PASS/FAIL; exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $p = \Drupal::entityTypeManager()->getStorage("captcha_point")->load("hcaptcha_eval_form");
  $type = $p ? $p->get("captchaType") : NULL;
  $ok = ($type === "hcaptcha/hCaptcha");
  print ($ok ? "PASS" : "FAIL") . " point=" . ($p ? "exists" : "missing") . " captchaType=" . var_export($type, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
