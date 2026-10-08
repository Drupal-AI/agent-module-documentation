#!/usr/bin/env bash
# Execution VERIFY: PASS when state twig_remove_html_comments_output holds the input with the
# HTML comment removed by the module: it must contain the kept text 'Keep this', must NOT contain
# any comment marker (<!-- or -->), and must NOT contain the comment body 'SECRET'.
# exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $v = \Drupal::state()->get("twig_remove_html_comments_output");
  if (!is_string($v) || $v === "") { print "FAIL empty output\n"; return; }
  $hasKeep = strpos($v, "Keep this") !== FALSE;
  $noOpen  = strpos($v, "<!--") === FALSE;
  $noClose = strpos($v, "-->") === FALSE;
  $noBody  = strpos($v, "SECRET") === FALSE;
  $ok = $hasKeep && $noOpen && $noClose && $noBody;
  print ($ok ? "PASS" : "FAIL") . " keep=" . var_export($hasKeep,true) . " no_comment=" . var_export($noOpen && $noClose && $noBody, true) . " output=" . var_export($v, true) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
