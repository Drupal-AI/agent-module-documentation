#!/usr/bin/env bash
# Execution VERIFY (message_subscribe_example): PASS when a published node titled 'MS Example Task Node'
# exists AND the example's node_insert produced a 'publish_node' Message referencing that node
# (field_node_reference). exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $nids = \Drupal::entityQuery("node")->condition("title", "MS Example Task Node")->condition("status", 1)->accessCheck(FALSE)->execute();
  $ok = FALSE; $msg = "none";
  if ($nids) {
    $nid = reset($nids);
    $mids = \Drupal::entityQuery("message")->condition("template", "publish_node")->condition("field_node_reference.target_id", $nid)->accessCheck(FALSE)->execute();
    if ($mids) { $ok = TRUE; $msg = "publish_node->node:".$nid; }
  }
  print ($ok ? "PASS" : "FAIL") . " node=" . ($nids ? reset($nids) : "missing") . " message=" . $msg . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
