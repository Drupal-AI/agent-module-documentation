#!/usr/bin/env bash
# Execution VERIFY: PASS when Article has a field named field_slf_task of type social_links
# (non-deleted). Read-only. Prints PASS/FAIL. exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\field\Entity\FieldConfig;
  $fc = FieldConfig::loadByName("node", "article", "field_slf_task");
  $type = $fc ? $fc->getType() : "none";
  $ok = ($fc && !$fc->isDeleted() && $type === "social_links");
  print ($ok ? "PASS" : "FAIL") . " type=" . $type . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
