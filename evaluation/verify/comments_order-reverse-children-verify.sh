#!/usr/bin/env bash
# Execution VERIFY: PASS when field_co_thread keeps order DESC AND children_natural_order is
# 0/false (parents and children both reversed). Prints PASS/FAIL; exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\field\Entity\FieldConfig;
  $f = FieldConfig::loadByName("node", "article", "field_co_thread");
  $order = $f ? $f->getThirdPartySetting("comments_order", "order", "ASC") : NULL;
  $cno = $f ? $f->getThirdPartySetting("comments_order", "children_natural_order", 1) : NULL;
  $ok = ($order === "DESC" && (int) $cno === 0);
  print ($ok ? "PASS" : "FAIL") . " order=" . var_export($order, TRUE) . " children_natural_order=" . var_export($cno, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
