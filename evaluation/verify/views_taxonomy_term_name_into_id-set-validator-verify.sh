#!/usr/bin/env bash
# Execution VERIFY: PASS when view vttnii_task's tid contextual filter uses validator
# taxonomy_term_name_into_id. Reads raw config storage. exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $d = \Drupal::service("config.storage")->read("views.view.vttnii_task");
  $t = $d["display"]["default"]["display_options"]["arguments"]["tid"]["validate"]["type"] ?? "none";
  print (($t === "taxonomy_term_name_into_id") ? "PASS" : "FAIL") . " validate.type=" . $t . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
