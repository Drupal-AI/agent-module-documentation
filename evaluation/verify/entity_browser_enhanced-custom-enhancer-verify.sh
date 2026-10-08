#!/usr/bin/env bash
# Execution VERIFY: PASS when an enabled module provides a valid entity_browser_enhanced_plugin
# definition with id "ebe_zoom" (label, form_extra_class and library all non-empty) and the
# referenced asset library actually resolves. exit 0 = pass, 1 = fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  \Drupal::service("plugin.manager.entity_browser_enhanced_plugin")->clearCachedDefinitions();
  $defs = \Drupal::service("plugin.manager.entity_browser_enhanced_plugin")->getDefinitions();
  $d = $defs["ebe_zoom"] ?? NULL;
  $libOk = FALSE;
  if ($d && !empty($d["library"]) && str_contains($d["library"], "/")) {
    [$ext, $name] = explode("/", $d["library"], 2);
    $libOk = (bool) \Drupal::service("library.discovery")->getLibraryByName($ext, $name);
  }
  $ok = $d && !empty($d["label"]) && !empty($d["form_extra_class"]) && $libOk;
  print ($ok ? "PASS" : "FAIL")
    . " definition=" . ($d ? "yes" : "no")
    . " label=" . var_export($d["label"] ?? NULL, TRUE)
    . " form_extra_class=" . var_export($d["form_extra_class"] ?? NULL, TRUE)
    . " library=" . var_export($d["library"] ?? NULL, TRUE)
    . " library_resolves=" . var_export($libOk, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
