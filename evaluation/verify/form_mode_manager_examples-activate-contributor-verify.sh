#!/usr/bin/env bash
# Execution VERIFY: PASS when the examples' 'contributor' form mode is activated on the Article
# bundle, i.e. a core.entity_form_display.node.article.contributor config entity exists.
# exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $d = \Drupal::entityTypeManager()->getStorage("entity_form_display")->load("node.article.contributor");
  $ok = (bool) $d;
  print ($ok ? "PASS" : "FAIL") . " node.article.contributor=" . ($d ? "present" : "absent") . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
