#!/usr/bin/env bash
# Execution CLEANUP: delete preview links for the target node and the node itself.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $ids = \Drupal::entityTypeManager()->getStorage("node")->getQuery()
    ->accessCheck(FALSE)->condition("type","article")->condition("title","PL Hard Target")->execute();
  foreach ($ids as $nid) {
    $pls = \Drupal::entityTypeManager()->getStorage("preview_link")->getQuery()
      ->accessCheck(FALSE)->condition("entities.target_type","node")->condition("entities.target_id",$nid)->execute();
    if ($pls) { $s=\Drupal::entityTypeManager()->getStorage("preview_link"); $s->delete($s->loadMultiple($pls)); }
    if ($n = \Drupal\node\Entity\Node::load($nid)) { $n->delete(); }
  }
' >/dev/null 2>&1
echo "cleanup: PL Hard Target node + its preview links removed"
