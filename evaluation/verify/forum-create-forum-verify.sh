#!/usr/bin/env bash
# Live-state verification for the "create a leaf forum named Support" task.
# Prints PASS/FAIL and exits 0 (pass) / 1 (fail). No arguments.
# PASS when the `forums` vocabulary contains a term named exactly "Support" that is a leaf
# forum (forum_container = 0), i.e. a postable forum, not a container.
set -uo pipefail
cd /var/www/html

out=$(drush php:eval '
  $storage = \Drupal::entityTypeManager()->getStorage("taxonomy_term");
  $found = FALSE; $asForum = FALSE;
  foreach ($storage->loadByProperties(["vid" => "forums", "name" => "Support"]) as $t) {
    $found = TRUE;
    if ((int) $t->forum_container->value === 0) { $asForum = TRUE; }
  }
  $ok = $found && $asForum;
  print (($ok ? "PASS" : "FAIL") . " found=" . ($found?1:0) . " leaf_forum=" . ($asForum?1:0) . "\n");
' 2>/dev/null)

echo "$out" | grep -E '^(PASS|FAIL)'
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
