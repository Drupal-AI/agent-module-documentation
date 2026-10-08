#!/usr/bin/env bash
# Execution VERIFY: PASS when node.page has a FieldConfig for field_ft_source. exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\field\Entity\FieldConfig;
  $fc = FieldConfig::loadByName("node", "page", "field_ft_source");
  print ($fc ? "PASS" : "FAIL") . " page_field=" . ($fc ? "present" : "missing") . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
