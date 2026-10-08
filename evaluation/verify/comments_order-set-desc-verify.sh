#!/usr/bin/env bash
# Execution VERIFY: PASS when field_co_task on node.article has comments_order.order === DESC.
# Prints PASS/FAIL; exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\field\Entity\FieldConfig;
  $f = FieldConfig::loadByName("node", "article", "field_co_task");
  $order = $f ? $f->getThirdPartySetting("comments_order", "order", "ASC") : NULL;
  $ok = ($order === "DESC");
  print ($ok ? "PASS" : "FAIL") . " order=" . var_export($order, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
