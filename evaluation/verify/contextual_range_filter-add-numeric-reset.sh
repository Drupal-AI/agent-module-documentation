#!/usr/bin/env bash
# Execution RESET: ensure field_crf_task is NOT registered as a numeric range filter (remove just
# that entry, leaving any others) so verify FAILS until the agent registers it. Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $c = \Drupal::configFactory()->getEditable("contextual_range_filter.settings");
  $list = array_values(array_filter((array) ($c->get("numeric_field_names") ?? []), fn($v) => $v !== "node__field_crf_task:field_crf_task_value"));
  $c->set("numeric_field_names", $list)->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: field_crf_task removed from numeric_field_names"
