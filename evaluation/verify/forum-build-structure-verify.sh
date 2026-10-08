#!/usr/bin/env bash
# Live-state verification for the "build a forum container + a forum inside it" task.
# Prints PASS/FAIL and exits 0 (pass) / 1 (fail). No arguments.
# PASS when the `forums` vocabulary contains at least one leaf forum term
# (forum_container = 0) whose parent is a container term (forum_container = 1) — i.e. a real
# container -> forum hierarchy was built, not two loose terms.
set -uo pipefail
cd /var/www/html

out=$(drush php:eval '
  $storage = \Drupal::entityTypeManager()->getStorage("taxonomy_term");
  $terms = $storage->loadByProperties(["vid" => "forums"]);
  $containers = 0; $forums = 0; $nested = FALSE;
  foreach ($terms as $t) {
    $isContainer = (int) $t->forum_container->value === 1;
    if ($isContainer) { $containers++; }
    else {
      $forums++;
      foreach ($storage->loadParents($t->id()) as $p) {
        if ((int) $p->forum_container->value === 1) { $nested = TRUE; }
      }
    }
  }
  $ok = $containers >= 1 && $forums >= 1 && $nested;
  print (($ok ? "PASS" : "FAIL") . " containers=$containers forums=$forums nested=" . ($nested?1:0) . "\n");
' 2>/dev/null)

echo "$out" | grep -E '^(PASS|FAIL)'
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
