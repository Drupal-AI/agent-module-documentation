#!/usr/bin/env bash
# Execution CLEANUP: remove the /tmp/scss_compiler-eval scratch directory. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $dir = "/tmp/scss_compiler-eval";
  foreach (["style.scss","style.css","style.css.map"] as $f) { @unlink("$dir/$f"); }
  if (is_dir($dir)) { @rmdir($dir); }
' >/dev/null 2>&1
echo "cleanup: /tmp/scss_compiler-eval removed"
