#!/usr/bin/env bash
# Execution VERIFY: PASS when an enabled block using the formblock_node plugin exists in the
# olivero theme's "content" region, configured for the article content type with the
# submission guidelines shown (settings.show_help truthy). exit 0 = pass, 1 = fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $match = NULL;
  foreach (\Drupal::entityTypeManager()->getStorage("block")->loadMultiple() as $b) {
    if ($b->getPluginId() !== "formblock_node") { continue; }
    $s = $b->get("settings");
    if ($b->getTheme() === "olivero"
      && $b->getRegion() === "content"
      && $b->status()
      && ($s["type"] ?? NULL) === "article"
      && !empty($s["show_help"])) {
      $match = $b->id();
      break;
    }
  }
  if ($match) {
    print "PASS block=$match\n";
  }
  else {
    $seen = [];
    foreach (\Drupal::entityTypeManager()->getStorage("block")->loadMultiple() as $b) {
      if ($b->getPluginId() === "formblock_node") {
        $s = $b->get("settings");
        $seen[] = $b->id() . "(theme=" . $b->getTheme() . ",region=" . $b->getRegion()
          . ",status=" . var_export($b->status(), TRUE)
          . ",type=" . var_export($s["type"] ?? NULL, TRUE)
          . ",show_help=" . var_export($s["show_help"] ?? NULL, TRUE) . ")";
      }
    }
    print "FAIL candidates=" . ($seen ? implode(" ", $seen) : "none") . "\n";
  }
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
