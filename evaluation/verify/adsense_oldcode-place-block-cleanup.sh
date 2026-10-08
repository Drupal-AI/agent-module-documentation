#!/usr/bin/env bash
# Execution CLEANUP: delete the adsense_oc_eval_ad block. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\block\Entity\Block;
  if ($b = Block::load("adsense_oc_eval_ad")) { $b->delete(); }
' >/dev/null 2>&1
echo "cleanup: block adsense_oc_eval_ad removed"
