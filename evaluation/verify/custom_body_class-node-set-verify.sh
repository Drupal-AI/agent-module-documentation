#!/usr/bin/env bash
# Execution VERIFY: PASS when an Article titled "CBC Hard Node" exists with its custom
# body_class field == "launch-hero".
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\node\Entity\Node;
  $ids = \Drupal::entityQuery("node")->condition("title", "CBC Hard Node")->accessCheck(FALSE)->execute();
  $val = "none"; $ok = FALSE;
  if ($ids) {
    $n = Node::load(reset($ids));
    $val = $n->get("body_class")->value;
    $ok = ($val === "launch-hero");
  }
  print ($ok ? "PASS" : "FAIL") . " body_class=" . var_export($val, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q "^PASS" && exit 0 || exit 1
