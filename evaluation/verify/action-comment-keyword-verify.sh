#!/usr/bin/env bash
# Live-state verification for "create a comment keyword-unpublish advanced action".
# PASS (exit 0) when an `action` config entity exists with plugin
# comment_unpublish_by_keyword_action, type comment, and a keywords list containing
# "profanity". Prints PASS/FAIL with detail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $ok = FALSE; $detail = "";
  foreach (\Drupal::entityTypeManager()->getStorage("action")->loadMultiple() as $id => $e) {
    if ($e->get("plugin") === "comment_unpublish_by_keyword_action" && $e->getType() === "comment") {
      $kw = array_map("strtolower", (array) ($e->get("configuration")["keywords"] ?? []));
      $detail = " id=" . $id . " keywords=" . implode(",", $kw);
      if (in_array("profanity", $kw, TRUE)) { $ok = TRUE; break; }
    }
  }
  print ($ok ? "PASS" : "FAIL") . $detail . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
