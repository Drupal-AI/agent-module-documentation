#!/usr/bin/env bash
# Execution VERIFY (crawler_rate_limit regular/visitor limit): PASS when the effective settings
# enable the limiter with a supported backend and a regular_traffic (visitor-level) limit of
# 275 requests / 900 seconds. Reads RateLimitManager::getSettings(). exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $s = \Drupal\crawler_rate_limit\RateLimitManager::getSettings();
  $enabled = !empty($s["enabled"]);
  $backend = $s["backend"] ?? "";
  $req = $s["regular_traffic"]["requests"] ?? 0;
  $int = $s["regular_traffic"]["interval"] ?? 0;
  $ok = ($enabled && in_array($backend, ["redis","apcu","memcached"]) && $req === 275 && $int === 900);
  print ($ok ? "PASS" : "FAIL") . " enabled=" . var_export($enabled,TRUE) . " backend=" . $backend . " regular_requests=" . $req . " regular_interval=" . $int . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
