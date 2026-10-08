#!/usr/bin/env bash
# Execution VERIFY: PASS when the submodule is installed AND its example email theme hooks are in
# the live theme registry. Read-only. Prints PASS/FAIL. exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $on = \Drupal::moduleHandler()->moduleExists("mailgun_email_templates_examples");
  $reg = \Drupal::service("theme.registry")->get();
  $hook = isset($reg["mailgun__password_reset"]) && isset($reg["mailgun__user"]);
  $ok = $on && $hook;
  print ($ok ? "PASS" : "FAIL") . " installed=" . var_export($on, TRUE) . " theme_hooks=" . var_export($hook, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
