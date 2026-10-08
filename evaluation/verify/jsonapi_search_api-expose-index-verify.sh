#!/usr/bin/env bash
# Execution VERIFY: PASS when jsonapi_search_api exposes index jsa_task, i.e. the module's
# route generator produces route jsonapi_search_api.index_jsa_task (only true when the index
# is enabled). exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $routes = \Drupal::service("class_resolver")
    ->getInstanceFromDefinition("Drupal\\jsonapi_search_api\\Routing\\Routes")->routes();
  $has = $routes->get("jsonapi_search_api.index_jsa_task") !== NULL;
  $enabled = ($i = \Drupal\search_api\Entity\Index::load("jsa_task")) ? $i->status() : FALSE;
  print ($has ? "PASS" : "FAIL") . " route=" . var_export($has, TRUE) . " enabled=" . var_export($enabled, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
