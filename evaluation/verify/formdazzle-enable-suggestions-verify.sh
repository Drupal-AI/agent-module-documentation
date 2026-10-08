#!/usr/bin/env bash
# Execution VERIFY: build AND render the user login form on the live site, then PASS only if a
# form element's #theme carries a formdazzle form-id+element suggestion (contains
# '__user_login_form__name'). formdazzle adds its suggestions during #pre_render, so the form
# must actually be rendered (renderRoot) before inspecting - this only yields the suffix when
# formdazzle is enabled. exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $form = \Drupal::formBuilder()->getForm("Drupal\\user\\Form\\UserLoginForm");
  // Trigger #pre_render (where formdazzle injects its suggestions).
  \Drupal::service("renderer")->renderRoot($form);
  $needle = "__user_login_form__name";
  $found = 0;
  $walk = function($el) use (&$walk, $needle, &$found) {
    if (is_array($el)) {
      if (isset($el["#theme"])) {
        $t = is_array($el["#theme"]) ? implode("|", $el["#theme"]) : (string) $el["#theme"];
        if (strpos($t, $needle) !== FALSE) { $found = 1; }
      }
      foreach ($el as $v) { if (is_array($v)) $walk($v); }
    }
  };
  $walk($form);
  print ($found ? "PASS" : "FAIL")." formdazzle_suggestion=".($found?"present":"absent")."\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
