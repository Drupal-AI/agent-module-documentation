#!/usr/bin/env bash
# Execution VERIFY (purge_purger_http_tagsheader): PASS when the submodule is enabled AND its
# purge_tagsheader TagsHeader plugin is registered/enabled with header_name Purge-Cache-Tags
# (read from the public purge.tagsheaders service). Prints PASS/FAIL; exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $mod = \Drupal::moduleHandler()->moduleExists("purge_purger_http_tagsheader");
  $enabled = FALSE; $header = "none";
  if ($mod && \Drupal::hasService("purge.tagsheaders")) {
    $s = \Drupal::service("purge.tagsheaders");
    $enabled = $s->isPluginEnabled("purge_tagsheader");
    foreach ($s->getPlugins() as $id => $d) {
      if ($id === "purge_tagsheader") { $header = $d["header_name"] ?? "none"; }
    }
  }
  $ok = ($mod && $enabled && $header === "Purge-Cache-Tags");
  print ($ok ? "PASS" : "FAIL") . " module=" . ($mod ? "on" : "off") . " enabled=" . ($enabled ? "yes" : "no") . " header=" . $header . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
