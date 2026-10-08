#!/usr/bin/env bash
# Execution VERIFY: PASS when media type meg_task2 uses source 'generic' and its configured
# source_field is 'field_meg_ref'. exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\media\Entity\MediaType;
  $t = MediaType::load("meg_task2");
  $src = $t ? $t->getSource()->getPluginId() : "none";
  $sf = $t ? ($t->get("source_configuration")["source_field"] ?? "") : "";
  $ok = ($t && $src === "generic" && $sf === "field_meg_ref");
  print ($ok ? "PASS" : "FAIL") . " source=" . $src . " source_field=" . $sf . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
