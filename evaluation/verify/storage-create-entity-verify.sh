#!/usr/bin/env bash
# Execution VERIFY: PASS when at least one 'storage' entity of type storage_item exists whose
# name contains 'Eval'. Prints PASS/FAIL. exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $s = \Drupal::entityTypeManager()->getStorage("storage");
  $ids = $s->getQuery()->accessCheck(FALSE)->condition("type","storage_item")->execute();
  $match = 0;
  foreach ($ids as $id) {
    $e = $s->load($id);
    if ($e && stripos((string) $e->getName(), "Eval") !== FALSE) { $match++; }
  }
  $ok = ($match > 0);
  print ($ok ? "PASS" : "FAIL") . " storage_item_entities=" . count($ids) . " name_matches=" . $match . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
