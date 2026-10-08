#!/usr/bin/env bash
# Execution VERIFY: PASS when entity_config.image_style.thumbnail.enabled === TRUE. exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '$v=\Drupal::config("graphql_compose.settings.graphql_compose_server")->get("entity_config.image_style.thumbnail.enabled"); print (($v===TRUE)?"PASS":"FAIL")." entity_config.image_style.thumbnail.enabled=".var_export($v,TRUE)."\n";' 2>/dev/null)
echo "$out"; echo "$out" | grep -q '^PASS' && exit 0 || exit 1
