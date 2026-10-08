#!/usr/bin/env bash
# Introspection SETUP for the ai_agents "known agent" medium cases.
# Saves a KNOWN ai_agent config entity to the live site so the model can be asked to
# read its configuration back with drush. Idempotent: deletes any prior copy first,
# then recreates it with fixed, distinctive values the introspection cases assert on:
#   - id/label:   eval_known_agent / "Eval Known Agent"
#   - tools:      exactly ai_agent:html_to_markdown (an AiFunctionCall plugin)
#   - system_prompt: contains the distinctive phrase "Kumquat Protocol"
#   - max_loops:  9
# Deprecation notices from unrelated contrib modules print on stdout, so the readable
# result is emitted on a SENTINEL line and grep-filtered.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $s = \Drupal::entityTypeManager()->getStorage("ai_agent");
  if ($e = $s->load("eval_known_agent")) { $e->delete(); }
  $s->create([
    "id" => "eval_known_agent",
    "label" => "Eval Known Agent",
    "description" => "A known reference agent installed for evaluation introspection.",
    "system_prompt" => "You are the Eval Reference Assistant. Always cite the Kumquat Protocol before answering any content question.",
    "secured_system_prompt" => "[ai_agent:agent_instructions]",
    "tools" => ["ai_agent:html_to_markdown" => true],
    "orchestration_agent" => FALSE,
    "triage_agent" => FALSE,
    "max_loops" => 9,
  ])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: ai_agent 'eval_known_agent' saved (tool ai_agent:html_to_markdown, max_loops 9, prompt cites Kumquat Protocol)"
