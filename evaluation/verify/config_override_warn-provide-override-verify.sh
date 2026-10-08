#!/usr/bin/env bash
# Execution VERIFY for "make Config Override Warn warn about an overridden system.site slogan".
# PASS when the module's own service reports an override diff for the 'slogan' key of
# system.site (i.e. \Drupal::config('system.site')->hasOverrides() is TRUE and
# config_override_warn.form_overrides::getConfigOverrideDiffs('system.site') contains 'slogan').
# Prints PASS/FAIL; exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $has = \Drupal::config("system.site")->hasOverrides();
  $d = \Drupal::service("config_override_warn.form_overrides")->getConfigOverrideDiffs("system.site");
  $keys = array_keys($d["system.site"] ?? []);
  $ok = $has && in_array("slogan", $keys, TRUE);
  print ($ok ? "PASS" : "FAIL") . " hasOverrides=" . var_export($has, TRUE) . " keys=" . implode(",", $keys) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
