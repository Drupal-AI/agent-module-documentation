#!/usr/bin/env bash
# Live-state verification for the "bigmenu depth = 5" task.
# PASS iff bigmenu.settings:max_depth === 5 on the running site. Exit 0 (pass) / 1 (fail).
set -uo pipefail
cd /var/www/html
val=$(drush php:eval 'print "MAXDEPTH[".\Drupal::config("bigmenu.settings")->get("max_depth")."]";' 2>/dev/null \
  | grep -oE 'MAXDEPTH\[[0-9]+\]' | grep -oE '[0-9]+')
if [ "$val" = "5" ]; then echo "PASS max_depth=$val"; exit 0; else echo "FAIL max_depth=${val:-unset} (want 5)"; exit 1; fi
