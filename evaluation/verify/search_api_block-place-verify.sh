#!/usr/bin/env bash
# Execution VERIFY: PASS when block.block.sab_task is a search_api_form_block submitting via
# GET to /sab-results with input_name 'search'. exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $b = \Drupal\block\Entity\Block::load("sab_task");
  if (!$b) { print "FAIL no-block\n"; return; }
  $s = $b->get("settings");
  $ok = ($b->get("plugin") === "search_api_form_block")
    && (($s["action_url"] ?? "") === "/sab-results")
    && (($s["action_method"] ?? "") === "get")
    && (($s["input_name"] ?? "") === "search");
  print ($ok ? "PASS" : "FAIL") . " plugin=" . $b->get("plugin")
    . " action_url=" . var_export($s["action_url"] ?? NULL, TRUE)
    . " method=" . var_export($s["action_method"] ?? NULL, TRUE)
    . " input_name=" . var_export($s["input_name"] ?? NULL, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
