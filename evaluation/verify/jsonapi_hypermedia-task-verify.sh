#!/usr/bin/env bash
# Execution VERIFY: PASS when the provider manager has a LinkProvider plugin, provided by the
# module 'jsonapi_hypermedia_task', with link_key 'task_action' targeting a top-level (entrypoint)
# links object. Prints PASS/FAIL; exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $defs = \Drupal::service("jsonapi_hypermedia_provider.manager")->getDefinitions();
  $ok = FALSE;
  foreach ($defs as $id => $d) {
    if (($d["provider"] ?? "") === "jsonapi_hypermedia_task"
        && ($d["link_key"] ?? "") === "task_action"
        && !empty($d["link_context"]["top_level_object"])) { $ok = TRUE; }
  }
  print ($ok ? "PASS" : "FAIL") . " ids=" . implode(",", array_keys($defs)) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
