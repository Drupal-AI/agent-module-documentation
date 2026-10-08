#!/usr/bin/env bash
# Execution VERIFY: PASS when css_editor no longer serves custom CSS for Stark -
# _css_editor_get_stylesheet('stark') (the module's own serving predicate) returns FALSE and
# css_editor.theme.stark:enabled is FALSE - while the CSS text is still preserved in config.
# Prints PASS/FAIL; exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $config = \Drupal::config("css_editor.theme.stark");
  $enabled = (bool) $config->get("enabled");
  $css = (string) $config->get("css");
  $kept = str_contains($css, "ce-rollback-marker");
  $served = _css_editor_get_stylesheet("stark");
  $ok = !$enabled && $kept && ($served === FALSE);
  print ($ok ? "PASS" : "FAIL") . " enabled=" . var_export($enabled, TRUE) . " css_kept=" .
    var_export($kept, TRUE) . " served=" . var_export($served, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
