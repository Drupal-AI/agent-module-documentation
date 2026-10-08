#!/usr/bin/env bash
# Execution VERIFY: PASS when scheme 'flypub' exists with driver local, config.public TRUE,
# and config.root == sites/default/files/flysystem-pub. Prints PASS/FAIL. exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $f = \Drupal::service("flysystem_factory");
  $has = in_array("flypub", $f->getSchemes(), TRUE);
  $s = $has ? $f->getSettings("flypub") : [];
  $driver = $s["driver"] ?? "";
  $public = $s["config"]["public"] ?? NULL;
  $root = $s["config"]["root"] ?? "";
  $ok = ($has && $driver === "local" && $public == TRUE && $root === "sites/default/files/flysystem-pub");
  print ($ok ? "PASS" : "FAIL") . " driver=" . var_export($driver, TRUE) . " public=" . var_export($public, TRUE) . " root=" . var_export($root, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
