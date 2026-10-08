#!/usr/bin/env bash
# Execution VERIFY: PASS when graphql_compose_layouts is present in the server's schema_configuration.graphql_compose.providers.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '$p=(array)\Drupal::config("graphql.graphql_servers.graphql_compose_server")->get("schema_configuration.graphql_compose.providers"); $ok=in_array("graphql_compose_layouts",$p,TRUE)||array_key_exists("graphql_compose_layouts",$p); print (($ok)?"PASS":"FAIL")." providers=".json_encode($p)."\n";' 2>/dev/null)
echo "$out"; echo "$out" | grep -q '^PASS' && exit 0 || exit 1
