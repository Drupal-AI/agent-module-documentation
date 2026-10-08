#!/usr/bin/env bash
# Execution VERIFY: PASS when the 'RUC Sample' node is authored by ruc_target. exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $nodes = \Drupal::entityTypeManager()->getStorage("node")->loadByProperties(["title" => "RUC Sample"]);
  $tgt = \Drupal::entityTypeManager()->getStorage("user")->loadByProperties(["name" => "ruc_target"]);
  if (!$nodes || !$tgt) { print "FAIL missing-fixture"; }
  else {
    $node = reset($nodes); $target = reset($tgt);
    $ok = ((int) $node->getOwnerId() === (int) $target->id());
    print ($ok ? "PASS" : "FAIL") . " owner_uid=" . $node->getOwnerId() . " target_uid=" . $target->id();
  }
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
