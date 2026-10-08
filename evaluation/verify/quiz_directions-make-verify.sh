#!/usr/bin/env bash
# Execution VERIFY: PASS when a quiz_question of type 'directions' titled quiz_dir_task exists
# with non-empty body text. Prints PASS/FAIL; exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $l = \Drupal::entityTypeManager()->getStorage("quiz_question")->loadByProperties(["type"=>"directions","title"=>"quiz_dir_task"]);
  $q = $l ? reset($l) : NULL;
  $body = $q ? trim((string) $q->get("body")->value) : "";
  $ok = ($q && $q->bundle() === "directions" && $body !== "");
  print ($ok ? "PASS" : "FAIL") . " exists=" . ($q?"1":"0") . " bundle=" . ($q?$q->bundle():"none") . " body_len=" . strlen($body) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
