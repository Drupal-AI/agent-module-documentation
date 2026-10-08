#!/usr/bin/env bash
# Live-state verification for the "build a Quick Tabs instance with exactly THREE
# tabs" execution task. Prints PASS/FAIL with detail and exits 0 (pass) / 1 (fail).
# PASS only if the quicktabs_instance `eval_tabs3` config entity exists AND its
# configuration_data (getConfigurationData()) holds exactly three configured tabs.
set -uo pipefail
cd /var/www/html

out=$(drush php:eval '
  $qt = \Drupal::entityTypeManager()->getStorage("quicktabs_instance")->load("eval_tabs3");
  $exists = (bool) $qt;
  $tabs = ($exists && is_array($qt->getConfigurationData())) ? $qt->getConfigurationData() : [];
  $count = count($tabs);
  $renderer = $exists ? (string) $qt->getRenderer() : "";
  $ok = $exists && $count === 3;
  print ($ok ? "PASS" : "FAIL")
    . " exists=" . ($exists ? 1 : 0)
    . " tabs=" . $count
    . " renderer=" . $renderer . "\n";
' 2>/dev/null)

echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
