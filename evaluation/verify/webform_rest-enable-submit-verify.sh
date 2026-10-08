#!/usr/bin/env bash
# HARD execution verify: the webform_rest_submit REST resource must be enabled via a
# rest_resource_config entity exposing POST, at least one serialization format, and at least
# one authentication provider. Prints PASS/FAIL, exits 0 (pass) / 1 (fail).
set -uo pipefail
cd /var/www/html

out=$(drush php:eval '
  $c = \Drupal::config("rest.resource.webform_rest_submit");
  $exists = ($c->get("id") === "webform_rest_submit");
  $plugin = ($c->get("plugin_id") === "webform_rest_submit");
  $methods = array_map("strtoupper", (array) $c->get("configuration.methods"));
  $formats = (array) $c->get("configuration.formats");
  $auth = (array) $c->get("configuration.authentication");
  $ok = $exists && $plugin && in_array("POST", $methods, TRUE) && count($formats) >= 1 && count($auth) >= 1;
  print ($ok ? "PASS" : "FAIL") . " exists=" . ($exists?1:0)
      . " methods=" . implode("|", $methods)
      . " formats=" . implode("|", $formats)
      . " auth=" . implode("|", $auth) . "\n";
' 2>/dev/null | grep -Ev "^\s*(Deprecated|Warning|Notice):" | grep -E "^(PASS|FAIL)")

echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
