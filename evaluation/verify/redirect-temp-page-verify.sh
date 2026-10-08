#!/usr/bin/env bash
# Live-state verification for the "eval-temp-page -> /node/1, temporary 302" redirect task.
# Prints PASS/FAIL with detail and exits 0 (pass) / 1 (fail). No arguments.
# PASS only if a redirect entity exists whose source path is `eval-temp-page`, whose
# status_code is 302, and whose target (redirect_redirect) points to node/1.
set -uo pipefail
cd /var/www/html

out=$(drush php:eval '
  $storage = \Drupal::entityTypeManager()->getStorage("redirect");
  $matches = $storage->loadByProperties(["redirect_source__path" => "eval-temp-page"]);
  if (!$matches) {
    foreach ($storage->loadMultiple() as $r) {
      if (ltrim($r->getSourcePathWithQuery(), "/") === "eval-temp-page") { $matches[] = $r; }
    }
  }
  $exists = (bool) $matches;
  $code_ok = FALSE; $target = ""; $target_ok = FALSE;
  foreach ($matches as $r) {
    $code = (int) $r->getStatusCode();
    $t = trim((string) $r->get("redirect_redirect")->uri);
    $is_node1 = in_array($t, ["internal:/node/1", "entity:node/1"], TRUE);
    if ($code === 302) { $code_ok = TRUE; }
    if ($t !== "" && $is_node1) { $target_ok = TRUE; $target = $t; }
    if ($code === 302 && $is_node1) { $target = $t; }
  }
  $pass = $exists && $code_ok && $target_ok;
  print ($pass ? "PASS" : "FAIL")
    . " exists=" . ($exists?1:0)
    . " code302=" . ($code_ok?1:0)
    . " node1Target=" . ($target_ok?1:0)
    . " target=" . ($target ?: "-") . "\n";
' 2>/dev/null)

echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
