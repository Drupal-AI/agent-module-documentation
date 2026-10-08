#!/usr/bin/env bash
# Execution VERIFY (2nd hard): PASS when groupmedia_paragraphs is enabled AND its
# paragraphs_media_embed media_finder plugin is registered. exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $enabled = \Drupal::moduleHandler()->moduleExists("groupmedia_paragraphs");
  $has = $enabled && \Drupal::service("plugin.manager.groupmedia.finder")->hasDefinition("paragraphs_media_embed");
  print ($has ? "PASS" : "FAIL") . " enabled=" . var_export($enabled, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
