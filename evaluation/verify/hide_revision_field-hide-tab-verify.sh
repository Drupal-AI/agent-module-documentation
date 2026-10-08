#!/usr/bin/env bash
# Live-state verification for "hide the whole revision tab on the Article node form".
# PASS (exit 0) when core.entity_form_display.node.article.default has the hide_revision_field
# widget on revision_log with BOTH show=FALSE AND hide_revision=TRUE. Prints PASS/FAIL detail.
set -uo pipefail
cd /var/www/html

out=$(drush php:eval '
  $ok = FALSE; $detail = "no-component";
  $fd = \Drupal::entityTypeManager()->getStorage("entity_form_display")->load("node.article.default");
  if ($fd) {
    $c = $fd->getComponent("revision_log");
    if (is_array($c)) {
      $type = $c["type"] ?? "";
      $show = $c["settings"]["show"] ?? TRUE;
      $hide = $c["settings"]["hide_revision"] ?? FALSE;
      $showOff = ($show === FALSE || $show === 0 || $show === "0");
      $hideOn  = ($hide === TRUE  || $hide === 1 || $hide === "1");
      $ok = ($type === "hide_revision_field_log_widget") && $showOff && $hideOn;
      $detail = "type=" . $type . " show=" . var_export($show, TRUE) . " hide_revision=" . var_export($hide, TRUE);
    }
  }
  print ($ok ? "PASS" : "FAIL") . " " . $detail . "\n";
' 2>/dev/null | grep -E "^(PASS|FAIL)")

echo "$out"
echo "$out" | grep -q "^PASS" && exit 0 || exit 1
