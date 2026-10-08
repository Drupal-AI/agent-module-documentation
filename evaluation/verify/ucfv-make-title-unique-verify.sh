#!/usr/bin/env bash
# Execution VERIFY: PASS when node.type.article third_party unique_content_field_validation.unique
# is TRUE. exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\node\Entity\NodeType;
  $t = NodeType::load("article");
  $u = $t ? $t->getThirdPartySetting("unique_content_field_validation", "unique", FALSE) : NULL;
  $ok = ($u === TRUE || $u === 1 || $u === "1");
  print ($ok ? "PASS" : "FAIL") . " unique=" . var_export($u, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
