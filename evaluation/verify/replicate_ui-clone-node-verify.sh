#!/usr/bin/env bash
# Live-state verification for the "clone a node via the replicate service" hard case.
# Prints PASS/FAIL and exits 0 (pass) / 1 (fail). No arguments.
# The reset left exactly ONE article titled "Replicate Eval Source". A correct clone
# (via replicate.replicator->replicateEntity(), which copies the label) yields a second
# node whose title starts with that text (the confirm-form "(Copy)" suffix is tolerated
# by the prefix match). PASS when >= 2 such nodes exist. The script then deletes ALL of
# them so the site is left clean regardless of outcome.
set -uo pipefail
cd /var/www/html

out=$(drush php:eval '
  $storage = \Drupal::entityTypeManager()->getStorage("node");
  $ids = $storage->getQuery()->accessCheck(FALSE)
    ->condition("title", "Replicate Eval Source%", "LIKE")->execute();
  $count = count($ids);
  $pass = $count >= 2;
  // Leave the site clean: remove the source and any clones.
  if ($ids) { $storage->delete($storage->loadMultiple($ids)); }
  print "RESULT " . ($pass ? "PASS" : "FAIL") . " count=" . $count . "\n";
' 2>/dev/null | grep "^RESULT ")

echo "$out"
echo "$out" | grep -q '^RESULT PASS' && exit 0 || exit 1
