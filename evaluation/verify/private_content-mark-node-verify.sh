#!/usr/bin/env bash
# Execution VERIFY: PASS when node 'PC Task Node' is marked private (private field isPrivate()
# true / stored 1). exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\node\Entity\Node;
  $ids = \Drupal::entityQuery("node")->condition("title","PC Task Node")->accessCheck(FALSE)->execute();
  $n = $ids ? Node::load(reset($ids)) : NULL;
  $stored = $n ? (int) $n->get("private")->stored : -1;
  $priv = $n ? (bool) $n->get("private")->isPrivate() : FALSE;
  $ok = ($n && $priv && $stored === 1);
  print ($ok ? "PASS" : "FAIL") . " stored=" . $stored . " isPrivate=" . var_export($priv, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
