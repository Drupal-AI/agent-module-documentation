#!/usr/bin/env bash
# Execution VERIFY: PASS when the 'tags' vocabulary contains tcei_Europe and tcei_France, and
# tcei_France's parent is tcei_Europe. Prints PASS/FAIL; exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $ts = \Drupal::entityTypeManager()->getStorage("taxonomy_term");
  $eu = $ts->loadByProperties(["name"=>"tcei_Europe","vid"=>"tags"]);
  $fr = $ts->loadByProperties(["name"=>"tcei_France","vid"=>"tags"]);
  $parent = "";
  if ($fr) { $f = reset($fr); foreach ($f->get("parent")->getValue() as $p) { if ($pt = $ts->load($p["target_id"])) { $parent = $pt->getName(); } } }
  $ok = $eu && $fr && $parent === "tcei_Europe";
  print ($ok ? "PASS" : "FAIL") . " europe=" . (count($eu)) . " france=" . (count($fr)) . " france_parent=" . var_export($parent, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
