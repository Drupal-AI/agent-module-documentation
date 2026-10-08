#!/usr/bin/env bash
# Execution VERIFY: PASS when body_node_id_class is installed and produces a page-node-<nid> body
# class for the 'BNIC Home Node' Article page. Invokes the module's real hook_preprocess_html with
# the node pushed onto the route. When the module is uninstalled the hook function does not exist,
# so this FAILS. Exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  if (!function_exists("body_node_id_class_preprocess_html")) { print "FAIL module-not-installed\n"; return; }
  $nodes = \Drupal::entityTypeManager()->getStorage("node")->loadByProperties(["title" => "BNIC Home Node", "status" => 1]);
  if (!$nodes) { print "FAIL no-node\n"; return; }
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
  print (in_array("page-node-" . $n->id(), $classes, TRUE) ? "PASS" : "FAIL") . " classes=" . implode(",", $classes) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
