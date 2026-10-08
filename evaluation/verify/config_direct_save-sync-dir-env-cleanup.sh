#!/usr/bin/env bash
# Introspection CLEANUP: remove cds_eval_env.yml from the sync directory. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\Core\Site\Settings;
  $dir = Settings::get("config_sync_directory");
  $abs = str_starts_with($dir, "/") ? $dir : DRUPAL_ROOT . "/" . $dir;
  $f = $abs . "/cds_eval_env.yml";
  if (is_file($f)) { unlink($f); }
' 2>/dev/null
echo "cleanup: cds_eval_env.yml removed from sync dir"
