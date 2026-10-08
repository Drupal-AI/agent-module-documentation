#!/usr/bin/env bash
# Execution VERIFY (hard): confirm theme development mode was enabled via drupal_cms_helper's
# `themeDevelopmentMode` config action. Prints PASS/FAIL and exits 0 (pass) / 1 (fail).
#
# The action submits core's DevelopmentSettingsForm, which persists to the `development_settings`
# key/value collection. Enabled => twig_debug === TRUE (and twig_cache_disable === TRUE).
set -uo pipefail
cd /var/www/html

out=$(drush php:eval '
  $kv = \Drupal::keyValue("development_settings");
  $debug = $kv->get("twig_debug");
  $cache = $kv->get("twig_cache_disable");
  print "R=" . (($debug === TRUE && $cache === TRUE) ? "PASS" : "FAIL")
    . " twig_debug=" . var_export($debug, TRUE) . " twig_cache_disable=" . var_export($cache, TRUE) . "\n";
' 2>/dev/null | grep '^R=')

echo "$out"
echo "$out" | grep -q '^R=PASS' && exit 0 || exit 1
