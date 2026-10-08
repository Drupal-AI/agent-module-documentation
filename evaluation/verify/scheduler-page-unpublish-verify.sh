#!/usr/bin/env bash
# Live-state verification for the "enable Scheduler on Basic page + schedule an auto-unpublish"
# task. Prints PASS/FAIL with detail and exits 0 (pass) / 1 (fail). No arguments.
# Two independent checks:
#   cfg  — node.type.page has scheduler unpublish_enable TRUE
#   fn   — a PUBLISHED page node exists whose unpublish_on timestamp is in the future
set -uo pipefail
cd /var/www/html

out=$(drush php:eval '
  $cfg = FALSE;
  if ($type = \Drupal\node\Entity\NodeType::load("page")) {
    $cfg = (bool) $type->getThirdPartySetting("scheduler", "unpublish_enable");
  }
  $now = \Drupal::time()->getRequestTime();
  $ids = \Drupal::entityQuery("node")->accessCheck(FALSE)
    ->condition("type", "page")
    ->condition("status", 1)
    ->condition("unpublish_on", $now, ">")
    ->execute();
  $fn = !empty($ids);
  $when = "";
  if ($fn) {
    $n = \Drupal::entityTypeManager()->getStorage("node")->load(reset($ids));
    $when = " unpublish_on=" . $n->get("unpublish_on")->value . " (now=" . $now . ")";
  }
  print ($cfg && $fn ? "PASS" : "FAIL") . " cfg=" . ($cfg?1:0) . " fn=" . ($fn?1:0) . $when . "\n";
' 2>/dev/null)

echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
