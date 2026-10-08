#!/usr/bin/env bash
# Live-state verification for the "add a Math CAPTCHA to the user login form" task.
# Prints PASS/FAIL with detail and exits 0 (pass) / 1 (fail). No arguments.
# PASS when a captcha_point for form user_login_form exists, is enabled, and its
# challenge type is the Math captcha (captcha/Math).
set -uo pipefail
cd /var/www/html

out=$(drush php:eval '
  $p = \Drupal::entityTypeManager()->getStorage("captcha_point")->load("user_login_form");
  $exists  = $p ? 1 : 0;
  $enabled = ($p && $p->status()) ? 1 : 0;
  $type    = $p ? $p->getCaptchaType() : "";
  $ok = ($p && $p->status() && $type === "captcha/Math");
  print ($ok ? "PASS" : "FAIL") . " exists=$exists enabled=$enabled type=$type\n";
' 2>/dev/null)

echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
