#!/usr/bin/env bash
# Execution VERIFY: PASS when a media type whose source plugin is media_tylerdi exists. exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\media\Entity\MediaType;
  $found = NULL;
  foreach (MediaType::loadMultiple() as $mt) {
    if ($mt->getSource()->getPluginId() === "media_tylerdi") { $found = $mt->id(); break; }
  }
  print ($found ? "PASS" : "FAIL") . " media_type=" . var_export($found, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
