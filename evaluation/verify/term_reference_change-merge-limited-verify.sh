#!/usr/bin/env bash
# Execution VERIFY: PASS only when "TRC Limit Move" references "Current Tag" AND both
# "TRC Limit Keep 1" and "TRC Limit Keep 2" still reference "Legacy Tag" — i.e. the agent
# used the $limit argument instead of migrating everything. exit 0 = pass, 1 = fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $ts = \Drupal::entityTypeManager()->getStorage("taxonomy_term");
  $legacy = $ts->loadByProperties(["vid" => "trc_limit", "name" => "Legacy Tag"]);
  $current = $ts->loadByProperties(["vid" => "trc_limit", "name" => "Current Tag"]);
  $legacy = $legacy ? reset($legacy)->id() : NULL;
  $current = $current ? reset($current)->id() : NULL;
  $storage = \Drupal::entityTypeManager()->getStorage("node");
  $get = function ($title) use ($storage) {
    $found = $storage->loadByProperties(["title" => $title]);
    if (!$found) { return NULL; }
    $n = reset($found);
    $v = $n->get("field_trc_limit")->getValue();
    return $v ? $v[0]["target_id"] : NULL;
  };
  $move = $get("TRC Limit Move");
  $k1 = $get("TRC Limit Keep 1");
  $k2 = $get("TRC Limit Keep 2");
  $ok = ($current !== NULL && $legacy !== NULL
    && (string) $move === (string) $current
    && (string) $k1 === (string) $legacy
    && (string) $k2 === (string) $legacy);
  print ($ok ? "PASS" : "FAIL") . " legacy=$legacy current=$current move=$move keep1=$k1 keep2=$k2\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
