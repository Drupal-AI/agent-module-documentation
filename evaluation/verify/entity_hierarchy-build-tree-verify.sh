#!/usr/bin/env bash
# HARD VERIFY: PASS when the "EH Child Node" article has field_eh_tree referencing the
# "EH Parent Node" article, AND the nested-set storage reports the child as a descendant of
# the parent. exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $ns = \Drupal::entityTypeManager()->getStorage("node");
  $p = $ns->loadByProperties(["title" => "EH Parent Node"]); $p = $p ? reset($p) : NULL;
  $c = $ns->loadByProperties(["title" => "EH Child Node"]);  $c = $c ? reset($c) : NULL;
  if (!$p || !$c) { print "FAIL nodes-missing\n"; return; }
  $ref = $c->get("field_eh_tree")->target_id ?? NULL;
  $ref_ok = ((string) $ref === (string) $p->id());
  // Confirm the nested-set tree has the child under the parent.
  $tree_ok = FALSE;
  try {
    $factory = \Drupal::service("entity_hierarchy.nested_set_storage_factory");
    $storage = $factory->get("field_eh_tree", "node");
    $keyFactory = \Drupal::service("entity_hierarchy.nested_set_node_factory");
    $descendants = $storage->getDescendants($keyFactory->fromEntity($p));
    foreach ($descendants as $d) { if ((string) $d->getId() === (string) $c->id()) { $tree_ok = TRUE; } }
  } catch (\Throwable $e) { $tree_ok = FALSE; }
  $ok = $ref_ok && $tree_ok;
  print ($ok ? "PASS" : "FAIL") . " ref=" . var_export($ref, TRUE) . " parent=" . $p->id() . " tree_ok=" . var_export($tree_ok, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
