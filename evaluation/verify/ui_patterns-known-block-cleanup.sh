#!/usr/bin/env bash
# restore baseline: remove the known component block.
set -uo pipefail
cd /var/www/html
drush php:eval 'if ($b = \Drupal\block\Entity\Block::load("uipeval_known_teaser")) { $b->delete(); }' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: block uipeval_known_teaser removed"
