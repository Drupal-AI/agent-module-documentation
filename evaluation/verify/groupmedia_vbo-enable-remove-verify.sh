#!/usr/bin/env bash
# Execution VERIFY (2nd hard): PASS when groupmedia_vbo is enabled AND its
# vbo_remove_media_from_group action plugin is registered. exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $enabled = \Drupal::moduleHandler()->moduleExists("groupmedia_vbo");
  $has = $enabled && \Drupal::service("plugin.manager.action")->hasDefinition("vbo_remove_media_from_group");
  print ($has ? "PASS" : "FAIL") . " enabled=" . var_export($enabled, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
