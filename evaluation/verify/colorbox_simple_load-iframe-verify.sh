#!/usr/bin/env bash
# Execution VERIFY: PASS when a custom block labelled "csl_task" has a colorbox-load link to
# /node/1 whose query string requests an iframe (iframe=true|yes) and width=900. Exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $blocks = \Drupal::entityTypeManager()->getStorage("block_content")->loadByProperties(["info" => "csl_task"]);
  $b = $blocks ? reset($blocks) : NULL;
  $body = $b ? strtolower((string) $b->get("body")->value) : "";
  $hasClass = (strpos($body, "colorbox-load") !== FALSE);
  $hasIframe = (strpos($body, "iframe=true") !== FALSE || strpos($body, "iframe=yes") !== FALSE);
  $hasW = (strpos($body, "width=900") !== FALSE);
  $ok = ($b && $hasClass && $hasIframe && $hasW);
  print ($ok ? "PASS" : "FAIL") . " block=" . ($b ? "yes" : "no") . " class=" . var_export($hasClass, TRUE) . " iframe=" . var_export($hasIframe, TRUE) . " w=" . var_export($hasW, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
