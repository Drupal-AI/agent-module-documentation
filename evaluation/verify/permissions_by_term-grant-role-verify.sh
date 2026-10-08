#!/usr/bin/env bash
# Execution VERIFY for "grant the role pbt_task_role access to the term 'PBT Task Term'".
# PASS when permissions_by_term_role holds a row for that term's tid with rid pbt_task_role.
# (Permissions by Term also auto-grants roles holding 'bypass node access', so extra rows are
# expected and ignored.) Prints PASS/FAIL; exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $storage = \Drupal::entityTypeManager()->getStorage("taxonomy_term");
  $found = $storage->loadByProperties(["vid" => "pbt_task_vocab", "name" => "PBT Task Term"]);
  $term = $found ? reset($found) : NULL;
  if (!$term) { print "FAIL term=missing\n"; return; }
  $rows = \Drupal::database()->select("permissions_by_term_role", "r")->fields("r")
    ->condition("tid", $term->id())->execute()->fetchAll();
  $rids = array_map(fn($r) => $r->rid, $rows);
  $ok = in_array("pbt_task_role", $rids, TRUE);
  print ($ok ? "PASS" : "FAIL") . " tid=" . $term->id() . " rids=" . implode(",", $rids) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
