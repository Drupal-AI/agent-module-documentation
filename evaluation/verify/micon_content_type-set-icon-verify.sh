#!/usr/bin/env bash
# Execution VERIFY: PASS when micon_ct_task carries micon_content_type.icon = fa-star.
# Exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $t = \Drupal\node\Entity\NodeType::load("micon_ct_task");
  $icon = $t ? $t->getThirdPartySetting("micon_content_type","icon") : NULL;
  $ok = ($icon === "fa-star");
  print ($ok ? "PASS" : "FAIL") . " icon=" . var_export($icon, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q "^PASS" && exit 0 || exit 1
