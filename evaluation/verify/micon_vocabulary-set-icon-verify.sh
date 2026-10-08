#!/usr/bin/env bash
# Execution VERIFY: PASS when micon_vocab_task carries micon_vocabulary.icon = fa-star. Exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $v = \Drupal\taxonomy\Entity\Vocabulary::load("micon_vocab_task");
  $icon = $v ? $v->getThirdPartySetting("micon_vocabulary","icon") : NULL;
  print (($icon === "fa-star") ? "PASS" : "FAIL") . " icon=" . var_export($icon, TRUE) . "\n";
' 2>/dev/null)
echo "$out"; echo "$out" | grep -q "^PASS" && exit 0 || exit 1
