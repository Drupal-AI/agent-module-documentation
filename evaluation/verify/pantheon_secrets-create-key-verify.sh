#!/usr/bin/env bash
# Execution VERIFY: PASS when key.key.ps_task_key exists with key_provider "pantheon" and
# key_provider_settings.secret_name === "ps_task_secret". exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $c = \Drupal::config("key.key.ps_task_key");
  $provider = $c->get("key_provider");
  $secret = $c->get("key_provider_settings.secret_name");
  $ok = ($provider === "pantheon" && $secret === "ps_task_secret");
  print ($ok ? "PASS" : "FAIL") . " provider=" . var_export($provider, TRUE) . " secret_name=" . var_export($secret, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
