#!/usr/bin/env bash
# Execution VERIFY: PASS when the core layout_twocol layout now uses the Layout Options plugin
# class (Drupal\layout_options\Plugin\Layout\LayoutOptions). exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $lm = \Drupal::service("plugin.manager.core.layout");
  $lm->clearCachedDefinitions();
  $class = $lm->getDefinition("layout_twocol")->getClass();
  $ok = (ltrim($class, "\\") === "Drupal\\layout_options\\Plugin\\Layout\\LayoutOptions");
  print ($ok ? "PASS" : "FAIL") . " class=" . $class . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
