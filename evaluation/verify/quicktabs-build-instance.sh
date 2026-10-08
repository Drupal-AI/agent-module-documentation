#!/usr/bin/env bash
# Live-state verification for the "build a tabbed content widget" Quick Tabs task.
# Prints PASS/FAIL with detail and exits 0 (pass) / 1 (fail). No arguments.
# PASS only if the quicktabs_instance `eval_tabs` config entity exists AND its
# configuration_data (getConfigurationData()) holds at least two configured tabs.
set -uo pipefail
cd /var/www/html

out=$(drush php:eval '
  $qt = \Drupal::entityTypeManager()->getStorage("quicktabs_instance")->load("eval_tabs");
  $exists = (bool) $qt;
  $tabs = ($exists && is_array($qt->getConfigurationData())) ? $qt->getConfigurationData() : [];
  $count = count($tabs);
  $renderer = $exists ? (string) $qt->getRenderer() : "";
  $ok = $exists && $count >= 2;
  print ($ok ? "PASS" : "FAIL")
    . " exists=" . ($exists ? 1 : 0)
    . " tabs=" . $count
    . " renderer=" . $renderer . "\n";
' 2>/dev/null)

echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
