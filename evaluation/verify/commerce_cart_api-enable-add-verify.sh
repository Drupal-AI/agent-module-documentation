#!/usr/bin/env bash
# Execution VERIFY: PASS when the commerce_cart_add REST resource is enabled — a rest.resource
# config with plugin_id commerce_cart_add, status true, and POST among its methods. Prints
# PASS/FAIL; exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\rest\Entity\RestResourceConfig;
  $c = RestResourceConfig::load("commerce_cart_add");
  $plugin = $c ? $c->get("plugin_id") : "";
  $methods = $c ? ($c->get("configuration")["methods"] ?? []) : [];
  $ok = $c && $c->status() && $plugin === "commerce_cart_add" && in_array("POST", $methods, TRUE);
  print ($ok ? "PASS" : "FAIL") . " exists=" . ($c ? "yes" : "no") . " status=" . var_export($c ? $c->status() : NULL, TRUE) . " methods=" . json_encode($methods) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
