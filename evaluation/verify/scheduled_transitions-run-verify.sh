#!/usr/bin/env bash
# Execution VERIFY: PASS when the node "ST Run One" latest revision moderation state is 'archived'
# (the scheduled transition was processed).
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $ns = \Drupal::entityTypeManager()->getStorage("node")->loadByProperties(["title"=>"ST Run One"]);
  $n = $ns ? reset($ns) : NULL;
  if (!$n) { print "FAIL no-node\n"; return; }
  $storage = \Drupal::entityTypeManager()->getStorage("node");
  $latestId = $storage->getLatestRevisionId($n->id());
  $latest = $latestId ? $storage->loadRevision($latestId) : $n;
  $state = $latest->get("moderation_state")->value;
  print (($state === "archived") ? "PASS" : "FAIL")." state=".$state."\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
