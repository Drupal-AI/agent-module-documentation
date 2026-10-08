#!/usr/bin/env bash
# Execution RESET: register field_crf_toggle as a numeric range filter (add the entry) so the
# "convert it back" task starts from a converted state; verify (which checks it is ABSENT) then
# FAILS until the agent removes it. Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $c = \Drupal::configFactory()->getEditable("contextual_range_filter.settings");
  $list = (array) ($c->get("numeric_field_names") ?? []);
  if (!in_array("node__field_crf_toggle:field_crf_toggle_value", $list, TRUE)) { $list[] = "node__field_crf_toggle:field_crf_toggle_value"; }
  $c->set("numeric_field_names", array_values($list))->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: field_crf_toggle registered as numeric range filter"
