#!/usr/bin/env bash
# hook_post_action execution VERIFY: insert a node and dispatch hook_post_action's post hook the way
# the module does at shutdown (invokeAll), then confirm the agent's hook wrote state
# hpa_probe_last_insert = 'node:<nid>'. PASS/FAIL, exit 0/1. (Node is deleted afterwards.)
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\node\Entity\Node;
  \Drupal::state()->delete("hpa_probe_last_insert");
  $n = Node::create(["type" => "article", "title" => "hpa_probe_verify"]);
  $n->save();
  \Drupal::moduleHandler()->invokeAll("entity_postinsert", [$n]);
  $val = \Drupal::state()->get("hpa_probe_last_insert");
  $ok = ($val === "node:" . $n->id());
  print ($ok ? "PASS" : "FAIL") . " state=" . var_export($val, TRUE) . " expected=node:" . $n->id() . "\n";
  $n->delete();
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
