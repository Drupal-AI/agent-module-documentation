#!/usr/bin/env bash
# Execution VERIFY (ui_styles main): PASS when a style plugin 'ui_styles_eval_spacing' is
# discovered in category 'Eval Spacing' with BOTH option classes 'ui-styles-eval-p-1' and
# 'ui-styles-eval-p-3'.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $m = \Drupal::service("plugin.manager.ui_styles");
  $ok = FALSE;
  if ($m->hasDefinition("ui_styles_eval_spacing")) {
    $def = $m->getDefinition("ui_styles_eval_spacing");
    $opts = \array_keys($def->getOptions());
    $cat = (string) $def->getCategory();
    $ok = \in_array("ui-styles-eval-p-1", $opts, TRUE)
      && \in_array("ui-styles-eval-p-3", $opts, TRUE)
      && $cat === "Eval Spacing";
  }
  print ($ok ? "PASS" : "FAIL") . " has=" . var_export($m->hasDefinition("ui_styles_eval_spacing"), TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
