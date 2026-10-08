#!/usr/bin/env bash
# Execution VERIFY: PASS when global filebrowser.settings has rights.download_archive==1 AND
# rights.explore_subdirs==1. exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $c = \Drupal::config("filebrowser.settings");
  $a = (int) $c->get("filebrowser.rights.download_archive");
  $s = (int) $c->get("filebrowser.rights.explore_subdirs");
  $ok = ($a === 1 && $s === 1);
  print ($ok ? "PASS" : "FAIL") . " download_archive=$a explore_subdirs=$s\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
