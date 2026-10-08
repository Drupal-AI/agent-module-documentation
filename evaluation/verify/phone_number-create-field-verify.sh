#!/usr/bin/env bash
# Execution VERIFY: PASS when node.article has field_pn_task of type phone_number. exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\field\Entity\FieldConfig;
  $fc = FieldConfig::loadByName("node","article","field_pn_task");
  $type = $fc ? $fc->getType() : "none";
  $ok = $fc && ($type === "phone_number");
  print ($ok?"PASS":"FAIL")." field_pn_task type=".$type."\n";
' 2>/dev/null)
echo "$out"; echo "$out" | grep -q '^PASS' && exit 0 || exit 1
