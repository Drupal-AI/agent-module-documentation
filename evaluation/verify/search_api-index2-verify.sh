#!/usr/bin/env bash
# Live-state verification for the "eval_index2 indexes BOTH title and body of Article, indexed"
# execution task. Prints PASS/FAIL with detail and exits 0 (pass) / 1 (fail). No arguments.
# Loads the Index config entity (and, via its server id, the Server) and asserts:
#   srv   — the index writes to a server whose backend id is search_api_db
#   idx   — index eval_index2 exists and is enabled
#   ds    — the index uses the entity:node datasource
#   title — an indexed field resolves to the node title (property path "title")
#   body  — an indexed field resolves to the node body (property path "body" or a rendered_item)
#   items — the index has at least one indexed item (content was actually indexed)
set -uo pipefail
cd /var/www/html

out=$(drush php:eval '
  $srv = $idx = $ds = $title = $body = $items = FALSE;
  $backend = ""; $server_id = ""; $count = 0;
  $index = \Drupal::entityTypeManager()->getStorage("search_api_index")->load("eval_index2");
  if ($index) {
    $idx = (bool) $index->status();
    $server_id = (string) $index->getServerId();
    if ($server_id) {
      $server = \Drupal::entityTypeManager()->getStorage("search_api_server")->load($server_id);
      if ($server) { $backend = $server->getBackendId(); $srv = ($backend === "search_api_db"); }
    }
    $ds = in_array("entity:node", $index->getDatasourceIds(), TRUE);
    foreach ($index->getFields() as $field) {
      $pp = $field->getPropertyPath();
      if ($pp === "title") { $title = TRUE; }
      if ($pp === "body" || strpos($pp, "rendered_item") !== FALSE) { $body = TRUE; }
    }
    try { $count = (int) $index->getTrackerInstance()->getIndexedItemsCount(); } catch (\Exception $e) { $count = 0; }
    $items = ($count > 0);
  }
  $pass = $srv && $idx && $ds && $title && $body && $items;
  print ($pass ? "PASS" : "FAIL")
    . " srv=" . ($srv?1:0) . " backend=" . $backend
    . " idx=" . ($idx?1:0) . " server=" . $server_id
    . " ds=" . ($ds?1:0) . " title=" . ($title?1:0) . " body=" . ($body?1:0)
    . " items=" . ($items?1:0) . " count=" . $count . "\n";
' 2>/dev/null)

echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
