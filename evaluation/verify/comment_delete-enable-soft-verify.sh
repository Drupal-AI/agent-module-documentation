#!/usr/bin/env bash
# Execution VERIFY: PASS when node.comment_forum comment_delete.operation has 'soft' selected.
# exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\field\Entity\FieldConfig;
  $f = FieldConfig::loadByName("node","forum","comment_forum");
  $op = $f ? ($f->getThirdPartySetting("comment_delete","operation") ?: []) : [];
  $ok = !empty($op["soft"]);
  print ($ok ? "PASS" : "FAIL") . " operation=" . json_encode($op) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
