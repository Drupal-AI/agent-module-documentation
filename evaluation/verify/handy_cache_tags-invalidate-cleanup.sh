#!/usr/bin/env bash
# Execution CLEANUP: delete content type hct_task and its cachetags counter row. Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\node\Entity\NodeType;
  $s = \Drupal::entityTypeManager()->getStorage("node");
  $ids = $s->getQuery()->accessCheck(FALSE)->condition("type","hct_task")->execute();
  if ($ids) { $s->delete($s->loadMultiple($ids)); }
  if ($nt = NodeType::load("hct_task")) { $nt->delete(); }
' >/dev/null 2>&1
drush sqlq "DELETE FROM cachetags WHERE tag='handy_cache_tags:node:hct_task'" >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: content type hct_task and its cachetags row removed"
