#!/usr/bin/env bash
# Execution VERIFY: PASS when node "CB Hard Two" is bundle convbnd2_to AND its
# field_convbnd_dst == "mango" (the source value was mapped across).
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $ns = \Drupal::entityTypeManager()->getStorage("node")->loadByProperties(["title" => "CB Hard Two"]);
  $n = $ns ? reset($ns) : NULL;
  $b = $n ? $n->bundle() : "none";
  $dst = ($n && $n->hasField("field_convbnd_dst") && !$n->get("field_convbnd_dst")->isEmpty()) ? $n->get("field_convbnd_dst")->value : "";
  $ok = ($b === "convbnd2_to" && $dst === "mango");
  print ($ok ? "PASS" : "FAIL") . " bundle=" . $b . " dst=" . var_export($dst, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
