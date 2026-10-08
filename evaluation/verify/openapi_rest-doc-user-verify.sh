#!/usr/bin/env bash
# Execution VERIFY (openapi_rest): PASS when the user entity is REST-enabled so openapi_rest's
# 'rest' generator will document it -- i.e. the rest_resource_config 'entity.user' exists, is
# enabled, and exposes the GET method with the json format. This is exactly the config the
# generator reads (RestInspectionTrait::getResourceConfigs -> getPaths). exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\rest\Entity\RestResourceConfig;
  $c = RestResourceConfig::load("entity.user");
  $ok = FALSE; $methods = []; $fmts = [];
  if ($c && $c->status()) {
    $methods = $c->getMethods();
    if (in_array("GET", $methods, TRUE)) { $fmts = $c->getFormats("GET"); $ok = in_array("json", $fmts, TRUE); }
  }
  print ($ok ? "PASS" : "FAIL") . " methods=" . implode(",", $methods) . " get_formats=" . implode(",", $fmts) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
