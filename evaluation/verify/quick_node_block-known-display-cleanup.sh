#!/usr/bin/env bash
# Introspection CLEANUP: delete the qnb_known_block and the 'QNB Known' fixture node. Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\block\Entity\Block;
  if ($b = Block::load("qnb_known_block")) { $b->delete(); }
  foreach (\Drupal::entityTypeManager()->getStorage("node")->loadByProperties(["title" => "QNB Known"]) as $n) { $n->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: qnb_known_block and QNB Known node removed"
