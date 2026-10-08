#!/usr/bin/env bash
# Live-state verification for the "build a menu access scheme" hard task.
# Passes (exit 0) only if the run actually CREATED the required config entity on the live
# site:
#   - an access_scheme config entity with machine name section_menu exists and is enabled
#   - its scheme (AccessControlHierarchy plugin) is exactly "menu"
# Prints PASS/FAIL with detail. Deprecation notices from unrelated contrib modules print on
# stderr (suppressed); the verdict is emitted on a SENTINEL line and grep-filtered.
set -uo pipefail
cd /var/www/html

out=$(drush php:eval '
  $ok = FALSE; $exists = 0; $enabled = 0; $plugin = "";
  $e = \Drupal::entityTypeManager()->getStorage("access_scheme")->load("section_menu");
  if ($e) {
    $exists = 1;
    $enabled = $e->status() ? 1 : 0;
    $plugin = (string) $e->get("scheme");
    if ($enabled && $plugin === "menu") { $ok = TRUE; }
  }
  print "SENTINEL " . ($ok ? "PASS" : "FAIL")
    . " exists=$exists enabled=$enabled scheme=$plugin\n";
' 2>/dev/null | grep "^SENTINEL")

verdict=${out#SENTINEL }
echo "$verdict"
echo "$verdict" | grep -q "^PASS" && exit 0 || exit 1
