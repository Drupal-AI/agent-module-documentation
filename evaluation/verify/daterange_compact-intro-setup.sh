#!/usr/bin/env bash
# Introspection SETUP (daterange_compact): create a compact date range format config entity
# dc_known with default_pattern d/m/Y and default_separator " thru ". Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $s = \Drupal::entityTypeManager()->getStorage("daterange_compact_format");
  if ($e = $s->load("dc_known")) { $e->delete(); }
  $s->create([
    "id" => "dc_known", "label" => "DC Known",
    "default_pattern" => "d/m/Y", "default_separator" => " thru ",
    "same_month_start_pattern" => "j", "same_month_end_pattern" => "j F Y", "same_month_separator" => "-",
  ])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: daterange_compact.format.dc_known default_pattern=d/m/Y separator=' thru '"
