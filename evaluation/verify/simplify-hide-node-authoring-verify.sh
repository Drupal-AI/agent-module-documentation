#!/usr/bin/env bash
# Live-state verification for "hide Authoring information + Promotion options on all node forms".
# Prints PASS/FAIL with detail and exits 0 (pass) / 1 (fail). No arguments.
# Reads simplify.global:simplify_nodes_global and requires BOTH element keys to be present:
#   author  — Authoring information
#   options — Promotion options
set -uo pipefail
cd /var/www/html

out=$(drush php:eval '
  $vals = \Drupal::config("simplify.global")->get("simplify_nodes_global");
  $vals = is_array($vals) ? $vals : [];
  $author  = in_array("author", $vals, TRUE);
  $options = in_array("options", $vals, TRUE);
  $ok = $author && $options;
  print ($ok ? "PASS" : "FAIL") . " author=" . ($author?1:0) . " options=" . ($options?1:0)
    . " set=[" . implode(",", $vals) . "]\n";
' 2>/dev/null)

echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
