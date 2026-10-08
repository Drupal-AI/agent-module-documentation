#!/usr/bin/env bash
# Live-state verification for the "eval-ext -> external URL (https://www.drupal.org), 301"
# redirect task. Prints PASS/FAIL with detail and exits 0 (pass) / 1 (fail). No arguments.
# PASS only if a redirect entity exists whose source path is `eval-ext`, whose status_code
# is 301, and whose target (redirect_redirect) is an external http(s) URL.
set -uo pipefail
cd /var/www/html

out=$(drush php:eval '
  use Drupal\Component\Utility\UrlHelper;
  $storage = \Drupal::entityTypeManager()->getStorage("redirect");
  $matches = $storage->loadByProperties(["redirect_source__path" => "eval-ext"]);
  if (!$matches) {
    foreach ($storage->loadMultiple() as $r) {
      if (ltrim($r->getSourcePathWithQuery(), "/") === "eval-ext") { $matches[] = $r; }
    }
  }
  $exists = (bool) $matches;
  $code_ok = FALSE; $target = ""; $target_ok = FALSE;
  foreach ($matches as $r) {
    $code = (int) $r->getStatusCode();
    $t = trim((string) $r->get("redirect_redirect")->uri);
    $is_external = UrlHelper::isExternal($t) && (stripos($t, "http://") === 0 || stripos($t, "https://") === 0);
    if ($code === 301) { $code_ok = TRUE; }
    if ($t !== "" && $is_external) { $target_ok = TRUE; $target = $t; }
    if ($code === 301 && $is_external) { $target = $t; }
  }
  $pass = $exists && $code_ok && $target_ok;
  print ($pass ? "PASS" : "FAIL")
    . " exists=" . ($exists?1:0)
    . " code301=" . ($code_ok?1:0)
    . " externalTarget=" . ($target_ok?1:0)
    . " target=" . ($target ?: "-") . "\n";
' 2>/dev/null)

echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
