#!/usr/bin/env bash
# Execution VERIFY: PASS when the 'PL Hard Target' Article node has at least one (unexpired)
# preview link, per the preview_link.host service.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $ids = \Drupal::entityTypeManager()->getStorage("node")->getQuery()
    ->accessCheck(FALSE)->condition("type","article")->condition("title","PL Hard Target")->execute();
  if (!$ids) { print "FAIL node-missing\n"; return; }
  $node = \Drupal\node\Entity\Node::load(reset($ids));
  $has = \Drupal::service("preview_link.host")->hasPreviewLinks($node);
  print ($has ? "PASS" : "FAIL") . " nid=" . $node->id() . " hasPreviewLinks=" . var_export($has, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
