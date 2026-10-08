#!/usr/bin/env bash
# Execution VERIFY: PASS when a newly created Article node defaults to display_updated = TRUE
# (i.e. the content-type default has been turned on). exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  \Drupal::service("entity_field.manager")->clearCachedFieldDefinitions();
  $node = \Drupal::entityTypeManager()->getStorage("node")->create(["type"=>"article"]);
  $val = $node->display_updated->value;
  $ok = ((bool) $val === TRUE);
  print ($ok ? "PASS" : "FAIL") . " article_default_display_updated=" . var_export($val, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
