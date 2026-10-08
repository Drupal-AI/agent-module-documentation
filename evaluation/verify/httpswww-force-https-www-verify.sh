#!/usr/bin/env bash
# Execution VERIFY for "force HTTPS and add the www prefix".
# PASS when httpswww.settings has enabled===TRUE, scheme==='https', prefix==='yes'.
# Prints PASS/FAIL; exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $c = \Drupal::config("httpswww.settings");
  $enabled = $c->get("enabled");
  $prefix = $c->get("prefix");
  $scheme = $c->get("scheme");
  $ok = ($enabled === TRUE) && ($scheme === "https") && ($prefix === "yes");
  print ($ok ? "PASS" : "FAIL") . " enabled=" . var_export($enabled, TRUE) . " prefix=" . var_export($prefix, TRUE) . " scheme=" . var_export($scheme, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
