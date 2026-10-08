#!/usr/bin/env bash
# Execution CLEANUP: remove sblb_h2 + simple_block sblb_b.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\node\Entity\NodeType;
  use Drupal\simple_block\Entity\SimpleBlock;
  if ($nt = NodeType::load("sblb_h2")) { $nt->delete(); }
  if ($b = SimpleBlock::load("sblb_b")) { $b->delete(); }
  \Drupal::service("plugin.manager.block")->clearCachedDefinitions();
' >/dev/null 2>&1
echo "cleanup: node.sblb_h2 + simple_block sblb_b removed"
