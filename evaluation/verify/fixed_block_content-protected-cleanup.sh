#!/usr/bin/env bash
# Introspection CLEANUP: delete fbc_prot and any block_content it created. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $s = \Drupal::entityTypeManager()->getStorage("fixed_block_content");
  if ($e = $s->load("fbc_prot")) {
    if ($bc = $e->getBlockContent(FALSE)) { $bc->delete(); }
    $e->delete();
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: fbc_prot removed"
