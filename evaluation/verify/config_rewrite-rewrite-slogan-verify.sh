#!/usr/bin/env bash
# HARD execution verify for the "rewrite system.site slogan" task.
# PASS (exit 0) iff the live system.site slogan equals the required target value.
# The agent is expected to reach this by calling the config_rewrite config.rewriter service;
# this check only asserts the resulting live config value.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $slogan = \Drupal::config("system.site")->get("slogan");
  $ok = ($slogan === "Rewritten by config_rewrite");
  print ($ok ? "PASS" : "FAIL") . " slogan=[" . $slogan . "]\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
