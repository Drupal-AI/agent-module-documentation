#!/usr/bin/env bash
# Execution RESET: ensure the adsense_oc_eval_ad block does NOT exist so verify FAILS until the
# agent places a legacy old-code ad block. Local block config only. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\block\Entity\Block;
  if ($b = Block::load("adsense_oc_eval_ad")) { $b->delete(); }
' >/dev/null 2>&1
echo "reset: block adsense_oc_eval_ad absent"
