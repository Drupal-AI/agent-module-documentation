#!/usr/bin/env bash
# Execution VERIFY: PASS when the entity_pager_example View's default display Entity Pager
# style has circular_paging === TRUE. Prints PASS/FAIL; exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $view = \Drupal::entityTypeManager()->getStorage("view")->load("entity_pager_example");
  $ok = FALSE; $type = "none"; $cp = NULL;
  if ($view) {
    $d = $view->getDisplay("default");
    $type = $d["display_options"]["style"]["type"] ?? "none";
    $cp = $d["display_options"]["style"]["options"]["circular_paging"] ?? NULL;
    $ok = ($type === "entity_pager" && $cp == TRUE);
  }
  print ($ok ? "PASS" : "FAIL") . " style=" . $type . " circular_paging=" . var_export($cp, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
