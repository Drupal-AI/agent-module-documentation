#!/usr/bin/env bash
# MEDIUM cleanup: remove the block placed by the known-visibility setup, restoring baseline.
set -uo pipefail
cd /var/www/html
drush php:eval '
  if ($b = \Drupal::entityTypeManager()->getStorage("block")->load("bep_eval_known")) { $b->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: block bep_eval_known removed"
