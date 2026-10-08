#!/usr/bin/env bash
# Introspection SETUP: place cds_eval_marker.yml (note: CDS-INTROSPECT-OK) into the config
# sync directory that config_direct_save exports to. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\Core\Site\Settings;
  $dir = Settings::get("config_sync_directory");
  $abs = str_starts_with($dir, "/") ? $dir : DRUPAL_ROOT . "/" . $dir;
  @mkdir($abs, 0775, TRUE);
  file_put_contents($abs . "/cds_eval_marker.yml", "note: CDS-INTROSPECT-OK\n");
  print "wrote " . $abs . "/cds_eval_marker.yml\n";
' 2>/dev/null
echo "setup: cds_eval_marker.yml (note: CDS-INTROSPECT-OK) in sync dir"
