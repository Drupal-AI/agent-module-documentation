#!/usr/bin/env bash
# Execution VERIFY: PASS when a PUBLISHED node of type bnic_land exists AND body_node_id_class adds
# the body classes page-node-<nid> and page-node-type-bnic_land for its page. The check invokes the
# module's real hook_preprocess_html with the node pushed onto the route (a full HTTP render is
# avoided because unrelated site modules can 500 in the CLI). Exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  if (!function_exists("body_node_id_class_preprocess_html")) { print "FAIL module-not-installed\n"; return; }
  $nodes = \Drupal::entityTypeManager()->getStorage("node")->loadByProperties(["type" => "bnic_land", "status" => 1]);
  if (!$nodes) { print "FAIL no-published-bnic_land-node\n"; return; }
  $n = reset($nodes);
  $route = \Drupal::service("router.route_provider")->getRouteByName("entity.node.canonical");
  $request = \Symfony\Component\HttpFoundation\Request::create("/node/" . $n->id());
  $request->attributes->set("_route", "entity.node.canonical");
  $request->attributes->set("_route_object", $route);
  $request->attributes->set("node", $n);
  \Drupal::requestStack()->push($request);
  $variables = ["attributes" => ["class" => []]];
  body_node_id_class_preprocess_html($variables);
  \Drupal::requestStack()->pop();
  $classes = $variables["attributes"]["class"];
  $ok = in_array("page-node-type-bnic_land", $classes, TRUE) && in_array("page-node-" . $n->id(), $classes, TRUE);
  print ($ok ? "PASS" : "FAIL") . " classes=" . implode(",", $classes) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
