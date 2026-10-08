#!/usr/bin/env bash
# Execution VERIFY: PASS when media type meg_task exists and its media source plugin is 'generic'.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\media\Entity\MediaType;
  $t = MediaType::load("meg_task");
  $src = $t ? $t->getSource()->getPluginId() : "none";
  $ok = ($t && $src === "generic");
  print ($ok ? "PASS" : "FAIL") . " source=" . $src . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
