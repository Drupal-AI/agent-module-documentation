#!/usr/bin/env bash
# Execution VERIFY: PASS when block.block.sab_adv is a search_api_form_block posting to
# /sab-adv-results with pass_get_params TRUE and input_name 'q'. exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $b = \Drupal\block\Entity\Block::load("sab_adv");
  if (!$b) { print "FAIL no-block\n"; return; }
  $s = $b->get("settings");
  $ok = ($b->get("plugin") === "search_api_form_block")
    && (($s["action_url"] ?? "") === "/sab-adv-results")
    && (($s["action_method"] ?? "") === "post")
    && (($s["pass_get_params"] ?? NULL) == TRUE)
    && (($s["input_name"] ?? "") === "q");
  print ($ok ? "PASS" : "FAIL") . " method=" . var_export($s["action_method"] ?? NULL, TRUE)
    . " pass_get_params=" . var_export($s["pass_get_params"] ?? NULL, TRUE)
    . " action_url=" . var_export($s["action_url"] ?? NULL, TRUE)
    . " input_name=" . var_export($s["input_name"] ?? NULL, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
