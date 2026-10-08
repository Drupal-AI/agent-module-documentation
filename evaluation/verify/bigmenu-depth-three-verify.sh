#!/usr/bin/env bash
# Live-state verification for the "bigmenu depth = 3" task.
# PASS iff bigmenu.settings:max_depth === 3 on the running site. Exit 0 (pass) / 1 (fail).
# Reads via php:eval with a grep marker because drush stdout carries unrelated deprecation notices.
set -uo pipefail
cd /var/www/html
val=$(drush php:eval 'print "MAXDEPTH[".\Drupal::config("bigmenu.settings")->get("max_depth")."]";' 2>/dev/null \
  | grep -oE 'MAXDEPTH\[[0-9]+\]' | grep -oE '[0-9]+')
if [ "$val" = "3" ]; then echo "PASS max_depth=$val"; exit 0; else echo "FAIL max_depth=${val:-unset} (want 3)"; exit 1; fi
