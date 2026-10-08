#!/usr/bin/env bash
# Introspection CLEANUP: delete the btt_known block content type. Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\block_content\Entity\BlockContentType;
  if ($t = BlockContentType::load("btt_known")) { $t->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: block content type btt_known removed"
