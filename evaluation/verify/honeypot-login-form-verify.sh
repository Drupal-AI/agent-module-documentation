#!/usr/bin/env bash
# Live-state verification for "protect ONLY the user login form" (per-form, not
# site-wide). Honeypot marks a single form as protected via the truthy
# form_settings.<form_id> map (HoneypotService::getProtectedForms()).
# Requires:
#   protect_all_forms                === FALSE  (NOT site-wide)
#   form_settings.user_login_form    truthy     (login form is protected)
#   the honeypot service reports user_login_form among getProtectedForms()
# Prints PASS/FAIL with detail; exits 0 (pass) / 1 (fail). No arguments.
set -uo pipefail
cd /var/www/html

out=$(drush php:eval '
  $c   = \Drupal::config("honeypot.settings");
  $all = $c->get("protect_all_forms");
  $fs  = $c->get("form_settings");
  $per = !empty($fs["user_login_form"]);
  $svc = in_array("user_login_form", \Drupal::service("honeypot")->getProtectedForms(), TRUE);
  $ok  = ($all === FALSE && $per && $svc);
  print ($ok ? "PASS" : "FAIL") . " protect_all_forms=" . var_export($all, TRUE) . " login_protected=" . ($per ? 1 : 0) . " service_sees_it=" . ($svc ? 1 : 0) . "\n";
' 2>/dev/null)

echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
