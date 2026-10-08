#!/usr/bin/env bash
# Execution VERIFY: PASS when css_editor.theme.stark is enabled, its css contains the required
# rule, and the generated stylesheet really exists on disk with that rule in it (i.e. the CSS
# would actually be served). Prints PASS/FAIL; exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $config = \Drupal::config("css_editor.theme.stark");
  $enabled = (bool) $config->get("enabled");
  $css = (string) $config->get("css");
  $path = (string) $config->get("path");
  $css_ok = (bool) preg_match("/\.ce-task-banner\b/", $css) && (bool) preg_match("/#bada55/i", $css);
  $file_ok = $path !== "" && file_exists($path);
  $file_css_ok = $file_ok && str_contains(file_get_contents($path), "ce-task-banner");
  $ok = $enabled && $css_ok && $file_css_ok;
  print ($ok ? "PASS" : "FAIL") . " enabled=" . var_export($enabled, TRUE) . " css_rule=" .
    var_export($css_ok, TRUE) . " path=" . ($path ?: "none") . " file=" . var_export($file_ok, TRUE) .
    " file_rule=" . var_export($file_css_ok, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
