#!/usr/bin/env bash
# hook_post_action execution VERIFY: save+update a node, dispatch node_postupdate the way the module
# does at shutdown (invokeAll), confirm the agent's hook wrote state hpa_probe2_last_update = <nid>.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\node\Entity\Node;
  \Drupal::state()->delete("hpa_probe2_last_update");
  $n = Node::create(["type" => "article", "title" => "hpa_probe2_verify"]);
  $n->save();
  $n->setTitle("hpa_probe2_verify_updated");
  $n->save();
  \Drupal::moduleHandler()->invokeAll("node_postupdate", [$n]);
  $val = \Drupal::state()->get("hpa_probe2_last_update");
  $ok = ((string) $val === (string) $n->id());
  print ($ok ? "PASS" : "FAIL") . " state=" . var_export($val, TRUE) . " expected=" . $n->id() . "\n";
  $n->delete();
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
