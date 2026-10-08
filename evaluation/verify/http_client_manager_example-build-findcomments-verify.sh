#!/usr/bin/env bash
# Execution VERIFY: PASS when hcme_eval_build exists (example_services/FindComments, postId 2).
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $e = \Drupal::entityTypeManager()->getStorage("http_config_request")->load("hcme_eval_build");
  $ok=FALSE; $api=$cmd=$pid=NULL;
  if ($e) {
    $api=$e->get("service_api"); $cmd=$e->get("command_name"); $p=$e->get("parameters"); $pid=$p["postId"]??NULL;
    $ok = ($api === "example_services" && $cmd === "FindComments" && (string) $pid === "2");
  }
  print ($ok ? "PASS" : "FAIL") . " api=" . var_export($api, TRUE) . " cmd=" . var_export($cmd, TRUE) . " postId=" . var_export($pid, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
