#!/usr/bin/env bash
# Execution VERIFY: PASS when the Filebrowser metadata info event contributes a 'modified'
# column (i.e. filebrowser_extra is enabled and wired). exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $enabled = \Drupal::moduleHandler()->moduleExists("filebrowser_extra");
  $has = FALSE;
  if ($enabled) {
    $e = new \Drupal\filebrowser\Events\MetadataInfo([]);
    \Drupal::service("event_dispatcher")->dispatch($e, "filebrowser.metadata_info");
    $has = array_key_exists("modified", $e->getMetaDataInfo());
  }
  print (($enabled && $has) ? "PASS" : "FAIL") . " enabled=" . var_export($enabled, TRUE) . " modified_column=" . var_export($has, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
