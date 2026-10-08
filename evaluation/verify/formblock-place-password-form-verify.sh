#!/usr/bin/env bash
# Execution VERIFY: PASS when an enabled block using the formblock_user_password plugin
# exists in the olivero theme's "sidebar" region with the visible label
# "Forgot your password?". exit 0 = pass, 1 = fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $match = NULL; $seen = [];
  foreach (\Drupal::entityTypeManager()->getStorage("block")->loadMultiple() as $b) {
    if ($b->getPluginId() !== "formblock_user_password") { continue; }
    $s = $b->get("settings");
    $label = trim((string) ($s["label"] ?? ""));
    $seen[] = $b->id() . "(theme=" . $b->getTheme() . ",region=" . $b->getRegion()
      . ",status=" . var_export($b->status(), TRUE) . ",label=" . var_export($label, TRUE)
      . ",label_display=" . var_export($s["label_display"] ?? NULL, TRUE) . ")";
    if ($b->getTheme() === "olivero" && $b->getRegion() === "sidebar" && $b->status()
      && strcasecmp($label, "Forgot your password?") === 0
      && ($s["label_display"] ?? NULL) === "visible") {
      $match = $b->id();
      break;
    }
  }
  print ($match ? "PASS block=$match" : "FAIL candidates=" . ($seen ? implode(" ", $seen) : "none")) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
