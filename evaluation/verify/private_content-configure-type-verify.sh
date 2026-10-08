#!/usr/bin/env bash
# Execution VERIFY: PASS when content type pc_task has private_content.private == 3 (PRIVATE_ALWAYS).
# exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\node\Entity\NodeType;
  $t = NodeType::load("pc_task");
  $v = $t ? $t->getThirdPartySetting("private_content","private","unset") : "no-type";
  $ok = ((string) $v === "3");
  print ($ok ? "PASS" : "FAIL") . " private=" . var_export($v, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
