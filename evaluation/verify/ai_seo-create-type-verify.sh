#!/usr/bin/env bash
# Execution VERIFY: PASS when an ai_seo_report_type entity 'ai_seo_task' exists, is enabled
# (status TRUE), and has a non-empty prompt. exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $e = \Drupal::entityTypeManager()->getStorage("ai_seo_report_type")->load("ai_seo_task");
  $status = $e ? (bool) $e->get("status") : FALSE;
  $prompt = $e ? (string) $e->getPrompt() : "";
  $ok = $e && $status && strlen(trim($prompt)) > 0;
  print ($ok ? "PASS" : "FAIL") . " exists=" . var_export((bool) $e, TRUE) . " status=" . var_export($status, TRUE) . " prompt_len=" . strlen($prompt) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q "^PASS" && exit 0 || exit 1
