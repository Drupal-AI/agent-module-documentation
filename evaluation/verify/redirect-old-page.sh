#!/usr/bin/env bash
# Live-state verification for the "eval-old-page -> front page, 301" redirect task.
# Prints PASS/FAIL with detail and exits 0 (pass) / 1 (fail). No arguments.
# PASS only if a redirect entity exists whose source path is `eval-old-page`, whose
# status_code is 301, and whose target (redirect_redirect) is a non-empty pointer to
# the site front page (internal:/ , <front>, or route:<front>).
set -uo pipefail
cd /var/www/html

out=$(drush php:eval '
  $storage = \Drupal::entityTypeManager()->getStorage("redirect");
  $matches = $storage->loadByProperties(["redirect_source__path" => "eval-old-page"]);
  if (!$matches) {
    // Fall back to scanning all redirects and comparing the source path.
    foreach ($storage->loadMultiple() as $r) {
      if (ltrim($r->getSourcePathWithQuery(), "/") === "eval-old-page") { $matches[] = $r; }
    }
  }
  $exists = (bool) $matches;
  $code_ok = FALSE; $target = ""; $target_ok = FALSE;
  foreach ($matches as $r) {
    $code = (int) $r->getStatusCode();
    $t = trim((string) $r->getRedirect()["uri"] ?? "");
    if ($t === "") { $t = trim((string) $r->get("redirect_redirect")->uri); }
    $is_front = in_array($t, ["internal:/", "internal:/<front>", "route:<front>", "<front>"], TRUE)
      || strcasecmp($t, "internal:/") === 0;
    if ($code === 301) { $code_ok = TRUE; }
    if ($t !== "" && $is_front) { $target_ok = TRUE; $target = $t; }
    if ($code === 301 && $t !== "" && $is_front) { $target = $t; }
  }
  $pass = $exists && $code_ok && $target_ok;
  print ($pass ? "PASS" : "FAIL")
    . " exists=" . ($exists?1:0)
    . " code301=" . ($code_ok?1:0)
    . " frontTarget=" . ($target_ok?1:0)
    . " target=" . ($target ?: "-") . "\n";
' 2>/dev/null)

echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
