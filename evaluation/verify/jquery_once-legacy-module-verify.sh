#!/usr/bin/env bash
# Execution VERIFY: PASS when the module jqonce_legacy is enabled and declares an asset library
# that depends on core/jquery.once, that dependency resolves on this site (i.e. jquery_once is
# supplying it), and the library's JavaScript file really exists. exit 0 = pass, 1 = fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $enabled = \Drupal::moduleHandler()->moduleExists("jqonce_legacy");
  $libs = $enabled ? \Drupal::service("library.discovery")->getLibrariesByExtension("jqonce_legacy") : [];
  $hit = NULL;
  foreach ($libs as $name => $lib) {
    if (in_array("core/jquery.once", $lib["dependencies"] ?? [], TRUE)) { $hit = [$name, $lib]; break; }
  }
  $jsOk = FALSE;
  if ($hit && !empty($hit[1]["js"][0]["data"])) {
    $jsOk = file_exists(DRUPAL_ROOT . "/" . ltrim($hit[1]["js"][0]["data"], "/"));
  }
  $once = \Drupal::service("library.discovery")->getLibraryByName("core", "jquery.once");
  $onceOk = !empty($once["js"][0]["data"]) && str_contains($once["js"][0]["data"], "jquery.once");
  $ok = $enabled && $hit && $jsOk && $onceOk;
  print ($ok ? "PASS" : "FAIL") . " module_enabled=" . var_export($enabled, TRUE)
    . " library=" . var_export($hit[0] ?? NULL, TRUE)
    . " js_exists=" . var_export($jsOk, TRUE)
    . " core_jquery_once=" . var_export($once["js"][0]["data"] ?? NULL, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
