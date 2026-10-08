#!/usr/bin/env bash
# Execution VERIFY: PASS when the commerce_cart_collection REST resource is enabled — a
# rest.resource config with plugin_id commerce_cart_collection, status true, and GET among its
# methods. Prints PASS/FAIL; exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\rest\Entity\RestResourceConfig;
  $c = RestResourceConfig::load("commerce_cart_collection");
  $plugin = $c ? $c->get("plugin_id") : "";
  $methods = $c ? ($c->get("configuration")["methods"] ?? []) : [];
  $ok = $c && $c->status() && $plugin === "commerce_cart_collection" && in_array("GET", $methods, TRUE);
  print ($ok ? "PASS" : "FAIL") . " exists=" . ($c ? "yes" : "no") . " status=" . var_export($c ? $c->status() : NULL, TRUE) . " methods=" . json_encode($methods) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
