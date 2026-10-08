#!/usr/bin/env bash
# Execution VERIFY (hard2): PASS when the media_gallery_migration2 submodule is ENABLED and its d7_media_gallery_files
# migration config exists (source d7_media_gallery_file, enforced by media_gallery_migration2). exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $enabled = \Drupal::moduleHandler()->moduleExists("media_gallery_migration2");
  $c = \Drupal::config("migrate_plus.migration.d7_media_gallery_files");
  $enf = $c->get("dependencies.enforced.module") ?: [];
  $src = $c->get("source.plugin");
  $ok = $enabled && in_array("media_gallery_migration2", $enf, TRUE) && $src === "d7_media_gallery_file";
  print ($ok ? "PASS" : "FAIL") . " enabled=" . var_export($enabled, TRUE) . " enforced=" . implode(",", $enf) . " source=" . var_export($src, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
