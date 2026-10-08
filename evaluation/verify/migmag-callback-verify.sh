#!/usr/bin/env bash
# Execution VERIFY (add): PASS when migmag_callback_upgrade is enabled AND (honestly) the core
# 'callback' process plugin class is UNCHANGED (core Callback), because this core is >= 9.2 so
# the module is a deliberate no-op.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $en = \Drupal::moduleHandler()->moduleExists("migmag_callback_upgrade");
  $cls = \Drupal::service("plugin.manager.migrate.process")->getDefinition("callback", FALSE)["class"] ?? "none";
  $core = ($cls === "Drupal\\migrate\\Plugin\\migrate\\process\\Callback");
  $ok = ($en && $core);
  print ($ok ? "PASS" : "FAIL") . " enabled=" . var_export($en,TRUE) . " callback_class=" . $cls . "\n";
' 2>/dev/null)
echo "$out"; echo "$out" | grep -q '^PASS' && exit 0 || exit 1
