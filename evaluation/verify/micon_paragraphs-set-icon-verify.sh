#!/usr/bin/env bash
# Execution VERIFY: PASS when micon_pg_task carries micon_paragraphs.icon = fa-star. Exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $t = \Drupal\paragraphs\Entity\ParagraphsType::load("micon_pg_task");
  $icon = $t ? $t->getThirdPartySetting("micon_paragraphs","icon") : NULL;
  print (($icon === "fa-star") ? "PASS" : "FAIL") . " icon=" . var_export($icon, TRUE) . "\n";
' 2>/dev/null)
echo "$out"; echo "$out" | grep -q "^PASS" && exit 0 || exit 1
