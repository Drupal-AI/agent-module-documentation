#!/usr/bin/env bash
# Introspection CLEANUP: delete the ba_promo block content type (its generated permissions
# disappear with it). Restores baseline. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\block_content\Entity\BlockContentType;
  if ($t = BlockContentType::load("ba_promo")) { $t->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: block content type ba_promo removed"
