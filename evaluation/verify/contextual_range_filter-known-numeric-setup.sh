#!/usr/bin/env bash
# Introspection SETUP: register a known field as a NUMERIC contextual range filter in the module's
# settings so an inspecting agent can read back which field was converted. Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("contextual_range_filter.settings")->set("numeric_field_names",["node__field_crf_probe:field_crf_probe_value"])->save();' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: contextual_range_filter.settings numeric_field_names=[node__field_crf_probe:field_crf_probe_value]"
