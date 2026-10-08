#!/usr/bin/env bash
# Execution VERIFY: PASS when a custom block labelled "csl_task" exists whose body HTML contains
# a colorbox-load link that opens at width=800 and height=600. Exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $blocks = \Drupal::entityTypeManager()->getStorage("block_content")->loadByProperties(["info" => "csl_task"]);
  $b = $blocks ? reset($blocks) : NULL;
  $body = $b ? (string) $b->get("body")->value : "";
  $hasClass = (stripos($body, "colorbox-load") !== FALSE);
  $hasW = (stripos($body, "width=800") !== FALSE);
  $hasH = (stripos($body, "height=600") !== FALSE);
  $ok = ($b && $hasClass && $hasW && $hasH);
  print ($ok ? "PASS" : "FAIL") . " block=" . ($b ? "yes" : "no") . " class=" . var_export($hasClass, TRUE) . " w=" . var_export($hasW, TRUE) . " h=" . var_export($hasH, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
