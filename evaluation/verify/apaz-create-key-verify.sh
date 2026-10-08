#!/usr/bin/env bash
# Execution VERIFY: PASS when Key entity azure_api_task exists and is an authentication key type.
# exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\key\Entity\Key;
  $k = Key::load("azure_api_task");
  $type = $k ? $k->getKeyType()->getPluginId() : "none";
  $ok = $k && ($type === "authentication");
  print ($ok ? "PASS" : "FAIL") . " key=" . ($k ? "exists" : "missing") . " type=" . $type . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
