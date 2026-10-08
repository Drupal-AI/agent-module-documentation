#!/usr/bin/env bash
# Execution VERIFY: PASS when hcm_eval_h2 exists (example_services/CreatePost, title=QA body=hello userId=42).
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $e = \Drupal::entityTypeManager()->getStorage("http_config_request")->load("hcm_eval_h2");
  $ok = FALSE; $api=$cmd=NULL; $t=$b=$u=NULL;
  if ($e) {
    $api = $e->get("service_api"); $cmd = $e->get("command_name"); $p = $e->get("parameters");
    $t = $p["title"] ?? NULL; $b = $p["body"] ?? NULL; $u = $p["userId"] ?? NULL;
    $ok = ($api === "example_services" && $cmd === "CreatePost" && $t === "QA" && $b === "hello" && (string) $u === "42");
  }
  print ($ok ? "PASS" : "FAIL") . " api=" . var_export($api, TRUE) . " cmd=" . var_export($cmd, TRUE) . " title=" . var_export($t, TRUE) . " userId=" . var_export($u, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
