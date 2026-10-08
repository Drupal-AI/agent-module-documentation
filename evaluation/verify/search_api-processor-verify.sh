#!/usr/bin/env bash
# Live-state verification for the "server + index with the HTML filter processor enabled" task.
# Prints PASS/FAIL with detail and exits 0 (pass) / 1 (fail). No arguments.
# Loads the Index config entity (and, via its server id, the Server) and asserts:
#   srv   — the index writes to a server whose backend id is search_api_db
#   idx   — index eval_index3 exists and is enabled
#   ds    — the index uses the entity:node datasource
#   proc  — the html_filter processor is enabled on the index
set -uo pipefail
cd /var/www/html

out=$(drush php:eval '
  $srv = $idx = $ds = $proc = FALSE;
  $backend = ""; $server_id = ""; $procs = "";
  $index = \Drupal::entityTypeManager()->getStorage("search_api_index")->load("eval_index3");
  if ($index) {
    $idx = (bool) $index->status();
    $server_id = (string) $index->getServerId();
    if ($server_id) {
      $server = \Drupal::entityTypeManager()->getStorage("search_api_server")->load($server_id);
      if ($server) { $backend = $server->getBackendId(); $srv = ($backend === "search_api_db"); }
    }
    $ds = in_array("entity:node", $index->getDatasourceIds(), TRUE);
    $enabled = array_keys($index->getProcessors());
    $procs = implode(",", $enabled);
    $proc = in_array("html_filter", $enabled, TRUE);
  }
  $pass = $srv && $idx && $ds && $proc;
  print ($pass ? "PASS" : "FAIL")
    . " srv=" . ($srv?1:0) . " backend=" . $backend
    . " idx=" . ($idx?1:0) . " server=" . $server_id
    . " ds=" . ($ds?1:0) . " proc=" . ($proc?1:0) . " processors=[" . $procs . "]\n";
' 2>/dev/null)

echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
