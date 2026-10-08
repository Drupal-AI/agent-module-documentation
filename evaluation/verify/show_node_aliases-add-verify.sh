#!/usr/bin/env bash
# Execution VERIFY: PASS when a path_alias exists with alias /sna-task-promo pointing at the
# system path of the node titled sna_task_node. Prints PASS/FAIL; exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $ids = \Drupal::entityTypeManager()->getStorage("node")->getQuery()
    ->accessCheck(FALSE)->condition("title", "sna_task_node")->execute();
  $ok = FALSE; $nid = $ids ? reset($ids) : NULL;
  if ($nid) {
    $m = \Drupal::entityTypeManager()->getStorage("path_alias")->loadByProperties([
      "path" => "/node/" . $nid, "alias" => "/sna-task-promo",
    ]);
    $ok = !empty($m);
  }
  print ($ok ? "PASS" : "FAIL") . " nid=" . var_export($nid, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
