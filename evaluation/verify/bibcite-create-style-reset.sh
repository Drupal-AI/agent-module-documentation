#!/usr/bin/env bash
# Execution RESET: ensure the CSL style 'bibcite_harvard' does NOT exist, so verify FAILS until
# the agent creates it. Running reset again after the task = cleanup. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\bibcite\Entity\CslStyle;
  if ($s = CslStyle::load("bibcite_harvard")) { $s->delete(); }
' >/dev/null 2>&1 || true
echo "reset: bibcite_csl_style bibcite_harvard absent"
