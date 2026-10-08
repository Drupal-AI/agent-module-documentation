#!/usr/bin/env bash
# Execution VERIFY: PASS when the live preprocess plugin manager has a Preprocess plugin
# provided by preprocess_yaml_host whose hook is 'node'. exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  \Drupal::service("plugin.cache_clearer")->clearCachedDefinitions();
  $m = \Drupal::service("preprocess.plugin.manager");
  $ok = FALSE; $found = "none";
  foreach ($m->getDefinitions() as $id => $def) {
    if (($def["provider"] ?? "") === "preprocess_yaml_host") {
      $found = $id . "(hook=" . ($def["hook"] ?? "?") . ")";
      if (($def["hook"] ?? "") === "node") { $ok = TRUE; }
    }
  }
  print ($ok ? "PASS" : "FAIL") . " plugin=$found\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
