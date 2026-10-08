#!/usr/bin/env bash
# Live-state verification for the "enable Scheduler on Article + schedule a post" task.
# Prints PASS/FAIL with detail and exits 0 (pass) / 1 (fail). No arguments.
# Two independent checks:
#   cfg  — node.type.article has scheduler publish_enable AND unpublish_enable TRUE
#   fn   — an unpublished Article node exists whose publish_on timestamp is in the future
set -uo pipefail
cd /var/www/html

out=$(drush php:eval '
  $cfg = FALSE;
  if ($type = \Drupal\node\Entity\NodeType::load("article")) {
    $cfg = (bool) $type->getThirdPartySetting("scheduler", "publish_enable")
        && (bool) $type->getThirdPartySetting("scheduler", "unpublish_enable");
  }
  $now = \Drupal::time()->getRequestTime();
  $ids = \Drupal::entityQuery("node")->accessCheck(FALSE)
    ->condition("type", "article")
    ->condition("status", 0)
    ->condition("publish_on", $now, ">")
    ->execute();
  $fn = !empty($ids);
  $when = "";
  if ($fn) {
    $n = \Drupal::entityTypeManager()->getStorage("node")->load(reset($ids));
    $when = " publish_on=" . $n->get("publish_on")->value . " (now=" . $now . ")";
  }
  print ($cfg && $fn ? "PASS" : "FAIL") . " cfg=" . ($cfg?1:0) . " fn=" . ($fn?1:0) . $when . "\n";
' 2>/dev/null)

echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
