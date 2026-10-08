#!/usr/bin/env bash
# Execution VERIFY (crawler_rate_limit bot limit): PASS when the effective settings enable the
# limiter with a supported backend and a bot_traffic limit of 150 requests / 300 seconds.
# Reads RateLimitManager::getSettings() (which merges settings.php). exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $s = \Drupal\crawler_rate_limit\RateLimitManager::getSettings();
  $enabled = !empty($s["enabled"]);
  $backend = $s["backend"] ?? "";
  $req = $s["bot_traffic"]["requests"] ?? 0;
  $int = $s["bot_traffic"]["interval"] ?? 0;
  $ok = ($enabled && in_array($backend, ["redis","apcu","memcached"]) && $req === 150 && $int === 300);
  print ($ok ? "PASS" : "FAIL") . " enabled=" . var_export($enabled,TRUE) . " backend=" . $backend . " bot_requests=" . $req . " bot_interval=" . $int . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
