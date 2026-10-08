#!/usr/bin/env bash
# Live-state verification for the "build an AI agent that uses tools" task.
# Passes (exit 0) if the run actually CREATED a working ai_agent config entity —
# not just described one. A "working" agent must be enabled, carry a non-empty
# system prompt, AND grant at least one tool (an AiFunctionCall plugin), because an
# agent with no tools can only talk, it can't build/act. No arguments.
set -uo pipefail
cd /var/www/html

out=$(drush php:eval '
  $ok = FALSE; $built = ""; $n = 0;
  foreach (\Drupal::entityTypeManager()->getStorage("ai_agent")->loadMultiple() as $a) {
    $n++;
    $enabled = $a->status();
    $sp = strlen(trim((string) $a->get("system_prompt"))) > 0;
    $tools = $a->get("tools");
    $has_tools = is_array($tools) && count(array_filter($tools)) > 0;
    if ($enabled && $sp && $has_tools) { $ok = TRUE; $built = $a->id(); }
  }
  print ($ok ? "PASS" : "FAIL") . " agents=$n built=$built\n";
' 2>/dev/null)

echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
