#!/usr/bin/env bash
# Execution CLEANUP: remove sblb_h1 + simple_block sblb_a.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\node\Entity\NodeType;
  use Drupal\simple_block\Entity\SimpleBlock;
  if ($nt = NodeType::load("sblb_h1")) { $nt->delete(); }
  if ($b = SimpleBlock::load("sblb_a")) { $b->delete(); }
  \Drupal::service("plugin.manager.block")->clearCachedDefinitions();
' >/dev/null 2>&1
echo "cleanup: node.sblb_h1 + simple_block sblb_a removed"
