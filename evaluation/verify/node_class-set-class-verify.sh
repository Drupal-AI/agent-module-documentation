#!/usr/bin/env bash
# Execution VERIFY: PASS when the Article 'node_class execution target' has node_class === 'nc-hero'.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\node\Entity\Node;
  $ids = \Drupal::entityQuery("node")->condition("title", "node_class execution target")->accessCheck(FALSE)->execute();
  $val = NULL;
  if ($ids) { $val = Node::load(reset($ids))->get("node_class")->value; }
  $ok = ($val === "nc-hero");
  print ($ok ? "PASS" : "FAIL") . " node_class=" . var_export($val, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
