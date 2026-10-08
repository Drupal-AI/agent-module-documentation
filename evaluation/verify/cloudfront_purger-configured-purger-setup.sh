#!/usr/bin/env bash
# Introspection SETUP: ensure a 'cloudfront' purger is registered in Purge. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $c = \Drupal::configFactory()->getEditable("purge.plugins");
  $purgers = $c->get("purgers") ?: [];
  foreach ($purgers as $p) { if (($p["plugin_id"] ?? "") === "cloudfront") { exit; } }
  $purgers[] = ["instance_id" => "cf_known01", "plugin_id" => "cloudfront", "order_index" => count($purgers) + 1];
  $c->set("purgers", $purgers)->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: cloudfront purger registered in purge.plugins"
