#!/usr/bin/env bash
# Execution VERIFY: PASS when md_part has the two "MD Keep" links but NEITHER "MD Del" link.
# exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $storage = \Drupal::entityTypeManager()->getStorage("menu_link_content");
  $titles = [];
  foreach ($storage->loadByProperties(["menu_name" => "md_part"]) as $l) { $titles[] = $l->getTitle(); }
  $has = fn($t) => in_array($t, $titles, TRUE);
  $ok = $has("MD Keep A") && $has("MD Keep D") && !$has("MD Del B") && !$has("MD Del C");
  print ($ok ? "PASS" : "FAIL") . " remaining=[" . implode("|", $titles) . "]\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
