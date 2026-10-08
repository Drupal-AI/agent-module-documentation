#!/usr/bin/env bash
# Execution VERIFY: PASS when a View with id ep_task_view exists and at least one of its
# displays uses the Entity Pager style (style.type === "entity_pager"). Prints PASS/FAIL;
# exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $view = \Drupal::entityTypeManager()->getStorage("view")->load("ep_task_view");
  $ok = FALSE; $found = "none";
  if ($view) {
    foreach ($view->get("display") as $id => $display) {
      $t = $display["display_options"]["style"]["type"] ?? NULL;
      if ($t === "entity_pager") { $ok = TRUE; $found = $id; break; }
    }
  }
  print ($ok ? "PASS" : "FAIL") . " view=" . ($view ? "ep_task_view" : "missing") . " entity_pager_display=" . $found . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
