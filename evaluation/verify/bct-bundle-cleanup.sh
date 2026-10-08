#!/usr/bin/env bash
# Introspection CLEANUP: delete the bct_probe custom block type. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\block_content\Entity\BlockContentType;
  if ($t = BlockContentType::load("bct_probe")) { $t->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: block_content type bct_probe removed"
