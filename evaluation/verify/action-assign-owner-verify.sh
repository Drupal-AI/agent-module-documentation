#!/usr/bin/env bash
# Live-state verification for "create a node assign-author advanced action targeting uid 1".
# PASS (exit 0) when an `action` config entity exists with plugin node_assign_owner_action,
# type node, and configuration.owner_uid == "1". Prints PASS/FAIL with detail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $ok = FALSE; $detail = "";
  foreach (\Drupal::entityTypeManager()->getStorage("action")->loadMultiple() as $id => $e) {
    if ($e->get("plugin") === "node_assign_owner_action" && $e->getType() === "node") {
      $uid = (string) ($e->get("configuration")["owner_uid"] ?? "");
      $detail = " id=" . $id . " owner_uid=" . $uid;
      if ($uid === "1") { $ok = TRUE; break; }
    }
  }
  print ($ok ? "PASS" : "FAIL") . $detail . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
