#!/usr/bin/env bash
# Execution VERIFY for "let pbe_ent_role view non-node entities tagged with 'PBE Entity Term'".
# PASS when permissions_by_term_role holds a row for that term's tid with rid pbe_ent_role AND
# permissions_by_term.settings:target_bundles contains pbe_ent_vocab (without which
# permissions_by_entity never treats such an entity as access controlled).
# Prints PASS/FAIL; exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $storage = \Drupal::entityTypeManager()->getStorage("taxonomy_term");
  $found = $storage->loadByProperties(["vid" => "pbe_ent_vocab", "name" => "PBE Entity Term"]);
  $term = $found ? reset($found) : NULL;
  if (!$term) { print "FAIL term=missing\n"; return; }
  $rids = array_map(fn($r) => $r->rid, \Drupal::database()->select("permissions_by_term_role", "r")
    ->fields("r")->condition("tid", $term->id())->execute()->fetchAll());
  $bundles = array_values(array_filter((array) \Drupal::config("permissions_by_term.settings")->get("target_bundles")));
  $ok = in_array("pbe_ent_role", $rids, TRUE) && in_array("pbe_ent_vocab", $bundles, TRUE);
  print ($ok ? "PASS" : "FAIL") . " tid=" . $term->id() . " rids=" . implode(",", $rids)
    . " target_bundles=" . json_encode($bundles) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
