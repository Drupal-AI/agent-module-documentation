#!/usr/bin/env bash
# Introspection CLEANUP: remove the known eval_twtr_intro block placed by
# twitter_block-configured-timeline-setup.sh, restoring baseline. Idempotent. Exits 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $b = \Drupal::entityTypeManager()->getStorage("block")->load("eval_twtr_intro");
  if ($b) { $b->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: block eval_twtr_intro removed"
