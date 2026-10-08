#!/usr/bin/env bash
# Introspection CLEANUP: delete the btt_vm block content type. Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\block_content\Entity\BlockContentType;
  if ($t = BlockContentType::load("btt_vm")) { $t->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: block content type btt_vm removed"
