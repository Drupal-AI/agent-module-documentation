#!/usr/bin/env bash
# Live-state verification for the "set the site default challenge to Math AND add a
# CAPTCHA to the user registration form" task.
# Prints PASS/FAIL with detail and exits 0 (pass) / 1 (fail). No arguments.
# Two independent checks, both required:
#   def    — captcha.settings default_challenge is the Math captcha (captcha/Math)
#   point  — a captcha_point for form user_register_form exists and is enabled
set -uo pipefail
cd /var/www/html

out=$(drush php:eval '
  $p = \Drupal::entityTypeManager()->getStorage("captcha_point")->load("user_register_form");
  $point = ($p && $p->status()) ? 1 : 0;
  $def   = \Drupal::config("captcha.settings")->get("default_challenge");
  $dok   = ($def === "captcha/Math") ? 1 : 0;
  $ok = ($point && $dok);
  print ($ok ? "PASS" : "FAIL") . " point=$point default=$def\n";
' 2>/dev/null)

echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
