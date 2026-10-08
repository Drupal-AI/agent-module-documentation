#!/usr/bin/env bash
# Live-state verification for "create a node keyword-unpublish advanced action".
# PASS (exit 0) when an `action` config entity exists with plugin
# node_unpublish_by_keyword_action, type node, and a keywords list containing BOTH
# "spam" and "casino". Prints PASS/FAIL with detail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $ok = FALSE; $detail = "";
  foreach (\Drupal::entityTypeManager()->getStorage("action")->loadMultiple() as $id => $e) {
    if ($e->get("plugin") === "node_unpublish_by_keyword_action" && $e->getType() === "node") {
      $kw = $e->get("configuration")["keywords"] ?? [];
      $kw = array_map("strtolower", (array) $kw);
      if (in_array("spam", $kw, TRUE) && in_array("casino", $kw, TRUE)) {
        $ok = TRUE; $detail = " id=" . $id . " keywords=" . implode(",", $kw); break;
      }
      $detail = " id=" . $id . " keywords=" . implode(",", $kw);
    }
  }
  print ($ok ? "PASS" : "FAIL") . $detail . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
