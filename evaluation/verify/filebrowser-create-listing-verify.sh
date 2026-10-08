#!/usr/bin/env bash
# Execution VERIFY: PASS when a dir_listing node titled "Filebrowser Eval Share" exists and
# its filebrowser_nodes row has folder_path == public://fb_hard. exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $ids = \Drupal::entityTypeManager()->getStorage("node")->getQuery()
    ->accessCheck(FALSE)->condition("type","dir_listing")->condition("title","Filebrowser Eval Share")->execute();
  $ok = FALSE; $fp = "none";
  if ($ids) {
    $nid = reset($ids);
    $rec = \Drupal::service("filebrowser.storage")->loadNodeRecord($nid);
    $fp = $rec["folder_path"] ?? "none";
    $ok = ($fp === "public://fb_hard");
  }
  print ($ok ? "PASS" : "FAIL") . " folder_path=" . $fp . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
