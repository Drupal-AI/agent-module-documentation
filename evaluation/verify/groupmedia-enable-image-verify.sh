#!/usr/bin/env bash
# Execution VERIFY: PASS when group type gm_hard has the group_media:image relation installed
# with plugin_config.tracking_enabled === 1. exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $rt = \Drupal::entityTypeManager()->getStorage("group_relationship_type")->load("gm_hard-group_media-image");
  $track = $rt ? ($rt->get("plugin_config")["tracking_enabled"] ?? NULL) : NULL;
  $ok = ($rt !== NULL && (int) $track === 1);
  print ($ok ? "PASS" : "FAIL") . " relation=" . ($rt ? $rt->id() : "none") . " tracking=" . var_export($track, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
