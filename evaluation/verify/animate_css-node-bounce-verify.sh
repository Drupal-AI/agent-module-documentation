#!/usr/bin/env bash
# Execution VERIFY: PASS when a node titled 'animate_css_bounce*' has a body containing both
# animate__animated and animate__bounce. Exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $ids = \Drupal::entityTypeManager()->getStorage("node")->getQuery()->accessCheck(FALSE)
    ->condition("title", "animate_css_bounce%", "LIKE")->execute();
  $ok = FALSE;
  foreach (\Drupal\node\Entity\Node::loadMultiple($ids) as $n) {
    $b = $n->hasField("body") ? (string) ($n->get("body")->value ?? "") : "";
    if (strpos($b, "animate__animated") !== FALSE && strpos($b, "animate__bounce") !== FALSE) { $ok = TRUE; }
  }
  print ($ok ? "PASS" : "FAIL") . " matches=" . count($ids) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
