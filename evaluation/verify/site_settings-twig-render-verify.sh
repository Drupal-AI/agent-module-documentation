#!/usr/bin/env bash
# Execution VERIFY: render the agent's Twig template inline and check the output contains the
# stored site setting value, i.e. that a real site_settings Twig function was used.
# PASS when the rendered markup contains "Book your visit" and the template source calls one of
# the module's Twig functions. Prints PASS/FAIL; exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
TPL=web/sites/default/files/site_settings_eval/label.html.twig
if [ ! -f "$TPL" ]; then
  echo "FAIL missing $TPL"
  exit 1
fi
if ! grep -qE 'site_setting|site_settings_by_name|all_site_settings|site_settings_by_group|site_setting_field|site_setting_entity_by_name' "$TPL"; then
  echo "FAIL $TPL does not call any site_settings twig function"
  exit 1
fi
out=$(drush php:eval '
  // drush runs PHP with the Drupal root as cwd, so resolve from DRUPAL_ROOT.
  $tpl = file_get_contents(DRUPAL_ROOT . "/sites/default/files/site_settings_eval/label.html.twig");
  $build = ["#type" => "inline_template", "#template" => $tpl, "#context" => []];
  $markup = (string) \Drupal::service("renderer")->renderInIsolation($build);
  $ok = str_contains($markup, "Book your visit");
  print ($ok ? "PASS" : "FAIL") . " markup=" . preg_replace("/\s+/", " ", substr($markup, 0, 300)) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
