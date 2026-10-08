#!/usr/bin/env bash
# Live-state verification for the "build a routing agent eval_router" hard task.
# Passes (exit 0) only if the run actually CREATED the required agent on the live site:
#   - an ai_agent config entity with machine name eval_router exists and is enabled
#   - it has a non-empty system_prompt
#   - it grants EXACTLY ONE tool, and that tool is ai_agent:html_to_markdown
# Prints PASS/FAIL with detail. Deprecation notices from unrelated contrib modules
# print on stdout, so the verdict is emitted on a SENTINEL line and grep-filtered.
set -uo pipefail
cd /var/www/html

out=$(drush php:eval '
  $ok = FALSE; $exists = 0; $enabled = 0; $sp = 0; $ntools = 0; $tool = "";
  $a = \Drupal::entityTypeManager()->getStorage("ai_agent")->load("eval_router");
  if ($a) {
    $exists = 1;
    $enabled = $a->status() ? 1 : 0;
    $sp = strlen(trim((string) $a->get("system_prompt"))) > 0 ? 1 : 0;
    $tools = $a->get("tools");
    $enabled_tools = is_array($tools) ? array_keys(array_filter($tools)) : [];
    $ntools = count($enabled_tools);
    $tool = $ntools === 1 ? $enabled_tools[0] : "";
    if ($enabled && $sp && $ntools === 1 && $tool === "ai_agent:html_to_markdown") { $ok = TRUE; }
  }
  print "SENTINEL " . ($ok ? "PASS" : "FAIL")
    . " exists=$exists enabled=$enabled system_prompt=$sp tools=$ntools tool=$tool\n";
' 2>/dev/null | grep "^SENTINEL")

verdict=${out#SENTINEL }
echo "$verdict"
echo "$verdict" | grep -q "^PASS" && exit 0 || exit 1
