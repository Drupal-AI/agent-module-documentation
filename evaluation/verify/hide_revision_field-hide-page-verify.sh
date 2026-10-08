#!/usr/bin/env bash
# Live-state verification for "hide the revision log field on the Basic page node form".
# PASS (exit 0) when core.entity_form_display.node.page.default has the hide_revision_field
# widget on the revision_log component with show=FALSE. Prints PASS/FAIL with detail.
set -uo pipefail
cd /var/www/html

out=$(drush php:eval '
  $ok = FALSE; $detail = "no-component";
  $fd = \Drupal::entityTypeManager()->getStorage("entity_form_display")->load("node.page.default");
  if ($fd) {
    $c = $fd->getComponent("revision_log");
    if (is_array($c)) {
      $type = $c["type"] ?? "";
      $show = $c["settings"]["show"] ?? TRUE;
      $ok = ($type === "hide_revision_field_log_widget") && ($show === FALSE || $show === 0 || $show === "0");
      $detail = "type=" . $type . " show=" . var_export($show, TRUE);
    }
  }
  print ($ok ? "PASS" : "FAIL") . " " . $detail . "\n";
' 2>/dev/null | grep -E "^(PASS|FAIL)")

echo "$out"
echo "$out" | grep -q "^PASS" && exit 0 || exit 1
