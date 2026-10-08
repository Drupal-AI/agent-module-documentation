#!/usr/bin/env bash
# Execution VERIFY (openapi_rest): PASS when the node entity is REST-enabled so openapi_rest's
# 'rest' generator will document it -- i.e. rest_resource_config 'entity.node' exists, is enabled,
# and exposes GET with the json format (the exact input the generator reads). exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\rest\Entity\RestResourceConfig;
  $c = RestResourceConfig::load("entity.node");
  $ok = FALSE; $methods = []; $fmts = [];
  if ($c && $c->status()) {
    $methods = $c->getMethods();
    if (in_array("GET", $methods, TRUE)) { $fmts = $c->getFormats("GET"); $ok = in_array("json", $fmts, TRUE); }
  }
  print ($ok ? "PASS" : "FAIL") . " methods=" . implode(",", $methods) . " get_formats=" . implode(",", $fmts) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
