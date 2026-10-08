#!/usr/bin/env bash
# Execution VERIFY: PASS when at least one enabled block config entity uses the
# last_login_block plugin. exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $storage = \Drupal::entityTypeManager()->getStorage("block");
  $blocks = $storage->loadByProperties(["plugin" => "last_login_block"]);
  $enabled = array_filter($blocks, fn($b) => $b->status());
  print (count($enabled) > 0 ? "PASS" : "FAIL") . " last_login_block_blocks=" . count($enabled) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
