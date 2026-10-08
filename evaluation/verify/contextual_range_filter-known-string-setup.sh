#!/usr/bin/env bash
# Introspection SETUP: register the node title as a STRING (alphabetic) contextual range filter so
# an inspecting agent can read back which field is a string-range filter. Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("contextual_range_filter.settings")->set("string_field_names",["node__field_data:title"])->save();' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: contextual_range_filter.settings string_field_names=[node__field_data:title]"
