#!/usr/bin/env bash
# Execution VERIFY: PASS when an Article 'node_class new post' exists with node_class === 'nc-created'.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\node\Entity\Node;
  $ids = \Drupal::entityQuery("node")->condition("title", "node_class new post")->condition("type","article")->accessCheck(FALSE)->execute();
  $val = NULL; $found = FALSE;
  foreach (Node::loadMultiple($ids) as $n) { $found = TRUE; if ($n->get("node_class")->value === "nc-created") { $val = "nc-created"; } }
  $ok = ($val === "nc-created");
  print ($ok ? "PASS" : "FAIL") . " found=" . var_export($found, TRUE) . " node_class=" . var_export($val, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
