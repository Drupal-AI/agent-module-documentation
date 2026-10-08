#!/usr/bin/env bash
# Execution VERIFY (ui_styles main): PASS when plugin.manager.ui_styles discovers a style
# plugin id 'ui_styles_eval_bg' whose options include the CSS class 'ui-styles-eval-bg'.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $m = \Drupal::service("plugin.manager.ui_styles");
  $ok = FALSE;
  if ($m->hasDefinition("ui_styles_eval_bg")) {
    $opts = \array_keys($m->getDefinition("ui_styles_eval_bg")->getOptions());
    $ok = \in_array("ui-styles-eval-bg", $opts, TRUE);
  }
  print ($ok ? "PASS" : "FAIL") . " has=" . var_export($m->hasDefinition("ui_styles_eval_bg"), TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
