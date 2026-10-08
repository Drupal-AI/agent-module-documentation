#!/usr/bin/env bash
# Execution VERIFY: PASS when view vttnii_task2's tid validator is restricted to vttnii_vocab
# (validate_options.bundles contains vttnii_vocab) and validate.type is taxonomy_term_name_into_id.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $d = \Drupal::service("config.storage")->read("views.view.vttnii_task2");
  $arg = $d["display"]["default"]["display_options"]["arguments"]["tid"] ?? [];
  $type = $arg["validate"]["type"] ?? "";
  $b = $arg["validate_options"]["bundles"] ?? [];
  $ok = ($type === "taxonomy_term_name_into_id" && !empty($b["vttnii_vocab"]));
  print ($ok ? "PASS" : "FAIL") . " bundles=" . implode(",", array_keys((array) $b)) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
