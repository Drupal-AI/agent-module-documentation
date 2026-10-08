#!/usr/bin/env bash
# Execution VERIFY: PASS when hcm_eval_h1 exists targeting example_services/FindPost postId 3.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $e = \Drupal::entityTypeManager()->getStorage("http_config_request")->load("hcm_eval_h1");
  $ok = FALSE; $api=$cmd=$pid=NULL;
  if ($e) {
    $api = $e->get("service_api"); $cmd = $e->get("command_name");
    $p = $e->get("parameters"); $pid = $p["postId"] ?? NULL;
    $ok = ($api === "example_services" && $cmd === "FindPost" && (string) $pid === "3");
  }
  print ($ok ? "PASS" : "FAIL") . " api=" . var_export($api, TRUE) . " cmd=" . var_export($cmd, TRUE) . " postId=" . var_export($pid, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
