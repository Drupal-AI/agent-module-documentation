#!/usr/bin/env bash
# Live-state verification for the "database-backed Search API index for Article nodes" task.
# Prints PASS/FAIL with detail and exits 0 (pass) / 1 (fail). No arguments.
# Loads the Server and Index config entities and asserts:
#   srv   — server eval_db_server exists and its backend id is search_api_db
#   idx   — index eval_index exists and is enabled
#   link  — the index writes to the eval_db_server server
#   ds    — the index has the node datasource (entity:node)
#   fld   — the index has at least one indexed field resolving to the node title
#           (property path "title", type text/string)
set -uo pipefail
cd /var/www/html

out=$(drush php:eval '
  $srv = $idx = $link = $ds = $fld = FALSE;
  $backend = ""; $server_id = "";
  $server = \Drupal::entityTypeManager()->getStorage("search_api_server")->load("eval_db_server");
  if ($server) {
    $backend = $server->getBackendId();
    $srv = ($backend === "search_api_db");
  }
  $index = \Drupal::entityTypeManager()->getStorage("search_api_index")->load("eval_index");
  if ($index) {
    $idx = (bool) $index->status();
    $server_id = (string) $index->getServerId();
    $link = ($server_id === "eval_db_server");
    $ds = in_array("entity:node", $index->getDatasourceIds(), TRUE);
    foreach ($index->getFields() as $field) {
      $pp = $field->getPropertyPath();
      $type = $field->getType();
      if ($pp === "title" && in_array($type, ["text", "string"], TRUE)) { $fld = TRUE; }
    }
  }
  $pass = $srv && $idx && $link && $ds && $fld;
  print ($pass ? "PASS" : "FAIL")
    . " srv=" . ($srv?1:0) . " backend=" . $backend
    . " idx=" . ($idx?1:0) . " link=" . ($link?1:0) . " server=" . $server_id
    . " ds=" . ($ds?1:0) . " fld=" . ($fld?1:0) . "\n";
' 2>/dev/null)

echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
