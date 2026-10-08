#!/usr/bin/env bash
# Execution VERIFY for "create a managed file entity for a remote URL without downloading it".
# PASS when a PERMANENT file entity exists whose uri is exactly
# http://web/core/misc/druplicon.png, remote_stream_wrapper reports that uri as remote
# (file_is_uri_remote), and NO local copy was written under public://rsw_task.
# Prints PASS/FAIL; exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $uri = "http://web/core/misc/druplicon.png";
  $files = \Drupal::entityTypeManager()->getStorage("file")->loadByProperties(["uri" => $uri]);
  $file = $files ? reset($files) : NULL;
  $isPermanent = $file && (int) $file->get("status")->value === 1;
  $isRemote = file_is_uri_remote($uri);
  $noLocalCopy = !is_dir(\Drupal::service("file_system")->realpath("public://rsw_task"));
  $ok = $file && $isPermanent && $isRemote && $noLocalCopy;
  print ($ok ? "PASS" : "FAIL")
    . " fid=" . ($file ? $file->id() : "none")
    . " permanent=" . var_export($isPermanent, TRUE)
    . " remote=" . var_export($isRemote, TRUE)
    . " no_local_copy=" . var_export($noLocalCopy, TRUE)
    . " mime=" . ($file ? $file->getMimeType() : "-") . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
