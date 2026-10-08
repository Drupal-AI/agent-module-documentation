#!/usr/bin/env bash
# Execution VERIFY (check_dns): PASS when check_dns is enabled AND its
# hook_form_user_register_form_alter() wires check_dns_user_register_validate onto the
# user registration form's #validate, i.e. new signups are gated by the domain check.
# Prints PASS/FAIL; exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $enabled = \Drupal::moduleHandler()->moduleExists("check_dns");
  $form = ["#validate" => []];
  $fs = new \Drupal\Core\Form\FormState();
  if ($enabled && function_exists("check_dns_form_user_register_form_alter")) {
    check_dns_form_user_register_form_alter($form, $fs);
  }
  $has = in_array("check_dns_user_register_validate", $form["#validate"], TRUE);
  $ok = ($enabled && $has);
  print ($ok ? "PASS" : "FAIL") . " enabled=" . var_export($enabled, TRUE) . " handler=" . var_export($has, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
